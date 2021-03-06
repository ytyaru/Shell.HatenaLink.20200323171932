# はてなブログのURL

　はてなブログのURLはユーザの選択によって異なる。

* はてなID
* ドメイン
* 形式
    * 日付
    * タイトル

## URL

　URLは記事を一意に特定する識別子。

### はてなID

　はてなIDはユーザ識別子。はてなサービスにアカウント登録するときに決める。変更不可。重複しないためユーザを一意に特定できる。他ユーザに使用されているIDは使えない。

　はてなブログ無料版ではURLにはてなIDが使われる。

### ドメイン

　はてなブログ有料版は独自ドメインにできる。無料版は所定のドメインから選択する。

　ドメインはURLの一部である。サービス、サーバ、IPアドレスの名前を表す。

#### 無料版ドメイン

* `*.hatenablog.com`
* `*.hatenablog.jp`
* `*.hateblo.jp`
* `*.hatenadiary.com`
* `*.hatenadiary.jp`

　いずれも先頭に「はてなID」が付与される。

### 記事URL

　はてなブログの記事URLは以下の形式から選択できる。

* 日付: `entry/$yyyy/$mm/$dd/$HHMMSS`
* タイトル: `entry/$TITLE`

　一意にできるという意味では日付形式が良い。また、毎日定時に公開すれば、すべての記事のURLを自動生成できる。今回のスクリプトでは日付形式のURLのみ対象とする。

　タイトル形式は予期せず重複する可能性がある。昔の記事と新しい記事で同じタイトルにしてしまう場合が考えられる。また、日本語名にするとURLが日本語になってしまうか、URLエンコードによって`%20`など暗号化されて分かりやすさが失われ、優位性がなくなる。今回のスクリプトでは自動生成できない。[はてなWebAPI](http://developer.hatena.ne.jp/ja/documents/apis)を使うしかないだろう。

