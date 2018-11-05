#!/usr/bin/env bash

mkdir -p ~/.vim/backup
mkdir -p ~/.vim/tmp

sudo apt install \
    libncurses5-dev \
    libgnome2-dev \
    libgnomeui-dev \
    libgtk2.0-dev \
    libatk1.0-dev \
    libbonoboui2-dev \
    libcairo2-dev \
    libx11-dev \
    libxpm-dev \
    libxt-dev \
    python3-dev \
    python-dev \
    ruby-dev \
    lua5.1 \
    lua5.1-dev \
    luajit \
    libperl-dev \
    git

sudo apt remove vim vim-runtime vim-tiny gvim

git clone https://github.com/vim/vim.git
cd vim

./configure \
    --with-features=huge \
    --enable-multibyte \
    --enable-rubyinterp \
    --enable-python3interp \
    --with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu/\
    --enable-perlinterp \
    --enable-luainterp \
    --enable-gui=gtk2 \
    --enable-cscope \
    --prefix=/usr/local

make VIMRUNTIMEDIR=/usr/local/share/vim/vim80
sudo make install

sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vim vim /usr/local/bin/vim 1
sudo update-alternatives --set vim /usr/local/bin/vim

cd ..
cp ~/.vimrc ~/.vimrc.bak
cp .vimrc ~/.vimrc

vim +PluginInstall
vim +Version
