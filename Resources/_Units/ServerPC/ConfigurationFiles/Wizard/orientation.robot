*** Settings ***
Documentation  Chiffre explanation:
...  CO ... Camera orientation
...  WD ... Web direction
...  IO ... Image orientation

Resource    ${EXECDIR}/Resources/_LibraryAdapters/JavaPropertiesAdapter.robot
Resource    ${EXECDIR}/Resources/_LibraryAdapters/SSHLibraryAdapter.robot
Resource    ${EXECDIR}/Resources/_Units/ServerPC/ConfigurationFiles/_path_variables.robot
Resource    ${EXECDIR}/Resources/_Units/ServerPC/ssh_connection.robot

*** Variables ***
# PARAMETERS
# camera.properties, GuiNormalParam.properties & GuiReverseParam.properties
${INVERT_CROSS_WEB_DIRECTION}         de.elsis.elscan.camera.web.InvertCrossWebDirection
${INVERT_WEB_DIRECTION}               de.elsis.elscan.camera.web.InvertWebDirection
${INVERT_OFFSET_WEB}                  de.elsis.elscan.camera.InvertOffsetWeb

# camera.properties
${TELE_OFFSET_WEB}                    de.elsis.elscan.camera.tele.OffsetWeb

# ipPipeTele.properties & ipPipeWide.properties
${TELE_IMAGE_PROCESSING_IMPL}          de.elsis.elscan.camera.tele.imageProcessing.Implementation
${TELE_IMAGE_PROCESSING_STEPS}         de.elsis.elscan.camera.tele.imageProcessing.Steps
${WIDE_IMAGE_PROCESSING_IMPL}          de.elsis.elscan.camera.wide.imageProcessing.Implementation
${WIDE_IMAGE_PROCESSING_STEPS}         de.elsis.elscan.camera.wide.imageProcessing.Steps

*** Keywords ***
########## SETUP & TEARDOWN ###################################################
Verify orientation - Setup
    [Documentation]  Copy all required properties files from the server to local directory

    Open SSH connection to server PC
    # Get 'Permission denied' error when using variables with the same content -> Strange!
    # Must explicitly define destination directory

    # double backlashes ('\\') required on windows, otherwise leads to IOError: [Errno 13] Permission denied
    # linux does not use backslashes in paths but is still fine with this
    get file via existing SSH connection  ${CAMERA_PROPERTIES_PATH}             ${PROP_DIR}${/}
    get file via existing SSH connection  ${IP_PIPE_TELE_PROPERTIES_PATH}       ${PROP_DIR}${/}
    get file via existing SSH connection  ${IP_PIPE_WIDE_PROPERTIES_PATH}       ${PROP_DIR}${/}
    get file via existing SSH connection  ${GUI_NORMAL_PARAM_PROPERTIES_PATH}   ${PROP_DIR}${/}
    get file via existing SSH connection  ${GUI_REVERSE_PARAM_PROPERTIES_PATH}  ${PROP_DIR}${/}

    close current SSH connection

#    ${CameraPropertiesContent}=             get properties file content  ${CAMERA_PROPERTIES_LOCAL_PATH}
#    ${IpPipeTelePropertiesContent}=         get properties file content  ${IP_PIPE_TELE_PROPERTIES_LOCAL_PATH}
#    ${IpPipeWidePropertiesContent}=         get properties file content  ${IP_PIPE_WIDE_PROPERTIES_LOCAL_PATH}
#    ${GuiNormalParamPropertiesContent}=     get properties file content  ${GUI_NORMAL_PARAM_PROP_LOCAL_PATH}
#    ${GuiReverseParamPropertiesContent}=    get properties file content  ${GUI_REVERSE_PARAM_PROP_LOCAL_PATH}

    ${InvertCrossWebDirection_Value}=       get properties value  ${CAMERA_PROPERTIES_LOCAL_PATH}           ${INVERT_CROSS_WEB_DIRECTION}
    ${InvertWebDirection_Value}=            get properties value  ${CAMERA_PROPERTIES_LOCAL_PATH}           ${INVERT_WEB_DIRECTION}
    ${InvertOffsetWeb_Value}=               get properties value  ${CAMERA_PROPERTIES_LOCAL_PATH}           ${INVERT_OFFSET_WEB}
    ${TeleOffsetWeb_Value}=                 get properties value  ${CAMERA_PROPERTIES_LOCAL_PATH}           ${TELE_OFFSET_WEB}

    ${TeleImageProcessingImpl_Value}=       get properties value  ${IP_PIPE_TELE_PROPERTIES_LOCAL_PATH}     ${TELE_IMAGE_PROCESSING_IMPL}
    ${TeleImageProcessingSteps_Value}=      get properties value  ${IP_PIPE_TELE_PROPERTIES_LOCAL_PATH}     ${TELE_IMAGE_PROCESSING_STEPS}

    ${WideImageProcessingImpl_Value}=       get properties value  ${IP_PIPE_WIDE_PROPERTIES_LOCAL_PATH}     ${WIDE_IMAGE_PROCESSING_IMPL}
    ${WideImageProcessingSteps_Value}=      get properties value  ${IP_PIPE_WIDE_PROPERTIES_LOCAL_PATH}     ${WIDE_IMAGE_PROCESSING_STEPS}

    ${Norm_InvertCrossWebDirection_Value}=  get properties value  ${GUI_NORMAL_PARAM_PROP_LOCAL_PATH}       ${INVERT_CROSS_WEB_DIRECTION}
    ${Norm_InvertWebDirection_Value}=       get properties value  ${GUI_NORMAL_PARAM_PROP_LOCAL_PATH}       ${INVERT_WEB_DIRECTION}
    ${Norm_InvertOffsetWeb_Value}=          get properties value  ${GUI_NORMAL_PARAM_PROP_LOCAL_PATH}       ${INVERT_OFFSET_WEB}

    ${Rev_InvertCrossWebDirection_Value}=   get properties value  ${GUI_REVERSE_PARAM_PROP_LOCAL_PATH}      ${INVERT_CROSS_WEB_DIRECTION}
    ${Rev_InvertWebDirection_Value}=        get properties value  ${GUI_REVERSE_PARAM_PROP_LOCAL_PATH}      ${INVERT_WEB_DIRECTION}
    ${Rev_InvertOffsetWeb_Value}=           get properties value  ${GUI_REVERSE_PARAM_PROP_LOCAL_PATH}      ${INVERT_OFFSET_WEB}

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


########## VERIFICATION #######################################################
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
