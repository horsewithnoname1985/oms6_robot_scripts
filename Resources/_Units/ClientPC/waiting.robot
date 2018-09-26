*** Settings ***
Resource  ${EXECDIR}/Resources/_LibraryAdapters/TimeAdapter.robot

*** Variables ***
${WAIT_FOR_CLIENT_RESTART_IN_SECONDS}   50
${WAIT_FOR_CLIENT_SHUTDOWN_IN_SECONDS}  10

*** Keywords ***
wait until the client PC has fully restarted
    wait for x seconds  ${WAIT_FOR_CLIENT_RESTART_IN_SECONDS}


wait until the client PC has shut down
    wait for x seconds  ${WAIT_FOR_CLIENT_SHUTDOWN_IN_SECONDS}