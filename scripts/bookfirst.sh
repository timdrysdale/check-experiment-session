#!/bin/bash
if [ -z "$PLAY_FILE" ]
then
    echo "\$PLAY_FILE is empty)"
fi
if [ -z "$LOGIN_CODE" ]
then
      echo "\$LOGIN_CODE is empty"
fi
if [ -z "$DURATION" ]
then
      echo "\$DURATION is empty"
fi

duration=$DURATION

logintoken=$(curl --silent "https://assets.practable.io/tokens/$LOGIN_CODE")

pools=$(curl --silent -XPOST https://book.practable.io/api/v1/login -H "Accept: application/json" -H "Authorization: $logintoken")

booktoken=$(echo $pools | jq ".token" -r)

count=$(echo $pools | jq ".pools | length" )

expt=$(( $RANDOM % $count + 0 )) 

pool=$(echo $pools | jq ".pools[$EXPT]" -r)

details=$(curl --silent -XGET "https://book.practable.io/api/v1/pools/$pool" -H "Accept: application/json" -H "Authorization: $booktoken")

echo $(echo $details | jq ".name" -r)

bookrequest=$(curl --silent -XPOST "https://book.practable.io/api/v1/pools/$pool/sessions?duration=$duration" -H "Accept: application/json" -H "Authorization: $booktoken")

export SESSION_CLIENT_TOKEN=$(echo $bookrequest | jq '.streams[] | select (.for == "data") | .token' -r)

permission=$(echo $bookrequest | jq '.streams[] | select(.for =="data") | .permission' -r )

aud=$(echo $permission | jq '.audience' -r)
ct=$(echo $permission | jq '.connection_type' -r )
topic=$(echo $permission | jq '.topic' -r)

export SESSION_CLIENT_SESSION="$aud/$ct/$topic"
export SESSION_CLIENT_FILE_PLAY=$PLAY_FILE
session-relay client file

