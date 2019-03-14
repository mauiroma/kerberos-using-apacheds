#!/bin/bash
CHROME_TEMP_BROWSER_DIR=/tmp/kerberos_browser
if [ -d ${CHROME_TEMP_BROWSER_DIR} ]; then
    rm -rf ${CHROME_TEMP_BROWSER_DIR}
fi
mkdir ${CHROME_TEMP_BROWSER_DIR}
open -nF /Applications/Google\ Chrome.app --args --user-data-dir="${CHROME_TEMP_BROWSER_DIR}" --auth-server-whitelist=localhost --auth-negotiate-delegate-whitelist=localhost --incognito --no-default-browser-check --no-first-run http://localhost:8080/spnego-demo