*** Settings ***
Library  SSHLibrary
Library  robot.libraries.DateTime
Library  String
Library  ../../Libraries/Common.py

*** Variables ***


*** Keywords ***
get file with timestamp
    [Tags]  getfile_with_timestamp
    [Documentation]  A random file from a remote PC is copied to a destination via ssh
    ...  using current timestamp as destination file prefix
    [Arguments]  ${SERVER_EL_GUI_PATH}  ${TESTPC_EL_GUI_DIR}  ${TESTPC_EL_GUI_FILENAME}

    ${current_date_and_time}=  get current date  exclude_millis=yes
    ${current_date_and_time}  convert date  ${current_date_and_time}  result_format=%Y%m%d_%H%M%S
    log  SERVER_EL_GUI_PATH = ${SERVER_EL_GUI_PATH}
    sshlibrary.get file  ${SERVER_EL_GUI_PATH}  destination=${TESTPC_EL_GUI_DIR}/${current_date_and_time}${TESTPC_EL_GUI_FILENAME}

    [Return]  ${TESTPC_EL_GUI_DIR}/${current_date_and_time}${TESTPC_EL_GUI_FILENAME}


delete file
    [Documentation]  delete any random file from remote PC
    [Arguments]  ${FILEPATH}

    execute command  rm ${FILEPATH}

