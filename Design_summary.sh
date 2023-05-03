#!/usr/bin/bash

: '
	1. Check for any drv violators by seeing the number in the summary
	2. If present, check for report_constraint command
	3. If run, no of lines to be printed = no of violations + 5
'

#read -p "Enter the file name: " file
#file=innovus.log63
file=$1
#Check for optDesign Final Summary
if [ -e $file ];			#main if block to check for file presence
then

temp=$(egrep -n "optDesign Final Summary" $file | tail -1 | awk -F: '{print $1}')
dummy=$(egrep -n "optDesign Final Summary" $file | tail -1 | wc -l)

#Function to check for max_cap violations
cap_drv() {
egrep -n 'Check type : max_capacitance' $file > /dev/null 
exit_stat=$?
if [ $exit_stat -eq 0 ];
then
linecheck=`egrep -n 'Check type : max_capacitance' $file | awk -F: '{print $1}' | tail -1`
#Check if the line number of DRV_violators options is greater than optDesign Final summary
	if [ $linecheck -gt $temp ];
	then
		echo -e 'DRV Violations(max_capacitance):-\n'	
		echo -e "Number of violations:$l1"	
		end=`expr $linecheck + $l2 + 5`
		sed -n "${linecheck},${end}p" $file 	
	else
		echo -e '\nThe "report_constraints" command for max_capacitance has not been run.\n'
	fi
fi
}


#Function to check for max_trans violations
trans_drv() {
egrep -n 'Check type : max_transition' $file > /dev/null 
exit_stat=$?
if [ $exit_stat -eq 0 ];
then
linecheck=`egrep -n 'Check type : max_transition' $file | awk -F: '{print $1}' | tail -1`
#Check if the line number of DRV_violators options is greater than optDesign Final summary
	if [ $linecheck -gt $temp ];
	then
		echo -e 'DRV Violations(max_transition):-\n'
		echo -e "Number of violations:$l2"	
		end=`expr $linecheck + $l2 + 5`
		sed -n "${linecheck},${end}p" $file 	
	else
	    echo -e '\nThe "report_constraints" command for max_transition has not been run.\n'
	fi
fi
}


presentfn() {
l1=`sed -n '1p' ct.txt`
l2=`sed -n '2p' ct.txt`
if [ $l1 -eq 0 ];
then
	echo -e "\nNo capacitance violations found.\n"
else
	cap_drv
fi

if [ $l2 -eq 0 ];
then
	echo -e "\nNo trans violations found.\n"
else
	trans_drv
fi
rm ct.txt
}

if [[ $dummy -eq 0 ]]; 
then
	echo -e "\nNo optimization report is available.\n"
elif [[ $dummy -gt 0 ]]; 
then
        sum=`expr $temp + 50`
        no_of_lines=`sed -n "${temp},${sum}p" $file | egrep -n 'Density:' | awk -F: '{print $1}'`
        endlno=`expr $temp + $no_of_lines`
        sed -n "${temp},${endlno}p" $file | egrep -n -A4 'DRV' | tail -2 | awk -F"|" '{print $5}' | awk -F"(" '{print $1}' > ct.txt	
	#sed -n "${temp},${endlno}p" $file
	presentfn
fi
else
	echo -e "\nFile not present! Please check again.\n"
fi
