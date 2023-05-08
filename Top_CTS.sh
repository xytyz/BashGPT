#!/usr/bin/bash

#check the entered files: if the file has [....], then concatenate it to the last
#if file doesn't have them, then it is a simple log file
PURPLE='\033[1;95m'
RED='\033[0;91m'
echo -e "${PURPLE}\n\n\n\n---------------WELCOME TO CTS SUMMARIZER---------------\e[0m\n\n"

echo -e  "**(Write 'na' or 'NA' if no file is to be provided)**"

read -p 'Enter the standard log(.log) file name:  ' logfile
read -p 'Enter the verbose log(.logv) file name:  ' logvfile
read -p 'Enter the skew groups file name:  ' skewfile


#Check for file availability and correspondingly display the error msgs
if [ $skewfile = "na" ] && [ $logfile = "na" ] && [ $logvfile = "na" ];   
then
	echo -e "\nNo files provided."
	sk_flag=0
	lv_flag=0
	log_flag=0
	
elif [ ! -e $skewfile ] && [ ! -e $logvfile ] && [ ! -e $logfile ];
then
	echo -e "\n${RED}No given files are present. Please check and re-enter again.\e[0m"
	source Top_CTS.sh
else
	#if NA is entered, don't print error message that file isn't present
	if [ $skewfile = "na" ] || [ $skewfile = "NA" ] || [ $skewfile = "Na" ] || [ $skewfile = "nA" ];	 
	then
		sk_flag=0
	elif [ ! -e $skewfile ];
	then
		echo -e "\n${RED}No skew groups file is present by this name. Please check again.\e[0m" 
		sk_flag=0
	else
		sk_flag=1	
	fi
		


	if [ $logvfile = "na" ] || [ $logvfile = "NA" ] || [ $logvfile = "Na" ] || [ $logvfile = "nA" ];
        then    
                lv_flag=0 
	elif [ ! -e $logvfile ];
	then
		echo -e "\n${RED}No .logv file is present by this name. Please check again.\e[0m" 
		lv_flag=0
	else
		lv_flag=1
	fi
	


        if [ $logfile = "na" ] || [ $logfile = "NA" ] || [ $logfile = "Na" ] || [ $logfile = "nA" ];
        then    
                log_flag=0 
	elif [ ! -e $logfile ];
	then
		echo -e "\n${RED}No .log file is present by this name. Please check again.\e[0m" 
		log_flag=0
	else
		log_flag=1
	fi
fi
echo -e "skflag = $sk_flag\t\tlv_flag=$lv_flag\t\tlog_flag=$log_flag\n\n"

all_flag_sum=`expr $sk_flag + $lv_flag + $log_flag`
lgfile_sum=`expr $lv_flag + $log_flag`

function file_choose(){
	if [[ $lgfile_sum -gt 1 ]];
	then 
		cat $logvfile $logfile > temp.rpt
		file=temp.rpt
	elif [[ $lgfile_sum -eq 1 ]]; then
		if [[ $lv_flag -eq 1 ]];then
			file=$logvfile
		elif [[ $log_flag -eq 1 ]]; then
			file=$logfile
		fi
	fi
}


#-------------print the options as per the input provided-----------
function Scenario1(){
#Scenario 1: Skew group file is there and one log file
	echo -e "\nThe following options are available as per the input provided:-\n"
	echo '1. Explicit Skew Groups Summary'
	echo '2. Clock Sinks Summary'
	echo '3. Min and Max Clock Paths'
	echo '4. OptDesign Initial Summary'
	echo '5. OptDesign Final Summary'
	echo -e "6. DRV Violators \n"
	read -p "Enter your choice: " choice

	file_choose
	
	case $choice in
		1) source Explicit_paths.sh $skewfile;;
		2) source Clock_sinks.sh $skewfile;;
		3) source cts_clock_path.sh $skewfile;;
		4) source preCTS_summary.sh $file;;
		5) source postCTS_summary.sh $file;;
		6) source Design_summary.sh $file;;
		*) echo -e "${RED}Not a valid option.\e[0m"
		   Scenario1;;
	esac
}


function Scenario2(){
	#Scenario 2: Only log and logv file is present
	echo -e "\nThe following options are available as per the input provided:-\n"
	echo '1. OptDesign Initial Summary'
	echo '2. OptDesign Final Summary'
	echo -e "3. DRV Violators"
	echo '4. Cell Counts'
	echo -e '5. Cell Capacitances\n'
	read -p "Enter your choice: " choice

	file_choose

	case $choice in
		1) source preCTS_summary.sh $file;;
		2) source postCTS_summary.sh $file;;
		3) source Design_summary.sh $file;;
		4) source cell_count.sh $logvfile;;
		5) source cell_cap.sh $logvfile;;
		*) echo -e "${RED}Not a valid option.\e[0m"
		   Scenario2;;
	esac
}


function Scenario3(){
	#Scenario 3: Only Skew group file present
	echo -e "\nThe following options are available as per the input provided:-\n"
	echo '1. Explicit Skew Groups Summary'
	echo '2. Clock Sinks Summary'
	echo -e "3. Min and Max Clock Paths\n"
	read -p "Enter your choice: " choice
	case $choice in
		1) source Explicit_paths.sh $skewfile;;
		2) source Clock_sinks.sh $skewfile;;
		3) source cts_clock_path.sh $skewfile;;
		*) echo -e "${RED}Not a valid option.\e[0m"
		   Scenario3;;
	esac
}

function Scenario4(){
#Scenario 4: Skew group file is there and logv file
        echo -e "\nThe following options are available as per the input provided:-\n"
        echo '1. Explicit Skew Groups Summary'
        echo '2. Clock Sinks Summary'
        echo '3. Min and Max Clock Paths'
        echo '4. OptDesign Initial Summary'
        echo '5. OptDesign Final Summary'
	echo '6. Cell Capacitances'
	echo -e '7. Cell Counts\n'
        read -p "Enter your choice: " choice

        file_choose

        case $choice in
                1) source Explicit_paths.sh $skewfile;;
                2) source Clock_sinks.sh $skewfile;;
                3) source cts_clock_path.sh $skewfile;;
                4) source preCTS_summary.sh $file;;
                5) source postCTS_summary.sh $file;;
                6) source cell_cap.sh $logvfile;;
		7) source cell_count.sh $logvfile;;
                *) echo -e "${RED}Not a valid option.\e[0m"
                Scenario4;;
        esac
}

function Scenario5(){
#Scenario 5: All files are present
        echo -e "\nThe following options are available as per the input provided:-\n"
        echo '1. Explicit Skew Groups Summary'
        echo '2. Clock Sinks Summary'
        echo '3. Min and Max Clock Paths'
        echo '4. OptDesign Initial Summary'
        echo '5. OptDesign Final Summary'
        echo -e "6. DRV Violators"
	echo '7. Cell Capacitances'
	echo -e '8. Cell Counts\n'
        read -p "Enter your choice: " choice

        file_choose

        case $choice in
                1) source Explicit_paths.sh $skewfile;;
                2) source Clock_sinks.sh $skewfile;;
                3) source cts_clock_path.sh $skewfile;;
                4) source preCTS_summary.sh $file;;
                5) source postCTS_summary.sh $file;;
                6) source Design_summary.sh $file;;
		7) source cell_cap.sh $logvfile;;
		8) source cell_count.sh $logvfile;;
                *) echo -e "${RED}Not a valid option.\e[0m"
                   Scenario5;;
        esac
}

function Scenario6(){
        #Scenario 6: Only logv file is present
        echo -e "\nThe following options are available as per the input provided:-\n"
        echo '1. OptDesign Initial Summary'
        echo '2. OptDesign Final Summary'
        echo '3. Cell Counts'
        echo -e '4. Cell Capacitances\n'
        read -p "Enter your choice: " choice

        case $choice in
                1) source preCTS_summary.sh $logvfile;;
                2) source postCTS_summary.sh $logvfile;;
                3) source Design_summary.sh $logvfile;;
                4) source cell_count.sh $logvfile;;
                5) source cell_cap.sh $logvfile;;
                *) echo -e "${RED}Not a valid option.\e[0m"
                   Scenario6;;
        esac
}

function Scenario7(){
        #Scenario 7: Only log file is present
        echo -e "\nThe following options are available as per the input provided:-\n"
        echo '1. OptDesign Initial Summary'
        echo '2. OptDesign Final Summary'
        echo -e "3. DRV Violators"
        read -p "Enter your choice: " choice

        case $choice in
                1) source preCTS_summary.sh $logfile;;
                2) source postCTS_summary.sh $logfile;;
                3) source Design_summary.sh $logfile;;
                *) echo -e "${RED}Not a valid option.\e[0m"
                   Scenario7;;
        esac
}


#Call the Scenario functions as per needed
while true
do
if [ $all_flag_sum -eq 0 ];
then
	echo -e "\n\nNo options are available as per the inputs provided. Please re-enter the correct file names.\n"
	source Top_CTS.sh	#rerun the script if no inputs are given

elif [[ $sk_flag -eq 1 ]] && [[ $log_flag -eq 1 ]] && [[ $lv_flag -eq 0 ]]; #skew is present and log is present
then
	Scenario1
elif [[ $sk_flag -eq 0 && $lgfile_sum -eq 2 ]]; #only log and logv are present
then
	Scenario2
elif [[ $sk_flag -eq 1 ]] && [[ $lgfile_sum -eq 0 ]]; #only skew is present
then
	Scenario3
elif [[ $sk_flag -eq 1 ]] && [[ $lv_flag -eq 1 ]] && [[ $log_flag -eq 0 ]]; #skew and logv are preset
then
	Scenario4
elif [[ $sk_flag -eq 1 ]] && [[ $lv_flag -eq 1 ]] && [[ $log_flag -eq 1 ]]; #all files are present
then
	Scenario5
elif [[ $sk_flag -eq 0 ]] && [[ $lgfile_sum -eq 1 ]] && [[ $lv_flag -eq 1 ]]; #only logv file is present
then
	Scenario6
elif [[ $sk_flag -eq 0 ]] && [[ $lgfile_sum -eq 1 ]] && [[ $log_flag -eq 1 ]]; #only log file is present
then
	Scenario7
fi

#Exit on user's input
read -p "Do you want to continue?(y/n): " yn
if [ $yn = "n" ] || [ $yn = "N" ];
then
	break
elif [ $yn = "y" ] || [ $yn = "Y" ];
then
	continue
fi
done
