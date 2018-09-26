*** Settings ***
Resource  ${EXECDIR}/Resources/_Units/ClientPC/commands.robot
Resource  ${EXECDIR}/Resources/_Units/ClientPC/screenshots.robot
Resource  ${EXECDIR}/Resources/_Units/ClientPC/ssh_connection.robot
Resource  ${EXECDIR}/Resources/_Units/ClientPC/status_checks.robot
Resource  ${EXECDIR}/Resources/_Units/ClientPC/waiting.robot

*** Keywords ***
the client PC is running

    [Documentation]  Checks, whether the client PC is still running by
    ...  to access a file residing on it

    check if PC is running


the client PC is restarted

    [Documentation]  Client PC is restarted. After restart, a new SSH
    ...  connection is established

    restart the client PC via SSH command
    wait until the client PC has fully restarted
    try reconnection to client PC


the client PC is successfully booted and GUI is opened

    [Documentation]  After checking whether the PC and the proper GUI Java
    ...  process is running, a screenshot is taken from the remote PC,
    ...  transferred to the local test PC and compared to a reference

    check if PC is running
    check if GUI is running
    ${screenshot_path} =  get screenshot from remote client PC via SSH connection
    compare startup screenshot with reference  ${screenshot_path}


i kill power to the client for a moment then restore the power

    [Documentation]  Client PC is powered off. After ``${CLIENT_SHUTDOWN_TIME}``

    ...  seconds, the PC is powered on again. After restart, a new SSH
    ...  connection is established
    PowerControlSwitch.I kill power to the client PC
    wait for x seconds  ${CLIENT_SHUTDOWN_TIME}
    PowerControlSwitch.I restore power to the client PC
    wait for x seconds  ${CLIENT_WAITING_TIME}
    ClientPC_connection.try reconnection  ${CLIENT_HOST_IP}  ${CLIENT_SSH_PORT}  ${CLIENT_SSH_USERNAME}  ${CLIENT_SSH_PASSWORD}

