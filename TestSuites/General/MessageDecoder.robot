*** Settings ***
Documentation    Message Decoder Automation
Resource   ${EXECDIR}/Pages/General/MessageDecoder.resource
Library    ${EXECDIR}\\CustomLibraries\\MessageDecoder.py
Library    ${EXECDIR}\\CustomLibraries\\Utilities.py
Variables   ${EXECDIR}/TestData/environment.py

*** Test Cases ***
Message Decoder Test Case
    Connect to the server
    Form the message
    Send Data to the server
    Read Data received from the server