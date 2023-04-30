#!/bin/bash

echo -e "\nEnter the CTS logv file: \c"

read file

echo -e ""

check(){
	if [[ -e $file ]]; then
cellxcount(){

	dummy1=$(grep "cell count" $file | wc -l)
	zero1=0
	if [[ $dummy1 -eq $zero1 ]]; then
		echo -e "No Cell Counts present to be displayed\n"
	elif [[ $dummy1 -gt $zero1 ]]; then
		echo -e "Loading Cell Counts......\n"
		temp=$(grep "cell count" $file | tail -1 | awk '{ print $7,$8,$9}' | cut -d"," -f1 | sed -n 's/b/Buffer/;p' | sed 's/=/	     |   /')
		temp1=$(grep "cell count" $file | tail -1 | awk '{ print $7,$8,$9}' | cut -d"," -f2 | sed -n 's/i/Inverter/;p' | sed 's/=/    |   /'  )
		temp2=$(grep "cell count" $file | tail -1 | awk '{ print $7,$8,$9}' | cut -d"," -f3 | sed -n 's/icg/ICG/;p' | sed 's/=/	     |   /'  )

		echo "----------------------------------"
		echo -e "|\t $temp\t |"
		echo -e "|\t$temp1\t |"
		echo -e "|\t$temp2\t |"
		echo -e "----------------------------------\n"
	fi
}
cellxcount
	else
		echo -e "\nFile not found.Please enter an existing file\n"
	fi
}
check

