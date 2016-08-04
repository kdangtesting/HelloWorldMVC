#! /bin/bash

if [[ $TRAVIS_EVENT_TYPE == 'push' ]]; then
	if [[ $TRAVIS_BRANCH == 'master' ]]; then
		echo 'ok to deploy'
		curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&source=github"  |   tar -zx
		export PATH=$PATH:.
		cf --version
		cf install-plugin -f https://static-ice.ng.bluemix.net/ibm-containers-linux_x64
		cf plugins
		cf login -a https://api.ng.bluemix.net -u kdang@ca.ibm.com -p $secretpw
		cf ic login
		cf ic images
		docker build -t tom_cat2 .
		docker tag tom_cat2 registry.ng.bluemix.net/ahhhh/tom_cat2
		docker push registry.ng.bluemix.net/ahhhh/tom_cat2
		cf ic images
		cf ic ps -a
		cf ic rename tom_cat2 old_tom_cat2
		cf ic stop old_tom_cat2
		cf ic ps -a
		cf ic rm $(cf ic ps -a -q)
		cf ic ps -a
		cf ic run -p 8080 --name tom_cat2 registry.ng.bluemix.net/ahhhh/tom_cat2
		cf ic ps
		cf ic ip list
		cf ic ip unbind 169.44.121.195 old_tom_cat2
		cf ic inspect tom_cat2
		cf ic ip bind 169.44.121.195 tom_cat2
	fi
else
	echo 'is it pull?'
	echo "$TRAVIS_PULL_REQUEST"
fi