Run() {
	THIS="$(realpath "${BASH_SOURCE:-$0}")" HERE="$(cd "$(dirname "$THIS")"; pwd)" APP="$(basename "$THIS")" APP_ROOT="$HERE"
	. "$APP_ROOT/lib/app/version/version.sh"
	. "$APP_ROOT/lib/cli/debug.sh"
	. "$APP_ROOT/lib/cli/error.sh"
	. "$APP_ROOT/lib/cli/showvartable.sh"
	. "$APP_ROOT/lib/app/defaults.sh"
	. "$APP_ROOT/lib/cli/subcommands.sh"
	. "$APP_ROOT/lib/cli/parameters.sh"
	. "$APP_ROOT/lib/hatena/valid.sh"
	. "$APP_ROOT/lib/cli/cmd/main.sh"
}
Run "$@"
