*** Settings ***
Library  ${EXECDIR}/Libraries/IniFileHandler.py

*** Keywords ***

# TODO: IniFile cannot be read this way (reads the path, not its content)

#get all content from ini file
#
#    [Arguments]  ${ini_file_path}
#
#    ${content}=  get ini file content  ${ini_file_path}
#
#    [Return]  ${content}


get value from ini file parameter

    [Arguments]  ${ini_file_path}  ${section_name}  ${parameter_key}

    ${value}=  get ini value  ${ini_file_path}  ${section_name}  ${parameter_key}

    [Return]  ${value}


write new value to exiting ini in properties file

    [Arguments]  ${ini_file_path}  ${parameter_key}  ${value}

    change properties value  ${ini_file_path}  ${parameter_key}  ${value}
