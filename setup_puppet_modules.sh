#! /usr/bin/env bash

# install the modules for the puppet master install
cd puppet_master_src
librarian-puppet install

# install the modules for the openstack AIO install
cd all_src
librarian-puppet install