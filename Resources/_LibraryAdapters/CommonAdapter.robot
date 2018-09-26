*** Settings ***
Library  ${EXECDIR}/Libraries/Common.py

*** Keywords ***
convert string to integer value

    [Arguments]  ${input}

    ${output}=  convert to int  ${input}

    [Return]  ${output}


convert string to float value

    [Arguments]  ${input}

    ${output}=  convert to float  ${input}

    [Return]  ${output}


check if two strings are equal

    [Arguments]  ${stringA}  ${stringB}

    ${result}=  Common.check if two strings are equal  ${stringA}  ${stringB}

    [Return]  ${result}

check if two strings are different

    [Arguments]  ${stringA}  ${stringB}

    ${result}=  Common.check if two strings are different  ${stringA}  ${stringB}

    [Return]  ${result}

add two integer values

    [Documentation]  The two passed values must not already be of integer
    ...  format, but will be converted to integer first
    [Arguments]  ${valueA}  ${valueB}

    ${result}=  add  ${valueA}  ${valueB}

    [Return]  ${result}

substract two integer values

    [Documentation]  The two passed values must not already be of integer
    ...  format, but will be converted to integer first
    [Arguments]  ${valueA}  ${valueB}

    ${result}=  substract  ${valueA}  ${valueB}

    [Return]  ${result}


remove spaces from string

    [Arguments]  ${string_with_spaces}

    ${string_without_spaces}=  remove spaces  ${string_with_spaces}

    [Return]  ${string_without_spaces}


replace spaces from string

    [Documentation]  Replaces each single space from a ``string_with_spaces``
    ...  with a ``replacement`` string
    [Arguments]  ${string_with_spaces}  ${replacement}

    ${string_with_spaces_replaced}=  replace spaces  ${string_with_spaces}  ${replacement}

    [Return]  ${string_with_spaces_replaced}


get absolute path from a relativ path

    [Arguments]  ${relative_path}

    ${absolute_path}=  get absolute path  ${relative_path}

    [Return]  ${absolute_path}
