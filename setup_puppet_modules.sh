#! /usr/bin/env bash

# install the modules for the puppet master install
cd puppet_master_src
./get_modules.sh

# install the modules for the wordpress install
cd ../all_src
./get_modules.sh
