#! /bin/bash

##################### Top Module for Bashgpt #######################
# To take in the input arguements and resolve what type of operation is to take place
# Inputs-
# 	bashgpt [DOMAIN] "QUESTION"
#	bashgpt -CTS [OPTIONS] [FILE...]
#	bashgpt [INFO]

Current_Version="Beta-0.3"

## Colors
PURPLE='\033[1;95m'
RED='\033[0;91m'
YELLOW='\033[1;93m'
GOLD='\033[0;33m' 
GREY='\033[0;90m'
NC='\033[0m'


function Options(){

echo -e "
	1) Ask A Question
	2) CTS Summarizer
	3) Sample Codes
	4) Version Information
	5) Change My Settings
	6) Exit Out
"
read -p "Your Option: " option
echo -e "\n${GREY}--------------------------------------------------------${NC}"
case $option in
	1) 			echo -e "\n Initializing Chatter"
				chat
				;;
	2) 			echo -e "\n Initializing CTS Summerizer"
				CTS
				;;
	3)			echo -e "\n Initializing Sample Codes Library"
				;;
	4) 			echo -e "\nThe Current Version Of Bashgpt Is ${YELLOW}$Current_Version${NC}.";
				AnythingElseOptions
				;;
	5)			echo -e "\n\t\t${RED}---- BashGPT Settings ----${NC}";
				echo -e "${GOLD}\e[3mWe recommend not changing settings you arent aware of,";
				echo -e "doing so can lead to possible unwanted behaviours.\e[0m${NC}";
				echo -e "What setting do you want to see?"
				Settings
				;;
	6)			exit 0;;
	*)			echo -e "	${RED}#### Not A Valid Option ####\e[0m";
				Options
				;;
esac
}

###################################################################################### AUXILARRY FUNCTIONS
function AnythingElseOptions(){
echo -e "${GREY}--------------------------------------------------------${NC}\n\nAnything Else I Can Help You With?"
Options
}
function AnythingElseSettings(){
echo -e "${GREY}--------------------------------------------------------${NC}\n\nAnything Else I Can Help You With?"
Settings
}

###################################################################################### SETTINGS FUNCTION
function Settings(){
echo -e "
	1) Max Tokens
	2) API Key
	3) Go Back
	4) Exit Out
"
read -p "Your Option: " choice

case $choice in
	1) 			tokenset
				;;
	2)			keyset
				;;
	3)			AnythingElseOptions;;
	4)			exit 0;;
	*)			echo -e "	${RED}#### Not A Valid Option ####\e[0m";
				Settings
				;;
esac
}

###################################################################################### SETTINGS

function tokenset(){
# Prints out the current Max Token Count, and replaces the value with the new one if asked.
	echo -e "${YELLOW}"
	grep -m -1 "maxtokens=" ~/Downloads/BashGPT/chatter.sh
	echo -e "${NC} "
	
	read -p "Change the value? (Y/N)" change
	
	case $change in
		Y|y)	read -p "Input The New Value between ${RED}50 and 200${NC} : " NewVal;
			if [[ $NewVal -le 200 ]] && [[ $NewVal -ge 50 ]]; then
				sed -i "s/maxtoken=.*/maxtokens=$NewVal/" ~/Downloads/BashGPT/chatter.sh
				echo "Max Token Count updated to ${YELLOW}$NewVal${NC}"
			elif [[ $NewVal -ge 200 ]] || [[ $NewVal -le 50 ]]; then
				echo -e "Invalid Token Count, Kindly specify something between 50-200."
			elif [[ -n $NewVal ]]; then echo "Invalid Max Tokens, Kindly Specify a Number, not a string."
			fi
			AnythingElseSettings
			;;
			
		N|n)	AnythingElseSettings;;
		
		*)	echo -e "	${RED}#### Not A Valid Option ####\e[0m";
			tokenset
			;;
	esac
}

function keyset(){
# Prints out the current API Key, and replaces the value with the new one if asked.
	echo -e "${YELLOW}"
	grep -m 1 "MY_API_KEY=*" ~/Downloads/BashGPT/chatter.sh		
	echo -e "${NC}"
	
	read -p "Change the value? (Y/N)" change
	
	case $change in
		Y|y)	read -p "Input The New Value: " NewVal;
			sed -i "s/MY_API_KEY=.*/MY_API_KEY=$NewVal/" ~/Downloads/BashGPT/chatter.sh
			echo -e "Your API Key was updated to ${YELLOW}$NewVal${NC}"
			AnythingElseSettings
			;;
		
		N|n)	AnythingElseSettings;;
		
		*)	echo -e "	${RED}#### Not A Valid Option ####\e[0m";
			keyset
			;;
	esac
}



###################################################################################### CHAT FUNCTION

function chat(){
	clear
	# taking value of number of columns in the terminal screen 
	width=$(tput cols)
	# print the * characters to fill the width of the window
	for (( i=0; i<$width; i++ )); do
	echo -ne "*"
	done
	title="Welcome To BashGPT"
	printf "%*s\n" $(((${#title}+$width)/2)) "$title"
	for (( i=0; i<$width; i++ ));
	do
	echo -ne "*"
	done
	echo "What is your question?"
	chatTop
	AnythingElseOptions
}

function chatTop(){
	IFS=$'\n'
	export question
	read ques
	question=$ques 
	case $question in
	 	"go back"|"Go Back"|"back"|"Back"|"Go back")		AnythingElseOptions
	 								;;
	 								
	 	"Exit"|"exit")						exit 0
	 								;;
	 								
	 	"Help"|"help"|"HELP"|"HELP ME"|"Help me"|"Help Me"|"help me"|"help Me"|"helup"|"Helup"|"halp"|"Halp")
	 								cat ~/Downloads/BashGPT/bashgpt-man;
	 								echo -e "Your prompt:";	
	 								chatTop
	 								;;
	 								
	 	"")							echo "Sorry but you have to input something for me to answer.";echo -e "${GREY}You can go to the other options using  'Go back' or can exit from bashgpt using 'Exit'${NC}";	
	 								echo -e "Your prompt:";	
	 								chatTop
	 								;;
	 								
	 	*)							~/Downloads/BashGPT/chatter.sh $question;
	 								echo -e "${GREY}You can go to the other options using  'Go back' or can exit from bashgpt using 'Exit'${NC}";		
									echo -e "Your prompt:";
	 								chatTop
	 								;;
	esac
}
###################################################################################### CTS FUNCTION

function CTS(){
	clear
	~/Downloads/BashGPT/Top_CTS.sh
	AnythingElseOptions
}

###################################################################################### MAIN FUNCTION

function main(){
	echo -e "Greetings! How May I Help You?"
	Options
}


(main)
