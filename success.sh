#! /bin/bash

if [[ $TRAVIS_EVENT_TYPE == 'push' ]]; then
	if [[ $TRAVIS_BRANCH == 'master' ]]; then
		echo 'ok to deploy'
	fi
else
	echo 'is it pull?'
	echo "$TRAVIS_PULL_REQUEST"
fi