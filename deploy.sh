#!/usr/bin/env bash

add_profiled(){
cat <<EOF > /etc/profile.d/telegram-alert.sh
#!/usr/bin/env bash
# Log connections
bash $ALERTSCRIPT_PATH bash
EOF
echo "Bash done"
}

add_zsh () {
cat <<EOF >> /etc/zsh/zshrc

# Log connections
bash $ALERTSCRIPT_PATH zsh
EOF
echo "ZSH done"
}


ALERTSCRIPT_PATH="/opt/ssh-login-alert-telegram/alert.sh"

echo "Deploying alerts..."
add_profiled

echo "Check if ZSH is installed.."
$file_zsh="/etc/zsh/zshrc"
HAS_ZSH=$(grep -o -m 1 "zsh" /etc/shells)
if [ ! -z $HAS_ZSH ]; then
    echo "ZSH is installed, deploy alerts to zshrc"
    if grep -q "$ALERTSCRIPT_PATH" "$file"; ##note the space after the string you are searching for
    then
    echo "ZSH has been deployed"
    else
    add_zsh
    fi
else
    echo "No zsh detected"
fi

echo "Done!"
