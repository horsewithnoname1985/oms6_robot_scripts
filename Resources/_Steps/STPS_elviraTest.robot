*** Settings ***
Library     Remote  http://127.0.0.1:8270/  WITH NAME  TestMain
Resource    ${EXECDIR}/Resources/_LibraryAdapters/JavaPropertiesAdapter.robot

*** Variables ***
${SERVER_IP_ADDRESS}                    10.80.11.181
${CLIENT_IP_ADDRESS}                    10.80.11.45

# *** Config Files Paths ***
${GUI_PROPERTIES_PATH}                  C:\\elscan\\config\\gui.properties
${OMS_PROPERTIES_PATH}                  C:\\elscan\\config\\oms.properties

# *** Test Parameter ***
${CLIENT_IP_ADDRESS_KEY}                de.elsis.elscan.network.gui.Address
${SERVER_IP_ADDRESS_KEY}                de.elsis.elscan.network.gui.MiddlewareAddress

*** Keywords ***
Write client and server address to local gui.properties file
    write new value to exiting parameter in properties file
    ...  ${GUI_PROPERTIES_PATH}  ${CLIENT_IP_ADDRESS_KEY}  ${CLIENT_IP_ADDRESS}
    write new value to exiting parameter in properties file
    ...  ${GUI_PROPERTIES_PATH}  ${SERVER_IP_ADDRESS_KEY}  ${SERVER_IP_ADDRESS}

Run test from elviraTest

    [Arguments]  ${test}

    ${result}  ${resultlink}=  TestMain.runTest  ${test}
    Run Keyword And Continue On Failure  should be equal as strings  ${result}  true

Run test from elviraTest with logging graph html file

    [Documentation]  file:///C://testResults/FramerateTest_TimeTrigger/FramerateTest_TimeTrigger.png
    [Arguments]  ${test}

    ${result}  ${resultlink}=  TestMain.runTest  ${test}
    Run Keyword And Continue On Failure  should be equal as strings  ${result}  true
    Log  See here for results: file:///${resultlink}




