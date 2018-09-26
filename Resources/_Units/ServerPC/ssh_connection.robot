*** Settings ***
Resource  ${EXECDIR}/Resources/_LibraryAdapters/SSHLibraryAdapter.robot

*** Variables ***
${SERVER_IP}                                    10.7.3.1
${SERVER_SSH_PORT}                              22
${SERVER_SSH_USERNAME}                          root
${SERVER_SSH_PASSWORD}                          Elv1ra!oms

*** Keywords ***
Open SSH connection to server PC

    open SSH connection and login  ${SERVER_IP}  ${SERVER_SSH_PORT}  ${SERVER_SSH_USERNAME}  ${SERVER_SSH_PASSWORD}

