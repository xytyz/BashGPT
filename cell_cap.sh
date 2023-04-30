#!/bin/bash


echo -e "\nEnter the CTS logv file: \c"

read file

echo -e ""

check(){
	if [[ -e $file ]]; then
cellxcap(){

	dummy=$(grep "cell capacitance" $file | wc -l)
	zero=0
	if [[ $dummy -eq $zero ]]; then
       		echo -e "No Capacitances present to be displayed\n"
	elif [[ $dummy -gt $zero ]]; then	
		echo -e "Loading Cell Capacitances......\n"
		temp=$(grep "cell capacitance" $file | tail -1 |  awk '{print $7,$8,$9}' | cut -d"," -f1 | sed 's/b/ Buffer Capacitance/' | sed 's/=/  | /')
		temp1=$(grep "cell capacitance" $file | tail -1 |  awk '{print $7,$8,$9}' | cut -d"," -f2 | sed 's/i/Inverter Capacitance/' | sed 's/=/ | /')
		temp2=$(grep "cell capacitance" $file | tail -1 |  awk '{print $7,$8,$9}' | cut -d"," -f3 | sed 's/icg/ICG Capacitance/' | sed 's/=/ | /')

		echo "----------------------------------"
		echo -e "|  $temp|"
		echo -e "| $temp1|"
		echo -e "|      $temp2|"
		echo -e "----------------------------------\n"
	fi
}
cellxcap
	else
		echo -e "\nFile not found.Please enter an existing file."
	fi
}
check
