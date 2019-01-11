

# split string in nth substrings
import re
re.findall("\w{3}", the_string)


############################################################################
# counter - counting repeated elements in a list/string/
from collections import Counter
Counter([1,1,2,2,2,3])

sum(c.values())                 # total of all counts
c.clear()                       # reset all counts
list(c)                         # list unique elements
set(c)                          # convert to a set
dict(c)                         # convert to a regular dictionary
c.items()                       # convert to a list of (elem, cnt) pairs
Counter(dict(list_of_pairs))    # convert from a list of (elem, cnt) pairs
c.most_common()[:-n-1:-1]       # n least common elements
c += Counter()                  # remove zero and negative counts
############################################################################


# conditional one-liner
return (('abundant', 'perfect')[aliquot == number], 'deficient')[aliquot < number]

# permutations/combinations
from itertools import combinations_with_replacement
comb = combinations_with_replacement([i for i in range(1,4)], 2)
# >>> for i in comb:
# ...     print(i)
# ...
# (1, 1)
# (1, 2)
# (1, 3)
# (2, 2)
# (2, 3)
# (3, 3)
# >>>

# copy a list instead of passing a reference
b = a[:]

# python pep8 checked
pycodestyle  --first file.py

#############################################################
# string manipulation
# string methods https://docs.python.org/3/library/stdtypes.html#string-methods
import string
'rema car'.replace('car','kralj')y
str_to_dict = set('car')
str_to_dict.issubset('rema car')

capitalize()            Converts the first character to upper case
casefold()              Converts string into lower case
center()                Returns a centered string
count()	                Returns the number of times a specified value occurs in a string
encode()                Returns an encoded version of the string
endswith()              Returns true if the string ends with the specified value
expandtabs()            Sets the tab size of the string
find();index()          Searches the string for a specified value and returns the position of where it was found
format()	            Formats specified values in a string
isalnum()               Returns True if all characters in the string are alphanumeric
isalpha()               Returns True if all characters in the string are in the alphabet
isdecimal()             Returns True if all characters in the string are decimals
isdigit()               Returns True if all characters in the string are digits
isidentifier()          Returns True if the string is an identifier
islower()               Returns True if all characters in the string are lower case
isnumeric()             Returns True if all characters in the string are numeric
isprintable()           Returns True if all characters in the string are printable
isspace()               Returns True if all characters in the string are whitespaces
istitle()               Returns True if the string follows the rules of a title
isupper()               Returns True if all characters in the string are upper case
join()                  Joins the elements of an iterable to the end of the string
ljust()                 Returns a left justified version of the string
lstrip()                Returns a left trim version of the string
maketrans()             Returns a translation table to be used in translations.
partition()             Returns a tuple where the string is parted into three parts
replace()               Returns a string where a specified value is replaced with a specified value
rfind()                 Searches the string for a specified value and returns the last position of where it was found
rindex()                Searches the string for a specified value and returns the last position of where it was found
rpartition()            Returns a tuple where the string is parted into three parts
rsplit()                Splits the string at the specified separator, and returns a list
rstrip()                Returns a right trim version of the string
split()                 Splits the string at the specified separator, and returns a list
splitlines()            Splits the string at line breaks and returns a list
startswith()            Returns true if the string starts with the specified value
swapcase()              Swaps cases, lower case becomes upper case and vice versa
title()                 Converts the first character of each word to upper case
translate()             Returns a translated string
zfill()                 Fills the string with a specified number of 0 values at the beginning
#############################################################

#############################################################
# binary operations
>>> bin(9)
'0b1001'
>>> int('00101', base=2)
5
>>> 34 & 2 # bitwise and
2
>>> 34 & 1
0
>>> 34 | 2 # bitwise or
34
#############################################################

# format 2 decimal number when printing
{:.2f}

#############################################################
# iterator pattern
def fib():
   a, b = 0, 1
   while True:
      yield b
      a, b = b, a + b

f = fib()
for i in range(20):
    print(next(f), end=' ')
print()
#############################################################

#############################################################
# monkey pathching
>>> class Example:
...     def add(self, a, b):
...         return a + b
...
>>> instance = Example()
>>> def add_more(self, a, b):
...     return a + b + 10
...
>>> instance.add(1, 1)
2
>>> Example.add = add_more
>>> instance.add(1, 1)
12
#############################################################

# to check lint the code
python -m py_compile qa/tasks/deepsea_deploy.py
flake8 qa/tasks/deepsea_deploy.py
pycodestyle --first  qa/tasks/deepsea_deploy.py

# assign partial string and variable
global_conf = '/path/to/conf'
section = 'global'
exec('path = ' + section + '_conf') # linters will complain

##### generators ###########################################
range(5)
(i for i in range(5)) # compared to list [i for i in range(5)]

def countdown(num):
    print(num)
    yield num
    num -= 1

g = countdown(5)
type(g) # generator
##### generators END ######################################

#########################################
# list all modules in a package
import pkgutil
import selenium # this is the package we are inspecting -- for example 'selenium' from stdlib
package = selenium
for importer, modname, ispkg in pkgutil.iter_modules(package.__path__):
    print("Found submodule {} (is a package: {})".format(modname, ispkg))
#########################################

#########################################
# wait until function
import time
def wait_until(somepredicate, timeout, period=0.25, *args, **kwargs):
  mustend = time.time() + timeout
  while time.time() < mustend:
    if somepredicate(*args, **kwargs): return True
    time.sleep(period)
  return False
#########################################


# *** configure tab autocomplete
import readline
import rlcompleter

# ipython interpreter
# pexpect
# *** ORM and http://www.sqlalchemy.org/

#===============================
# unpacking the list and dictionary
In [1]: def foo(*arg):
   ...: 	print(arg)
   ...:

In [2]: list = [1,2,3]

In [3]: foo(list)
([1, 2, 3],)

In [4]: foo(*list)
(1, 2, 3)
#===============================

# creating generators, yield istead of return
# list comperhensions
return [x for x in servers if x.servers.contains(query)]

======================
#creating and assigning list is only assigning references, for copy the list use:
import copy
list_1=[1, 2, 3]
list_2=copy.deepcopy(list_1)

# manipulisanje sa clipboardom
pip install pyperclip
pyperclip.copy()
pyperclip.paste()

# logging
import logging
logging.basicConfig(filename='myProgramLog.txt', level=logging.DEBUG, format=' %(asctime)s - %(levelname)s
- %(message)s')
logging.disable(logging.CRITICAL)

# sending emails
import smtplib
connection = smtplib.SMTP('smtp.gmail.com', 587)
connection.ehlo()
connection.starttls() #doesn't work in my Linux
connection.login('soundwavetesting', 'password')
connection.sendmail('soundwavetesting@gmail.com', 'stanojlovic.marko@gmail.com', 'Subject: test message\n\nMessage start...')
connection.quit()

############################################################
# date time
from datetime import date, timedelta
yesterday = date.today() - timedelta(1)
yesterday.strftime('%Y-%m-%d')
# Date manipulation
from datetime import datetime
from datetime import timedelta
print datetime.now()+timedelta(days=90)
# Formating
mydate.strftime("%Y-%m-%d %H:%M:%S")

############################################################

# matchin a cell in the excel file
import re
p=re.compile('.*filename.*')
match=p.march(cell)


#>>> list(zip(['a','b','c'],[1,2,3]))
#[('a', 1), ('b', 2), ('c', 3)]

a = input("a=? "); b = input("b=? ");print("a+b={}".format(int(a)+int(b)))
a,b = int(input("a=? ")), int(input("b=? "));print("{}+{}={}".format(a,b,a+b))

# take the last value from cli with underscore "_"
#>>> "---".join("MARKO")
#'M---A---R---K---O'
#>>> s = _
#>>> s
#'M---A---R---K---O'

# encoding unicode utf8 (Python 2)
unicode('Město:','utf8') # string to unicode
u'M\u011bstsk\xe1 \u010d\xe1st:'.encode('utf8') # unicode to string

# FOR LOOP
for x in range(0, 3):
    print "We're on time %d" % (x)

#####################################################
# CASE statement
# define the function blocks
def zero():
    print "You typed zero.\n"

def sqr():
    print "n is a perfect square\n"

def even():
    print "n is an even number\n"

def prime():
    print "n is a prime number\n"

# map the inputs to the function blocks
options = {0 : zero,
           1 : sqr,
           4 : sqr,
           9 : sqr,
           2 : even,
           3 : prime,
           5 : prime,
           7 : prime,
}

options[num]()
# END CASE statement

# other way: dictionary mappings, also known as associative arrays
response = {
    'question' : 'Sure.',
    'yelling' : 'Whoa, chill out!',
    'qestion yelling' : "Calm down, I know what I'm doing!",
    'silence' : 'Fine. Be that way!'
}
return response.get(phraseType, 'Whatever.')

#####################################################

#####################################################
# random string of N lenght
import string
import random
N = 8
''.join(random.choice(string.ascii_letters + string.digits) for _ in range(N))

# random robot-name example
import random
from random import seed # to seed randomness from current time
from string import ascii_uppercase as AZ
from string import digits
rrname = ''.join(random.sample(ascii_uppercase,2)) + ''.join(random.sample(digits, 3))
#####################################################

# iterate trough array
for i in range(0,len(a)):
    print a[i]

# run bash command from python
from subprocess import check_output
cmd='ssh root@192.168.100.151 "salt \* test.ping|grep True|wc -l"'
output=check_output(['bash','-c',cmd]).rstrip()

# downloading file
# pip install wget
import os
download_dir_path='/home/marko/Documents/Dokumentacija-Papiri/Scripting/Python'
os.chdir(download_dir_path)
import wget
url = 'http://www.mvcr.cz/mvcren/file/list-valid-to-the-april-10th-2017.aspx'
filename = wget.download(url)

# Web scraping
import webbrowser
webbrowser.open('http://www.mvcr.cz/mvcren/article/status-of-your-application.aspx')
import bs4 		# beautiful soup module
import requests
webpage=requests.get('http://www.mvcr.cz/mvcren/article/status-of-your-application.aspx')
webpage.raise_for_status()
soup=bs4.BeautifulSoup(webpage.text, 'html.parser')
# elems = soup.select('<copy css path from the page>')
elem = soup.select('#content > div > ul > li > a')
file_path=elem[0].get('href')
file_url='http://www.mvcr.cz/mvcren/'+file_path
