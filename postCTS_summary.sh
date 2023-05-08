#!/bin/bash/
: '
echo -e "Enter the filename: \c"

read file
'
file=$1
#function to check if the inserted filename corresponds to any file or not
check(){
	if [[ -e $file ]]; then

#function to check and display the occurance of optDesign Final Summary
optxdesign(){

dummy=$(egrep -n "optDesign Final Summary" $file | tail -1 | wc -l) #dummy variable for storing the occurance of required phrase

	if [[ $dummy -eq 0 ]]; then #checking if the op of dummy is empty i.e no regex found
		echo -e "\nNo optimization report is available \n"
	elif [[ $dummy -gt 0 ]]; then #if regex found then - Does it include hold?
		temp1=$(egrep -A 100 -B 1 "optDesign Final Summary" $file | egrep "Hold mode" | wc -l)
		if [[ $temp1 -gt 0 ]]; then #if yes, then :-
			var1=$(egrep -n -A 100 -B 1 "optDesign Final Summary" $file |egrep -A 40 -B 40 "Hold mode" | egrep  -B 1 "optDesign Final Summary"| head -1 | awk -F- '{print $1}')
			var=$(egrep -A 100 -B 1 "optDesign Final Summary" $file | egrep -A 40 -B 70 "Hold mode" | egrep -A 100 "optDesign Final Summary"| egrep -n "^$" | head -5 | tail -1 | awk -F: '{print $1}')
			sum=$(expr $var1 + $var)
			sed -n "${var1},${sum}p" $file > new.txt
		cat new.txt
		rm new.txt
		elif [[ $temp1 -eq 0 ]]; then #if no, then :-
		echo -e "\nOops! Looks like report_constraint hasn't been performed after CTS. Please check again.\n"
		fi
fi
}
optxdesign

	else # if regex isn't found then :-
		echo -e "\nFile not found. Please enter an existing file."
	fi
}
check
