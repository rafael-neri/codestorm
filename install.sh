#!/usr/bin/env bash

APP_NAME=codestorm
CODE_BIN=code

LOCAL_DIR=~/.local
CODESTORM_DIR=~/.codestorm

JETBRAINS_FONT=https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip
FIRACODE_FONT=https://github.com/tonsky/FiraCode/releases/download/5.2/Fira_Code_v5.2.zip

RED='\033[0;31m'
NC='\033[0m' # No Color

function check_vscode() {
    if [ ! -x "$(command -v $CODE_BIN)" ]
    then
        echo
        echo -e "${RED}Please install Visual Studio Code.${NC}" > &2
        exit 1
    fi
}


function create_dirs() {
    mkdir -p $LOCAL_DIR/bin
    mkdir -p $CODESTORM_DIR/extensions
    mkdir -p $CODESTORM_DIR/user_data
}

function create_bin() {
    echo "code \
        --new-window \
        --sync off \
        --user-data-dir $CODESTORM_DIR/user_data \
        --extensions-dir $CODESTORM_DIR/extensions \
    " > $LOCAL_DIR/bin/$APP_NAME
    chmod +x $LOCAL_DIR/bin/$APP_NAME
}

function install_fonts() {
    wget $JETBRAINS_FONT -P /tmp
    wget FIRACODE_FONT -P /tmp
}

# function install_extensions() {

# }

# function settings() {

# }


echo -n "Check Visual Studio Code......... "
check_vscode
sleep 1
echo "[OK]"


echo -n "Create Structure................. "
create_dirs
create_bin
sleep 1
echo "[OK]"

# echo -n "Install Fonts..................... "
# install_fonts
# sleep 2
# echo "[OK]"

# echo -n "Install Extensions................ "
# install_extensions
# sleep 2
# echo "[OK]"

# echo -n "Settings........................... "
# settings
# sleep 2
# echo "[OK]"

echo "Done."
