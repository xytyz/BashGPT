#!/bin/bash

#Initial Summary
#IDesign Initial Hold Timing
#Hold Opt Initial Summary
echo -e "Enter the Filename: \c"
read file

#function to check if the entered file exists or not
check(){
	if [[ -e $file ]]; then

dummy=$(egrep -i "Hold Opt Initial Summary" $file | wc -l) #variable to store the wc of the regex as an input for existing or not

#function to check the occurance of required regex
function ini(){
	if [[ $dummy -eq 0 ]]; then
		echo -e "\nNo information regarding Initial Summary is available\n"
	elif [[ $dummy -gt 0 ]]; then		
		temp=$(egrep -i -B 1 -A 100 "Hold Opt Initial Summary" $file | egrep -n "^$" | head -5 | tail -1 | awk -F: '{print $1}')
		temp1=1
		echo -e "\nHere is the Initial Summary\n"
		egrep -i -B 1 -A 100 "Hold Opt Initial Summary" $file  | sed -n "${temp1},${temp}p" 
	fi
}
ini
	else
		echo -e "\nFile not found. Please enter an existing file."
	fi
}
check
