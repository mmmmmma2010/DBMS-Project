#!/bin/bash
shopt -s extglob

function updateTable {
  echo -e "Enter Table Name: \c"
  read tableName

  if ! [[ -f $tableName ]]; then
    echo "Table $tableName isn't existed ,choose another Table"
    tablesMenu
  fi

  echo -e "Enter Condition Column name: \c"
  read field
  fid=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$field'") print i}}}' $tableName)
  if [[ $fid == "" ]]
  then
    echo "Not Found"
    tablesMenu
  else
    echo -e "Enter Condition Value: \c"
    # echo $fid
    read value
    result=$(awk 'BEGIN{FS="|"}{if ($'$fid'=="'$value'") print $'$fid'}' $tableName 2>>./.error.log)
    if [[ $result == "" ]]
    then
      echo "Value Not Found"
      tablesMenu
    else
      echo -e "Enter FIELD name to set: \c"
      read setField
      setFid=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$setField'") print i}}}' $tableName)
      if [[ $setFid == "" ]]
      then
        echo "Not Found"
        tablesMenu
      else
        #echo -e "Enter new Value to set: \c"
	column_Key=$( awk 'BEGIN{FS="|"}{if(NR==(('$setFid+1'))) print $3}' .$tableName)
		
	 if [[ $column_Key == "PK" ]]; then

              echo "you can not update primary Key choose anthor column"
                updateTable

		fi
	echo -e "Enter new Value to set: \c"


        read newValue
	      column_Type=$( awk 'BEGIN{FS="|"}{if(NR==(('$setFid+1'))) print $2}' .$tableName)
        column_Key=$( awk 'BEGIN{FS="|"}{if(NR==(('$setFid+1'))) print $3}' .$tableName)
	      # echo $column_Type
	      # echo $column_Key
	      if [[ $column_Type == "int" ]]; then
        while ! [[ $newValue =~ ^[0-9]+$ ]]; do
        echo -e "invalid DataType !!\c"
	      echo -e "Enter new Value to set: \c"
	      read newValue
        done
	      elif [[ $column_Type == "str" ]]; then
        while ! [[ $newValue =~ ^[a-zA-Z]+$ ]]; do
        echo -e "invalid DataType !!"
        echo -e "the type of column $column_Type \c"
	      echo -e "Enter new Value to set: \c"

        read newValue
        done

    	fi

      #if [[ $column_Key == "PK" ]]; then

	#      echo "you can not update primary Key choose anthor column"
		#updateTable 
	 #     x="true"
      	#while [[ $x == "true" ]]; do
         # if [[ $newValue =~ ^[`awk 'BEGIN{FS="|" ;ORS=" " }{if(NR != 1) print $(('$setFid-1'))}' $tableName`]$ ]]; then
          #echo -e "invalid value for Primary Key !!\c"
    
	        #echo -e "the type of column $column_Type \n"
          # echo -e "Enter new Value to set: \c"
          # read newValue

		

         # else	
          #  break;

	      #    if [[ $column_Type == "int" ]]; then
              #while ! [[ $newValue =~ ^[0-9]+$ ]]; do
               # echo -e "invalid DataType !!\c"
                #echo -e "Enter new Value to set: \c"
                #read newValue
	        #      x=""
             # done
            #elif [[ $column_Type == "str" ]]; then
             # while ! [[ $newValue =~ ^[a-zA-Z]+$ ]]; do
              #  echo -e "invalid DataType !!"
               # echo -e "the type of column $column_Type \c"
                #echo -e "Enter new Value to set: \c"
	         #     x=""
                #read newValue
         #     done

          #  fi


          #fi
           # echo -e "the type of column $column_Type \n"
	    #      echo -e "Enter new Value to set: \c"
            #read newValue
	
      #  done
      #fi


	
        NR=$(awk 'BEGIN{FS="|"}{if ($'$fid' == "'$value'") print NR}' $tableName 2>>./.error.log)
        oldValue=$(awk 'BEGIN{FS="|"}{if(NR=='$NR'){for(i=1;i<=NF;i++){if(i=='$setFid') print $i}}}' $tableName 2>>./.error.log)
        echo $oldValue
        sed -i ''$NR's/'$oldValue'/'$newValue'/g' $tableName 2>>./.error.log
        echo "Row Updated Successfully"
        tablesMenu
      fi
    fi
  fi
}