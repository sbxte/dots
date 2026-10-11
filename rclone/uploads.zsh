#!/usr/bin/env zsh
# rclone-uploads: live view of in-progress rclone VFS uploads
# usage: rclone-uploads [port ...]     (default: 5572 5573)
# env:   INTERVAL=2  refresh seconds
# needs: rclone (with --rc on the mount), jq, numfmt (coreutils)

DEFAULT_PORTS=(5572 5573)
if (( $# )); then
	ports=("$@")
	explicit=1
else
	ports=("${DEFAULT_PORTS[@]}")
	explicit=0
fi

interval=${INTERVAL:-2}

bar() {  # bar <percent> -> [#####-----]
	local p=${1%.*} w=20
	(( p > 100 )) && p=100
	local f=$(( p * w / 100 ))
	printf '[%s%s]' "$(printf '%*s' $f '' | tr ' ' '#')" "$(printf '%*s' $((w - f)) '' | tr ' ' '-')"
}

hb() { numfmt --to=iec --suffix=B "${1%.*}" 2>/dev/null || print -n "${1}B"; }

render() {
	local port=$1 addr=localhost:$1 stats vfs
	stats=$(rclone rc core/stats --rc-addr $addr 2>/dev/null) || {
		# defaults: skip silently. explicit ports: the user asked for it, so say so
			(( explicit )) && print -P "%F{red}:: port $port unreachable%f\n"
			return 1
	}
vfs=$(rclone rc vfs/stats --rc-addr $addr 2>/dev/null)

local queued up errs speed
queued=$(jq -r '.diskCache.uploadsQueued // 0' <<<$vfs)
up=$(jq -r '.diskCache.uploadsInProgress // 0' <<<$vfs)
errs=$(jq -r '.errors // 0' <<<$stats)
speed=$(jq -r '.speed // 0' <<<$stats)

print -P "%B:: rclone @ $addr%b"
print "uploading: $up   queued: $queued   errors: $errs   speed: $(hb $speed)/s"

local lines
lines=$(jq -r '.transferring[]? | [.name, (.percentage // 0), (.bytes // 0), (.size // 0), (.speed // 0), (.eta // 0)] | @tsv' <<<$stats)
if [[ -z $lines ]]; then
	print -P "%F{green}idle: nothing transferring%f"
else
	local name pct bytes size spd eta
	while IFS=$'\t' read -r name pct bytes size spd eta; do
		printf '%-38s %s %3s%%  %9s/%-9s %9s/s  ETA %ss\n' \
			"${name[-38,-1]}" "$(bar $pct)" "${pct%.*}" "$(hb $bytes)" "$(hb $size)" "$(hb $spd)" "${eta%.*}"
	done <<<$lines
fi
print
}

trap 'print -n "\e[?25h"; exit' INT TERM
print -n "\e[?25l"   # hide cursor
while true; do
	out=$(for p in $ports; render $p)
	[[ -z $out ]] && out="no reachable rclone mounts on port(s): ${ports[*]}"
	print -n "\e[H\e[J${out}\n$(date +%T)  (Ctrl-C to quit)"
	sleep $interval
done
