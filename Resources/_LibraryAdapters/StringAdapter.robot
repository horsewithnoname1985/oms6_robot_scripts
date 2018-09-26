*** Settings ***
Library  String

*** Keywords ***
Replace content inside a string

    [Arguments]  ${string}  ${search_for}  ${replace_with}

    replace string  ${string}  ${search_for}  ${replace_with}

