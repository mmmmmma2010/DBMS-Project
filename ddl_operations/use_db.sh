#!/bin/bash
shopt -s extglob
source ./dml_operations/table_menu.sh

function use_DB {
  echo -e "Enter Database Name: \c"
  read DBName
  cd ./DBMS

  if ! [[ -d $DBName  ]]
  then  
		echo not found 
	  cd ..	
		main_Menu
  fi
  cd ./$DBName 2>>./.error.log
  if [[ $? == 0 ]]; then
    echo "Database $DBName was Successfully Selected"
    
    tablesMenu
  else
    echo "Database $DBName wasn't found"
    echo "please try again"
    use_DB
  fi
}

use_DB

