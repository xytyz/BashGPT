#! /bin/bash

#API key to authorize chatgpt communication
MY_API_KEY=No_key
export OPENAI_API_KEY=$MY_API_KEY

## temporary file to store output
temp_file="temp"

## first argument denotes the domain and second denotes the question
domain="$1"

## maximum words in which we want our answer
maxtokens=200

## data arguement for the curl command

if [ -e "$domain" ]; then
	domain="hello"
fi

## partitioning the message being sent
message=$(echo '{
    "model": "gpt-3.5-turbo",
    "messages": [{"role": "user", "content": "placeholder"}],
    "max_tokens": 50,
    "temperature": 0.3 
  }' | sed "s/placeholder/$domain/" | sed "s/50/$maxtokens/")

## token : max number of words
## temperature : creativity in answers

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
## If the file has an error category, then print the error message otherwise print content of reply
if grep -q "error" $temp_file; then
	echo -e "\rWE HAVE DETECTED AN ERROR\n"
	output=$(cat $temp_file |grep -o '"message": ".*"'| sed 's/"message": "\(.*\)"/\1/')

	echo -e "$output \n"
	echo -e "In case of API Key error, you can change your key using the command \n bashgpt -k <Valid_API_Key>"
else
	output=$(cat $temp_file |grep -o '"content":.*' | sed 's/"content"://;s/"//g'| sed -n 's/\(.*\)},finish_reason.*/\1/p')
	echo -e "\nHope this helps: \n";
	echo -e "$output \n"
fi

rm temp
