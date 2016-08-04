#! /bin/bash

if [[ $TRAVIS_EVENT_TYPE == 'push' ]]; then
	if [[ $TRAVIS_BRANCH == 'master' ]]; then
		echo 'ok to deploy'
		curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&source=github"  |   tar -zx
		export PATH=$PATH:.
		cf --version
		cf install-plugin -f https://static-ice.ng.bluemix.net/ibm-containers-linux_x64
		cf plugins
	fi
else
	echo 'is it pull?'
	echo "$TRAVIS_PULL_REQUEST"
fi