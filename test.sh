#FILLITPATH=~/fillit_passed/ProjectFiles/ #For setting the correct answers, set this to a confirmed passed fillit project and comment out the next line
FILLITPATH=~/fillit_t #CHANGE THIS TO THE EVALUATEES PATH

export FILLITPATH

fillit=$FILLITPATH/fillit
libftpath=$FILLITPATH/libft #CHANGE IF NEEDED
mypath=$(pwd)
valgrindsummary=$mypath/results_valgrind
diffsummary=$mypath/results_diff
RED='\033[0;31m'
BLUE='\033[0;34m'
NOCOLOR='\033[0m'

#make re libft and fillit, empty diffs and valgrind folders
printf "${RED}"
make re -C $libftpath
printf "${BLUE}"
make re -C $FILLITPATH
rm -rf $diffsummary
rm -rf $valgrindsummary
rm -rf "$valgrindsummary-2"
rm -rf $mypath/diffs/*
rm -rf $mypath/valgrind/*
rm -rf $mypath/their_res/*
printf "${NOCOLOR}"

#DIFFS
echo "FILLIT IS ASSUMED TO BE HERE = $fillit"
touch $diffsummary
for filename in $mypath/input/*; do
	file=$(basename "$filename")
	echo "FILE FOUND UNDER INPUT $file"
	$fillit $filename > "$mypath/their_res/$file"
	#$fillit $filename > "$mypath/res/$file" #For setting the correct answers
	diffvar=$(diff "$mypath/their_res/$file" "$mypath/res/$file")
	#echo "$(pwd)"
	#echo "$mypath"
	echo -n "$diffvar" > "$mypath/diffs/$file"
	if [[ "$diffvar" != "" ]]
	then
		echo -e "$file had diff:\nINPUT:\n" >> "$diffsummary"
		cat "$filename" >> "$diffsummary"
		echo -e "\nDIFF:\n" >> "$diffsummary"
		echo "$diffvar" >> "$diffsummary"
	fi
done

echo -e "\nSPECIAL DIFFS:\n" >> "$diffsummary"
#invalidfilename
filename="invalidfilename"
$fillit $filename > "$mypath/their_res/$filename"
diffvar=$(diff "$mypath/their_res/$filename" "$mypath/res/$filename")
diff "$mypath/their_res/$filename" "$mypath/res/$filename" > "$mypath/diffs/$filename"
echo -n "$diffvar" > "$mypath/diffs/$filename"
echo -en "invalidfilenamediff:\n$diffvar" >> "$diffsummary"
#running without argument
filename="noargument"
$fillit > "$mypath/their_res/$filename"
diffvar=$(diff "$mypath/their_res/$filename" "$mypath/res/$filename")
diff "$mypath/their_res/$filename" "$mypath/res/$filename" > "$mypath/diffs/$filename"
echo -n "$diffvar" > "$mypath/diffs/$filename"
echo -en "without arg diff:\n$diffvar" >> "$diffsummary"


printf "\nDIFFS SIZES AFTER TESTS:\n${RED}"
cd $mypath/diffs && stat -c "%s	%n" *
printf "\n${BLUE}RUNNING WITH VALGRIND:${NOCOLOR}\n"

#VALGRIND
for filename in $mypath/input/*; do
	file=$(echo "$filename" | cut -d "/" -f 6)
	
	if ! [ "$#" -ne 1 ] && [ $1 == "o" ]
	then
		echo "$file"
		echo -e "${RED}OUTPUT:${BLUE}"
		valgrind --log-file="$mypath/valgrind/$file" $fillit $filename
		echo -e "${NOCOLOR}\n"
	else
		echo -n "."
		valgrind --log-file="$mypath/valgrind/$file" $fillit $filename &> /dev/null
	fi
done
#With invalid file name arg
valgrind --log-file="$mypath/valgrind/invalidfilename" $fillit invalidfilename &> /dev/null
#With no file name arg
valgrind --log-file="$mypath/valgrind/noargument" $fillit &> /dev/null

echo -e "valgrind summary:\n" > $valgrindsummary
printf "\n${RED}making valgrind summaries for files${NOCOLOR}\n"
for filename in $mypath/valgrind/*; do
	file=$(basename "$filename")
	echo "$filename:" >> $valgrindsummary
	echo "$filename:" >> "$valgrindsummary-2"
	cat $filename | grep 'LEAK SUMMARY' -A 10 >> $valgrindsummary
	cat $filename | grep 'lost' >> "$valgrindsummary-2"
	echo -e "\n" >> $valgrindsummary
	echo -e "\n" >> "$valgrindsummary-2"
done

echo -e "\nDONE!\n"

cd $mypath

#UNCOMMENT the line below to run time tests
#bash ./time.sh
