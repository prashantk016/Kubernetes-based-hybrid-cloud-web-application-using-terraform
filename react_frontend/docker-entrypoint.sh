#!/bin/bash 
set -e
if [ -z "$API_URL" ]; then
    API_URL_JSON="undefined"
else
    API_URL_JSON=\"$API_URL\"
fi
echo "window.REACT_APP_API_URL=$API_URL_JSON;" >/usr/share/nginx/html/config.js
nginx -g "daemon off;"