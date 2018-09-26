*** Settings ***
Resource    ../Resources/ServerPC.robot
Resource    ../Resources/ClientPC.robot
Resource    ../Resources/PowerControlSwitch.robot

Test Setup      Run Keywords
                ...  Open Connection And Log In  ${CLIENT_HOST}  ${CLIENT_PORT}  ${CLIENT_USERNAME}  ${CLIENT_PASSWORD}
                ...  Open Connection And Log In  ${SERVER_HOST}  ${SERVER_PORT}  ${SERVER_USERNAME}  ${SERVER_PASSWORD}
Test Teardown   SSHLibrary.Close All Connections


*** Variables ***

${RESTART_ITERATIONS} =  10

${SERVER_HOST} =
${SERVER_PORT} =
${SERVER_USERNAME} =
${SERVER_PASSWORD} =

${SERVER_POWER_SLOT} =

${CLIENT_HOST} =
${CLIENT_PORT} =
${CLIENT_USERNAME} =
${CLIENT_PASSWORD} =

${CLIENT_POWER_SLOT} =

# robot -d Results -i test Tests/TODO_camera_image_transfer.robot

*** Test Cases ***

Endurance test - Server PC delivers WIDE camera images after system start
    [Tags]  wide

 :FOR  ${Index}  IN RANGE  ${RESTART_ITERATIONS}
    \   run keyword and continue on failure  Server PC delivers WIDE camera images after system start

Endurance test - Server PC delivers TELE camera images after system start
    [Tags]  tele

 :FOR  ${Index}  IN RANGE  ${RESTART_ITERATIONS}
    \   run keyword and continue on failure  Server PC delivers TELE camera images after system start

*** Keywords ***

# Check: How can the camera be toggled from remote?

Server PC delivers WIDE camera images after system start
    Given i kill power to server, client, pixelbox, motor and camera
    And wait for x seconds  10
    When i restore power to server, client, pixelbox, motor and camera
    And wait for x seconds  150
    And the elviraGUI is successfully launched
    And the WIDE camera is selected
    Then the client receives WIDE camera images

Server PC delivers TELE camera images after system start
    Given i kill power to server, client, pixelbox, motor and camera
    And wait for x seconds  10
    When i restore power to server, client, pixelbox, motor and camera
    And wait for x seconds  150
    And the elviraGUI is successfully launched
    And the TELE camera is selected
    Then the client receives TELE camera images