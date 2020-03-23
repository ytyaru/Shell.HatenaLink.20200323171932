# hatenalink

　はてなブログ記事のリンクを日付連番に作る。

# 特徴

* CLI (bash script)
* 出力値をコマンド引数や設定ファイルで変更できる

　出力例は以下。

```
* [http://ytyaru.hatenablog.com/entry/2020/03/16/000000:title]
* [http://ytyaru.hatenablog.com/entry/2020/03/17/000000:title]
* [http://ytyaru.hatenablog.com/entry/2020/03/18/000000:title]
* [http://ytyaru.hatenablog.com/entry/2020/03/19/000000:title]
* [http://ytyaru.hatenablog.com/entry/2020/03/20/000000:title]
* [http://ytyaru.hatenablog.com/entry/2020/03/21/000000:title]
* [http://ytyaru.hatenablog.com/entry/2020/03/22/000000:title]
* [http://ytyaru.hatenablog.com/entry/2020/03/23/000000:title]
```

# 開発環境

* <time datetime="2020-03-20T00:00:00+0900">2020-03-20</time>
* [Raspbierry Pi](https://ja.wikipedia.org/wiki/Raspberry_Pi) 4 Model B Rev 1.2
* [Raspbian](https://ja.wikipedia.org/wiki/Raspbian) buster 10.0 2019-09-26 <small>[setup](http://ytyaru.hatenablog.com/entry/2019/12/25/222222)</small>
* bash 5.0.3(1)-release

```sh
$ uname -a
Linux raspberrypi 4.19.75-v7l+ #1270 SMP Tue Sep 24 18:51:41 BST 2019 armv7l GNU/Linux
```

# インストール

```sh
git clone https://github.com/ytyaru/hatenalink
ln -s ./hatenalink.sh /usr/bin/hatenalink
```

# 使い方

　端末で`hatenalink.sh`を実行する。

## 設定ファイル

設定ファイル|概要
------------|----
[defaults.txt][defaults]|はてなIDなどのデフォルト値を指定する
[domains.txt][domains]|はてなブログ無料ドメイン一覧を編集する

## 引数

引数|値の例|デフォルト値|意味
----|------|------------|----
`-d`|`DOMAIN|`hatenablog.com`|[はてなブログ無料ドメイン][domains]
`-i`|`ID`|`ytyaru`|はてなID
`-t`|`TIME`|`000000`|記事の時刻（記事URLが年月日時分秒の形式であること）
`-e`|`END`|実行時の日付|記事の日時（終了）
`-s`|`START`|`END`から一週間前|記事の日時（開始）
`-u`|`URL_FORMAT`|`\${SCHEME}://\${ID}.\${DOMAIN}/entry/\${DATE}/\${TIME}`|URL書式
`-o`|`OUT_FORMAT`|`\\* [${URL_FORMAT}:title]`|出力するリンク書式: 

* [デフォルト設定][defaults]
* [はてなブログ無料ドメイン一覧][domains]

[defaults]:src/lib/hatena/defaults.txt
[domains]:src/lib/hatena/domains.txt

## ヘルプ表示

* [ヘルプ][help_jp]

[help_jp]:src/lib/app/help/help.ja.txt
[help_en]:src/lib/app/help/help.en.txt

```sh
hatenalink.sh -h
```
```sh
hatenalink.sh h
```
```sh
hatenalink.sh help
```

## バージョン表示

* [バージョン][version]

[version]:src/lib/app/version/version.txt

```sh
hatenalink.sh -v
```
```sh
hatenalink.sh v
```
```sh
hatenalink.sh version
```

## 使用例

　実行日から7日前までのリンクを出力する。

```sh
hatenalink
```

　`2020/01/01`時点から実行日までのリンクを出力する。

```sh
hatenalink -s 2020/01/01
```

　`2020/01/01`〜`2020/12/31`までのリンクを出力する。

```sh
hatenalink -s 2020/01/01 -e 2020/12/31
```

　以降は[設定ファイル][defaults]で指定したほうがいいかもしれない。コマンドでも以下のように指定できる。

　URLの時刻部分を指定した値にする。

```sh
hatenalink -t 123456
```

　[はてなブログ無料ドメイン][domains]を指定する。

```sh
hatenalink -d hateblo.jp
```

　URL書式を指定する。はてなURLの仕様が変更したとき等に使う。

```sh
hatenalink -u '\${SCHEME}://\${ID}.\${DOMAIN}/entry/\${DATE}/\${TIME}'
```

　出力書式を指定する。Markdownやはてな記法を含めた箇所を変更したいときに使う。

```sh
hatenalink -o '\\* '"[\${URL_FORMAT}:title:bookmark]'
```

　開発者用にデバッグ出力もできる。

```sh
hatenalink -D
```


　出力先について。リンク以外にもエラー、警告、デバッグ出力がある。これらはファイルディスクリプタ`2`(`stderr`)に出力される。もしこれらの出力を取り除きたいなら以下のようにする。

```sh
hatenalink 2>/dev/null
```

## エラー

　以下のエラーになると中断されてリンク出力されない。

```sh
TIMEが6桁でない。TIMEは時分秒を表す6桁の数字であるべきです。（はてなの仕様）
```
```sh
TIMEが数字でない。TIMEは時分秒を表す6桁の数字であるべきです。（はてなの仕様）
```
```sh
STARTはYYYY/mm/dd形式の有効な日付であるべきです。
```
```sh
ENDはYYYY/mm/dd形式の有効な日付であるべきです。
```

## 警告

　以下の警告では意図しない結果になるかもしれない旨を伝える。リンクは出力する。
```sh
指定したはてなIDとドメインのURL '"$URL"' は見つかりませんでした。はてな無料ドメイン内に同一はてなIDが存在するか調査します。
```

```sh
指定はてなID '"$ID"' のはてなブログ無料ドメインは見つかりませんでした。次の可能性が考えられます
  A. はてなID入力ミス
  B. はてなサービス上に存在しないIDである
  C. はてなブログを利用していないユーザである
  D. はてなブログの無料ドメイン仕様が変更された
  E. はてなブログのサーバがダウンしている
  F. はてなブログのザービスが終了した
```

# Note

* はてなサービスとは一切関係ない
* はてなサービスが変更されても無保証

# Author

ytyaru

* [![github](http://www.google.com/s2/favicons?domain=github.com)](https://github.com/ytyaru "github")
* [![hatena](http://www.google.com/s2/favicons?domain=www.hatena.ne.jp)](http://ytyaru.hatenablog.com/ytyaru "hatena")
* [![mastodon](http://www.google.com/s2/favicons?domain=mstdn.jp)](https://mstdn.jp/web/accounts/233143 "mastdon")

# License

This software is CC0 licensed.

[![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png "CC0")](http://creativecommons.org/publicdomain/zero/1.0/deed.en)

