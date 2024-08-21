#!/bin/bash

# curl -L -R -O https://www.lua.org/ftp/lua-5.4.7.tar.gz
# tar zxf lua-5.4.7.tar.gz
curl -L https://www.lua.org/ftp/lua-5.4.7.tar.gz | tar -xz
cd lua-5.4.7
make all test