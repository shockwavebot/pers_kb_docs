# Robot framework 

The Robot Framework is an open source, general purpose test automation framework used for acceptance testing and streamlines it into mainstream development, giving rise to the concept of acceptance test driven development (ATDD). **Python-based, keyword-driven, and acceptance test automation framework.** 

![high level](./rbtfrm.PNG)

### Aproaches 

- **Keyword driven** : keyworads are defined in python library 
- **Data driven** : when repeating same workflow multiple times 
- Gherkin : more descriptive and clear for non technical testers 

## Example usage 

./tests/TC01.robot: (*notice 2 spaces, double space, around key word **log***)

```
*** Settings ***
Documentation     A test suite with a single test for example.

***Test Cases***

First Test Action  log  this is a basic test

```

`python -m robot.run tests/`

```
(v) mstan@vitredzmj:~/projects/py-playground/robotframe/simpleapp$ python -m robot.run tests/
==============================================================================
Tests                                                                         
==============================================================================
Tests.TC01                                                                    
==============================================================================
First Test Action                                                     | PASS |
------------------------------------------------------------------------------
Tests.TC01                                                            | PASS |
1 critical test, 1 passed, 0 failed
1 test total, 1 passed, 0 failed
==============================================================================
Tests                                                                 | PASS |
1 critical test, 1 passed, 0 failed
1 test total, 1 passed, 0 failed
==============================================================================
Output:  /home/mstan/projects/py-playground/robotframe/simpleapp/output.xml
Log:     /home/mstan/projects/py-playground/robotframe/simpleapp/log.html
Report:  /home/mstan/projects/py-playground/robotframe/simpleapp/report.html
```

#### Run only one test from file 

`-t "Test name" /path/to/suite/file.robot`

## Test config files 

### 1) Suite initialization files

`__init__.robot`

### 2) External variable files

`${Variable Name}` - single-valued variables

`@{Variable Name}` - variable containing a list of different values

```
*** Variables *** 
${Weather}  London  Cloudy  25 
${humidity}  75 
${MARKS}  65.5 
@{DAYS}  Monday  Wednesday  Friday  Sunday
```

#### Python file containing variables 

`person = { 'name' : 'John Doe','age' : '26', 'grade' : 'A', 'gpa' : 8.9 }`

```
*** Setting ***
Variables  python_file.py
...
*** Test Cases ***
...
  Log  For ${person['name']}, the grade obtained was ${person['grade']}
```

### 3) Resource files

```
*** Settings ***
Resource  Path/to/another_resource

*** Variable ***
${USER}  Test user

*** Keyword ***
Print welcome message for  [Arguments]  ${USER}
    Log  Welcome ${USER}!
```

## Other 

### FOR loop 

```
# This code block runs 5 times for x = 10, 12, 14, 16,18
|  | :FOR | ${x} | IN RANGE | 10  |  20 |  2  |
|  |    |  Log  |  ${x} |
```

#### Continue and break ???

`|  |  | Exit For Loop If | ${val} > 10 |`

???








