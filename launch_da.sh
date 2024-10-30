#!/bin/bash

# Copyright (c) 2021 Michael Neill Hartman. All rights reserved.
# mnh_license@proton.me
# https://github.com/hartmanm

# launch_da

# configure amazon_items and newegg_items files to have one item url per line

# to run, 
# cd <to cloned repo directory>
# bash launch_da.sh

initial_update(){
bash images_query.sh https://www.bitcoinblockhalf.com
bash amazon_item_query_wrapper.sh amazon_items
bash newegg_item_query_wrapper.sh newegg_items
bash join_results.sh
}

initial_update
