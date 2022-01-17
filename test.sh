#fillitpath=~/fillit_passed/ProjectFiles/ #For setting the correct answers, set this to a confirmed passed fillit project and comment out the next line
fillitpath=~/fillit_ours #CHANGE THIS TO THE EVALUATEES PATH

fillit=$fillitpath/fillit
libftpath=$fillitpath/libft #CHANGE IF NEEDED
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
make re -C $fillitpath
rm -rf $diffsummary
rm -rf $valgrindsummary
rm -rf $mypath/diffs/*
rm -rf $mypath/valgrind/*
printf "${NOCOLOR}"

#DIFFS
echo "FILLIT IS ASSUMED TO BE HERE = $fillit"
touch $diffsummary
for filename in $mypath/input/*; do
	file=$(echo "$filename" | cut -d "/" -f 6)
	echo "$file"
	$fillit $filename > "$mypath/their_res/$file"
	#$fillit $filename > "$mypath/res/$file" #For setting the correct answers
	diffvar=$(diff "$mypath/their_res/$file" "$mypath/res/$file")
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


printf "\nDIFFS FOLDER CONTENTS AFTER TESTS:\n${RED}"
cd $mypath/diffs && stat -c "SIZE OF DIFF-FILE %s %n" *
printf "\n${BLUE}RUNNING WITH VALGRIND:${NOCOLOR}\n"

#VALGRIND
for filename in $mypath/input/*; do
	file=$(echo "$filename" | cut -d "/" -f 6)
	echo "$file"
	if ! [ "$#" -ne 1 ] && [ $1 == "o" ]
	then
		echo -e "${RED}OUTPUT:${BLUE}"
		valgrind --log-file="$mypath/valgrind/$file" $fillit $filename
		echo -e "${NOCOLOR}\n"
	else
		valgrind --log-file="$mypath/valgrind/$file" $fillit $filename &> /dev/null
	fi
done
#With invalid file name arg
valgrind --log-file="$mypath/valgrind/invalidfilename" $fillit invalidfilename &> /dev/null
#With no file name arg
valgrind --log-file="$mypath/valgrind/noargument" $fillit &> /dev/null

rm -f $valgrindsummary
echo "valgrind summary:
" > $valgrindsummary
printf "${RED}making valgrind summaries for files${NOCOLOR}\n"
for filename in $mypath/valgrind/*; do
	file=$(echo "$filename" | cut -d "/" -f 6)
	echo "$filename:" >> $valgrindsummary
	cat $filename | grep 'leaks\|leak\|free' >> $valgrindsummary
	echo "
	" >> $valgrindsummary
done

echo -e "\nDONE!"