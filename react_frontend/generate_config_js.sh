#!/bin/bash -eu
if [ -z "$API_URL" ]; then
    API_URL_JSON="undefined"
else
    API_URL_JSON="$API_URL"
fi
cat <<EOF
window.REACT_APP_API_URL=$API_URL_JSON;
EOF