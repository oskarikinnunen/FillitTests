#fillitpath=~/fillit_passed/ProjectFiles/ #For setting the correct answers, set this to a confirmed passed fillit project and comment out the next line
fillitpath=~/fillit_ours #CHANGE THIS TO THE EVALUATEES PATH

fillit=$fillitpath/fillit
libftpath=$fillitpath/libft #CHANGE IF NEEDED
mypath=$(pwd)
RED='\033[0;31m'
BLUE='\033[0;34m'
NOCOLOR='\033[0m'


#make re libft and fillit, empty diffs and valgrind folders
printf "${RED}"
make re -C $libftpath
printf "${BLUE}"
make re -C $fillitpath
rm -rf $mypath/diffs/*
rm -rf $mypath/valgrind/*
printf "${NOCOLOR}"

#DIFFS
echo "FILLIT IS ASSUMED TO BE HERE = $fillit"
for filename in ~/fillit_tests/input/*; do
	file=$(echo "$filename" | cut -d "/" -f 6)
	echo "$file"
	$fillit $filename > "$mypath/their_res/$file"
	#$fillit $filename > "$mypath/res/$file" #For setting the correct answers
	diff "$mypath/their_res/$file" "$mypath/res/$file" > "$mypath/diffs/$file"
done
$fillit invalidfilename > "$mypath/their_res/invalidfilename"
$fillit > "$mypath/their_res/noargument"

printf "
DIFFS FOLDER CONTENTS AFTER TESTS:
${RED}"
cd $mypath/diffs && ls -l
printf "
${BLUE}
RUNNING WITH VALGRIND:${NOCOLOR}
"
#VALGRIND
for filename in ~/fillit_tests/input/*; do
	file=$(echo "$filename" | cut -d "/" -f 6)
	echo "$file"
	valgrind --log-file="$mypath/valgrind/$file" $fillit $filename
done
#With invalid file name arg
valgrind --log-file="$mypath/valgrind/invalidfilename" $fillit invalidfilename
#With no file name arg
valgrind --log-file="$mypath/valgrind/noargument" $fillit