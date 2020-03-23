#THIS="$(realpath "${BASH_SOURCE:-$0}")" HERE="$(cd "$(dirname "$THIS")"; pwd)"
#. "$APP_ROOT/lib/cli/debug.sh"
#. "$APP_ROOT/lib/cli/error.sh"
#. "$APP_ROOT/lib/cli/showvartable.sh"
#. "$APP_ROOT/lib/app/defaults.sh"
HasDebugFlag() {
	local ARGS=("$@")
	for ARG in $ARGS; do { [ '-D' = "$ARG" ] && return; } done;
	return 1
}
HasDebugFlag "$@" && DEBUG=1
ShowDebugPath() { Debug "$(ShowVarTable THIS HERE APP_ROOT)"; }
ShowDebug() {
	Debug '----- '"$1"' -----'
	Debug "$(ShowVarTable DOMAIN ID TIME END START DATE URL_FORMAT OUT_FORMAT URL_ROOT_FORMAT)"
}
ShowDebugPath
ShowDebug 'getopts前'
while getopts :d:i:t:e:s:Dhv OPT; do
	case $OPT in
		d) DOMAIN=$OPTARG;;
		i) ID=$OPTARG;;
		t) TIME=$OPTARG;;
		s) START=$OPTARG;;
		e) END=$OPTARG;;
		u) URL_FORMAT=$OPTARG;;
		o) OUT_FORMAT=$OPTARG;;
#		D) DEBUG=1; ShowDebugPath; ShowDebug '-D(Debug option)直後';;
#		v) cat "$APP_ROOT/lib/app/version/version.txt"; exit 0; ;;
		v) . "$APP_ROOT/lib/cli/cmd/version.sh"; exit 0; ;;
#		h | \?) eval "cat <<< \"$(cat "$APP_ROOT/lib/app/help/help.ja.txt")\""; exit 0; ;;
		h | \?) . "$APP_ROOT/lib/cli/cmd/help.sh"; exit 0; ;;
	esac
done
ShowDebug 'getopts後'

