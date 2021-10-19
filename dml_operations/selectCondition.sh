#!/bin/bash
shopt -s extglob

source ./dml_operations/selectAllColumns.sh
source ./dml_operations/specColUnderCond.sh

function selectCondition {
  echo "*************************************************"
  echo "*         Select Under Condition Menu           *"
  echo "* 1. Select Record Matching Condition           *"
  echo "* 2. Select Specific Column Matching Condition  *"
  echo "* 3. Back To Main Menu                          *"
  echo "* 4. Exit                                       *"
  echo "*************************************************"
  echo -e "Enter Choice: \c"
  read choice
  case $choice in
    1) clear; selectAllColumns ;;
    2) clear; specColUnderCond ;;
    3) clear; cd ../.. 2>>./.error.log; main_Menu ;;
    4) echo "exit db we will miss you"; exit ;;
    *) echo " Wrong Choice " ; selectCondition;
  esac
}