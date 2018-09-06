$ - SUBSTITUTION SIGN

### Invoking scripts ###
. prog.sh		# run (sourced) in current Shell
ksh prog.sh		# run in a new Korn Shell
./prog.sh 		# run in a new Shell if prog is executable
exec prog.sh		# run in a new Shell to replace the current one

### Wildcard Metacharacters ###

*		# Match any number of any characters
?		# Match any single character
[abc]		# Match a single character from the bracketed list
[!az] 		# Match any single character except those listed
[a-z]		# Inclusive range for a list

[[:upper:]]
[[:lower:]]
[[:digit:]]
[[:space:]]

*(pattern|pattern...) 	# zero or more occurrences
?(pattern|pattern...)	# zero or one occurrence
+(pattern|pattern...) 	# one or more occurrences
@(pattern|pattern...)	# exactly one occurrence
!(pattern&pattern...)	# anything except

### Setting I/O or File Descriptors ###
$ exec n> of 	# Opens output file descriptor n to file "of"
$ exec n< if  	# Opens input file descriptor n to read file "if"
$ exec m>&n  	# Associates output file descriptor m with n
$ exec m<&n  	# Associates input file descriptor m with n
$ exec n>&-  	# Closes output file descriptor n
$ exec n<&-  	# Closes input file descriptor n

### Command grouping ###
( command1 ; command2 ) > /dev/null 2>&1

### Shell job controll ###
jobs 	# The jobs command lists your current Shell processes and their job ids
Ctrl-z 	# suspends the current foreground job
bg 	# runs a suspended job in background
fg 	# brings to foreground a suspended or background job

### Arguments ###
set arg1 arg2 arg3
echo $1 $2 $3  
shift

$#	# number of arguments
$@	# all arguments as one string, space separated list
$* 	# in double quotes, behaves different than $@

$0	# path name of the script
$$	# PID of current process
$?	# Return code 

export VAR 	# exportst variable VAR so it's inherited to other shells, but only creates a copy, it's not linked

### PS1 ###
\d 	# date
\H	# hostname
\h	# hostname up to first "."
\T	# time in 12 hour HH:MM:SS
\t	# time in HH:MM:SS
\u	# username
\w	# current working directory
\W	# basename of current working directory

http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html
http://mywiki.wooledge.org/BashGuide/TestsAndConditionals
### Conditional execution ###
command1 && command2 	# If command1 is successful execute command2
command1 || command2	# If command1 is not successful execute command2
[[ expression ]]	# Same as: test expression test a=b, returns 0 or 1 RC

-s file 	# file has a size greater than zero EXAMPLE: 	if [[ -s $TMP_RES ]];then echo NON_EMPTY;else echo EMPTY;fi
-r file 	# file exists and is readable
-w file 	# file exists and is writable
-x file 	# file exists and is executable
-u file 	# file exists and has the SUID bit set
-g file 	# file exists and has the SGID bit set
-k file 	# file exists and has the SVTX sticky bit set
-e file 	# file exists
-f file 	# file exists and is an ordinary file
-d file 	# file exists and is a directory
-c file 	# file exists as a character special file
-b file 	# file exists as a block special file
-p file 	# file exists and is a named pipe file
-L file 	# file exists and is a symbolic link

exp1 -eq exp2 	# exp1 is equal to exp2
exp1 -ne exp2 	# exp1 is not equal to exp2
expl -lt exp2 	# exp1 is less than exp2
exp1 -le exp2 	# exp1 is less than or equal to exp2
exp1 -gt exp2 	# exp1 is greater than exp2
exp1 -ge exp2 	# exp1 is greater than or equal to exp2

-n str 		# string is non-zero in length
-z str 		# string is zero in length
str1 = str2 	# str1 is the same as str2
str1 != str2 	# str1 is not the same as str2

##########################################################################
### FLOW CONTROL ###
##########################################################################
if [[ expression1 ]]
then
# commands to be executed if expression1 is true
elif [[ expression2 ]]
then
# commands to be executed if expression1 is false, and expression2 is true
elif [[ expression3 ]]
then
# commands to be executed if expression1 and expression2 are false, but expression3 is true
else
# commands to be executed if all expressions are false
fi
##########################################################################
while [[ expression ]]
do
# commands executed when expression is true
done # optional < file or > file
##########################################################################
for identifier in word1 word2 ...
do
# commands using $identifier
done
##########################################################################
for (( num=1; num < 500; num++ ))
do
mv file$num file${num}.bkup
done

#or 
for (( i=0; i<=5; i++ )) do echo $i; done

##########################################################################
case $1 in 
    Ace )	echo "You are really close." ;;
    King)	echo "Missed it by that much." ;;
    Queen) 	echo "Finally!" ;;
    Jack) 	echo "I hope you'll get it next time." ;;
    Ten | 10) 	echo "Getting close" ;;
    *)		echo "Guess again." ;;
esac
##########################################################################
PS3="Pick an animal:"
select animal in cow pig dog quit
do
	case $animal in
		cow)	echo "Mooo";;
		pig)	echo "Oink";;
		dog)	echo "Woof";;
		quit)	exit;;
		*)	echo "Not in the barn";;
	esac
done
##########################################################################
##########################################################################

### set command ###
set -o vi 	#enables line recall and editing
set -o emacs

### Operations ###
expr
let -or (( ))

###########################################################################
#!/bin/bash
df > output.txt
exec 7<output.txt
read <&7 	#skipping the first line
while IFS= read -r -u7 FS SIZE USED AVAIL USAGE MOUNT 
do 
	#echo Read line: $FS $SIZE $USED $AVAIL $USAGE $MOUNT 
	if [[ $SIZE -eq $((USED+AVAIL)) ]]; then
		echo "Size is equal to Used+Available for: 	$MOUNT"
	else
		echo "Size is NOT equal to Used+Available for: 	$MOUNT"
	fi
done

while read -r line
do
    echo $line
done < $filename
###########################################################################

### ARRAY ###
arr=(Hello World)
arr[0]=Hello
arr[1]=World
echo ${arr[0]} ${arr[1]}
${arr[*]}         # All of the items in the array
${!arr[*]}        # All of the indexes in the array
${#arr[*]}        # Number of items in the array
${#arr[0]}        # Length of item zero

array[4]=variable
echo ${array[3]}
echo ${array[*]}
echo ${array[*]}

PREPORTUKA: koristiti "${array[@]}" jer se ponasa drugacije kada jedna promenljiva ima delimitere u sebi npr. "jedan dva tri"
*** array[0]=123 je isto sto  array=123

echo ${#array[*]}	# number of elements of array, string length
set|grep array		# prikazuje definiciju niza 

IFS=":" 		# changing the delimiter
IFS=":" read USER OSTALO < /etc/passwd # moze da se definise IFS samo za read komandu, lokalno

###########################################################################
### FUNCTIONS ###
###########################################################################
identifier()		function identifier 
{		-or-	{
#commands		#commands
}			}

typeset VAR 	# VAR je difinisano samo unutar funksije

return 		# exiting from the function only
exit 		# exiting from the function and from the script

typeset -F 	# list the names of the defined functions
typeset -f 	# list the defined functions
###########################################################################
###########################################################################

### Command line processing ###
1. word separation
2. alias expansion
3. tilda expansions
4. IO redirection
5. command substitutions $()
6. variable and parameter expansions
7. pathname exapnsions and metacharaters 
8. removal of unquoted quotes
9. special buildins 
10. functions 
11. regular buildins 
12. expand tracked aliases
13. AIX commands

### EVAL command ###
set -x 	# shell debuggin mode *******!!!!!
set +x 	# disable debug mode 

cmd="ps -ef|grep bash"
$cmd 		# will have and error: '|' is treathed as argument
eval $cmd 	# will work

### Shell Substrings ### 
${variable#pattern}		# removes smallest matching left pattern from variable
${variable##pattern}		# removes the largest matching left pattern
${variable%pattern}		# removes the smallest right matching pattern
${variable%%pattern}		# removes the largest matching right pattern
${variable:1:3}			# cut the string from 2. till 4. charater
${var::-1}			# brise poslednji karakter u stringu delete last char (only BASH)
${var%?}			# brise poslednji karakter u stringu delete last char (BASH + KORN)

var=/dir/subdir/file_name.txt
echo ${var##*/}			# get the file name
echo ${var%/*}			# get the file path

fqdn=hostname.domain
echo ${fqdn%%\.*}       # get the hostname without domain

${VAR/pattern/substitute}	# replace first occurence
${VAR//pattern/substitute}	# replace every occurence

${#variable}			# number of characters in variable 

### tr ###
cat /etc/passwd|tr ":" " " 	# changing all : to spaces

### cut ###
df|tr -s " "|cut -f2 -d " "	# uzima samo kolonu 

tr # translate

### sed ###
sed "s/['\"]//g" 	# remove single quotes from a string
sed 's/,//g'		# brise zareze

### date ###
date  +%Y%m%d_%H%M

# sabiranje svih brojeva iz fajla
sum=0;while read NUM && [[ $NUM == +([[:digit:]]) ]];do (( sum += NUM ));done < FILE_NAME; (( gb = sum/1024/1204/1024 ));echo $gb GB

cd /home/homeldap/wtp1613/DAP19_OCCUPANCY/MPLLC01;cat MPLLC01_MPLLC01_input_part_* |awk '{print $3}'> MPLLC01;sum=0;while read NUM && [[ $NUM == +([[:digit:]]) ]];do (( sum += NUM ));done < MPLLC01; (( gb = sum/1024/1204/1024 ));echo $gb GB


# shell checking while infinite loop sleep
while true 
do
wc -l ORA_OLD_FILES_OCCU_adtMPLLC00_20160919_1308
sleep 3
done

# Checking if value in the list
aliases_list=" MPLCL00 MPLLC01 LC08 LC07 LC06 LC05 LC04 LC02 LC00 "
set LC08
if [[ $aliases_list =~ (^|[[:space:]])$1($|[[:space:]]) ]];then echo "yes";else echo "no";fi

# date days substract
days_back=42
query_date=$(date --date="$(date +%Y-%m-%d) - $days_back day" +%Y-%m-%d);echo $query_date # ne radi na AIX-u, radi na Linux-u
# u AIX-u mora da se radi sa 42 dana*24h = 1008h => GMT+1007 (-1h za CET time zone)
TZ="GMT+1007";query_date=$(date +%Y-%m-%d);TZ="GMT";echo $query_date

# pad zeros
tst=$(printf "%05g" 44);echo $tst

###########################################################################
###########################################################################
### REGULAR EXPRESSIONS ###
'(?:\d{1,3}\.)+(?:\d{1,3})'         # ip address regex
'[a-zA-Z]\w+(?:\.[a-zA-Z]\w+)+'     # fqdn regex 

###########################################################################
###########################################################################

