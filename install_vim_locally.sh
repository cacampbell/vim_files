#!/usr/bin/env python3
prog=
local=

mkdir -p $prog
mkdir -p $local
cd $prog
wget http://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.0.tar.gz
tar xvf ncurses-6.0.tar.gz
cd ncurses-6.0
./configure --prefix=$local
make
make install
cd $prog
wget https://cache.ruby-lang.org/pub/ruby/2.3.1/ruby-2.3.1.tar.gz
tar xvf ruby-2.3.1.tar.gz
cd ruby-2.3.1
./configure --prefix=$local
make
make install
cd $prog
wget https://www.lua.org/ftp/lua-5.3.3.tar.gz
tar xvf lua-5.3.3.tar.gz
cd lua-5.3.3
./configure --prefix=$local
make
make install
cd $prog
wget http://luajit.org/download/LuaJIT-2.0.4.tar.gz
tar xvf LuaJIT-2.0.4.tar.gz
cd LuaJIT-2.0.4
./configure --prefix=$local
make
make install
cd $prog
wget https://www.python.org/ftp/python/3.5.2/Python-3.5.2.tgz
tar xvf Python-3.5.2.tgz
cd Python-3.5.2
./configure --prefix=$local
make
make install
cd $prog
wget https://www.python.org/ftp/python/2.7.9/Python-2.7.9.tar.xz
tar xvf Python-2.7.9.tar.xz
cd Python-2.7.9
./configure --prefix=$local
make
make install
git clone https://github.com/vim/vim
cd vim
git pull
./configure \
    --with-compiledby=cacampbell \
    --enable-multibyte \
    --with-features=huge \
    --with-luajit \
    --enable-luainterp \
    --with-lua-prefix=/usr \
    --enable-rubyinterp \
    --with-python3 \
    --enable-python3interp \
    --with-python-config-dir=/usr/lib/python3.4/config \
    --enable-perlinterp \
    --enable-gui=gtk2 \
    --enable-gtk2-check \
    --with-x \
    --enable-fail-if-missing \
    --enable-cscope \
    --prefix=$local
