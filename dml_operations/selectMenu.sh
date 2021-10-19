#!/bin/bash
shopt -s extglob

source ./dml_operations/displayTable.sh
source ./dml_operations/selectColumn.sh
source ./dml_operations/selectCondition.sh

function selectMenu {
  echo "***************************************************"
  echo "*                  Select Menu                    *"
  echo "* 1. Display All Contents of a Table              *"
  echo "* 2. Select A Column from a Table                 *"
  echo "* 3. Select Record From Table with condition      *" 
  echo "* 4. Back To Tables Menu                          *"
  echo "* 5. Back To Main Menu                            *"
  echo "* 6. Exit                                         *"
  echo "***************************************************"
  echo -e "Enter Choice: \c"
  read ch
  case $ch in
    1) displayTable ;;
    2) selectColumn ;;
    3) clear; selectCondition ;;
    4) clear; tablesMenu ;;
    5) clear; cd ../.. 2>>./.error.log; main_Menu ;;
    6) echo "exit db we will miss you"; exit ;;
    *) echo " Wrong Choice " ; selectMenu;
  esac
}

