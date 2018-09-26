*** Settings ***
Resource  ${EXECDIR}/Resources/_LibraryAdapters/SSHLibraryAdapter.robot

*** Variables ***
${REMOTE_ONLINE_FILE_PATH}      /cygdrive/c/online.txt
${LOCAL_ONLINE_FILE_PATH}       ${EXECDIR}/Resources/temp/online.txt
${GUI_TASK}                     javaw.exe

*** Keywords ***

check if PC is running
    wait until keyword succeeds  100 seconds  2 seconds
    ...  get file via existing SSH connection  ${REMOTE_ONLINE_FILE_PATH}
    ...  ${LOCAL_ONLINE_FILE_PATH}


check if GUI is running
    ${tasks}=  execute command via SSH connection  tasklist
    log  tasks: ${tasks}
    run keyword and continue on failure  should match  ${tasks}  *${GUI_TASK}*


the OMS6 GUI waits for the server
    [Documentation]  Checks, whether the client is currently in a state, where
    ...  it excepts a server connection
    #TODO: Require a method to check, if the client currently waits for the server

the elviraGUI is opened
    [Documentation]  Checks, if elviraGUI is currently open
    #TODO: Require a method to check, if the elviraGUI has been successfully launched

the OMS6 GUI is successfully opened
    [Documentation]  Checks, if the ELSCAN OMS6 GUI is currently open
    #TODO: Require a method to check, if the OMS6 GUI has been successfully launched

the elviraGUI is successfully launched
    [Documentation]  Launches the elviraGUI and verifies whether the GUI is
    ...  able to successfully connect to the server
    #TODO: Require a method to launch elviraGUI and check, if it successfully connects to the server

the client receives camera images
    [Documentation]  Checks, whether the middleware is currently sending tele
    ...  camera images to the client
    [Tags]  Image transmission

    # TODO. Require a method to check, if the middleware is sending tele camera images to the client

the client receives WIDE camera images
    [Documentation]  Checks, whether the middleware is currently sending wide
    ...  camera images to the client
    [Tags]  Image transmission
    # TODO: Require a method to check if the middleware is sending wide camera image to the client


#TODO: Is that used? How can it work, if the command is executed before connection
#check connection
#    [Arguments]  ${HOST}  ${PORT}  ${USERNAME}  ${PASSWORD}
#    ${result} =  execute command  echo I am alive
#    run keyword if  should be equal  ${result}  I am alive
#    ...  ClientPC_connection.Open Connection And Log In  ${HOST}  ${PORT}  ${USERNAME}  ${PASSWORD}


#TODO: Is that used somewhere?
#check if PC restarted
#    [Arguments]  ${HOST}  ${PORT}  ${USERNAME}  ${PASSWORD}
#    close connection

