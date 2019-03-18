${#string}           # String Length
${string#substring}  # Deletes shortest match of $substring from front of $string
${string##substring} # Deletes longest match of $substring from front of $string
${string%substring}  # Deletes shortest match of $substring from back of $string
${string%%substring} # Deletes longest match of $substring from back of $string
${string/substring/replacement}  # replace
${string//substring/replacement} # replace all

# Cut parts of the variable/string 
[me@myhost ~]$ myvar=1234567890
[me@myhost ~]$ echo ${myvar: 2} # cut from left
34567890
[me@myhost ~]$ echo ${myvar: -2} # cut from right
90
[me@myhost ~]$ echo ${myvar: 3:5} # cut 5 chars from index position 3, index starts from 0 
45678
