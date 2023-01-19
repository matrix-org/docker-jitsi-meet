#!/bin/bash

set -o pipefail -xeu

google-chrome "${PUBLIC_URL:-https://google.com}" &
PID=$!
sleep 10
kill $PID
