*** Settings ***
Resource    ${EXECDIR}/Resources/_LibraryAdapters/SSHLibraryAdapter.robot

*** Variables ***


*** Keywords ***
restart the client PC via SSH command
    open SSH connection to client PC and log in if not already existing
    execute command via SSH connection  shutdown -r now

