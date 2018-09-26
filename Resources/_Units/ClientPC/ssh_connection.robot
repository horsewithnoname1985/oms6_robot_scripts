*** Settings ***
Documentation
...  This test suite verifies the successful startup of the
...  Client PC and the OMS6 GUI software

Resource  ${EXECDIR}/Resources/_LibraryAdapters/SSHLibraryAdapter.robot

*** Variables ***
${CLIENT_IP}                10.80.11.37
${CLIENT_SSH_PORT}          22
${CLIENT_SSH_USERNAME}      root
${CLIENT_SSH_PASSWORD}      root

*** Keywords ***
open SSH connection to client PC and log in
    open SSH connection and login  ${CLIENT_IP}  ${CLIENT_SSH_PORT}
    ...  ${CLIENT_SSH_USERNAME}  ${CLIENT_SSH_PASSWORD}


open SSH connection to client PC and log in if not already existing
    open SSH connection and login if not already open  ${CLIENT_IP}
    ...  ${CLIENT_SSH_PORT}  ${CLIENT_SSH_USERNAME}  ${CLIENT_SSH_PASSWORD}


try reconnection to client PC
    wait until keyword succeeds  1min  5 sec  open SSH connection to client PC and log in


close connection to client PC
    close current SSH connection