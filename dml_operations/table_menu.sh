#!/bin/bash
shopt -s extglob

source ./dml_operations/createTable.sh
source ./dml_operations/selectMenu.sh
source ./dml_operations/insert.sh
source ./dml_operations/updateTable.sh
source ./dml_operations/deleteFromTable.sh
source ./dml_operations/dropTable.sh

function tablesMenu {
  echo "*************************************"
  echo "*          Tables Menu              *"
  echo "* 1. Show Tables                    *"
  echo "* 2. Create Table                   *"
  echo "* 3. Insert Into Table              *"
  echo "* 4. Select From Table              *"
  echo "* 5. Update Table                   *"
  echo "* 6. Delete From Table              *"
  echo "* 7. Drop Table                     *"
  echo "* 8. Back To Main Menu              *"
  echo "* 9. Exit                           *"
  echo "*************************************"
  echo -e "Enter Choice: \c"
  read choice
  case $choice in
    1)  ls . | column -t ; tablesMenu ;;
    2)  createTable ;;
    3)  insert ;;
    4)  clear; selectMenu ;;
    5)  updateTable ;;
    6)  deleteFromTable ;;
    7)  dropTable ;;
    8) clear; cd ../.. 2>>./.error.log; main_Menu ;;
    9) exit; echo "exit db we will miss you" ;;
    *) echo " Wrong Choice " ; tablesMenu;
  esac

}






















