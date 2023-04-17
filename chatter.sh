#! /bin/bash

#API key to authorize chatgpt communication
export OPENAI_API_KEY=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

## temporary file to store output
temp_file="temp"

## first argument denotes the domain and second denotes the question
domain="$1"
data="$2"

## maximum words in which we want our answer
maxtoken=50

## data arguement for the curl command

if [ -n "$domain" ]; then
	if [ -n "$data" ];then 
		domain="$data with reference to $domain in maximum $maxtoken words"
	else domain="$domain in maximum $maxtoken words"
	fi
else
	domain="hello"
fi

## partitioning the message being sent
message=$(echo '{
    "model": "gpt-3.5-turbo",
    "messages": [{"role": "user", "content": "placeholder"}],
    "max_tokens": 50,
    "temperature": 0.3
  }' | sed "s/placeholder/$domain/")
  
## curl command set to the openai api for interfacing with chatgpt
curl -s https://api.openai.com/v1/chat/completions \
	-H "Content-Type: application/json" \
	-H "Authorization: Bearer $OPENAI_API_KEY" \
	-d "$message" -o $temp_file &

## Loop while waiting for the download to finish
while ps -p $! &> /dev/null; do
  echo -n "."
  sleep 1
done

## removing the header and footer from the json and printing out the actual content needed

output=$(cat $temp_file |grep -o '"content":.*' | sed 's/"content"://;s/"//g'| sed -n 's/\(.*\)},finish_reason.*/\1/p')
echo -e "\nHope this helps: \n";
echo -e "$output \n"

