. "$APP_ROOT/lib/cli/error.sh"
IsInt() { test 0 -eq $1 > /dev/null 2>&1 || expr $1 + 0 > /dev/null 2>&1; }
ValidTime() {
	[ ${#TIME} -ne 6 ] && { Throw 'TIMEが6桁でない。TIMEは時分秒を表す6桁の数字であるべきです。（はてなの仕様）'; }
	! IsInt "$TIME" && { Throw 'TIMEが数字でない。TIMEは時分秒を表す6桁の数字であるべきです。（はてなの仕様）'; }
}
IsDate() { date +'%Y/%m/%d' -d "$1" > /dev/null 2>&1; }
ValidDates() {
	! IsDate "$START" && { Throw 'STARTはYYYY/mm/dd形式の有効な日付であるべきです。'; }
	! IsDate "$END" && { Throw 'ENDはYYYY/mm/dd形式の有効な日付であるべきです。'; }
}
GetHttpCode() { curl -Ss -w '%{http_code}\n' "$1" -o /dev/null 2>/dev/null; }
SearchDomain() { # 指定したはてなIDをはてなブログの無料ドメインから探す（存在しなければそのユーザが存在しないか、そのユーザははてなブログを利用していない）
	local DOMAINS="$(cat "$APP_ROOT/lib/hatena/domains.txt" | tr '\n' ' ')"
	local CODE DOMAIN_TMP="$DOMAIN"
	for DOMAIN in $DOMAINS; do
		local URL=$(eval echo "${URL_ROOT_FORMAT}")
		CODE=$(GetHttpCode "$URL")
		[ 200 -eq $CODE ] && { echo "$DOMAIN"; return; }
	done
	DOMAIN="$DOMAIN_TMP"
}
ValidId() {
	local URL="$(eval echo "${URL_ROOT_FORMAT}")"
	local CODE=$(GetHttpCode "$URL")
	[ 200 -eq $CODE ] && return;
	Warn '指定したはてなIDとドメインのURL '"$URL"' は見つかりませんでした。はてな無料ドメイン内に同一はてなIDが存在するか調査します。'
	local domain=$(SearchDomain)
	[ -n "$domain" ] && { DOMAIN="$domain"; Warn '無料ドメイン '"$domain"' に指定はてなID '"$ID"' のサイトが存在しました。 "'"$(eval echo ${URL_ROOT_FORMAT})"'" これをベースにURL作成します。'; return; }
	Warn '指定はてなID '"$ID"' のはてなブログ無料ドメインは見つかりませんでした。次の可能性が考えられます' \
		'  A. はてなID入力ミス' \
		'  B. はてなサービス上に存在しないIDである' \
		'  C. はてなブログを利用していないユーザである' \
		'  D. はてなブログの無料ドメイン仕様が変更された: '"$APP_ROOT/lib/hatena/domains.txt" \
		'  E. はてなブログのサーバがダウンしている' \
		'  F. はてなブログのザービスが終了した';
}
ValidTime
ValidDates
ValidId

