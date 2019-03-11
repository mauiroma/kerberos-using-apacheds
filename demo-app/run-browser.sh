#!/bin/bash

#. set-env.sh

#$BROWSER http://$BIND_ADDRESS:8080/spnego-demo/

open /Applications/Google\ Chrome.app --args --auth-server-whitelist=localhost --auth-negotiate-delegate-whitelist=localhost --app=http://localhost:8080/spnego-demo