USAGE:
1. Change the "fillitpath" variable in test.sh
2. Run test.sh
3. Check diffs folder for discrepancies
	note: "usage" message of fillit without parameters can/will vary since it's exact form is not specified in the PDF
4. Check valgrind folder for valgrind output with different cases

IF YOU WANT TO ADD MORE TEST CASES:
1. add the input file to the	 'input' folder
2. add the correct result in the 'res'	 folder

FOLDER STRUCTURE EXPLANATION:
input		INPUT FILES FOR THE PROGRAM
res			CORRECT RESULTS, THESE ARE CURRENTLY GENERATED MOSTLY FROM THE "https://github.com/JemCopeCodes/42-Fillit" REPOSITORYS ANSWERS
their_res	EVALUATEES RESULTS
diffs		DIFFS BETWEEN "CORRECT" AND EVALUATEES RESULTS
valgrind	VALGRIND OUTPUT FOR CHECKING LEAKS, CHECK MANUALLY
