#!/usr/bin/env bash

APP_NAME=codestorm
CODE_BIN=code

LOCAL_DIR=~/.local
CODESTORM_DIR=~/.codestorm

JETBRAINS_FONT=JetBrainsMono-2.242.zip
FIRACODE_FONT=5.2/Fira_Code_v5.2.zip

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
    mkdir -p ~/.fonts
    mkdir -p $LOCAL_DIR/bin
    mkdir -p $LOCAL_DIR/share/icons
    mkdir -p $LOCAL_DIR/applications
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
    wget -q https://download.jetbrains.com/fonts/$JETBRAINS_FONT -O /tmp/jetbrains.zip
    wget -q https://github.com/tonsky/FiraCode/releases/download/$FIRACODE_FONT -O /tmp/firacode.zip

    unzip /tmp/jetbrains.zip -d /tmp/jebrains
    unzip /tmp/firacode.zip -d /tmp/firacode

    cp /tmp/jetbrains/fonts/ttf/*.ttf ~/.fonts/
    cp /tmp/firacode/ttf/*.ttf ~/.fonts/

    fc-cache -f
}

function install_extensions() {
    EXTENSION_NAME=$1
    EXTENSION_URL=$2

    
}

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

echo -n "Install Fonts..................... "
install_fonts
sleep 1
echo "[OK]"

install_extensions
sleep 2


# echo -n "Settings........................... "
# settings
# sleep 2
# echo "[OK]"

echo "Done."
