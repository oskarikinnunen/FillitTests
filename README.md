<h1> Shell script for testing Fillit project of the 42 schools </h1>

<h3>USAGE:</h3>
1. Change the "fillitpath" variable in test.sh
2. Run test.sh
3. Check results_diff for quick summary of diffs between "res" and "their_res" files
	<br>note: *"usage" message of fillit without parameters can/will vary since it's exact form is not specified in the PDF*
4. Check results_valgrind for quick summary of valgrind output (grepped with leaks\|leak\|free)
	<br>or check the full results for each file in valgrind/*filename*
5. You can also check inside valgrind/ or diffs/ files individually to see full outputs

<h3>OPTIONS:</h3><br>
run test.sh with "o" to see output of the program with each file<br>
(shows up during "Running with valgrind" part) <br>
>./test.sh o
<br>

<h3>IF YOU WANT TO ADD MORE TEST CASES:</h3>
1. add the input file to the	 'input' folder
2. add the correct result in the 'res'	 folder

<br>
<br>
<h3>FOLDER STRUCTURE EXPLANATION:</h3><br>

><h4>input</h4>
>INPUT FILES FOR THE PROGRAM
<br>

><h4>res</h4>
>CORRECT RESULTS, THESE ARE CURRENTLY GENERATED <br> MOSTLY FROM THE "https://github.com/JemCopeCodes/42-Fillit" REPOSITORYS ANSWERS
<br>

><h4>their_res</h4>
>EVALUATEES RESULTS
<br>

><h4>diffs</h4>
>DIFFS BETWEEN "CORRECT" AND EVALUATEES RESULTS
<br>

><h4>valgrind</h4>
>VALGRIND OUTPUT FOR CHECKING LEAKS
<br>
