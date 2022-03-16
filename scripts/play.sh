#!/bin/bash

#example
# export PLAY_EXPT=spin35
# export PLAY_RESULT_DIR=$HOME/tmp
# export PLAY_DURATION=30
# export PLAY_FILE=../files/step.play

# Make token
export ACCESSTOKEN_LIFETIME=$PLAY_DURATION
export ACCESSTOKEN_ROLE=clien
export ACCESSTOKEN_SECRET=$($HOME/secret/session_secret.sh)
export ACCESSTOKEN_TOPIC="${PLAY_EXPT}-data"
export ACCESSTOKEN_CONNECTIONTYPE=session
export ACCESSTOKEN_AUDIENCE=https://relay-access.practable.io
export SESSION_CLIENT_TOKEN=$(session token)

# set up other options
export SESSION_CLIENT_SESSION=$ACCESSTOKEN_AUDIENCE/$ACCESSTOKEN_CONNECTIONTYPE/$ACCESSTOKEN_TOPIC
export SESSION_CLIENT_FILE_PLAY=$PLAY_FILE

mkdir -p $3

# set output filename
now=$(date +"%Y-%m-%d-%h-%m")
export SESSION_CLIENT_FILE_LOG=$PLAY_RESULT_DIR/$PLAY_EXPT-$now

session client file
