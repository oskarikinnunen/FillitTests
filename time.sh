#FILLITPATH=~/fillit_tet_branch

tput setaf 2

echo "TESTING TIME OF $FILLITPATH/fillit WITH max.txt"
#../fillit-tests/input/26_easy
TIME=`(time $FILLITPATH/fillit ../max.txt) 2>&1 | grep real`
MINUTES=$(echo "$TIME" | cut -d '	' -f2 | cut -d 'm' -f1)
SEC=$(echo "$TIME" | cut -d '	' -f2 | cut -d 'm' -f2 | cut -d ',' -f1)

let MINSEC=$MINUTES*60
let FINALSEC=$MINSEC+SEC
#echo "MINSEC IS $MINSEC"
echo -e "TOOK $FINALSEC SECONDS TO RUN FILLIT"
SCHOOLSEC=$(python3 -c "print(round($FINALSEC*1.47))")
echo -e "ESTIMATE TIME ON SCHOOL COMPUTER:\n$SCHOOLSEC SECONDS\n"
#echo "TIME IS $TIME"