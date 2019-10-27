#!/bin/bash

# Feed the entire email to this script, it will extract Subject and From.

while IFS= read -r line; do
	#header="$header$line\n"
	if [[ x$line = "xSubject:"* ]]; then
		subject="$line"
	fi
	if [[ x$line = "xFrom:"* ]]; then
		from="$line"
	fi
done

# No need to notify me on mail from myself
case $from in
	*"Wei Liu"*) exit 0;;
esac

DISPLAY=:0 /usr/bin/notify-send -t 10000 "$from $subject"

exit 0
