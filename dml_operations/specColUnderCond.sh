#!/bin/bash
shopt -s extglob

function specColUnderCond {
  echo -e "Select specific column from TABLE Where FIELD(OPERATOR)VALUE \n"
  echo -e "Enter Table Name: \c"
  read tableName 
    if ! [[ -f $tableName ]]; then
    echo "Table $tableName isn't existed ,choose another Table \n"
    specColUnderCond
  fi
  echo -e "Enter required FIELD name: \c"
  read field
  fid=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$field'") print i}}}' $tableName)
  # echo $fid
  if [[ $fid == "" ]]
  then
    echo "Not Found"
    selectCondition
  else
    echo -e "\nSupported Operators: [==, !=, >, <, >=, <=] \nSelect OPERATOR: \c"
    read op
    if [[ $op == "==" ]] || [[ $op == "!=" ]] || [[ $op == ">" ]] || [[ $op == "<" ]] || [[ $op == ">=" ]] || [[ $op == "<=" ]]
    then
      echo -e "\nEnter required VALUE: \c"
      read value
      if [[ $value =~ ^[a-zA-Z]+$ ]]; then
              value=\"$value\"
      fi

      result=$(awk 'BEGIN{FS="|"; ORS="\n"}{if ($'$fid$op$value') print $'$fid'}' $tableName 2>>./.error.log |  column -t -s '|')
      if [[ $result == "" ]]
      then
        echo "Value Not Found"
        selectCondition
      else
        awk 'BEGIN{FS="|"; ORS="\n"}{if ($'$fid$op$value') print $'$fid'}' $tableName 2>>./.error.log |  column -t -s '|'
        selectCondition
      fi
    else
      echo "Unsupported Operator\n"
      selectCondition
    fi
  fi
}