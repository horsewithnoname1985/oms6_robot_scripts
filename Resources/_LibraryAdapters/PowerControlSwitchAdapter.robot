*** Settings ***
Documentation  This keywords are designed for an Expert Power Control NET switched power distribution unit.
...  To execute the control command, the epccontrol2.pl tool is required (http://wiki.gude.info/FAQ_EPC_CmdLine)
...  To run the *.pl file it is required to install a Perl interpreter (such as Strawberry Perl http://strawberryperl.com/)

Library  OperatingSystem

*** Keywords ***
Kill port

    [Arguments]  ${PowerSwitchIP}   ${EPC_Port}

    run  epccontrol2.pl --host=${PowerSwitchIP} --switch_off --p=${EPC_Port}


Kill all ports

    [Arguments]  ${PowerSwitchIP}

    run  epccontrol2.pl --host=${PowerSwitchIP} --switch_off --p=1
    run  epccontrol2.pl --host=${PowerSwitchIP} --switch_off --p=2
    run  epccontrol2.pl --host=${PowerSwitchIP} --switch_off --p=3
    run  epccontrol2.pl --host=${PowerSwitchIP} --switch_off --p=4
    run  epccontrol2.pl --host=${PowerSwitchIP} --switch_off --p=5
    run  epccontrol2.pl --host=${PowerSwitchIP} --switch_off --p=6
    run  epccontrol2.pl --host=${PowerSwitchIP} --switch_off --p=7
    run  epccontrol2.pl --host=${PowerSwitchIP} --switch_off --p=8


Activate port

    [Arguments]  ${PowerSwitchIP}   ${EPC_Port}

    run  epccontrol2.pl --host=${PowerSwitchIP} --switch_on --p=${EPC_Port}


Activate all ports

    [Arguments]  ${PowerSwitchIP}

    run  epccontrol2.pl --host=${PowerSwitchIP} --switch_on --p=1
    run  epccontrol2.pl --host=${PowerSwitchIP} --switch_on --p=2
    run  epccontrol2.pl --host=${PowerSwitchIP} --switch_on --p=3
    run  epccontrol2.pl --host=${PowerSwitchIP} --switch_on --p=4
    run  epccontrol2.pl --host=${PowerSwitchIP} --switch_on --p=5
    run  epccontrol2.pl --host=${PowerSwitchIP} --switch_on --p=6
    run  epccontrol2.pl --host=${PowerSwitchIP} --switch_on --p=7
    run  epccontrol2.pl --host=${PowerSwitchIP} --switch_on --p=8
