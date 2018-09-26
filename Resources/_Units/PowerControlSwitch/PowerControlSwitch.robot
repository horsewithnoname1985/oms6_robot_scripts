*** Settings ***
Resource  ${EXECDIR}/_LibraryAdapters/PowerControlSwitchAdapter.robot
Resource  ${EXECDIR}/_LibraryAdapters/TimeAdapter.robot

*** Variables ***
${ClientPC_Port}        6
${ServerPC_Port}        7
${Pxlbx_AG9_DK_Port}    8
${PowerSwitchIP}        10.6.3.100

*** Keywords ***
########## RESTORE POWER ######################################################
I restore power to all ports
    Activate all ports

I restore power to the client PC
    Activate port  ${PowerSwitchIP}  ${ClientPC_Port}

I restore power to the server PC
    Activate port  ${PowerSwitchIP}  ${ServerPC_Port}

I restore power to the pixelbox
    Activate port  ${PowerSwitchIP}  ${Pxlbx_AG9_DK_Port}

I restore power to both server and client PC
    Activate port  ${PowerSwitchIP}  ${ServerPC_Port}
    Activate port  ${PowerSwitchIP}  ${ClientPC_Port}

I restore power to server, client, pixelbox, motor and camera
    Activate port  ${PowerSwitchIP}  ${ServerPC_Port}
    Activate port  ${PowerSwitchIP}  ${ClientPC_Port}
    Activate port  ${PowerSwitchIP}  ${Pxlbx_AG9_DK_Port}

########## KILL POWER #########################################################
I kill all ports
    Kill all ports
    wait the usual time before restoring power

I kill power to the client PC
    Kill port  ${PowerSwitchIP}  ${ClientPC_Port}
    wait the usual time before restoring power

I kill power to the server PC
    Kill port  ${PowerSwitchIP}  ${ServerPC_Port}
    wait the usual time before restoring power

I kill power to the pixelbox
    Kill port  ${PowerSwitchIP}  ${Pxlbx_AG9_DK_Port}
    wait the usual time before restoring power

I kill power to both server and client PC
    Kill port  ${PowerSwitchIP}  ${ServerPC_Port}
    Kill port  ${PowerSwitchIP}  ${ClientPC_Port}
    wait the usual time before restoring power

I kill power to server, client, pixelbox, motor and camera
    Kill port  ${PowerSwitchIP}  ${ServerPC_Port}
    Kill port  ${PowerSwitchIP}  ${ClientPC_Port}
    Kill port  ${PowerSwitchIP}  ${Pxlbx_AG9_DK_Port}
    wait the usual time before restoring power

I kill power to all components
    Kill port  ${PowerSwitchIP}  ${ServerSwitchCabinet_Port}
    Kill port  ${PowerSwitchIP}  ${AG9_Port}
    wait the usual time before restoring power

########## WAITING ############################################################
wait the usual time before restoring power
    wait for x seconds  5