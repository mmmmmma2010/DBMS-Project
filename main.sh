#!/bin/bash
shopt -s extglob
mkdir DBMS 2>> ./.error.log
clear
echo "**************************************************************************************************"
echo "**************************************************************************************************"
echo "* Welcome To DBMS – Team (Fathi Yehia – Hani Mohsen –  Mohamed Ali) - Full stack using Python    *"
echo "* Databases are Directories .... Tables are Files with extension .tb                             *"
echo "* Every Choose you are in (yes,no,int,str,etc...) just enter choice number (1,2,3 ...)           *"
echo "* Please Follow the Instructions to not Interface Troubles using this App                        *"
echo "* For any Further Information please contact us                                                  *"
echo "**************************************************************************************************"
echo "**************************************************************************************************"

function main_Menu {
  echo "***********************************"
  echo "*           Main Menu             *"
  echo "* 1. use_DB                       *"
  echo "* 2. Create DB                    *"   
  echo "* 3. Drop DB                      *"
  echo "* 4. list DBs                     *"
  echo "* 5. Exit                         *"
  echo "***********************************"
  echo -e "Enter Choice: \c"
  read choice
  case $choice in
    1)  . ./ddl_operations/use_db.sh ;;
    2)  . ./ddl_operations/create_db.sh ;;
    3)  . ./ddl_operations/drop_db.sh ;;
    4)  ls ./DBMS | column -t; main_Menu;;
    5) echo "exit db we will miss you";
       exit;;
    *) echo "wrong query please choose one of menu " ; 
    main_Menu;
  esac
}

main_Menu