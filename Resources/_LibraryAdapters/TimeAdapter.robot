*** Settings ***
Library  ${EXECDIR}/Libraries/Time.py
Library  ${EXECDIR}/Libraries/Common.py

*** Keywords ***
wait for x minutes

    [Arguments]  ${timeInMinutes}

    ${time}=  convert_to_int  ${timeInMinutes}
    wait_in_minutes  ${time}


wait for x seconds

    [Arguments]  ${timeInSeconds}

    ${time}=  convert_to_int  ${timeInSeconds}
    wait_in_seconds  ${time}