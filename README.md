# RHOKP (Red Hat Online Knwoledge Portal) 管理用シェル

# 準備
okp.sh の先頭の以下の環境だけご自身の環境に合わせて書き替えて下さい。
(ベタ書きイケてないと思いつつ)

REGISTRY_USER=<registry.redhat.ioのユーザー>

REGISTRY_PWD=<registry.redhat.ioのパスワード>

MY_KEY=<生成したアクセスキー> 

# 使い方
okp.sh start : 最新のイメージを確認してから RHOKP を起動
okp.sh stop : RHOKP を停止
okp.sh restart : RHOKP を停止後、最新のイメージを確認してから RHOKP を起動
