 #!/bin/bash
set -e

mkdir actions-runner && cd actions-runner
curl -o actions-runner-linux-x64-2.288.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.288.1/actions-runner-linux-x64-2.288.1.tar.gz
tar -xzf actions-runner-linux-x64-2.288.1.tar.gz





#Get Token
token=$(curl -s -XPOST \
    -H "authorization: token ${PAT}" \
    https://api.github.com/repos/${USER}/${REPONAME}/actions/runners/registration-token |\
    jq -r .token)

./config.sh --url ${URL} --token $token --name "aws-runner-$(hostname)" --work _work
./bin/runsvc.sh