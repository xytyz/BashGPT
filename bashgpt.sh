#! /bin/bash

##################### Top Module for Bashgpt #######################
# To take in the input arguements and resolve what type of operation is to take place
# Inputs-
# 	bashgpt [DOMAIN] "QUESTION"
#	bashgpt CTSSUM [OPTIONS] [FILE...]
#	bashgpt DRCSUM [OPTIONS] [FILE...]
#	bashgpt [INFO]

echo "hello"

first=$1
second=$2
file=$3
Current_Version="VersionPlaceholder"
case $first in
	CTSSUM) ~/Downloads/BashGPT/Ctsdebugger.sh $first $second $file;;
	DRCSUM) ~/Downloads/BashGPT/DRCSummerizer.sh $first $second $file;;
	--help) cat ~/Downloads/BashGPT/bashgpt-man;;
	-V||--version) echo "The Current Version of BashGPT is $version";;
	-m||--maxtokens) if[[ $second == ^[0-9]+$ ]]; then
				if[[ $second -le 200 ]] && [[ $second -gt 10 ]]; then
					sed -i 's/maxtoken=50/maxtokens=$second/' ~/Downloads/BashGPT/chatter.sh
					echo "Max Token Count updated to $second"
				else echo -e "Invalid Token Count, Kindly specify something between 10-200."
				fi
			else echo "Invalid Max Tokens, Kindly Specify a Number, not a string."
			fi;;
	-h||--history)	cat ~/Downloads/BashGPT/bashgpt-history;;
	*) ~/Downloads/BashGPT/chatter.sh $first $second;;

