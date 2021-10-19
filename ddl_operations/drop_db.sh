#!/bin/bash
shopt -s extglob

function dropDB {
  echo -e "Enter Database Name: \c"
  read DBName
  cd ./DBMS
  if ! [[ -d $DBName  ]]
  then
                echo not found 
                cd ..
                main_Menu
  fi


  rm -r ./$DBName  2>>./.error.log
  if [[ $? == 0 ]]; then
    echo "Database $DBName Dropped Successfully"
  else
    echo "Database Not found"
  fi
  cd ..
  main_Menu
}

dropDB