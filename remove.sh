#!/usr/bin/env bash

remove_profiled(){
FILE="/etc/profile.d/telegram-alert.sh"
if [ -f "$FILE" ]; then
    mv "$FILE" "$FILE-bk"
    echo "bash profile $FILE exists and has been rename to $FILE-bk"
else 
    echo "$FILE does not exist."
fi
}

remove_zsh() {
FILE="/etc/zsh/zshrc"
cp "$FILE" "$FILE-bk"
echo "$FILE exists and has been backup to $FILE-bk"
sed -i "s/bash $ALERTSCRIPT_PATH/#bash $ALERTSCRIPT_PATH/g" FILE
echo "ZSH remove done at file $FILE"
}

file_zsh="/etc/zsh/zshrc"
HAS_ZSH=$(grep -o -m 1 "zsh" /etc/shells)
if [ ! -z $HAS_ZSH ]; then
    echo "ZSH is installed, deploy alerts to zshrc"
    if grep -q "$ALERTSCRIPT_PATH" "$file_zsh"; ##note the space after the string you are searching for
    then
    remove_zsh
    else
    echo "Config ZSH has been not deployed"
    fi
else
    echo "No zsh detected"
fi
