#! /bin/bash

if [[ $TRAVIS_EVENT_TYPE == 'push' ]]; then
	if [[ $TRAVIS_BRANCH == 'master' ]]; then
		echo 'ok to deploy'
		curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&source=github"  | tar -zx
		export PATH=$PATH:.
		cf --version
		cf install-plugin -f https://static-ice.ng.bluemix.net/ibm-containers-linux_x64
		cf plugins
		cf login -a https://api.ng.bluemix.net -u kdang@ca.ibm.com -p $secretpw
		cf ic login
		cf ic images
		docker build -t tom_cat .
		docker tag tom_cat registry.ng.bluemix.net/ahhhh/tom_cat
		docker push registry.ng.bluemix.net/ahhhh/tom_cat
		cf ic images
		cf ic ps -a
		cf ic rename tom_cat old_tom_cat
		cf ic stop old_tom_cat
		cf ic ps -a
		cf ic rm $(cf ic ps -a -q)
		cf ic ps -a
		cf ic run -p 8080 --name tom_cat registry.ng.bluemix.net/ahhhh/tom_cat
		cf ic ps
		cf ic ip list
		cf ic ip unbind 169.44.120.170 old_tom_cat
		cf ic inspect tom_cat
		cf ic ip bind 169.44.120.170 tom_cat
	fi
else
	echo 'is it pull?'
	echo "$TRAVIS_PULL_REQUEST"
fi