#THIS="$(realpath "${BASH_SOURCE:-$0}")" HERE="$(cd "$(dirname "$THIS")"; pwd)" APP_ROOT="$HERE"
VERSION=$(cat "$APP_ROOT/lib/app/version/version.txt")
