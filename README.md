# -scenario (Personal Fork)
Forked from [EnJoeToh/-scenario: シナリオ書き用](https://github.com/EnJoeToh/-scenario)

- 脚本でインデントを入れるのに疲れた
- 差分も取りたい
- テキストデータで書いてから変換する
- 結果はブラウザで見る
- PDF化はブラウザにまかせる（うまくページに入るかは、column-gapを調節して頑張る）

## Modifications from Original

このフォークでは以下の変更を加えています：

- フォント変更: Windows環境に最適化（游明朝）
- ト書きインデント: 3文字分に変更（オリジナルは1文字）
- ライブリロード機能の追加: localhostする
- 印刷フォーマット、ディスプレイフォーマットの簡単切り替え

## Demo

new.html
<img width="1087" alt="new" src="https://user-images.githubusercontent.com/8622918/37465896-c04910fc-289f-11e8-9e1b-d843b0f0f802.png">

diff.html
<img width="1089" alt="diff" src="https://user-images.githubusercontent.com/8622918/37465952-e89e6908-289f-11e8-8c5d-186b69c063da.png">

## Requirement

- ruby
    - DocDiff

## Usage

- ★: タイトル

- ○: シーン

- ＠: 描写

- ＃: コメント

整形する

```ruby genetrate.rb new.txt > new.html```

```ruby genetrate.rb new.txt > new.html 2```
と末尾に2をつけることで一枚に2行入ってディスプレイで見やすい

ライブビューイング

```ruby live_server.rb new.txt```

```ruby live_server.rb new.txt 2```
と末尾に2をつけることで一枚に2行入ってディスプレイで見やすい

差分をとる

```ruby difference.rb old.txt new.txt > diff.html```

## License
modified BSD style license

Original repository: [EnJoeToh/-scenario: シナリオ書き用](https://github.com/EnJoeToh/-scenario)
