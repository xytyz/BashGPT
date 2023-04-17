#!/bin/bash

## Function that installs the dependencies if not present.
function comm_installer(){
	command=$1
	if command -v $command > /dev/null
	then
		echo "$command is available, NOICE."
	else
		echo "Whelp!! $command is not available, time to install it.."
#		sudo apt update && sudo apt install -y $1
	fi
}

## Dependencies: curl, git

echo -e "Thank you for installing BashGPT\n"

comm_installer curl
comm_installer git
echo -e ""
pattern="Please wait while we do some VERY important processing"

for (( i=0; i<${#pattern}; i++ ))
do
  echo -n "${pattern:$i:1}"
  sleep 0.05
done
echo ""
sleep 1
pattern="Hacking your Computer..."

for (( i=0; i<${#pattern}; i++ ))
do
  echo -n "${pattern:$i:1}"
  sleep 0.08
done
sleep 1
echo ""
pattern="AHEM..."
for (( i=0; i<${#pattern}; i++ ))
do
  echo -n "${pattern:$i:1}"
  sleep 0.03
done
sleep 0.5
pattern="i mean" 
for (( i=0; i<${#pattern}; i++ ))
do
  echo -n "${pattern:$i:1}"
  sleep 0.05
done
sleep 0.7
pattern=",going through your browsing history........"
for (( i=0; i<${#pattern}; i++ ))
do
  echo -n "${pattern:$i:1}"
  sleep 0.05
done
sleep 1
#echo -e "\n\t⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄\n\t⠄⠄⠄⠄⠄⣀⠠⣴⣶⣾⣿⣶⣄⡀⣀⣠⣤⣄⡀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄\n\t⠄⠄⠄⢰⣿⣿⣿⣿⣿⣯⣭⡛⠿⡇⢚⣽⣿⣟⡻⡆⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄\n\t⠄⣠⣾⣸⣿⣿⣒⡹⠟⢛⣉⠐⢖⢃⣵⡖⠂⠒⠲⡀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄\n\t⣰⣿⣿⣿⣿⣿⡇⡐⣫⣿⣿⣷⡿⣠⡻⢿⣾⣯⣶⡤⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄\n\t⣿⣿⣿⣿⣥⡿⢃⠛⣲⢉⣩⣭⠬⠭⠭⠥⠬⠭⠽⠜⠆⣦⠄⠄⠄⠄⠄⠄⠄⠄\n\t⣿⣿⣿⣿⣿⡇⣿⠄⡇⣴⣰⢰⡇⣿⠘⣧⢹⡆⠇⠃⢸⣸⡇⠄⠄⠄⡜⣷⡰⡄\n\t⣿⣿⣿⣿⣿⡇⢻⣀⣇⡉⡍⡄⣶⢰⡆⢰⢰⡆⣄⡄⡴⣿⠇⢰⣦⠄⣿⣸⣧⡿\n\t⢿⣿⣿⣿⣿⣿⣶⣍⣻⣿⣟⣃⡛⣘⢃⢻⢘⢃⣌⣼⣿⠃⠄⡀⣿⣷⣿⣿⠟⠁\n\t⣔⡺⠯⣝⣛⡻⠿⠿⣿⣿⡻⣔⢷⣯⣿⣘⣿⢘⡌⣿⠏⢰⣾⣿⣿⡿⠉⠁⠄⠄\n\t⣿⣿⣿⣶⣭⣭⣙⣛⣒⣒⣒⣛⠿⢿⣿⣿⣿⠿⠋⠁⠄⠘⣿⣿⣿⡇⠄⠄⠄⠄\n\t⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢸⣿⣿⣿⢰⣿⣆⠄⠄⠄⢿⣿⣿⣷⠄⠄⠄⠄\n\t⣿⣿⣿⣿⣍⢻⣿⣿⣿⣿⣿⡇⣿⣿⣿⣿⢸⣿⣿⣷⣄⠄⢸⣿⣿⣿⡀⠄⠄⠄\n\t⡜⢿⣿⣿⣿⣷⣜⢿⣿⣿⣿⢱⣿⣿⣿⡧⠻⣿⣿⣿⣿⡟⣼⣿⣿⣿⡇⠄⠄⠄\n\t⣿⣎⢿⣿⣿⣿⣿⣷⣌⢻⡿⣿⣿⣿⡿⢡⣷⡈⠻⣿⡟⣴⣿⣿⣿⣿⠄⠄⠄⠄\n"

echo -e "\n░░░░░░▄▀▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒█\n░░░░░█▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█\n░░░░█▒▒▄▀▀▀▀▀▄▄▒▒▒▒▒▒▒▒▒▄▄▀▀▀▀▀▀▄\t I've seen enough on your computer...\n░░▄▀▒▒▒▄█████▄▒█▒▒▒▒▒▒▒█▒▄█████▄▒█\t Aint gonna mess with a hotshot like you...\n░█▒▒▒▒▐██▄████▌▒█▒▒▒▒▒█▒▐██▄████▌▒█\t Forgive my brethren for my mistakes...\n▀▒▒▒▒▒▒▀█████▀▒▒█▒░▄▒▄█▒▒▀█████▀▒▒▒█\n▒▒▐▒▒▒░░░░▒▒▒▒▒█▒░▒▒▀▒▒█▒▒▒▒▒▒▒▒▒▒▒▒█\n▒▌▒▒▒░░░▒▒▒▒▒▄▀▒░▒▄█▄█▄▒▀▄▒▒▒▒▒▒▒▒▒▒▒▌\n▒▌▒▒▒▒░▒▒▒▒▒▒▀▄▒▒█▌▌▌▌▌█▄▀▒▒▒▒▒▒▒▒▒▒▒▐\n▒▐▒▒▒▒▒▒▒▒▒▒▒▒▒▌▒▒▀███▀▒▌▒▒▒▒▒▒▒▒▒▒▒▒▌\n▀▀▄▒▒▒▒▒▒▒▒▒▒▒▌▒▒▒▒▒▒▒▒▒▐▒▒▒▒▒▒▒▒▒▒▒█\n▀▄▒▀▄▒▒▒▒▒▒▒▒▐▒▒▒▒▒▒▒▒▒▄▄▄▄▒▒▒▒▒▒▄▄▀\n▒▒▀▄▒▀▄▀▀▀▄▀▀▀▀▄▄▄▄▄▄▄▀░░░░▀▀▀▀▀▀\n▒▒▒▒▀▄▐▒▒▒▒▒▒▒▒▒▒▒▒▒▐"
