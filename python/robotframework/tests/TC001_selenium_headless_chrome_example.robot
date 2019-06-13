*** Settings ***
Documentation     A test example by using \n
...               - selenium library \n
...               - variables loaded from python file \n
...               - using headless chrome browser \n
Library           SeleniumLibrary
Variables         TCVARS_realpython.py

*** Variables ***
${SUT_URL}  https://realpython.com/
${BROWSER}  headlesschrome

***Test Cases***
Example test case on home page
    Open Browser To Home Page
    Welcome Page Should Be Open
    log    Example message from python var file: ${MSG}
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To Home Page
    Open Browser    ${SUT_URL}    ${BROWSER}

Welcome Page Should Be Open
    Title Should Be    Python Tutorials – Real Python
