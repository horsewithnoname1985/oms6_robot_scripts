*** Settings ***
Documentation  This resource file contains a set of keywords useful to establish
...  a SSH connection with a OMS6 server PC.
...
...  Please consider that all relevant connection parameters are set inside
...  Resources/ServerPC.robot
Library     SSHLibrary
Resource    ../ServerPC.robot

*** Variables ***
# Connection variables are defined in ServerPC.robot

*** Keywords ***

# * ACTIONS *
Open Connection And Log In
    [Documentation]  An SSH connection is attempted, using the variables
    ...  ``${SERVER_HOST_IP}`` and ``${SERVER_SSH_PORT}``. OMS6 server
    ...  PCs by default have a SSH server installed.
    SSHLibrary.open connection  ${SERVER_HOST_IP}  timeout=15s  port=${SERVER_SSH_PORT}
    login  ${SERVER_SSH_USERNAME}  ${SERVER_SSH_PASSWORD}

try reconnection
    [Documentation]  If the connection is not reliable at the point in time
    ...  where this keyword is called, then rather use this keyword instead of
    ...  `Open Connection And Log In`. It tries to establish a connection for
    ...  2 minutes while attempting a connection each 5 seconds.
    # tries to execute the keyword every 5 seconds for 2 minutes
    wait until keyword succeeds  2 min  5 sec  ServerPC_connection.Open Connection And Log In