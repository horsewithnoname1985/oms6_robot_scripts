*** Settings ***
Documentation    This suite contains all tests that use the elviraTest remote
...  library

Metadata        Version     1.0
Metadata        Author      Arne Wohletz

Resource        ${EXECDIR}/Resources/_Steps/STPS_elviraTest.robot

Force Tags      elviraTest

Suite Setup     Setup - Update client and server IP addresses

# robot -d C:/testResults -e client_view Tests/TS_elviraTest.robot
# robot -d C:/testResults -i framerate Tests/TS_elviraTest.robot
# robot -d C:/testResults -i basic Tests/TS_elviraTest.robot

*** Variables ***
########## Test Names #########################################################
${BASIC_CONNECTION_TEST}                ConnectionTest

${FRAMERATE_TEST_TIME_SYNC}             FramerateTest_TimeTrigger
${FRAMERATE_TEST_WEB_SYNC}              FramerateTest_WebTrigger

${PARAM_READ_ONLY_TEST}                 IsReadOnlyTest
${PARAM_AMOUNT_OF_CAM_PARAM_TEST}       NumberOfCamParameterTest
${PARAM_AMOUNT_OF_SYS_PARAM_TEST}       NumberOfSysParameterTest
${PARAM_SET_CURR_CAM_VALUE_TEST}        SetCurrentCamValueTest
${PARAM_SET_CURR_SYS_VALUE_TEST}        SetCurrentSysValueTest
${PARAM_SET_INVALID_CAM_VALUE_TEST}     SetInvalidCamValueTest
${PARAM_SET_INVALID_SYS_VALUE_TEST}     SetInvalidSysValueTest
${PARAM_SET_VALID_CAM_VALUE_TEST}       SetValidCamValueTest
${PARAM_SET_VALID_SYS_VALUE_TEST}       SetValidSysValueTest

# Client View (CV)
${CV_NEAREST_NEIGBOUR_SCALING_TEST}     ClientViewTest_Scaling_NearestNeighbour
${CV_LINEAR_SCALING_TEST}               ClientViewTest_Scaling_Linear
${CV_QUADRATIC_SCALING_TEST}            ClientViewTest_Scaling_Quadratic
${CV_CUBRIC_SCALING_TEST}               ClientViewTest_Scaling_Cubic

########## Test Parameters Values #############################################
# THESE ARE CURRENTLY NOT USED BECAUSE elviraTest LOOKS THESE UP IN DIFFERENT PROPERTIES FILE
${FRAMERATE_TEST_DURATION_IN_MS}        100000


*** Test Cases ***
Execute basic tests

    [Tags]  basic

    Connection test is successful


Execute framerate tests

    [Tags]  framerate

    Framerate (Time Trigger) is sufficient
#    Framerate (Web Trigger) is sufficient


Execute client views tests

    [Tags]  client_view

    Client view with nearest neigbour scaling is created sufficiently fast and contains the correct FOV
    Client view with linear scaling is created sufficiently fast and contains the correct FOV
    Client view with quadratic scaling is created sufficiently fast and contains the correct FOV
    Client view with cubric scaling is created sufficiently fast and contains the correct FOV

Execute parameter tests

    [Tags]  parameter

    Read-only parameters are not adjustable
    Amount of parameters is correct
    Sending already set value does not lead to a reset of any parameter
    Unable to set an invalid value
    Able to set a valid value


*** Keywords ***
########## SETUP ##############################################################
Setup - Update client and server IP addresses
    Write client and server address to local gui.properties file

########## TESTS ##############################################################
# *** Basic tests ***
Connection test is successful
    run test from elviraTest  ${BASIC_CONNECTION_TEST}

# *** Framerate tests ***
Framerate (Time Trigger) is sufficient
    run test from elviraTest with logging graph html file  ${FRAMERATE_TEST_TIME_SYNC}

Framerate (Web Trigger) is sufficient
    run test from elviraTest with logging graph html file  ${FRAMERATE_TEST_WEB_SYNC}

# *** Client view tests ***
Client view with nearest neigbour scaling is created sufficiently fast and contains the correct FOV
    Run test from elviraTest with logging graph html file  ${CV_NEAREST_NEIGBOUR_SCALING_TEST}

Client view with linear scaling is created sufficiently fast and contains the correct FOV
    Run test from elviraTest with logging graph html file  ${CV_LINEAR_SCALING_TEST}

Client view with quadratic scaling is created sufficiently fast and contains the correct FOV
    Run test from elviraTest with logging graph html file  ${CV_QUADRATIC_SCALING_TEST}

Client view with cubric scaling is created sufficiently fast and contains the correct FOV
    Run test from elviraTest with logging graph html file  ${CV_CUBRIC_SCALING_TEST}

# *** Parameter tests ***
Read-only parameters are not adjustable
    run test from elviraTest  ${PARAM_READ_ONLY_TEST}

Amount of parameters is correct
    run test from elviraTest  ${PARAM_AMOUNT_OF_CAM_PARAM_TEST}
    run test from elviraTest  ${PARAM_AMOUNT_OF_SYS_PARAM_TEST}

Sending already set value does not lead to a reset of any parameter
    run test from elviraTest  ${PARAM_SET_CURR_CAM_VALUE_TEST}
    run test from elviraTest  ${PARAM_SET_CURR_SYS_VALUE_TEST}

Unable to set an invalid value
    run test from elviraTest  ${PARAM_SET_INVALID_CAM_VALUE_TEST}
    run test from elviraTest  ${PARAM_SET_INVALID_SYS_VALUE_TEST}

Able to set a valid value
    run test from elviraTest  ${PARAM_SET_VALID_CAM_VALUE_TEST}
    run test from elviraTest  ${PARAM_SET_VALID_SYS_VALUE_TEST}

