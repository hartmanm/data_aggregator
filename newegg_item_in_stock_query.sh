#!/bin/bash

# Copyright (c) 2021 Michael Neill Hartman. All rights reserved.
# mnh_license@proton.me
# https://github.com/hartmanm

# newegg_item_in_stock_query.sh

# determines if an item is instock at newegg, is wrapped by newegg_item_query_wrapper 

TARGET_URL=${1}

curl -s "${TARGET_URL}" -H "Accept-Encoding: gzip,deflate,sdch" -H "Accept-Language: en-US,en;q=0.8" -H "User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.143 Safari/537.36" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" -H "Cookie: <>" -H "Connection: keep-alive" -H "Cache-Control: max-age=0" --compressed | tr '<>' '\n' | grep -i "In stock."

# example use
# bash newegg_item_in_stock_query.sh https://www.newegg.com/sapphire-radeon-rx-6600-xt-11309-03-20g/p/N82E16814202406

# bash newegg_item_in_stock_query.sh https://www.newegg.com/asus-geforce-gtx-1050-ti-ph-gtx1050ti-4g/p/N82E16814126170

# bash newegg_item_in_stock_query.sh https://www.newegg.com/amd-ryzen-9-5950x/p/N82E16819113663

# bash newegg_item_in_stock_query.sh https://www.newegg.com/amd-ryzen-threadripper-2970wx/p/N82E16819113546