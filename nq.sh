
#!/bin/bash

# Copyright (c) 2024 Michael Neill Hartman. All rights reserved.
# mnh_license@proton.me
# https://github.com/hartmanm

# nq.sh is a wrapper for images_query.sh, it will work with some websites

TARGET_URL="$1"
TARGET_KEYWORD=profile

#TARGET_URL="$1"
#TARGET_KEYWORD="$2"

clean_results(){
rm *json*
}

ign(){

clean_results
curl -s "$TARGET_URL" | tr ' ' '\n' | grep href | tr '"' '\n' | grep https > /tmp/1112

BUILDER_FILE=/tmp/builder
awk 'NF > 0' /tmp/1112 > /tmp/11122
uniq /tmp/11122 ${BUILDER_FILE}

for item in `cat $BUILDER_FILE`
do
bash images_query.sh $item
done

> target_results_json
bash join_results.sh

echo '{' > target_results_json
for item in `cat z_all_results_json`
do
[[ `echo $item | grep "$TARGET_KEYWORD"` != "" ]] && echo -e "$item" >> target_results_json
done
echo '}' >> target_results_json
clear
}

ign

> image_results_json
echo '{' > image_results_json
[[ ! -d targets ]] && mkdir targets
cd targets
COUNTER=0
for item in `cat ../target_results_json`
do
wget `echo $item | tr '"' ' ' | awk '{print $1}'`
item=`echo $item | tr '/"' '\n' | grep jpg | tr '.' ' ' | awk '{print $1}'`
[[ `echo $item` != "" ]] && echo -e \"${COUNTER}A\":\"$item\", >> ../image_results_json
COUNTER=$(($COUNTER +1))
done
echo '"endcap":""' >> ../image_results_json
echo '}' >> ../image_results_json
ls
rm *.1
cd ..
cat image_results_json
