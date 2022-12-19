#!/bin/bash
# DEFAULT
NAME=$(basename "$0")
LOGS="${NAME}.log"
INPUT=makretplace.csv
OUTPUT=README.md
[ -z "$OUTPUT" ] && echo "!!! Second Param, Target File" && exit
[ ! -w "$OUTPUT" ] && echo -n "" > $OUTPUT
[ ! -r "$OUTPUT" ] && echo "!!! NOT READABLE: $OUTPUT" && exit
#
# Script to split a string based on the delimiter
#LINES=$(cat $INPUT)
echo "# [texttoservice:](http://www.texttoservice.com/)" > $OUTPUT
echo "" >> $OUTPUT
COUNTER=0
LIMIT=2

while
  LINE=
  IFS=$' \t\r\n' read -r LINE || [[ $LINE ]]
do
  [ -z "$LINE" ] && echo "REMOVED: $LINE" >>$LOGS && continue
  COUNTER=$((COUNTER+1))

    if [ $COUNTER -lt $LIMIT ]; then
        continue
    fi

    while IFS=';' read -ra ROW; do
        #echo $ROW
        #for COL in "${ROW[@]}"; do
         #   echo $COL
            echo "## [${ROW[0]}](${ROW[3]})" >> $OUTPUT
            echo "${ROW[1]} " >> $OUTPUT
            REPO=${ROW[2]}
            # DOWNLOAD CONTENT and ATTACHe to DESCRIPTION
            #git clone $REPO
            #curl https://raw.githubusercontent.com/readock-com/bash/main/README.md
            echo "$REPO " >> $OUTPUT
            echo " " >> $OUTPUT
          #  echo $COL >> $OUTPUT
            #echo $COL[0] >> $OUTPUT
        #done
    done <<< "${LINE[@]}"

done <"$INPUT"



exit
for ROW in $LINES
do
  COUNTER=$((COUNTER+1))
  if [ $COUNTER -eq $LIMIT ]; then
      continue
  fi
  echo $ROW
  IFS=';'
  #Print the split string
  for i in ${ROW}
  do
      echo $i >> $OUTPUT
  done
done