#!/bin/sh

read -p "Select File : " file
echo "Reading the selected file" $file
hdr="HDR"
headerString=$(head -n 1 $file | cut -d , -f 1)
echo "Header string : " $headerString
headerDate=$(head -n 1 $file | cut -d , -f 2 | tr -d '[:space:]')
echo "Header date : " $headerDate
currentDate=$(date +"%m/%d/%Y")
echo "Todays date : " $currentDate
if [ $hdr == $headerString ]
then 
	if [ $currentDate == $headerDate ]
	then	
		read -p "Un necessary rows : " rows
		tcount=$(tail -n 1 $file | cut -d , -f 2)
		echo "Tail Count Given : "$tcount
		totalRecordCount=$(wc -l < $file)
		echo "Total records with header and tailer are : "$totalRecordCount
		recordsCount=$(($totalRecordCount-$rows))
		echo "Only record count : "$recordsCount
		if [ $tcount == $recordsCount ]
		then
			echo "Matched, moving to lfs landing zone"
		else
			echo "File currpoted!"
		fi
	else
		echo "Date missmatch!"
	fi
else
	echo "Header missmatch!"
fi
