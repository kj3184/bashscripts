#!/bin/bash
#Script-Name: sortnumbers.sh
#Description: This script sorts the digits (0-9) in provided number file
# from server


sortnumbers()
{

	filesize=$( stat -c %s $filename)

	echo $filesize
	# file size =1mb
	maxsize=1000000

	if [ $filesize -gt $maxsize ]
	then
		sortlargefiles
	else
		sortsmallerfile
	fi
	
	removeTempFiles

}

sortsmallerfile()
{

	inputstring=`cat $filename | grep -o .`

	#echo $inputstring

	echo $inputstring| tr " " "\n" > tempinputdigitssorted.txt

	sort -g tempinputdigitssorted.txt | tr "\n" " " > sortednumbers.txt

}


sortlargefiles()
{

	split -b 1000k $filename '_tmp'

	ls -1 _tmp* | while read FILE; do cat $FILE | grep -o . > $FILE'_' ; sort -n $FILE'_' -o $FILE'__' & done;

	# important - required for slower IO bound systems
	sleep 20s

	sort -m _tmp*__ -o tempinputdigitssorted.txt

	cat tempinputdigitssorted.txt | tr "\n" " " > sortednumbers.txt
}

removeTempFiles()
{
	rm -f _tmp*

	rm -f tempinputdigitssorted.txt
}

startexecution=$(date +"%T")

echo "The script execution started at : $startexecution"

filename='inputdigits.txt'

sortnumbers

echo "please check sortednumbers.txt for output"

finishexecution=$(date +"%T")

echo "The script execution finished at : $finishexecution"