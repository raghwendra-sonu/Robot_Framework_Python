*** Settings ***
Documentation   Message Decoder Automation
Library    ${EXECDIR}/CustomLibraries/MessageDecoder.py
Variables   ${EXECDIR}/TestData/environment.py

*** Keywords ***
Connect to the server
            [Documentation]  Connect to the DB Server using given Host name, Port and Timeout
            establish connection    ${HOST}    ${PORT}
            ${dict_test_params}    get test params    ${MSG_DECODER_DATA}
            set test variable    ${dict_test_params}

Form the message
            [Documentation]  Form data to be sent to the DB Server using data from Excel sheet
             ${data_to_send}    form data     ${dict_test_params}[REQUEST_TYPE]  ${dict_test_params}[CARD_NUMBER]  ${dict_test_params}[AMOUNT]  ${dict_test_params}[ACQUIRER_ID]  ${dict_test_params}[TERMINAL_ID]  ${dict_test_params}[CAID]  ${dict_test_params}[TERMINAL_NAME]  ${dict_test_params}[MCC]
             set test variable    ${data_to_send}
             log to console    ${data_to_send}

Send Data to the server
            [Documentation]  Send data to the DB Server using message from Excel test data sheet
            send data    ${data_to_send}

Read Data received from the server
            [Documentation]  Verify the response received from the server
            ${ResponseCode}   read data    ${dict_test_params}[CARD_NUMBER]
            log to console    ${ResponseCode}
            should contain    ${ResponseCode}    ${dict_test_params}[EXPECTED_RESPONSE]