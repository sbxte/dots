#!/bin/bash
DEV=i2c-ELAN06FA:00
bound() { [ -e "/sys/bus/i2c/drivers/i2c_hid_acpi/$DEV" ]; }
failed() { dmesg | grep -q "$DEV: probe with driver i2c_hid_acpi failed"; }

# Wait up to 20 s for the normal probe to succeed or fail
for _ in $(seq 20); do
	bound && exit 0
	failed && break
	sleep 1
done
bound && exit 0

logger -t fix-elan-touchpad "$DEV not bound, resetting i2c_designware.0..."
echo i2c_designware.0 >/sys/bus/platform/drivers/i2c_designware/unbind
sleep 1
echo i2c_designware.0 >/sys/bus/platform/drivers/i2c_designware/bind
sleep 2

if ! bound; then
	modprobe -r i2c_hid_acpi
	sleep 1
	modprobe i2c_hid_acpi
	sleep 2
fi

if bound; then
	logger -t fix-elan-touchpad "Recovery successful."
else
	logger -t fix-elan-touchpad "Recovery failed, manual intervention needed."
fi
