*** Settings ***
Library     SeleniumLibrary
Library     ${EXECDIR}/Libraries/MyExtendedSeleniumLibrary.py
Resource    ${EXECDIR}/Resources/Others/time.robot
Resource    ${EXECDIR}/Resources/Others/browser.robot


*** Keywords ***
Click wizard selection button
    [Arguments]  ${element}  ${button}
    scroll to element  ${element}
    click button  ${button}

Write into wizard field
    [Arguments]  ${element}  ${field}  ${text}
    scroll to element  ${element}
    input text  ${field}  ${text}


