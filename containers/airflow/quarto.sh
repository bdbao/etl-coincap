#!/bin/bash

# Detect system architecture
ARCH=$(uname -m)
if [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
    QUARTO_URL="https://github.com/quarto-dev/quarto-cli/releases/download/v1.5.43/quarto-1.5.43-linux-arm64.tar.gz"
    QUARTO_FILE="quarto-1.5.43-linux-arm64.tar.gz"
elif [ "$ARCH" = "x86_64" ]; then
    QUARTO_URL="https://github.com/quarto-dev/quarto-cli/releases/download/v1.5.43/quarto-1.5.43-linux-amd64.tar.gz"
    QUARTO_FILE="quarto-1.5.43-linux-amd64.tar.gz"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

curl -L -o ~/$QUARTO_FILE $QUARTO_URL
mkdir ~/opt
tar -C ~/opt -xvzf ~/$QUARTO_FILE

mkdir ~/.local/bin
ln -s ~/opt/quarto-1.5.43/bin/quarto ~/.local/bin/quarto

( echo ""; echo 'export PATH=$PATH:~/.local/bin\n' ; echo "" ) >> ~/.profile
source ~/.profile
