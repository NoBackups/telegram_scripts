#!/bin/bash
#Author:chris@franscois.co.za
#Creation:November 5 2019

function sendMessage () {
        # Send a telegram messaage
        message="$1"
        USERID="{TELEGRAM_USER_ID}"
        KEY="{TELEGRAM_API_KEY}"
        TIMEOUT="10"
        URL="https://api.telegram.org/bot$KEY/sendMessage"
        DATE_EXEC="$(date "+%d %b %Y %H:%M")"
        TEXT="$DATE_EXEC $(hostname) - $(pwd)/$(basename $0): $message"
        curl -s --max-time $TIMEOUT -d "chat_id=$USERID&disable_web_page_preview=1&text=$TEXT" $URL > /dev/null
}

# Cause script to expire after time and trigger another action
scriptExpire="86499" #seconds
scriptAge="$((($(date +%s) - $(date +%s -r "$(basename $0)")) / 1))"





# Monitor MD5 of given file
trueMD5="{MD5}"
dir="{DIR}" #DIR to monitor
file="{FILE}" #file to compare to MD5


# if script expire then die
expireTrigger="exp_notified"
if [[ -f $expireTrigger ]];then exit;fi





# Monitor a condition, and send message if true.
(($scriptAge > $scriptExpire)) && sendMessage "Script Expired" && touch exp_notified

if [[ $(md5sum $dir/$file |awk '{print $1}') != "$trueMD5" ]];then
        sendMessage "MD5 of $domain has changed!"
fi
