#!/bin/sh
# Source: https://github.com/sv0/scripts/sharebyemail.sh
# This is sharebyemail.sh that allows to send files by email
# from PCMan File Manager [1]
# This assumes that you have following packages installed:
# - pcmanfm
# - zenity
# - neomutt or other mail program

# Usage:
#    sharebyemail.sh <filename>

# This script is licensed under The WTFPL (see LICENCE for more information).

# [1] https://en.wikipedia.org/wiki/PCMan_File_Manager

MAIL_PROGRAM=neomutt
# EMAIL="slavik@svyrydiuk.eu"

echo "attachment file: [$1]"

# email=$(zenity --entry --text="Send file $1 to email?" --entry-text="bookmark@svyrydiuk.eu")

email=$(
    printf 'slavik@svyrydiuk.eu\nroot@svyrydiuk.eu' \
    | zenity --list \
             --title "Share file" \
             --text "Send file to email addresses:" \
             --column "Email" \
             --multiple
)
subject="$(whoami) shares file with you"
if [ -n "$email" ];
then
    # mailx -s "$(whoami) shares file with you" -v -a "$1" $email
    echo "$subject" \
    | $MAIL_PROGRAM -s "$subject" -a "$1" -- "$email"
fi
