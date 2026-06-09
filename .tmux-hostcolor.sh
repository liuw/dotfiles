#!/bin/sh
# Print a tmux 256-palette colour index, deterministic per short hostname.
# Used by ~/.tmux.conf to colourise the hostname in the status bar so the
# same host always gets the same colour and different hosts get distinct
# colours, helping avoid confusion about which machine you are on.

# Curated palette: high contrast against a black background, visually
# distinct from one another, and distinct from the white used for the clock.
colours="39 45 46 51 75 81 82 87 99 105 118 141 154 177 190 196 197 201 207 208 213 214 220 226"
n=$(echo "$colours" | awk '{print NF}')

hash=$(hostname -s | cksum | awk '{print $1}')
idx=$(( hash % n + 1 ))

echo "$colours" | awk -v i="$idx" '{print $i}'
