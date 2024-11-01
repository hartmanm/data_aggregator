#!/bin/bash

# Copyright (c) 2021 Michael Neill Hartman. All rights reserved.
# mnh_license@proton.me
# https://github.com/hartmanm

# amazon_item_in_stock_query.sh

# determines if an item is instock at amazon, is wrapped by amazon_item_query_wrapper 

TARGET_AMAZON_URL=${1}

curl -s "${TARGET_AMAZON_URL}" -H "Accept-Encoding: gzip,deflate,sdch" -H "Accept-Language: en-US,en;q=0.8" -H "User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.143 Safari/537.36" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" -H "Cookie: <>" -H "Connection: keep-alive" -H "Cache-Control: max-age=0" --compressed | tr '<>' '\n' > /tmp/amazon_query 

# exclude all results if We_don't_know_when_or_if_this_item_will_be_back string is present
[[ `cat /tmp/amazon_query | tr ' ' '_' | grep "We_don't_know_when_or_if_this_item_will_be_back"` == "" ]] && grep -i "In stock." /tmp/amazon_query 

# example use
# bash amazon_item_in_stock_query.sh https://www.amazon.com/XFX-Speedster-SWFT210-Graphics-RX-66XT8DFDQ/dp/B09B17SQBS
