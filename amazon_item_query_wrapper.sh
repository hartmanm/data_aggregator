#!/bin/bash

# Copyright (c) 2021 Michael Neill Hartman. All rights reserved.
# mnh_license@proton.me
# https://github.com/hartmanm

# amazon_item_query_wrapper.sh

ITEMS_FILE=${1}

RESULTS_JSON=results_json_amazon

echo "{" > ${RESULTS_JSON}

NUMBER_OF_ITEMS=$((`wc -l ${ITEMS_FILE} | awk '{print $1}'`+1))

LAST_ITEM=1
for ITEM in `cat ${ITEMS_FILE}`
do
RESULT=`bash amazon_item_in_stock_query.sh ${ITEM}`
#echo "!$ITEM !${RESULT}!"
[[ `echo ${RESULT} | grep -i "in stock"` != "" ]] && {
[[ $LAST_ITEM -eq $NUMBER_OF_ITEMS ]] && echo "\"${ITEM}\":\"in stock\"" >> ${RESULTS_JSON}
[[ $LAST_ITEM -ne $NUMBER_OF_ITEMS ]] && echo "\"${ITEM}\":\"in stock\"," >> ${RESULTS_JSON}
}
[[ `echo ${RESULT} | grep -i "in stock"` == "" ]] && {
[[ $LAST_ITEM -eq $NUMBER_OF_ITEMS ]] && echo "\"${ITEM}\":\"no stock\"" >> ${RESULTS_JSON}
[[ $LAST_ITEM -ne $NUMBER_OF_ITEMS ]] && echo "\"${ITEM}\":\"no stock\"," >> ${RESULTS_JSON}
}
LAST_ITEM=$(($LAST_ITEM+1))
done
echo "}" >> ${RESULTS_JSON}

cat ${RESULTS_JSON}

# example use
# bash amazon_item_query_wrapper.sh amazon_items
