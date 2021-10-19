#!/bin/bash
shopt -s extglob

function createTable {
  echo -e "Table Name: \c"
  read tableName
	if ! [[ $tableName =~ ^[a-zA-Z0-9]+$ ]]; then
		echo "table name must have char "
		createTable
	fi
  if [[ -f $tableName ]]; then
    echo " this table already existed "
    echo "please try again"
    createTable
  fi
   echo -e "Number of Columns: \c"
  read colsNum
   while ! [[ $colsNum =~ ^[0-9]+$ ]]; do
         echo " Number of Columns must be a number "
	 #createTable
	 echo -e "Number of Columns: \c"

	 read colsNum
 done
  
  counter=1
  sep="|"
  rSep="\n"
  pKey=""
  x=1
  metaData="Field"$sep"Type"$sep"key"
  checkarray=()
  while [ $counter -le $colsNum ]
  do
    echo -e "Name of Column No.$counter: \c"
    read colName
    #set -x
    while ! [[ $colName =~ ^[a-zA-Z0-9]+$ ]]; do
	    echo name of column must have char
	    read colName
    done

    while [[ $x == 1 ]] 
    do
    	for col1 in "${checkarray[@]}"
    	do
    		if [[ $col1 == $colName ]]
    		then 
	    		echo "this column already existed"
	     		echo -e "Name of Column No.$counter: \c"
	    		read colName
			x=1
	
    		fi
    	done
	checkarray+=("$colName")
	x=0
	echo $x
	echo ${checkarray[@]}
    done
    #set +x
    echo -e "Type of Column $colName: "
    select var in "int" "str"
    do
      case $var in
        int ) colType="int";break;;
        str ) colType="str";break;;
        * ) echo "Wrong Choice" ;;
      esac
    done
    if [[ $pKey == "" ]]; then
      echo -e "Make PrimaryKey ? "
      select var in "yes" "no"
      do
        case $var in
          yes ) pKey="PK";
          metaData+=$rSep$colName$sep$colType$sep$pKey;
          break;;
          no )
          metaData+=$rSep$colName$sep$colType$sep""
          break;;
          * ) echo "Wrong Choice" ;;
        esac
      done
    else
      metaData+=$rSep$colName$sep$colType$sep""
    fi
    if [[ $counter == $colsNum ]]; then
      temp=$temp$colName
    else
      temp=$temp$colName$sep;
      echo $temp;
    fi
       
    ((counter++)) 
     x=1 
     done
  touch .$tableName
  echo -e $metaData  >> .$tableName
  touch $tableName
  echo -e $temp >> $tableName
  if [[ $? == 0 ]]
  then
    echo "Table Created Successfully"
    tablesMenu
  else
    echo "Error Creating Table $tableName"
    tablesMenu
  fi
  
} 