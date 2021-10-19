#!/bin/bash
shopt -s extglob


function displayTable {
  echo -e "Enter Table Name: \c"
  read tableName
	
  if ! [[ $tableName =~ ^[a-zA-Z0-9]+$ ]]; then
                echo "table name must have char "
                selectMenu
        fi



  column -t -s '|' $tableName 2>>./.error.log
  if [[ $? != 0 ]]
  then
    echo "Error Displaying Table $tableName"
  fi
  selectMenu
}
