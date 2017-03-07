#!/usr/bin/env bash
cd vim && git pull
sudo apt-get update && sudo apt-get upgrade
sudo apt-get build-dep vim-gtk
sudo apt-get install liblua5.1-dev luajit libluajit-5.1 python-dev ruby-dev libperl-dev libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev

sudo ./configure \
    --with-compiledby=cacampbell \
    --enable-multibyte \
    --with-features=huge \
    --with-luajit \
    --enable-luainterp \
    --with-lua-prefix=/usr \
    --enable-rubyinterp \
    --enable-python3interp \
    --with-python-config-dir=/usr/lib/python3.5-config \
    --enable-perlinterp \
    --enable-gui=gtk2 \
    --enable-gtk2-check \
    --with-x \
    --enable-fail-if-missing \
    --enable-cscope \
    --prefix=/usr/local \
&& sudo checkinstall

vim --version

cd ..
