#!/bin/bash
shopt -s extglob

function deleteFromTable {
  echo -e "Enter Table Name: \c"
  read tableName
  
  if ! [[ -f $tableName ]]; then
    echo "Table $tableName isn't existed ,choose another Table"
    deleteFromTable
  fi

  echo -e "Enter Condition Column name: \c"
  read column
  selColumn=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$column'") print i}}}' $tableName)
  if [[ $selColumn == "" ]]
  then
    echo "Not Found"
    tablesMenu
  else
  # echo $selColumn
    echo -e "Enter Condition Value: \c"
    read value
    result=$(awk 'BEGIN{FS="|"}{if ($'$selColumn'=="'$value'") print $'$selColumn'}' $tableName 2>>./.error.log)
    if [[ $result == "" ]]
    then
      echo "Value Not Found"
      tablesMenu
    else
      NR=$(awk 'BEGIN{FS="|"}{if ($'$selColumn'=="'$value'") print NR}' $tableName 2>>./.error.log)
      sed -i ''$NR'd' $tableName 2>>./.error.log
      echo "Row Deleted Successfully"
      tablesMenu
    fi
  fi
}
