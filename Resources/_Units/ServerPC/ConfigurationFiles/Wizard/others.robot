*** Settings ***
Resource    ${EXECDIR}/Resources/_LibraryAdapters/IniFileHandlerAdapter.robot
Resource    ${EXECDIR}/Resources/_LibraryAdapters/JavaPropertiesAdapter.robot
Resource    ${EXECDIR}/Resources/_LibraryAdapters/SSHLibraryAdapter.robot
Resource    ${EXECDIR}/Resources/_Units/ServerPC/ConfigurationFiles/_path_variables.robot
Resource    ${EXECDIR}/Resources/_Units/ServerPC/ssh_connection.robot

*** Variables ***
# PIXELBOX_0_INI
# Sections
# The final ']' is considered part as section's syntax ('[]') by ConfigParser
# and therefor must be removed from the name
${PXBX_PULSES_PER_ROUND_SECTION}        /Application/TriggerModel/encoderInput[0
${PXBX_ENCODER_CIRCUMFERENCE_SECTION}   /Application/TriggerModel/encoderInput[0
# Keys
${PXBX_PULSES_PER_ROUND_KEY}            pulsesPerRoundAB
${PXBX_ENCODER_CIRCUMFERENCE_KEY}       circumference

# CAMERA.PROPERTIES
${CAM_PULSES_PER_ROUND}         de.elsis.elscan.camera.trigger.NumberOfTeeth
${CAM_ENCODER_CIRCUMFERENCE}    de.elsis.elscan.camera.trigger.ReferenceLength
${REPEAT_LENGTH}                de.elsis.elscan.camera.repeat.RepeatLength
${ZERO_OFFSET_TRAVERSE}         de.elsis.elscan.camera.ZeroOffsetTraverse

*** Keywords ***
########## SETUP ##############################################################

Setup - Verify number of teeth, encoder circumference, repeat length and traverse zero offset

    Open SSH connection to server PC

    # double backlashes ('\\') required on windows, otherwise leads to IOError: [Errno 13] Permission denied
    # linux does not use backslashes in paths but is still fine with this
    get file via existing SSH connection    ${CAMERA_PROPERTIES_PATH}   ${PROP_DIR}${/}
    get file via existing SSH connection    ${PIXELBOX_INI_PATH}        ${PROP_DIR}${/}

    close current SSH connection

    ${CameraPropertiesContent}=     get properties file content     ${CAMERA_PROPERTIES_LOCAL_PATH}

    ${Pxbx_AmountOfPulses_Value}=       get value from ini file parameter
    ...  ${PIXELBOX_INI_LOCAL_PATH}  ${PXBX_PULSES_PER_ROUND_SECTION}  ${PXBX_PULSES_PER_ROUND_KEY}
    ${Pxbx_EncoderCirumference_Value}=  get value from ini file parameter
    ...  ${PIXELBOX_INI_LOCAL_PATH}  ${PXBX_ENCODER_CIRCUMFERENCE_SECTION}  ${PXBX_ENCODER_CIRCUMFERENCE_KEY}

    ${Cam_AmountOfPulses_Value}=        get properties value    ${CameraPropertiesContent}  ${CAM_PULSES_PER_ROUND}
    ${Cam_EncoderCircumference_Value}=  get properties value    ${CameraPropertiesContent}  ${CAM_ENCODER_CIRCUMFERENCE}
    ${RepeatLength_Value}=              get properties value    ${CameraPropertiesContent}  ${REPEAT_LENGTH}
    ${ZeroOffsetTraverse_Value}=        get properties value    ${CameraPropertiesContent}  ${ZERO_OFFSET_TRAVERSE}

    set test variable   ${Pxbx_AmountOfPulses_Value}        ${Pxbx_AmountOfPulses_Value}
    set test variable   ${Pxbx_EncoderCirumference_Value}   ${Pxbx_EncoderCirumference_Value}
    set test variable   ${Cam_AmountOfPulses_Value}         ${Cam_AmountOfPulses_Value}
    set test variable   ${Cam_EncoderCircumference_Value}   ${Cam_EncoderCircumference_Value}
    set test variable   ${RepeatLength_Value}               ${RepeatLength_Value}
    set test variable   ${ZeroOffsetTraverse_Value}         ${ZeroOffsetTraverse_Value}


########## VERIFICATION #######################################################
Verify - Number of teeth, encoder circumference, repeat length and traverse zero offset

    [Arguments]  ${number_of_teeth}  ${encoder_circumference}  ${repeat_length}  ${traverse_zero_offset}

    Setup - Verify number of teeth, encoder circumference, repeat length and traverse zero offset

    should be equal as integers  ${Pxbx_AmountOfPulses_Value}       ${number_of_teeth}
    should be equal as integers  ${Pxbx_EncoderCirumference_Value}  ${encoder_circumference}
    should be equal as integers  ${Cam_AmountOfPulses_Value}        ${number_of_teeth}
    should be equal as integers  ${Cam_EncoderCircumference_Value}  ${encoder_circumference}
    should be equal as integers  ${RepeatLength_Value}              ${repeat_length}
    should be equal as integers  ${ZeroOffsetTraverse_Value}        ${traverse_zero_offset}

