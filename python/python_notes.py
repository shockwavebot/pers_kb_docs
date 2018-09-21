
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

pip install flask    	 # web application in python
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

# date time
from datetime import date, timedelta
yesterday = date.today() - timedelta(1)
yesterday.strftime('%Y-%m-%d')
# Date manipulation
from datetime import datetime
from datetime import timedelta
print datetime.now()+timedelta(days=90)

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



# random string of N lenght
import string
import random
N = 8
''.join(random.choice(string.ascii_letters + string.digits) for _ in range(N))

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
