*** Variables ***
# Remote (OMS6 Server)
${ACQUIRE_MODULE_PROPERTIES_PATH}           /elscan/config/acquireModule.properties
${CAMERA_PROPERTIES_PATH}                   /elscan/config/camera.properties
${FLASH_HARDWARE_CONFIG_PROPERTIES_PATH}    /elscan/config/flashHardwareConfig.properties
${GUI_NORMAL_PARAM_PROPERTIES_PATH}         /elscan/config/GuiNormalParam.properties
${GUI_REVERSE_PARAM_PROPERTIES_PATH}        /elscan/config/GuiReverseParam.properties
${IP_PIPE_TELE_PROPERTIES_PATH}             /elscan/config/ipPipeTele.properties
${IP_PIPE_WIDE_PROPERTIES_PATH}             /elscan/config/ipPipeWide.properties
${PIXELBOX_INI_PATH}                        /elscan/config/pixelbox_0.ini


# Local
# used ${tempDir} (instead of ${propdir}) before, which is a predefined variable
# that can't be reset and points to a temporary dir during test execution
# (C:\Users\<username>\appdata\local\temp\..)
${PROP_DIR}                                     ${EXECDIR}/Resources/temp/properties_files
${ACQUIRE_MODULE_PROPERTIES_LOCAL_PATH}         ${PROP_DIR}/acquireModule.properties
${CAMERA_PROPERTIES_LOCAL_PATH}                 ${PROP_DIR}/camera.properties
${FLASH_HARDWARE_CONFIG_PROPERTIES_LOCAL_PATH}  ${PROP_DIR}/flashHardwareConfig.properties
${GUI_NORMAL_PARAM_PROP_LOCAL_PATH}             ${PROP_DIR}/GuiNormalParam.properties
${GUI_REVERSE_PARAM_PROP_LOCAL_PATH}            ${PROP_DIR}/GuiReverseParam.properties
${IP_PIPE_TELE_PROPERTIES_LOCAL_PATH}           ${PROP_DIR}/ipPipeTele.properties
${IP_PIPE_WIDE_PROPERTIES_LOCAL_PATH}           ${PROP_DIR}/ipPipeWide.properties
${PIXELBOX_INI_LOCAL_PATH}                      ${PROP_DIR}/pixelbox_0.ini
