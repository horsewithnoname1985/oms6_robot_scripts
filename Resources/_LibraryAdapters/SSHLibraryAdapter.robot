*** Settings ***
Library     SSHLibrary
Resource    ${EXECDIR}/Resources/_LibraryAdapters/TimeAdapter.robot
Resource    ${EXECDIR}/Resources/_LibraryAdapters/PathAdapter.robot
Resource    ${EXECDIR}/Resources/_LibraryAdapters/CommonAdapter.robot

*** Keywords ***
########## CONNECTION #########################################################
open SSH connection and login

    [Arguments]  ${destination_ip}  ${destination_port}  ${ssh_username}  ${ssh_password}

    SSHLibrary.open connection  ${destination_ip}  ${destination_port}  timeout=15s
    login  ${ssh_username}  ${ssh_password}


open SSH connection and login if not already open

    [Arguments]  ${destination_ip}  ${destination_port}  ${ssh_username}  ${ssh_password}

    ${connection}=  get connection
    ${destination_ip}=  convert to string  ${destination_ip}
    ${require_proper_connection}=  check if two strings are different  ${connection.host}  ${destination_ip}
    Run keyword if  ${require_proper_connection}
    ...  open SSH connection and login  ${destination_ip}  ${destination_port}  ${ssh_username}  ${ssh_password}


close current SSH connection
    close connection


########## COMMANDS ###########################################################
execute command via SSH connection

    [Arguments]  ${command}

    ${result}=  execute command  ${command}

    [Return]  ${result}


########## GET & SEND FILES ###################################################
get file via existing SSH connection

    [Arguments]  ${file_path}  ${dest_dir}

    sshlibrary.get file  ${file_path}  ${dest_dir}


get file via existing SSH connection with timestamp

    [Documentation]  A random file from a remote PC is copied to a destination via ssh
    ...  using current timestamp as destination file prefix in YYYYMMDD_HHMMSS format
    [Arguments]  ${remote_file_path}  ${local_dest_dir}  ${local_file_name}=None

    ${current_date_and_time}=  get current date  exclude_millis=yes
    ${current_date_and_time}=  convert date  ${current_date_and_time}  result_format=%Y%m%d_%H%M%S
    Run keyword if  ${local_file_name}=None  ${local_file_name}=get filename from path  ${remote_file_path}
    sshlibary.get file  ${remote_file_path}  ${local_dest_dir}/${current_date_and_time}_${local_file_name}

    [Return]  ${local_dest_dir}/${current_date_and_time}_${local_file_name}


delete file

    [Documentation]  delete any random file from remote PC
    [Arguments]  ${file_path}

    execute command  rm ${file_path}
