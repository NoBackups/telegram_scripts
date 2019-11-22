#!/bin/bash
function sendMessage () {
        # Send a telegram messaage
        message="$1"
        USERID="USER_ID"
        KEY="API_KEY"
        TIMEOUT="10"
        URL="https://api.telegram.org/bot$KEY/sendMessage"
        DATE_EXEC="$(date "+%d %b %Y %H:%M")"
        TEXT="$DATE_EXEC :: $(hostname) :: $message"
        curl -s --max-time $TIMEOUT -d "chat_id=$USERID&disable_web_page_preview=1&text=$TEXT" $URL > /dev/null
}
sendMessage "$1"
