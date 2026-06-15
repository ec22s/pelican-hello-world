# pelican-hello-world

Python&thinsp;の静的サイトジェネレータ&thinsp;Pelican&thinsp;の&thinsp;Docker&thinsp;用テンプレート

### 動作確認環境（2026年6月）

```shell
$ $SHELL --version \
  && docker -v \
  && docker compose version \
  && make --version
GNU bash, version 5.3.12(1)-release (x86_64-apple-darwin23.6.0)
...
Docker version 29.5.3, build d1c06ef6b4
Docker Compose version v5.1.0
GNU Make 3.81
```

<br>

### 主な使い方

- リポジトリ直下で `make init`

- コンテナが正常に起動すれば `pelican-quickstart` が起動され諸設定を聞かれる. 下記は応答例

  ```
  Please answer the following questions so this script can generate the files
  needed by Pelican.

  > Where do you want to create your new web site? [.]
  > What will be the title of this web site? Hello world!
  > Who will be the author of this web site? me
  > What will be the default language of this web site? [en]
  > Do you want to specify a URL prefix? e.g., https://example.com   (Y/n) n
  > Do you want to enable article pagination? (Y/n)
  > How many articles per page do you want? [10]
  > What is your time zone? [Europe/Rome] Asia/Tokyo
  > Do you want to generate a tasks.py/Makefile to automate generation and publishing? (Y/n)
  > Do you want to upload your website using FTP? (y/N)
  > Do you want to upload your website using SSH? (y/N)
  > Do you want to upload your website using Dropbox? (y/N)
  > Do you want to upload your website using S3? (y/N)
  > Do you want to upload your website using Rackspace Cloud Files? (y/N)
  > Do you want to upload your website using GitHub Pages? (y/N)
  Error: [Errno 17] File exists: '/project/content'
  Done. Your new project is available at /project
  ```

- コンテナの `/project` が&thinsp;Pelican&thinsp;のプロジェクトフォルダ

- プロジェクトフォルダに最初から `content` フォルダがある（バインドマウント）. そのため `pelican-quickstart` の最後にエラーが出るが問題なし

- この時点で、リポジトリ直下で `make serve` を実行するとコンテナ側の&thinsp;Web&thinsp;サーバが起動する. ホスト側ポートは [`compose.yml`](./compose.yml) を参照. まだ記事がないのでサイトに空のページが表示される

  ```
  $ curl http://localhost:8000
  <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
  <html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <title>Directory listing for /</title>
  </head>
  <body>
  <h1>Directory listing for /</h1>
  <hr>
  <ul>
  </ul>
  <hr>
  </body>
  </html>
  ```

- 続いてリポジトリ直下で `make html` を実行すると、既にある [`content/hello-world.md`](./content/hello-world.md) が&thinsp;HTML&thinsp;化されサイトがブログの体になる

  ```
  $ make html
  "pelican" "/project/content" -o "/project/output" -s "/project/pelicanconf.py"
  Done: Processed 1 article, 0 drafts, 0 hidden articles, 0 pages, 0 hidden pages and 0 draft pages in 0.09 seconds.
  ```

<br>

### 補足


- `make down` でコンテナを終了してもコンテナの `/project` は消えない（ボリュームで永続化）

- 再び `make init` するとボリュームが削除されコンテナの `/project` が初期化されるが、`/project/content` はホスト側とのバインドマウントだから消えない

- `make restart` など若干のユーティリティコマンドが [`Makefile`](./Makefile) にあり

- Web&thinsp;サーバのログを見る場合の例

  - `make bash` でコンテナのシェルに入る

  - `ps a` で `make serve-global` の&thinsp;PID&thinsp;を確認し `kill -9 [PID]` で止める

    ```
    root@...:/project# ps a
    PID TTY      STAT   TIME COMMAND
      1 pts/0    Ss+    0:00 python3
    13 pts/1    Ss+    0:00 make serve-global
    ...
    ```

  - コンテナ側で `make serve-global` を起動

    ```
    root@...:/project# make serve-global
    "pelican" -l "/project/content" -o "/project/output" -s "/project/pelicanconf.py"  -b "0.0.0.0"
    Serving site at: http://0.0.0.0:8000 - Tap CTRL-C to stop
    ```

<br>

### 参考

  - https://qiita.com/saira/items/71faa202efb4320cb41d

<br>

### 問合せ先

  - [<ins>プロフィール</ins>](/ec22s)&thinsp;のメールアドレス

<br>

---
