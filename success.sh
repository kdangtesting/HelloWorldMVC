#! /bin/bash

if [[ $TRAVIS_EVENT_TYPE == 'push' ]]
	if [[ $TRAVIS_BRANCH == 'master' ]]
		echo 'ok to deploy'
	fi
else
	echo 'is it pull?'
	echo $TRAVIS_PULL_REQUEST
fi