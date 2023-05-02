#!/usr/bin/bash
filename=$1

if [ -e $filename ];
then
line_no=`egrep -in -A2 'Skew Group Structure' $filename | tail -1 | awk -F- '{print $1}'`
total_lines=`wc -l $filename | awk '{print $1}'`

#iterate over the lines till the next blank line is found
for ((i=$line_no+1; i<$total_lines; i=i+1))
do 
	sed -n "${i}p" $filename | grep '^$' 
	exitstat=$?	
	if [ $exitstat -eq 0 ];
	then
		sed -n "${line_no},${i}p" $filename 
		break
	else
		continue
	fi
done

else
	echo -e "File is not present. Please Check Again."
fi
