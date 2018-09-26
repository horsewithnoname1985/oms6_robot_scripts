*** Settings ***
Library  ${EXECDIR}/Libraries/Path.py

*** Keywords ***
Get filename from path

    [Arguments]  ${file_path}

    ${filename}=get filename from path  ${file_path}

    [Return]  ${filename}