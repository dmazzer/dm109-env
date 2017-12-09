#/bin/bash

set -e

ENVPATH=~/work/torcs-telemetry-bigdata

echo "Preparing environment"

echo "vscode configuration reset"
rm -rf ~/.vscode
rm -rf ~/.config/Code

echo "cloning project folder from github"
cd ~/work
if [ -d "$ENVPATH" ]; then
	rm -rf $ENVPATH
fi
git clone --recursive https://github.com/dmazzer/torcs-telemetry-bigdata.git
cp ~/work/bigdata-tools/udp-kafka-bridge/udp-kafka-bridge-assembly-0.1.jar $ENVPATH/udp-kafka-bridge/

echo "generating ssh keys for hadoop"
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

echo "build flink projects"
cd $ENVPATH/stream_processor/kafka-flink-101/
mvn clean package

echo "done."
