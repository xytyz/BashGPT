#! /bin/bash

############################################

#API key to authorize chatgpt communication

export OPENAI_API_KEY=


## temporary file to store output

temp_file=temp


## string we want to send our question as

data="$1"


## data arguement for the curl command

message=$(echo '{

    "model": "gpt-3.5-turbo",

    "messages": [{"role": "user", "content": "placeholder" }]

  }' | sed "s/placeholder/$data/")



## curl command set to the openai api for interfacing with chatgpt

curl -s https://api.openai.com/v1/chat/completions \

  -H "Content-Type: application/json" \

  -H "Authorization: Bearer $OPENAI_API_KEY" \

  -d "$message" -o "$temp_file" &



## getting the PID of the recently backgrounded job

PID=$!



## Loop while waiting for the download to finish

while kill -0 $PID 2>/dev/null; do

    printf "."

    sleep 1

done



## removing the header and footer from the json and printing out the actual content needed

temp_file=$(cat $temp_file |grep -o '"content":.*' | sed 's/"content"://;s/"//g' | sed 's/},finish_reason:stop,index:0}]}//')

echo -e "\nHope this helps: \n";

echo -e $temp_file

rm temp
