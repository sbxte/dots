#!/bin/bash

if command -v uwsm 2>&1 >/dev/null; then
	uwsm app -- "$@" &
else
	eval "$@" &
fi
