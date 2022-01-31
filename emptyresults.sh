#	This is just to make life easier for me
#	Not needed to run test.sh, test.sh will also empty these folders

rm -f their_res/*
rm -f diffs/*
rm -f valgrind/*
rm -f results_valgrind*
rm -f results_diff

# These are here so git doesn't ignore the folders
touch their_res/ignore
touch diffs/ignore
touch valgrind/ignore