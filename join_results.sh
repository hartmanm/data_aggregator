#!/bin/bash

# Copyright (c) 2021 Michael Neill Hartman. All rights reserved.
# mnh_license@proton.me
# https://github.com/hartmanm

# join_results.sh

AMAZON_NUMBER_OF_ITEMS=$((`wc -l amazon_items | awk '{print $1}'`+1))
NEWEGG_NUMBER_OF_ITEMS=$((`wc -l newegg_items | awk '{print $1}'`+1))
MAX_NUMBER_OF_ITEMS=$AMAZON_NUMBER_OF_ITEMS 
[[ $AMAZON_NUMBER_OF_ITEMS -gt $NEWEGG_NUMBER_OF_ITEMS ]] && MAX_NUMBER_OF_ITEMS=$AMAZON_NUMBER_OF_ITEMS 
[[ $AMAZON_NUMBER_OF_ITEMS -lt $NEWEGG_NUMBER_OF_ITEMS ]] && MAX_NUMBER_OF_ITEMS=$NEWEGG_NUMBER_OF_ITEMS 

# wait longer for more items
SLEEP_TIMEOUT=$(($MAX_NUMBER_OF_ITEMS+3))
sleep $SLEEP_TIMEOUT

RESULTS_JSON=z_all_results_json
> ${RESULTS_JSON}
echo "{" > ${RESULTS_JSON}

# TODO improve handling to allow any order import
# RESULT_JSONS=`ls | grep results | grep -v z_all_results_json | grep -v join_results`
# for now changing the order in this list will change the order in which they are loaded
RESULT_JSONS="
results_json_amazon
results_json_newegg
results_images_json_httpswwwbitcoinblockhalfcom
`ls | grep results_images_json | tr ' ' '\n'`
"

NUMBER_OF_RESULT_JSON_FILES=`echo ${RESULT_JSONS} | awk '{print NF}'`
FILE_ITERATOR=1
for FILE in ${RESULT_JSONS}
do
NUMBER_OF_ITEMS=$((`wc -l ${FILE} | awk '{print $1}'`+1))
LAST_ITEM=1
while [[ $LAST_ITEM -lt $NUMBER_OF_ITEMS ]]
do
ITEM=`head -$LAST_ITEM ${FILE} | tail -1`
[[ ${ITEM} == "{" ]] || [[ ${ITEM} == "}" ]] && NUMBER_OF_ITEMS=$(($NUMBER_OF_ITEMS-1))
[[ ${ITEM} != "{" ]] && [[ ${ITEM} != "}" ]] && {
[[ $LAST_ITEM -eq $(($NUMBER_OF_ITEMS-1)) ]] && [[ $FILE_ITERATOR -eq $NUMBER_OF_RESULT_JSON_FILES ]] && echo "${ITEM}" >> ${RESULTS_JSON}
[[ $LAST_ITEM -eq $(($NUMBER_OF_ITEMS-1)) ]] && [[ $FILE_ITERATOR -ne $NUMBER_OF_RESULT_JSON_FILES ]] && echo "${ITEM}," >> ${RESULTS_JSON}
[[ $LAST_ITEM -ne $(($NUMBER_OF_ITEMS-1)) ]] && echo "${ITEM}" >> ${RESULTS_JSON}
}
LAST_ITEM=$(($LAST_ITEM+1))
done
FILE_ITERATOR=$(($FILE_ITERATOR+1))
done
echo "}" >> ${RESULTS_JSON}
cat ${RESULTS_JSON}

# example use
# bash join_results.sh