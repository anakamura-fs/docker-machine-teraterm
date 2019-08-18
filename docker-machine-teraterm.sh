#!/bin/bash
# docker machineにTeraTermでログインするシェルスクリプト。(git for windowsのbash想定)

# teraterm のインストール場所。各自調整
TTERM='/c/Program Files (x86)/teraterm/ttermpro.exe'

# docker machine名を引数に取る。
MACHINE=$1

# envの取得をやりなおしてるが、あくまでこのシェルでローカルの話なので、呼び出し元には悪影響は無い。
eval $(docker-machine env $MACHINE)

# IPアドレスはenvの結果を加工して抽出。
DOCKER_IP_ADR=$(echo $DOCKER_HOST | sed -e 's|tcp://||' -e 's|:[0-9]*||')

# 本来「/」である個所を「//」にしてるのは、git for windowsのクセのため。ほかのシェル環境(cygwin等々)だと「/」に戻したほうが良い。
"$TTERM" docker@$DOCKER_IP_ADR //auth=publickey //keyfile=$(echo $HOME/.docker/machine/machines/$MACHINE/id_rsa | xargs cygpath -w ) &

