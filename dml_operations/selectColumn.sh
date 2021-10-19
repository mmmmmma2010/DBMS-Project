#!/bin/bash
shopt -s extglob

function selectColumn {
  echo -e "Enter Table Name: \c"
  read tableName
  
  if ! [[ -f $tableName ]]; then
    echo "Table $tableName isn't existed ,choose another Table"
    selectColumn
  fi

  echo -e "Enter Column name to View: \c"
  read field
  fid=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$field'") print i}}}' $tableName)
  if [[ $fid == "" ]]
  then
    echo "Not Found"
    selectColumn
  else
  awk 'BEGIN{FS="|"}{print $'$fid'}' $tableName
  selectMenu
  fi
}