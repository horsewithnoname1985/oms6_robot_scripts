*** Settings ***
Documentation  This test suite deals with the OMS6 client startup reliability

Resource        ${EXECDIR}/Resources/_Steps/STPS_client_restart.robot
Resource        ${EXECDIR}/Resources/_Units/ClientPC/ssh_connection.robot

Test Setup     open SSH connection to client PC and log in
Test Teardown  close connection to client PC

# robot -d Results -i Connection Tests/TS_client_restart.robot
# robot -d Results -i Restart Tests/TS_client_restart.robot
# robot -d Results -i Restart_Loop -v RESTART_ITERATIONS:1 Tests/TS_client_restart.robot
# robot -d Results -i Restart_Loop_Summary -v RESTART_ITERATIONS:2 Tests/TS_client_restart.robot
# robot -d Results -i test Tests/TS_client_restart.robot

*** Variables ***
${RESTART_ITERATIONS}       1

*** Test Cases ***
Endurance Test - OMS6 GUI Restart Test

    [Documentation]  Client PC is started repeatedly. Each time it is ensured, that the GUI is successfully launched
    ...  and reveives images
    [Tags]  Restart_Loop

    :FOR  ${Index}  IN RANGE  ${RESTART_ITERATIONS}
    \   run keyword and continue on failure  OMS6 GUI is successfully launched after client PC restart


Endurance Test - OMS6 GUI is successfully launched after client PC restart

    [Documentation]  Client PC is started repeatedly. Each time it is ensured, that the GUI is successfully launched
    ...  and reveives images. Additionally , a counter is supposed to give a concise overview about the numbers of
    ...  failed and succeeded runs
    [Tags]  Restart_Loop_Summary

    ${fail}=  Set Variable  0
    ${success}=  set variable  0
    :FOR  ${Index}  IN RANGE  ${RESTART_ITERATIONS}
    \   ${passed}=  Run Keyword and Return Status  OMS6 GUI is successfully launched after client PC restart
    \   continue for loop if  ${passed}
    \   ${fail} =  evaluate  ${fail} + 1
    ${success}=  substract  ${RESTART_ITERATIONS}  ${fail}
    Log Many   Success:  ${success}
    Log Many   Fail:  ${fail}


*** Keywords ***
OMS6 GUI is successfully launched after client PC restart

    [Tags]  Restart
    [Timeout]  2 minutes

    GIVEN the client PC is running
    WHEN the client PC is restarted
    THEN the client PC is successfully booted and GUI is opened


OMS6 GUI is successfully launched after client PC shutdown

    [Tags]  Shutdown
    [Timeout]  2 minutes

    GIVEN the client PC is running
    WHEN i kill power to the client for a moment then restore the power
    THEN the client PC is successfully booted and GUI is opened