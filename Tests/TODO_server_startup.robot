*** Settings ***
Documentation    This test suite contains test cases that check if the server (which includes backend
...  and middleware) is successfully initialized under various conditions

Resource  ../Resources/ServerPC.robot
Resource  ../Resources/PowerControlSwitch.robot

*** Test Cases ***
#TODO: Define keywords
Server is successfully initialized when powered up
    [Documentation]  The server is supposed to be powered off and restarted.
    ...  After the restart, the elviraGUI is started automatically. If the
    ...  system has been successfully initialized, all alarms from the elviraGUI
    ...  logfile must have been set to 'STATUS_CLEARED'.
    ...  The test is considered as not passed, if any alarm has not been cleared
    ...  after a certain amount of time.
    [Tags]  power_up_server_only
    [Setup]  ServerPC_connection.Open Connection And Log In

    Given I kill power to the server PC
    When I restore power to the server PC
    Then the server PC is successfully initialized

*** Keywords ***