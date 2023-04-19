#!/bin/bash

## Function that installs the dependencies if not present.
function comm_installer(){
	command=$1
	if command -v $command > /dev/null
	then
		echo "$command is already available, NOICE."
	else
		echo "Whelp!! $command is not available, time to install it.."
		sudo apt update && sudo apt install -y $1
	fi
}
##############################
## Dependencies: curl, git

echo -e "Thank you for installing BashGPT\n"

comm_installer curl
comm_installer git

##############################
## Cloning files from git and storing them on desktop
if [[ -e ~/Downloads/BashGPT/ ]]; then
 	echo "Oh Hey! we're alrady here!"
else git clone https://github.com/xytyz/BashGPT ~/Downloads/BashGPT/
fi
chmod +x ~/Downloads/BashGPT/*
##############################
## Making Alias in .bashrc

# Define the alias we want to add
NEW_ALIAS="alias bashgpt='~/Downloads/BashGPT/bashgpt.sh'"

# Check if the alias already exists in .bashrc
if grep -Fxq "$NEW_ALIAS" ~/.bashrc
then
    echo "Alias already exists"
else
    # Add the alias to .bashrc
    echo "$NEW_ALIAS" >> ~/.bashrc
    echo "Alias added to .bashrc"
fi
source ~/.bashrc

##############################
## promptng to enter API Key

read -p " Kindly enter your OpenAI API Key found at https://platform.openai.com/account/api-keys " Your_Key

sed -i "s/No_Key/$Your_Key/g" ~/Downloads/chatter.sh
##############################
## Additional jargon

echo "The current version of BashGPT is Beta-0.2"
##############################
## Finisher
echo -e ""
~/Downloads/pepe.sh
