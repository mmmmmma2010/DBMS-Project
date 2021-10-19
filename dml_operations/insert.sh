#!/bin/bash
shopt -s extglob

function insert {
  echo -e "Table Name: \c"
  read tableName
  if ! [[ -f $tableName ]]; then
    echo "Table $tableName isn't existed ,choose another Table"
    tablesMenu
  fi
  column_Num=`awk 'END{print NR}' .$tableName`
  sep="|"
  rSep="\n"
  for (( i = 2; i <= $column_Num; i++ )); do
    column_Name=$(awk 'BEGIN{FS="|"}{ if(NR=='$i') print $1}' .$tableName)
    column_Type=$( awk 'BEGIN{FS="|"}{if(NR=='$i') print $2}' .$tableName)
    column_Key=$( awk 'BEGIN{FS="|"}{if(NR=='$i') print $3}' .$tableName)
    echo -e "$column_Name ($column_Type) = \c"
    read value
    
    # Validate Input
    if [[ $column_Type == "int" ]]; then
      while ! [[ $value =~ ^[0-9]+$ ]]; do
        echo -e "invalid DataType !!"
	      echo -e "$column_Name ($column_Type) = \c"
        read value
      done
    elif [[ $column_Type == "str" ]]; then
      while ! [[ $value =~ ^[a-zA-Z]+$ ]]; do
        echo -e "invalid DataType !!"
        echo -e "$column_Name ($column_Type) = \c"
        read value
      done
    fi
	
    if [[ $column_Key == "PK" ]]; then
	    x="true"
      while [[ $x == "true" ]]; do 
	      if [[ $column_Type == "int" ]] ;then
          pks=$(awk 'BEGIN{FS="|" ;ORS=" " }{if(NR != 1) print $(('$i'-1))}' $tableName)
          found="false"
          for item in ${pks[@]}; do
			      if [[ $value == $item ]] || ! [[ $value =~ ^[0-9]+$ ]]; then 
				      found="true"
              break
			      fi
		      done

          if [[ $found == "true" ]] ;then
            echo -e "invalid value for Primary Key !! \c"
            read value
          else
            x=""
          fi

	      elif [[ $column_Type == "str" ]]; then
	        pkss=$(awk 'BEGIN{FS="|" ;ORS=" " }{if(NR != 1) print $(('$i'-1))}' $tableName)
			    found="false"
          for itemm in ${pkss[@]}; do
            if [[ $value == $itemm ]] || ! [[ $value =~ ^[a-zA-Z]+$ ]]; then
              found="true"
              break
            fi
          done

          if [[ $found == "true" ]] ;then
            echo -e "invalid value for Primary Key !! \c"
            read value
          else
            x=""
          fi
        fi
      done
    fi

    #pass row to table
    if [[ $i == $column_Num ]]; then
      row=$row$value$rSep
    else
      row=$row$value$sep
    fi
    # echo "after row"
  done

  echo -e $row"\c" >> $tableName
  if [[ $? == 0 ]]
  then
    echo "Data Inserted Successfully"
  else
    echo "Error Inserting Data into Table $tableName"
  fi
  row=""
  tablesMenu
}