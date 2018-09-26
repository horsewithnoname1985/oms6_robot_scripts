*** Settings ***
Documentation  Chiffre explanation:
...  CO ... Camera orientation
...  WD ... Web direction
...  IO ... Image orientation

Library     ${EXECDIR}/Libraries/JavaProperties.py
Library     SSHLibrary
Library     OperatingSystem
Resource    ${EXECDIR}/Resources/ServerPC/ServerPC_connection.robot


*** Variables ***
# PARAMETERS
# camera.properties, GuiNormalParam.properties & GuiReverseParam.properties Parameter
${InvertCrossWebDirection}          de.elsis.elscan.camera.web.InvertCrossWebDirection
${InvertWebDirection}               de.elsis.elscan.camera.web.InvertWebDirection
${InvertOffsetWeb}                  de.elsis.elscan.camera.InvertOffsetWeb

# camera.properties only Parameter
${TeleOffsetWeb}                    de.elsis.elscan.camera.tele.OffsetWeb

# ipPipeTele.properties & ipPipeWide.properties Parameter
${TeleImageProcessingImpl}          de.elsis.elscan.camera.tele.imageProcessing.Implementation
${TeleImageProcessingSteps}         de.elsis.elscan.camera.tele.imageProcessing.Steps
${WideImageProcessingImpl}          de.elsis.elscan.camera.wide.imageProcessing.Implementation
${WideImageProcessingSteps}         de.elsis.elscan.camera.wide.imageProcessing.Steps

# PATHS
# Remote
${CameraPropertiesPath}             /elscan/config/camera.properties
${IpPipeTelePropertiesPath}         /elscan/config/ipPipeTele.properties
${IpPipeWidePropertiesPath}         /elscan/config/ipPipeWide.properties
${GuiNormalParamPropertiesPath}     /elscan/config/GuiNormalParam.properties
${GuiReverseParamPropertiesPath}    /elscan/config/GuiReverseParam.properties

# Local
# used ${tempDir} instead of ${propdir} before which is a predefined variable,
# that can't be reset and points to a temporary dir during test execution
# (C:\Users\<username>\appdata\local\temp\..)
${propDir}                          .\\Resources\\temp\\properties_files
${CameraPropertiesLocalPath}        ${propDir}\\camera.properties
${IpPipeTelePropertiesLocalPath}    ${propDir}\\ipPipeTele.properties
${IpPipeWidePropertiesLocalPath}    ${propDir}\\ipPipeWide.properties
${GuiNormalParamPropLocalPath}      ${propDir}\\GuiNormalParam.properties
${GuiReverseParamPropLocalPath}     ${propDir}\\GuiReverseParam.properties


*** Keywords ***
Verify orientation - Setup
    [Documentation]  Copy all required properties files from the server to local directory

    Open Connection And Log In
    # Get 'Permission denied' error when using variables with the same content -> Strange!
    # Must explicitly define destination directory
    SSHLibrary.get file  ${CameraPropertiesPath}            destination=${propDir}\\
    SSHLibrary.get file  ${ipPipeTelePropertiesPath}        destination=${propDir}\\
    SSHLibrary.get file  ${ipPipeWidePropertiesPath}        destination=${propDir}\\
    SSHLibrary.get file  ${GuiNormalParamPropertiesPath}    destination=${propDir}\\
    SSHLibrary.get file  ${GuiReverseParamPropertiesPath}   destination=${propDir}\\

    ${CameraPropertiesContent}=             get properties file content  ${CameraPropertiesLocalPath}
    ${IpPipeTelePropertiesContent}=         get properties file content  ${ipPipeTelePropertiesLocalPath}
    ${IpPipeWidePropertiesContent}=         get properties file content  ${IpPipeWidePropertiesLocalPath}
    ${GuiNormalParamPropertiesContent}=     get properties file content  ${GuiNormalParamPropLocalPath}
    ${GuiReverseParamPropertiesContent}=    get properties file content  ${GuiReverseParamPropLocalPath}

    ${InvertCrossWebDirection_Value}=       get properties value  ${CameraPropertiesContent}            ${InvertCrossWebDirection}
    ${InvertWebDirection_Value}=            get properties value  ${CameraPropertiesContent}            ${InvertWebDirection}
    ${InvertOffsetWeb_Value}=               get properties value  ${CameraPropertiesContent}            ${InvertOffsetWeb}
    ${TeleOffsetWeb_Value}=                 get properties value  ${CameraPropertiesContent}            ${teleOffsetWeb}

    ${TeleImageProcessingImpl_Value}=       get properties value  ${IpPipeTelePropertiesContent}        ${TeleImageProcessingImpl}
    ${TeleImageProcessingSteps_Value}=      get properties value  ${IpPipeTelePropertiesContent}        ${TeleImageProcessingSteps}
    ${WideImageProcessingImpl_Value}=       get properties value  ${IpPipeWidePropertiesContent}        ${WideImageProcessingImpl}
    ${WideImageProcessingSteps_Value}=      get properties value  ${IpPipeWidePropertiesContent}        ${WideImageProcessingSteps}

    ${Norm_InvertCrossWebDirection_Value}=  get properties value  ${GuiNormalParamPropertiesContent}    ${InvertCrossWebDirection}
    ${Norm_InvertWebDirection_Value}=       get properties value  ${GuiNormalParamPropertiesContent}    ${InvertWebDirection}
    ${Norm_InvertOffsetWeb_Value}=          get properties value  ${GuiNormalParamPropertiesContent}    ${InvertOffsetWeb}

    ${Rev_InvertCrossWebDirection_Value}=   get properties value  ${GuiReverseParamPropertiesContent}   ${InvertCrossWebDirection}
    ${Rev_InvertWebDirection_Value}=        get properties value  ${GuiReverseParamPropertiesContent}   ${InvertWebDirection}
    ${Rev_InvertOffsetWeb_Value}=           get properties value  ${GuiReverseParamPropertiesContent}   ${InvertOffsetWeb}

    set test variable   ${InvertCrossWebDirection_Value}        ${InvertCrossWebDirection_Value}
    set test variable   ${InvertWebDirection_Value}             ${InvertWebDirection_Value}
    set test variable   ${InvertOffsetWeb_Value}                ${InvertOffsetWeb_Value}
    set test variable   ${TeleOffsetWeb_Value}                  ${TeleOffsetWeb_Value}

    set test variable   ${TeleImageProcessingImpl_Value}        ${TeleImageProcessingImpl_Value}
    set test variable   ${TeleImageProcessingSteps_Value}       ${TeleImageProcessingSteps_Value}
    set test variable   ${WideImageProcessingImpl_Value}        ${WideImageProcessingImpl_Value}
    set test variable   ${WideImageProcessingSteps_Value}       ${WideImageProcessingSteps_Value}

    set test variable   ${Norm_InvertCrossWebDirection_Value}   ${Norm_InvertCrossWebDirection_Value}
    set test variable   ${Norm_InvertWebDirection_Value}        ${Norm_InvertWebDirection_Value}
    set test variable   ${Norm_InvertOffsetWeb_Value}           ${Norm_InvertOffsetWeb_Value}

    set test variable   ${Rev_InvertCrossWebDirection_Value}    ${Rev_InvertCrossWebDirection_Value}
    set test variable   ${Rev_InvertWebDirection_Value}         ${Rev_InvertWebDirection_Value}
    set test variable   ${Rev_InvertOffsetWeb_Value}            ${Rev_InvertOffsetWeb_Value}


Verify orientation - Teardown
    close all connections
#    remove directory  ${propDir}  recursive=True


Verify - CO: Normal + WD: Top down + IO: Right side up
    [Documentation]  This method checks the orientation parameters set from the wizard

    Verify orientation - Setup

    # camera.properties
    should be equal as strings  ${InvertCrossWebDirection_Value}        true
    should be equal as strings  ${InvertWebDirection_Value}             true
    should be equal as strings  ${InvertOffsetWeb_Value}                false
    should be equal as strings  ${TeleOffsetWeb_Value}                  -42500

    # ipPipeTele.properties
    should contain              ${TeleImageProcessingImpl_Value}        ROTATE
    should contain              ${TeleImageProcessingSteps_Value}       ROTATE

    # ipPipeWide.properties
    should not contain          ${WideImageProcessingImpl_Value}        ROTATE
    should not contain          ${WideImageProcessingSteps_Value}       ROTATE

    # GuiNormalParam.properties
    should be equal as strings  ${Norm_InvertCrossWebDirection_Value}   true
    should be equal as strings  ${Norm_InvertWebDirection_Value}        true
    should be equal as strings  ${Norm_InvertOffsetWeb_Value}           false

    # GuiReverseParam.properties
    should be equal as strings  ${Rev_InvertCrossWebDirection_Value}    true
    should be equal as strings  ${Rev_InvertWebDirection_Value}         false
    should be equal as strings  ${Rev_InvertOffsetWeb_Value}            true

    Verify orientation - Teardown


Verify - CO: Normal + WD: Bottom up + IO: Right side up
    [Documentation]  This method checks the orientation parameters set from the wizard

    Verify orientation - Setup

    # camera.properties
    should be equal as strings  ${InvertCrossWebDirection_Value}        true
    should be equal as strings  ${InvertWebDirection_Value}             false
    should be equal as strings  ${InvertOffsetWeb_Value}                true
    should be equal as strings  ${TeleOffsetWeb_Value}                  42500

    # ipPipeTele.properties
    should contain              ${TeleImageProcessingImpl_Value}        ROTATE
    should contain              ${TeleImageProcessingSteps_Value}       ROTATE

    # ipPipeWide.properties
    should not contain          ${WideImageProcessingImpl_Value}        ROTATE
    should not contain          ${WideImageProcessingSteps_Value}       ROTATE

    # GuiNormalParam.properties
    should be equal as strings  ${Norm_InvertCrossWebDirection_Value}   true
    should be equal as strings  ${Norm_InvertWebDirection_Value}        false
    should be equal as strings  ${Norm_InvertOffsetWeb_Value}           true

    # GuiReverseParam.properties
    should be equal as strings  ${Rev_InvertCrossWebDirection_Value}    true
    should be equal as strings  ${Rev_InvertWebDirection_Value}         true
    should be equal as strings  ${Rev_InvertOffsetWeb_Value}            false

    Verify orientation - Teardown


Verify - CO: Rotated + WD: Bottom up + IO: Right side up
    [Documentation]  This method checks the orientation parameters set from the wizard

    Verify orientation - Setup

    # camera.properties
    should be equal as strings  ${InvertCrossWebDirection_Value}        true
    should be equal as strings  ${InvertWebDirection_Value}             false
    should be equal as strings  ${InvertOffsetWeb_Value}                true
    should be equal as strings  ${TeleOffsetWeb_Value}                  -42500

    # ipPipeTele.properties
    should not contain          ${TeleImageProcessingImpl_Value}        ROTATE
    should not contain          ${TeleImageProcessingSteps_Value}       ROTATE

    # ipPipeWide.properties
    should contain              ${WideImageProcessingImpl_Value}        ROTATE
    should contain              ${WideImageProcessingSteps_Value}       ROTATE

    # GuiNormalParam.properties
    should be equal as strings  ${Norm_InvertCrossWebDirection_Value}   true
    should be equal as strings  ${Norm_InvertWebDirection_Value}        false
    should be equal as strings  ${Norm_InvertOffsetWeb_Value}           true

    # GuiReverseParam.properties
    should be equal as strings  ${Rev_InvertCrossWebDirection_Value}    true
    should be equal as strings  ${Rev_InvertWebDirection_Value}         true
    should be equal as strings  ${Rev_InvertOffsetWeb_Value}            false

    Verify orientation - Teardown


Verify - CO: Rotated + WD: Top down + IO: Right side up
    [Documentation]  This method checks the orientation parameters set from the wizard

    Verify orientation - Setup

    # camera.properties
    should be equal as strings  ${InvertCrossWebDirection_Value}        true
    should be equal as strings  ${InvertWebDirection_Value}             true
    should be equal as strings  ${InvertOffsetWeb_Value}                false
    should be equal as strings  ${TeleOffsetWeb_Value}                  42500

    # ipPipeTele.properties
    should not contain          ${TeleImageProcessingImpl_Value}        ROTATE
    should not contain          ${TeleImageProcessingSteps_Value}       ROTATE

    # ipPipeWide.properties
    should contain              ${WideImageProcessingImpl_Value}        ROTATE
    should contain              ${WideImageProcessingSteps_Value}       ROTATE

    # GuiNormalParam.properties
    should be equal as strings  ${Norm_InvertCrossWebDirection_Value}   true
    should be equal as strings  ${Norm_InvertWebDirection_Value}        true
    should be equal as strings  ${Norm_InvertOffsetWeb_Value}           false

    # GuiReverseParam.properties
    should be equal as strings  ${Rev_InvertCrossWebDirection_Value}    true
    should be equal as strings  ${Rev_InvertWebDirection_Value}         false
    should be equal as strings  ${Rev_InvertOffsetWeb_Value}            true

    Verify orientation - Teardown


Verify - CO: Normal + WD: Bottom up + IO: Upside down
    [Documentation]  This method checks the orientation parameters set from the wizard

    Verify orientation - Setup

    # camera.properties
    should be equal as strings  ${InvertCrossWebDirection_Value}        false
    should be equal as strings  ${InvertWebDirection_Value}             true
    should be equal as strings  ${InvertOffsetWeb_Value}                false
    should be equal as strings  ${TeleOffsetWeb_Value}                  42500

    # ipPipeTele.properties
    should not contain          ${TeleImageProcessingImpl_Value}        ROTATE
    should not contain          ${TeleImageProcessingSteps_Value}       ROTATE

    # ipPipeWide.properties
    should contain              ${WideImageProcessingImpl_Value}        ROTATE
    should contain              ${WideImageProcessingSteps_Value}       ROTATE

    # GuiNormalParam.properties
    should be equal as strings  ${Norm_InvertCrossWebDirection_Value}   false
    should be equal as strings  ${Norm_InvertWebDirection_Value}        true
    should be equal as strings  ${Norm_InvertOffsetWeb_Value}           false

    # GuiReverseParam.properties
    should be equal as strings  ${Rev_InvertCrossWebDirection_Value}    false
    should be equal as strings  ${Rev_InvertWebDirection_Value}         false
    should be equal as strings  ${Rev_InvertOffsetWeb_Value}            true

    Verify orientation - Teardown


Verify - CO: Rotated + WD: Bottom up + IO: Upside down
    [Documentation]  This method checks the orientation parameters set from the wizard

    Verify orientation - Setup

    # camera.properties
    should be equal as strings  ${InvertCrossWebDirection_Value}        false
    should be equal as strings  ${InvertWebDirection_Value}             true
    should be equal as strings  ${InvertOffsetWeb_Value}                false
    should be equal as strings  ${TeleOffsetWeb_Value}                  -42500

    # ipPipeTele.properties
    should contain              ${TeleImageProcessingImpl_Value}        ROTATE
    should contain              ${TeleImageProcessingSteps_Value}       ROTATE

    # ipPipeWide.properties
    should not contain          ${WideImageProcessingImpl_Value}        ROTATE
    should not contain          ${WideImageProcessingSteps_Value}       ROTATE

    # GuiNormalParam.properties
    should be equal as strings  ${Norm_InvertCrossWebDirection_Value}   false
    should be equal as strings  ${Norm_InvertWebDirection_Value}        true
    should be equal as strings  ${Norm_InvertOffsetWeb_Value}           false

    # GuiReverseParam.properties
    should be equal as strings  ${Rev_InvertCrossWebDirection_Value}    false
    should be equal as strings  ${Rev_InvertWebDirection_Value}         false
    should be equal as strings  ${Rev_InvertOffsetWeb_Value}            true

    Verify orientation - Teardown


Verify - CO: Normal + WD: Top down + IO: Upside down
    [Documentation]  This method checks the orientation parameters set from the wizard

    Verify orientation - Setup

    # camera.properties
    should be equal as strings  ${InvertCrossWebDirection_Value}        false
    should be equal as strings  ${InvertWebDirection_Value}             false
    should be equal as strings  ${InvertOffsetWeb_Value}                true
    should be equal as strings  ${TeleOffsetWeb_Value}                  -42500

    # ipPipeTele.properties
    should not contain          ${TeleImageProcessingImpl_Value}        ROTATE
    should not contain          ${TeleImageProcessingSteps_Value}       ROTATE

    # ipPipeWide.properties
    should contain              ${WideImageProcessingImpl_Value}        ROTATE
    should contain              ${WideImageProcessingSteps_Value}       ROTATE

    # GuiNormalParam.properties
    should be equal as strings  ${Norm_InvertCrossWebDirection_Value}   false
    should be equal as strings  ${Norm_InvertWebDirection_Value}        false
    should be equal as strings  ${Norm_InvertOffsetWeb_Value}           true

    # GuiReverseParam.properties
    should be equal as strings  ${Rev_InvertCrossWebDirection_Value}    false
    should be equal as strings  ${Rev_InvertWebDirection_Value}         true
    should be equal as strings  ${Rev_InvertOffsetWeb_Value}            false

    Verify orientation - Teardown


Verify - CO: Rotated + WD: Top down + IO: Upside down
    [Documentation]  This method checks the orientation parameters set from the wizard

    Verify orientation - Setup

    # camera.properties
    should be equal as strings  ${InvertCrossWebDirection_Value}        false
    should be equal as strings  ${InvertWebDirection_Value}             false
    should be equal as strings  ${InvertOffsetWeb_Value}                true
    should be equal as strings  ${TeleOffsetWeb_Value}                  42500

    # ipPipeTele.properties
    should contain              ${TeleImageProcessingImpl_Value}        ROTATE
    should contain              ${TeleImageProcessingSteps_Value}       ROTATE

    # ipPipeWide.properties
    should not contain          ${WideImageProcessingImpl_Value}        ROTATE
    should not contain          ${WideImageProcessingSteps_Value}       ROTATE

    # GuiNormalParam.properties
    should be equal as strings  ${Norm_InvertCrossWebDirection_Value}   false
    should be equal as strings  ${Norm_InvertWebDirection_Value}        false
    should be equal as strings  ${Norm_InvertOffsetWeb_Value}           true

    # GuiReverseParam.properties
    should be equal as strings  ${Rev_InvertCrossWebDirection_Value}    false
    should be equal as strings  ${Rev_InvertWebDirection_Value}         true
    should be equal as strings  ${Rev_InvertOffsetWeb_Value}            false

    Verify orientation - Teardown
