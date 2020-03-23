ShowVarTable() { # 引数で渡された名前の変数名とその値をcolumnコマンドで整形して表示する
	local text=
	for v in "$@"; do
		text="$text""\n""$v"'='"$(echo "$(eval echo '$'"$v")")"
	done
	echo -e "$text" | tail -n +2 | column -t -s=
}
