# check-experiment-session
Example of how to use session client to check performance of an experiment

## Usage

you will need the secret for the relay you are operating with, or a token.
This script assumes you have access to the secret. It's simpler if you have the token - you can omit the code to generate a token.

```
git clone github.com/practable/relay
cd relay
go mod tidy
cd cmd/session
go build
sudo cp session /usr/local/bin
# add /usr/local/bin to path if needed
which session #check it is found ....

git clone github.com/timdrysdale/check-experiment-session
cd check-experiment-session/scripts
#book out spin35 first!
./example.sh
```
