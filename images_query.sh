#!/bin/bash

# Copyright (c) 2021 Michael Neill Hartman. All rights reserved.
# mnh_license@proton.me
# https://github.com/hartmanm

# images_query.sh

# returns a json of all the images used or referenced by the url passed specifically. Not crawling links.

TARGET_URL="${1}"

curl -s "${TARGET_URL}" -H "Accept-Encoding: gzip,deflate,sdch" -H "Accept-Language: en-US,en;q=0.8" -H "User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.143 Safari/537.36" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" -H "Cookie: <>" -H "Connection: keep-alive" -H "Cache-Control: max-age=0" --compressed | grep "<img"| tr "'" '\n' | tr ',=";&(? ' '\n' | grep "https" > /tmp/image_list

curl -s "${TARGET_URL}" -H "Accept-Encoding: gzip,deflate,sdch" -H "Accept-Language: en-US,en;q=0.8" -H "User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.143 Safari/537.36" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" -H "Cookie: <>" -H "Connection: keep-alive" -H "Cache-Control: max-age=0" --compressed | grep "<img" | tr ',="' '\n' | grep -v "alt" > /tmp/image_list_partial #| tr "'" '\n' | tr ',=";&(? ' '\n' > /tmp/image_list

> /tmp/resulting_images

grep -E ".png" /tmp/image_list_partial >> /tmp/resulting_images
grep -E ".jpeg" /tmp/image_list_partial >> /tmp/resulting_images
grep -E ".jp2" /tmp/image_list_partial >> /tmp/resulting_images
grep -E ".svg" /tmp/image_list_partial >> /tmp/resulting_images
grep -E ".gif" /tmp/image_list_partial >> /tmp/resulting_images

# .svg .png .jp2 .jpeg .gif .jpg
grep -E ".png" /tmp/image_list >> /tmp/resulting_images
grep -E ".jpeg" /tmp/image_list >> /tmp/resulting_images
grep -E ".jp2" /tmp/image_list >> /tmp/resulting_images
grep -E ".svg" /tmp/image_list >> /tmp/resulting_images
grep -E ".gif" /tmp/image_list >> /tmp/resulting_images
# exclude amazon incorrect file extension images
for ITEM in `grep -E ".jpg" /tmp/image_list`
do
[[ `echo ${ITEM} | tr '.' ' ' | awk '{print $NF}'` == "jpg" ]] && echo ${ITEM} >> /tmp/resulting_images
done
# exclude amazon incorrect file extension images
for ITEM in `grep -E ".jpg" /tmp/image_list_partial`
do
[[ `echo ${ITEM} | tr '.' ' ' | awk '{print $NF}'` == "jpg" ]] && echo ${ITEM} >> /tmp/resulting_images
done

> /tmp/final_images
for ITEM in `cat /tmp/resulting_images`
do
ITEM=`echo ${ITEM} | tr -d "'"`

[[ `echo ${ITEM} | grep "coursera"` != "" ]] && [[ `echo ${ITEM} | grep "imageUrl"` != "" ]] && ITEM=`echo ${ITEM} | tr ';' ' ' | awk '{print $NF}'`

[[ `echo ${ITEM:0:1}` == "/" ]] && [[ `echo ${ITEM} | grep App_Drive` != "" ]] && [[ `echo ${ITEM} | grep thumb` == "" ]] && {
TL=`echo ${TARGET_URL} | tr '.' ' ' | awk '{print $1}'`
echo "${TL}.com${ITEM}" >> /tmp/final_images
} 

[[ `echo ${ITEM} | tr ':' ' ' | awk '{print $1}' | grep http` == "" ]] && {
[[ `echo ${TARGET_URL: -1}` != "/" ]] && TARGET_URL="${TARGET_URL}/"
[[ `echo ${ITEM:0:2}` != ".." ]] && echo ${TARGET_URL}${ITEM} >> /tmp/final_images
[[ `echo ${ITEM:0:2}` == ".." ]] && echo ${TARGET_URL}${ITEM:2:${#ITEM}} >> /tmp/final_images
}
[[ `echo ${ITEM} | tr ':' ' ' | awk '{print $1}' | grep http` != "" ]] && echo ${ITEM} >> /tmp/final_images
done

sed s/\&quot/\"/g /tmp/final_images > /tmp/final_images_expanded_quotes

> /tmp/final_images_uniq
uniq /tmp/final_images_expanded_quotes /tmp/final_images_uniq

IMAGES_FILE=/tmp/final_images_uniq
RESULTS_JSON_FINAL=results_images_json
RESULTS_JSON=/tmp/results_images_json_tmp
echo "{" > ${RESULTS_JSON}
NUMBER_OF_ITEMS=$((`wc -l ${IMAGES_FILE} | awk '{print $1}'`+1))
ITEM_COUNT=0
LAST_ITEM=2
for ITEM in `cat ${IMAGES_FILE}`
do
ITEM=`echo ${ITEM} | tr -d "\""`
[[ `echo ${ITEM} | grep "<"` == "" ]] && [[ `echo ${ITEM} | grep "?"` == "" ]] && [[ `echo ${ITEM} | grep ">"` == "" ]] && {
[[ `echo ${ITEM} | grep "/width"` == "" ]] && [[ `echo ${ITEM} | grep "/svg"` == "" ]] && [[ `echo ${ITEM} | grep "/class"` == "" ]] && {
[[ `echo ${ITEM} | grep "/id"` == "" ]] && [[ `echo ${ITEM} | grep "/png"` == "" ]] && {
[[ `echo ${ITEM} | grep "/class"` == "" ]] && [[ `echo ${ITEM} | grep "/width"` == "" ]] && {
[[ `echo ${ITEM} | grep "/type"` == "" ]] && [[ `echo ${ITEM} | grep "/fill"` == "" ]] && {
[[ `echo ${ITEM} | grep "/aria-hidden"` == "" ]] && [[ `echo ${ITEM} | grep "/id"` == "" ]] && {
[[ `echo ${ITEM} | grep "/data-track"` == "" ]] && [[ `echo ${ITEM} | grep "/role"` == "" ]] && {

[[ `echo ${ITEM} | grep "/Sponsored"` == "" ]] && {
[[ `echo ${ITEM} | grep "/aria-hidden"` == "" ]] && {
[[ `echo ${ITEM} | grep "/data-fallback"` == "" ]] && [[ `echo ${ITEM} | grep "/style"` == "" ]] && {
[[ `echo ${ITEM} | grep "/href"` == "" ]] && {

[[ `echo ${ITEM} | grep "/xmlns"` == "" ]] && [[ `echo ${ITEM} | grep "/viewBox"` == "" ]] && {
[[ `echo ${ITEM} | grep "/Rebrand"` == "" ]] && [[ `echo ${ITEM} | grep "/Coinglass.com"` == "" ]] && {
[[ `echo ${ITEM} | grep "/to"` == "" ]] && [[ `echo ${ITEM} | grep "/Reflect"` == "" ]] && {
[[ `echo ${ITEM} | grep "/Growth"` == "" ]] && [[ `echo ${ITEM} | grep "/and"` == "" ]] && {
[[ `echo ${ITEM} | grep "/Organizational"` == "" ]] && [[ `echo ${ITEM} | grep "/role"` == "" ]] && {
#echo "$LAST_ITEM  $NUMBER_OF_ITEMS"
ITEM_COUNT=$(($ITEM_COUNT+1))
[[ $LAST_ITEM -eq $NUMBER_OF_ITEMS ]] && echo "\"${ITEM}\":\"\"" >> ${RESULTS_JSON}
[[ $LAST_ITEM -ne $NUMBER_OF_ITEMS ]] && echo "\"${ITEM}\":\"\"," >> ${RESULTS_JSON}
ENDCAP=${ITEM}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
LAST_ITEM=$(($LAST_ITEM+1))
done

# check for last item comma
LAST=`tail -1 ${RESULTS_JSON}`
[[ `echo ${LAST: -1}` == "," ]] && {
NUMBER_OF=$((`wc -l ${RESULTS_JSON} | awk '{print $1}'`+1))
head -$NUMBER_OF ${RESULTS_JSON} > /tmp/transit
echo "\"${ENDCAP}\":\"\"" >> /tmp/transit
cat /tmp/transit >  ${RESULTS_JSON} 
}
echo "}" >> ${RESULTS_JSON}

# if no results use img tag parsing only
[[ ${ITEM_COUNT} -eq 0 ]] && {
> ${RESULTS_JSON}
> /tmp/final_images
curl -s "${1}" -H "Accept-Encoding: gzip,deflate,sdch" -H "Accept-Language: en-US,en;q=0.8" -H "User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.143 Safari/537.36" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" -H "Cookie: <>" -H "Connection: keep-alive" -H "Cache-Control: max-age=0" --compressed | grep "<img" | tr ',="' '\n' | grep "https" > /tmp/final_images
uniq /tmp/final_images /tmp/final_images_uniq
echo "{" > ${RESULTS_JSON}
NUMBER_OF_ITEMS=$((`wc -l ${IMAGES_FILE} | awk '{print $1}'`+1))
ENDCAP=
LAST_ITEM=2
for ITEM in `cat ${IMAGES_FILE}`
do
[[ $LAST_ITEM -eq $NUMBER_OF_ITEMS ]] && echo "\"${ITEM}\":\"\"" >> ${RESULTS_JSON}
[[ $LAST_ITEM -ne $NUMBER_OF_ITEMS ]] && echo "\"${ITEM}\":\"\"," >> ${RESULTS_JSON}
ITEM_COUNT=$(($ITEM_COUNT+1))
LAST_ITEM=$(($LAST_ITEM+1))
ENDCAP=${ITEM}
done
# check for last item comma
LAST=`tail -1 ${RESULTS_JSON}`
[[ `echo ${LAST: -1}` == "," ]] && {
NUMBER_OF=$((`wc -l ${RESULTS_JSON} | awk '{print $1}'`-1))
head -$NUMBER_OF ${RESULTS_JSON} > /tmp/transit
echo "\"${ENDCAP}\":\"\"" >> /tmp/transit
cat /tmp/transit >  ${RESULTS_JSON} 
}
echo "}" >> ${RESULTS_JSON}
} ## [[ ${ITEM_COUNT} -eq 0 ]] && {

uniq ${RESULTS_JSON} ${RESULTS_JSON_FINAL}_`echo ${1} | tr -d '"=-?&:/.'`

cat ${RESULTS_JSON_FINAL}_`echo ${1} | tr -d '"=-?&:/.'`

# example use
## tested with:

# bash images_query.sh https://www.elastic.co/

# bash images_query.sh https://www.bitcoinblockhalf.com

# bash images_query.sh https://www.amazon.com/XFX-Speedster-SWFT210-Graphics-RX-66XT8DFDQ/dp/B09B17SQBS

# bash images_query.sh https://www.coinglass.com

# bash images_query.sh https://www.coursera.org


