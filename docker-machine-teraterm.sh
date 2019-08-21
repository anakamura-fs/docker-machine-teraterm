#!/bin/bash
# docker machineにTeraTermでログインするシェルスクリプト。(git for windowsのbash想定)

# teraterm のインストール場所。各自調整
TTERM='/c/Program Files (x86)/teraterm/ttermpro.exe'

# docker machine名を引数に取る。
MACHINE=$1

# 第2引数(オプション)は窓タイトル
TITLE=$2

# envの取得をやりなおしてるが、あくまでこのシェルでローカルの話なので、呼び出し元には悪影響は無い。
eval $(docker-machine env $MACHINE)

DOCKER_IP_ADR=$(docker-machine ip $MACHINE)

TITLE_FOR_TTERM=""
if [ $TITLE ]; then
	TITLE_FOR_TTERM="//W=${TITLE}"
fi

# 本来「/」である個所を「//」にしてるのは、git for windowsのクセのため。ほかのシェル環境(cygwin等々)だと「/」に戻したほうが良い。
"$TTERM" docker@$DOCKER_IP_ADR //auth=publickey //keyfile=$(echo $HOME/.docker/machine/machines/$MACHINE/id_rsa | xargs cygpath -w ) ${TITLE_FOR_TTERM} &

