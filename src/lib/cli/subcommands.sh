VERSION=$(cat "$APP_ROOT/lib/app/version/version.txt")
IsHelp() { [ "$1" = 'h' -o "$1" = 'help' ] && return || return $LINENO; }
IsVersion() { [ "$1" = 'v' -o "$1" = 'version' ] && return || return $LINENO; }
IsHelp "$@" && { . "$APP_ROOT/lib/cli/cmd/help.sh"; exit; }
IsVersion "$@" && { . "$APP_ROOT/lib/cli/cmd/version.sh"; exit; }

