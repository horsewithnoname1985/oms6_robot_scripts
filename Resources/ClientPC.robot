*** Settings ***
Documentation  This is a high level keyword file containing all interactions
...  with the OMS6 Client PC.
...
...  This resource file also contains all Client PC variables needed during
...  test execution.
...  = Resource Variables =
...  == Client PC variables ==
...  Client PC specific variables
...     |   =Name=                          |   =Explanation=                       |
...     |   ${CLIENT_HOST_IP}               |   Client PCs IP address               |
...     |   ${CLIENT_SSH_PORT}              |   Client PCs SSH Port (default = 22)  |
...     |   ${CLIENT_SSH_USERNAME}          |   Client PCs SSH login username       |
...     |   ${CLIENT_SSH_PASSWORD}          |   OMS4 GUI application task name      |
...     |   ${CLIENT_ONLINE_FILE_PATH}      |   Path to the file used for startup check |
...     |   ${CLIENT_SCREENSHOT_DIR_CMD}    |   Path where screenshot files are saved on the ClientPC's side    |
...     |   ${CLIENT_WAITING_TIME}          |   Time in seconds to wait before verifying proper startup |
...     |   ${CLIENT_SHUTDOWN_TIME}         |   Time in seconfs to wait before power is restored to PC after shutdown   |
...  == Test PC variables ==
...  Test PC specific variables
...     |   =Name=                                          |   =Explanation=                       |
...     |   ${TESTPC_CLIENT_ONLINE_FILE_DIR}                |   Path to where to startup check file is copied to    |
...     |   ${TESTPC_SCREENSHOT_DIR}                        |   Path to where screenshots from the ClienPC are copied to    |
...     |   ${TESTPC_STARTUP_SAMPLE_SCREENSHOT_FILENAME}    |   Path where a reference image of the startup screen is located   |

Library     SSHLibrary
Resource    ./ClientPC/ClientPC_commands.robot
Resource    ./ClientPC/ClientPC_connection.robot
Resource    ./ClientPC/ClientPC_checks.robot
Resource    ./Others/time.robot
Resource    ./TestPC/TestPC_imageAnalysis.robot
Resource    ./PowerControlSwitch.robot

# python -m robot.libdoc ./Resources/ClientPC.robot ./Resources/ClientPC_doc.html

*** Variables ***

# * Client *
${CLIENT_HOST_IP}                               10.6.3.37
${CLIENT_SSH_PORT}                              22
${CLIENT_SSH_USERNAME}                          root
${CLIENT_SSH_PASSWORD}                          root
${CLIENT_GUI_TASK}                              javaw.exe
${CLIENT_ONLINE_FILE_PATH}                      /cygdrive/c/online.txt
${CLIENT_SCREENSHOT_DIR_CMD}                    C:\\\\robot_screenshots  # requires 4 backslashes due to psexec
${CLIENT_WAITING_TIME}                          60  # defines the waiting time for the client to restart
${CLIENT_SHUTDOWN_TIME}                         10


# * TestPC *
${TESTPC_CLIENT_ONLINE_FILE_DIR}                ./Resources/temp/online.txt
${TESTPC_SCREENSHOT_DIR}                        ./Resources/temp/robot_screenshots/  # cygdrive
${TESTPC_STARTUP_SAMPLE_SCREENSHOT_FILENAME}    Startup_GUI.png


*** Keywords ***

# 1) CHECKS
the client PC is running
    [Documentation]  Checks, whether the client PC is still running by
    ...  to access a file residing on it
    ClientPC_checks.check if PC is running  ${CLIENT_ONLINE_FILE_PATH}  ${TESTPC_CLIENT_ONLINE_FILE_DIR}

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

the client PC is successfully booted and GUI is opened
    [Documentation]  After checking whether the PC and the proper GUI Java
    ...  process is running, a screenshot is taken from the remote PC,
    ...  transferred to the local test PC and compared to a reference

    ClientPC_checks.check if PC is running  ${CLIENT_ONLINE_FILE_PATH}  ${TESTPC_CLIENT_ONLINE_FILE_DIR}
    ClientPC_checks.check if GUI is running  ${CLIENT_GUI_TASK}
    ${screenshot_name} =  ClientPC_commands.get screenshot
    ...  ${CLIENT_HOST_IP}
    ...  ${TESTPC_STARTUP_SAMPLE_SCREENSHOT_FILENAME}
    ...  ${CLIENT_SCREENSHOT_DIR_CMD}
    ...  ${TESTPC_SCREENSHOT_DIR}
    TestPC_imageAnalysis.compare screenshots  ${screenshot_name}

# 2) ACTIONS
i restart the client PC
    [Documentation]  Client PC is restarted. After restart, a new SSH
    ...  connection is established
    ClientPC_commands.restart the PC  ${CLIENT_HOST_IP}  ${CLIENT_SSH_PORT}  ${CLIENT_SSH_USERNAME}  ${CLIENT_SSH_PASSWORD}
    I wait for x seconds  ${CLIENT_WAITING_TIME}
    ClientPC_connection.try reconnection  ${CLIENT_HOST_IP}  ${CLIENT_SSH_PORT}  ${CLIENT_SSH_USERNAME}  ${CLIENT_SSH_PASSWORD}

i kill power to the client for a moment then restore the power
    [Documentation]  Client PC is powered off. After ``${CLIENT_SHUTDOWN_TIME}``
    ...  seconds, the PC is powered on again. After restart, a new SSH
    ...  connection is established
    PowerControlSwitch.I kill power to the client PC
    I wait for x seconds  ${CLIENT_SHUTDOWN_TIME}
    PowerControlSwitch.I restore power to the client PC
    I wait for x seconds  ${CLIENT_WAITING_TIME}
    ClientPC_connection.try reconnection  ${CLIENT_HOST_IP}  ${CLIENT_SSH_PORT}  ${CLIENT_SSH_USERNAME}  ${CLIENT_SSH_PASSWORD}