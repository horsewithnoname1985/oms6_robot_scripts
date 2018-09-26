*** Settings ***
Library  JavaPropertiesLibrary

*** Keywords ***
get all content from properties file

    [Arguments]  ${properties_file_path}

    ${content}=  get_properties_file_content  ${properties_file_path}

    [Return]  ${content}


get value from properties file parameter

    [Arguments]  ${properties_file_path}  ${properties_key}

    ${value}=  get properties value  ${properties_file_path}  ${properties_key}

    [Return]  ${value}


write new value to exiting parameter in properties file

    [Arguments]  ${properties_file_path}  ${properties_key}  ${value}

    change properties value  ${properties_file_path}  ${properties_key}  ${value}