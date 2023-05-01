#! /bin/bash

##################### Top Module for Bashgpt #######################
# To take in the input arguements and resolve what type of operation is to take place
# Inputs-
# 	bashgpt [DOMAIN] "QUESTION"
#	bashgpt -CTS [OPTIONS] [FILE...]
#	bashgpt [INFO]

first=$1
second=$2
file=$3
Current_Version="Beta-0.2"
case $first in
	-cts|-CTS) 		echo "Running CTS Summerizer"
				~/Downloads/BashGPT/Ctsdebugger.sh $second $file
				;;	
	--help) 		cat ~/Downloads/BashGPT/bashgpt-man;;
	-v|-V|--version) 	echo "The Current Version of BashGPT is $Current_Version"
				;;
	-m|-M|--maxtokens) 	if [ -n "$second" ]; then
					if [[ $second -le 200 ]] && [[ $second -ge 10 ]]; then
						sed -i "s/maxtoken=50/maxtokens=$second/" ~/Downloads/BashGPT/chatter.sh
						echo "Max Token Count updated to $second"
					elif [[ $second -ge 200 ]] || [[ $second -le 10 ]]; then
						echo -e "Invalid Token Count, Kindly specify something between 10-200."
					elif [[ -n $second ]]; then echo "Invalid Max Tokens, Kindly Specify a Number, not a string."
					fi
				else egrep "Max tokens are " ~/Downloads/BashGPT/chatter.sh
				fi
				;;
	-k|-K|-key|-KEY|-Key)	if [ -n "$second" ]; then
					sed -i "s/MY_API_KEY=.*/MY_API_KEY=$second/" ~/Downloads/BashGPT/chatter.sh
					echo "Your API Key was updated to $second"
				else 
					grep -m 1 "MY_API_KEY=*" ~/Downloads/BashGPT/chatter.sh		
				fi
				;;
	*) 			~/Downloads/BashGPT/chatter.sh $first $second
				;;
esac
