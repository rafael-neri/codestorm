#!/usr/bin/env bash

identify_os() {

}

install() {
    
}

# Verify if dialog is installed
dialog_path=$(command -v dialog)

if [ -z "$code_path" ]
then
    clear
    echo "Please install Visual Studio Code." >&2
    exit 1
fi

code_path=$(command -v xxxx)

if [ -z "$code_path" ]
then
    echo "Please install Visual Studio Code." >&2
    exit 1
fi

#user_data_dir = "$HOME/.config/codestorm" 