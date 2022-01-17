<h1> Shell script for testing Fillit project of the 42 schools </h1>

USAGE:
1. Change the "fillitpath" variable in test.sh
2. Run test.sh
3. Check results_diff for quick summary of diffs between "res" and "their_res" files
	<br>note: *"usage" message of fillit without parameters can/will vary since it's exact form is not specified in the PDF*
4. Check results_valgrind for quick summary of valgrind output (grepped with leaks\|leak\|free)
	<br>or check the full results for each file in valgrind/*filename*
5. You can also check inside valgrind/ or diffs/ files individually to see full outputs

OPTIONS:<br>
run test.sh with "o" to see output of the program with each file<br>
(shows up during "Running with valgrind" part) <br>
>./test.sh o
<br>

IF YOU WANT TO ADD MORE TEST CASES:
1. add the input file to the	 'input' folder
2. add the correct result in the 'res'	 folder

<br>
<br>
FOLDER STRUCTURE EXPLANATION:<br>

><h1>input</h1>
>INPUT FILES FOR THE PROGRAM
<br>

><h1>res</h1>
>CORRECT RESULTS, THESE ARE CURRENTLY GENERATED <br> MOSTLY FROM THE "https://github.com/JemCopeCodes/42-Fillit" REPOSITORYS ANSWERS
<br>

><h1>their_res</h1>
>EVALUATEES RESULTS
<br>

><h1>diffs</h1>
>DIFFS BETWEEN "CORRECT" AND EVALUATEES RESULTS
<br>

><h1>valgrind</h1>
>VALGRIND OUTPUT FOR CHECKING LEAKS
<br>
