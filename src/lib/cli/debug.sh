#!/usr/bin/env bash
Debug() {
	[ -v DEBUG ] || return
	Reset() { echo -en "\e[0m"; }
	Bold() { echo -en "\e[1m"; }
	LightCyan() { echo -en "\e[96m"; }
	Header() { LightCyan; }
	Show() { Reset; echo -e "$(Header)""$msg" 1>&2; Reset; }
#	Header() { Bold; LightCyan; echo -en 'DEBUG: '; Reset; LightCyan; }
#	Show() { Reset; echo -e "$msg" 1>&2; Reset; }
	local args=("$@"); local msg="$(IFS=$'\n'; echo -e "${args[*]}")"
	Show
}
