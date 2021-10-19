#!/bin/bash
shopt -s extglob

function createDB {
  echo -e "Enter Database Name: \c"
  read DBName

  if [[ $DBName == "" ]]; then
    echo "Database Name must have no spaces or special character"
    createDB
  else
    if [[ -d ./DBMS/$DBName ]]; then
    echo "Database name is exist"
      else
      mkdir ./DBMS/$DBName
      if [[ $? == 0 ]]; then
        echo "Database $DBName Created Successfully"
      else
        echo "Error Creating Database $DBName"
        echo "please try again"
        createDB
      fi
    fi

  fi
  # case $DBName in

  #     *)

  #    +([a-zA-Z0-9]))

  # esac
  main_Menu
}

createDB
