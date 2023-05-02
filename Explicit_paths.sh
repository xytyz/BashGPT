#!/usr/bin/bash

filename=$1

: '
1. Count the number of lines for the skew grp table
2. Check for explicit paths in the table
3. Display Min, Max, Avg ID, Skew target, actual skew
4. Display them in a table
'

if [ -e $filename ];
then
egrep 'explicit' $filename > /dev/null
start_exitstat=$?
	
	if [[ $start_exitstat -eq 0 ]]; 
	then

	start=`egrep -n 'explicit' $filename | sed -n '1p' | awk -F: '{print $1}'` 
	end=`egrep -n 'explicit' $filename | sed -n '$p' | awk -F: '{print $1}'`
	sed -n "${start},${end}p" $filename > skgrp.txt

	awk '
	BEGIN{
	print "Skew Groups Summary:"
	print "--------------------\n\n"
	print "Skew Group\t\t\t\t Min ID\t\t Max ID\t\t AvgID\t\t Target Skew\t Actual Skew\n"
	}

	{

	if(NR==1){
        	print $1"\n"
        	printf "%-40s %0.3f\t\t %0.3f\t\t %0.3f\t\t %s\t\t %0.3f\n", $2, $4, $5, $6, $9, $10
        }   
	else{
        	printf "%-40s %0.3f\t\t %0.3f\t\t %0.3f\t\t %s\t\t %0.3f\n", $1, $3, $4, $5, $8, $9
        }   

	}	

	END{
	print "\nNOTE: * means that Target Skew was not met."
	}' skgrp.txt
	rm skgrp.txt

	else
		echo -e "No explicit paths found.\n"
	fi
else
	echo -e "File is not present. Please check again.\n" 
fi

