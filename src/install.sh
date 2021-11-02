#!/usr/bin/env bash

APP_NAME=codestorm
CODE_BIN=code

LOCAL_DIR=~/.local
CODESTORM_DIR=~/.codestorm

JETBRAINS_FONT=JetBrainsMono-2.242.zip
FIRACODE_FONT=5.2/Fira_Code_v5.2.zip

COLOR_RED='\033[0;31m'
NO_COLOR='\033[0m'


function check_vscode() {
    if [ ! -x "$(command -v $CODE_BIN)" ]
    then
        echo
        echo -e "${COLOR_RED}Please install Visual Studio Code.${NO_COLOR}" >&2
        exit 1
    fi
}


function create_dirs() {
    mkdir -p ~/.fonts
    mkdir -p $LOCAL_DIR/bin
    mkdir -p $LOCAL_DIR/share/icons
    mkdir -p $LOCAL_DIR/share/applications
    mkdir -p $CODESTORM_DIR/extensions
    mkdir -p $CODESTORM_DIR/user_data
    mkdir -p $CODESTORM_DIR/user_data/User
}


function create_bin() {
    echo "code \
        --new-window \
        --sync off \
        --user-data-dir $CODESTORM_DIR/user_data \
        --extensions-dir $CODESTORM_DIR/extensions \
        $@ \
    " > $LOCAL_DIR/bin/$APP_NAME
    chmod +x $LOCAL_DIR/bin/$APP_NAME
}


function install_fonts() {
    wget -q https://download.jetbrains.com/fonts/$JETBRAINS_FONT -O /tmp/jetbrains.zip
    wget -q https://github.com/tonsky/FiraCode/releases/download/$FIRACODE_FONT -O /tmp/firacode.zip

    unzip -qo /tmp/jetbrains.zip -d /tmp/jetbrains
    unzip -qo /tmp/firacode.zip -d /tmp/firacode

    cp /tmp/jetbrains/fonts/ttf/*.ttf ~/.fonts/
    cp /tmp/firacode/ttf/*.ttf ~/.fonts/

    rm -Rf /tmp/jetbrains*
    rm -Rf /tmp/firacode*

    fc-cache -f
}


function install_extension() {
    EXTENSION_NAME=$1
    EXTENSION_URL=$2

    echo "Install extension: $EXTENSION_NAME "
    code --sync off --extensions-dir $CODESTORM_DIR/extensions --install-extension $EXTENSION_URL > /dev/null 2>&1
}


function download_assets() {
    wget -q https://raw.githubusercontent.com/rafael-neri/codestorm/master/src/assets/codestorm.png -O $LOCAL_DIR/share/icons/codestorm.png
    wget -q https://raw.githubusercontent.com/rafael-neri/codestorm/master/src/assets/settings.json -O $CODESTORM_DIR/user_data/User/settings.json
    wget -q https://raw.githubusercontent.com/rafael-neri/codestorm/master/src/assets/codestorm.desktop -O $LOCAL_DIR/share/applications/codestorm.desktop

    sed -i "s/{{USER}}/$USER/" $LOCAL_DIR/share/applications/codestorm.desktop
}


echo -n "Check Visual Studio Code.......... "
check_vscode
sleep 0.5
echo "[OK]"


echo -n "Create Structure.................. "
create_dirs
create_bin
sleep 0.5
echo "[OK]"

echo -n "Install Fonts..................... "
install_fonts
echo "[OK]"


install_extension "Auto Close Tag" formulahendry.auto-close-tag

install_extension "Auto Rename Tag" formulahendry.auto-rename-tag

install_extension "Bracket Pair Colorizer 2" coenraads.bracket-pair-colorizer-2

install_extension "Customize UI" iocave.customize-ui

install_extension "DotENV" mikestead.dotenv

install_extension "Editorconfig" editorconfig.editorconfig

install_extension "Fluent Icons" miguelsolorio.fluent-icons

install_extension "Git Graph" mhutchie.git-graph

install_extension "Git History" donjayamanne.githistory

install_extension "Gitignore" codezombiech.gitignore

install_extension "Git Lens" eamodio.gitlens

install_extension "HTML CSS Support" ecmel.vscode-html-css

install_extension "Hungry Delete" jasonlhy.hungry-delete

install_extension "Intellij IDEA Keybindings" k--kato.intellij-idea-keybindings

install_extension "Intellij Parameter Hints" bobbyzrncev.intellij-parameter-hints

install_extension "Jetbrains Darcula Theme" anan.jetbrains-darcula-theme

install_extension "Jetbrains Icon Theme" chadalen.vscode-jetbrains-icon-theme

install_extension "Laravel Blade Snippets" onecentlin.laravel-blade

install_extension "Laravel Extra Intellisense" amiralizadeh9480.laravel-extra-intellisense

install_extension "Laravel Goto View" codingyu.laravel-goto-view

install_extension "Laravel Snippets" onecentlin.laravel5-snippets

install_extension "Laravel Goto Controller" stef-k.laravel-goto-controller

install_extension "Markdown All in One" yzhang.markdown-all-in-one

install_extension "Monkey Patch" iocave.monkey-patch

install_extension "PHP Debug" felixfbecker.php-debug

install_extension "PHP Import Checker" marabesi.php-import-checker

install_extension "PHP Intelephense" bmewburn.vscode-intelephense-client

install_extension "PHP Snippets from PHPStorm" phiter.phpstorm-snippets

install_extension "Shortcut Menu Bar" jerrygoyal.shortcut-menu-bar

install_extension "Thunder Client" rangav.vscode-thunder-client

install_extension "Visual Studio Intellicode" visualstudioexptteam.vscodeintellicode

install_extension "Version Lens" pflannery.vscode-versionlens

install_extension "PDF Reader Embedded" tomoki1207.pdf

install_extension "XML Tools" dotjoshjohnson.xml

install_extension "YAML" redhat.vscode-yaml


echo -n "Download Assets................. "
download_assets
echo "[OK]"

echo "Done."
