*** Settings ***
Documentation  This file contains all parameter checks about the backside traverse

Library     ${EXECDIR}/Libraries/JavaProperties.py
Library     SSHLibrary
Library     OperatingSystem
Resource    ${EXECDIR}/Resources/ServerPC/ServerPC_connection.robot

*** Variables ***
#PARAMETERS
${BackflashTraverseType}                 AcquireModule.system.traverse.BackflashTraverseType
${Backflash_InvertCrossWebDirection}     de.elsis.elscan.camera.backflash.InvertCrossWebDirection
${Backflash_MoveSynchronized}            de.elsis.elscan.camera.backflash.MoveSynchronized

# PATHS
# Remote
${AcquireModulePropertiesPath}              /elscan/config/acquireModule.properties
${CameraPropertiesPath}                     /elscan/config/camera.properties

# Local
${propDir}                                  .\\Resources\\temp\\properties_files
${AcquireModulePropertiesLocalPath}         ${propDir}\\acquireModule.properties
${CameraPropertiesLocalPath}                ${propDir}\\camera.properties

*** Keywords ***

Verify traverse - Setup
    open connection and log in

    SSHLibrary.get file  ${AcquireModulePropertiesPath}     destination=${propDir}\\
    SSHLibrary.get file  ${CameraPropertiesPath}            destination=${propDir}\\

    ${AcquireModulePropertiesContent}=          get properties file content  ${AcquireModulePropertiesLocalPath}
    ${CameraPropertiesContent}=                 get properties file content  ${CameraPropertiesLocalPath}

    ${Backflash_TraverseType_Value}=                get properties value  ${AcquireModulePropertiesContent}         ${BackflashTraverseType}
    ${Backflash_MoveSynchronized_Value}=            get properties value  ${CameraPropertiesContent}                ${Backflash_MoveSynchronized}
    ${Backflash_InvertCrossWebDirection_Value}=     get properties value  ${CameraPropertiesContent}                ${Backflash_InvertCrossWebDirection}

    set test variable  ${BackflashTraverseType_Value}               ${BackflashTraverseType_Value}
    set test variable  ${Backflash_MoveSynchronized_Value}          ${Backflash_MoveSynchronized_Value}
    set test variable  ${Backflash_InvertCrossWebDirection_Value}   ${Backflash_InvertCrossWebDirection_Value}

Verify traverse - Teardown
    close all connections

Verify - No backside traverse
    Verify traverse - Setup

    # acquireModule.properties
    should be equal as strings  ${BackflashTraverseType_Value}              none

    # camera.properties
    should be equal as strings  ${Backflash_MoveSynchronized_Value}         false
    should be equal as strings  ${Backflash_InvertCrossWebDirection_Value}  false

    Verify traverse - Teardown

Verify - Standard backside traverse
    Verify traverse - Setup

    # acquireModule.properties
    should be equal as strings  ${BackflashTraverseType_Value}              AG8

    # camera.properties
    should be equal as strings  ${Backflash_MoveSynchronized_Value}         true
    should be equal as strings  ${Backflash_InvertCrossWebDirection_Value}  false

    Verify traverse - Teardown

Verify - Inverted backside traverse
    Verify traverse - Setup

    # acquireModule.properties
    should be equal as strings  ${BackflashTraverseType_Value}              AG8

    # camera.properties
    should be equal as strings  ${Backflash_MoveSynchronized_Value}         true
    should be equal as strings  ${Backflash_InvertCrossWebDirection_Value}  true

    Verify traverse - Teardown

Verify - Full width backflash
    Verify traverse - Setup

    # acquireModule.properties
    should be equal as strings  ${BackflashTraverseType_Value}              none

    # camera.properties
    should be equal as strings  ${Backflash_MoveSynchronized_Value}         false
    should be equal as strings  ${Backflash_InvertCrossWebDirection_Value}  false

    Verify traverse - Teardown

