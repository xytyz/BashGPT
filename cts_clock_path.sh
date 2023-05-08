#! /usr/bin/bash

filename=$1

function clock_path ()
{
  while true
  do
  echo "Select clock 
        1 for m_clk
        2 for m_digit_clk
        3 for m_dsram_clk
        4 for m_ram_clk
        5 for m_rcc_clk
        6 for m_spt_clk
        7 for ref_clk
          "
        
  read -p "Enter= " S1
  case $S1 in 
     1) clock=m_clk; break;;
     2) clock=m_digit_clk; break;;
     3) clock=m_dsram_clk; break;;
     4) clock=m_ram_clk; break;;
     5) clock=m_rcc_clk; break;;
     6) clock=m_spt_clk; break;;
     7) clock=ref_clk; break;;
     *) echo "###  Select from the given options  ###";;
    esac
  done
  ##################################################
  while  true
  do 
  echo "Select Mode
        1 for functional_mode
        2 for scan_mode
        3 for test_mode
          "
  read -p "Enter= " S2
  case $S2 in 
     1) mode=functionnal_mode; break;;
     2) mode=scan_mode; break;;
     3) mode=test_mode; break;;
     *) echo "###  Select from the given options  ###";;
   esac
  done
  ##################################################
  while true 
  do
  echo "Select delay corner
        1 for CMAX
        2 for RCMAX
        3 for RMAX
        4 for CMIN
        5 for RCMIN
        6 for RMIN
          "
  read -p "Enter= " S3
  case $S3 in 
     1) DCV2=CMAX; break;;
     2) DCV2=RCMAX; break;;
     3) DCV2=RMAX; break;;
     4) DCV2=CMIN; break;;
     5) DCV2=RCMIN; break;;
     6) DCV2=RMIN; break;;
     *) echo "###  Select from the given options  ###";;
  esac
  done
  ##################################################
  while true 
  do
  echo "Select options
        1 for slow
        2 for fast
          "
  read -p "Enter= " S4
  case $S4 in
     1) DCV1=slow; break;;
     2) DCV1=fast; break;;
     *) echo "###  Select from the given options  ###";;
  esac
  done
  
  ##################################################
  
  while true
  do
  echo "Select options
        1 for early
        2 for late
          "
  read -p "Enter= " S5
  case $S5 in
     1) DCV3=early; break;;
     2) DCV3=late; break;;
     *) echo "###  Select from the given options  ###";;
  esac
  done
  
  ##################################################
  
  temp1=`echo "delay_corner_$DCV1""_$DCV2:both.$DCV3"`
  
  temp2=`echo " $clock/$mode"`
  
  ##################################################
  
   
     max_path=`sed -n '/Skew Group Min/,/Timing for timing corner delay_corner_slow_CMAX:both.early, min clock_path:/p' $filename | egrep -A52 "$temp1" | egrep "$temp2" | awk '{print $NF}'`

     min_path=`sed -n '/Skew Group Min/,/Timing for timing corner delay_corner_slow_CMAX:both.early, min clock_path:/p' $filename | egrep -A52 "$temp1" | egrep "$temp2" | awk '{print $(NF-2)}'`

  ##################################################
     
     temp3=`echo "PathID    : $min_path$"`
     temp4=`echo "PathID    : $max_path$"`
     
     echo -e "\n\n####  Now this is the result:  ####\n"
     echo -e "#########  MIN_clock_path  #########\n"
     sed -n "/$temp3/,/timing/p" $filename | head -n -1 
     
     echo -e "#########  MAX_clock_path  #########\n"
     sed -n "/$temp4/,/timing/p" $filename | head -n -1 

}

clock_path
