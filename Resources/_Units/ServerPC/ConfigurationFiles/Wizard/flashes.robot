*** Settings ***
Documentation  This file contains all parameter checks about flashes

Resource    ${EXECDIR}/Resources/_LibraryAdapters/JavaPropertiesAdapter.robot
Resource    ${EXECDIR}/Resources/_LibraryAdapters/SSHLibraryAdapter.robot
Resource    ${EXECDIR}/Resources/_Units/ServerPC/ConfigurationFiles/_path_variables.robot
Resource    ${EXECDIR}/Resources/_Units/ServerPC/ssh_connection.robot

*** Variables ***
# PARAMETERS
# flashHardwareConfig.properties
${VARNISH_FLASH_PRESENT}                  de.elsis.elscan.camera.VarnishFlashPresent
${UV_FLASH_PRESENT}                       de.elsis.elscan.camera.UvFlashPresent
${BACKSIDE_FLASH_PRESENT}                 de.elsis.elscan.camera.BacksideFlashPresent
${THROUGH_FLASH_PRESENT}                  de.elsis.elscan.camera.ThroughFlashPresent

*** Keywords ***
########## SETUP & TEARDOWN ###################################################
Verify flashes - Setup
    Open SSH connection to server PC

    # double backlashes ('\\') required on windows, otherwise leads to IOError: [Errno 13] Permission denied
    # linux does not use backslashes in paths but is still fine with this
    get file via existing SSH connection  ${FLASH_HARDWARE_CONFIG_PROPERTIES_PATH}   ${PROP_DIR}${/}

    close current SSH connection

    ${VarnishFlashPresent_Value}=               get properties value  ${FLASH_HARDWARE_CONFIG_PROPERTIES_LOCAL_PATH}   ${VARNISH_FLASH_PRESENT}
    ${UVFlashPresent_Value}=                    get properties value  ${FLASH_HARDWARE_CONFIG_PROPERTIES_LOCAL_PATH}   ${UV_FLASH_PRESENT}
    ${BacksideFlashPresent_Value}=              get properties value  ${FLASH_HARDWARE_CONFIG_PROPERTIES_LOCAL_PATH}   ${BACKSIDE_FLASH_PRESENT}
    ${ThroughFlashPresent_Value}=               get properties value  ${FLASH_HARDWARE_CONFIG_PROPERTIES_LOCAL_PATH}   ${THROUGH_FLASH_PRESENT}

    set test variable  ${VarnishFlashPresent_Value}     ${VarnishFlashPresent_Value}
    set test variable  ${UVFlashPresent_Value}          ${UVFlashPresent_Value}
    set test variable  ${BacksideFlashPresent_Value}    ${BacksideFlashPresent_Value}
    set test variable  ${ThroughFlashPresent_Value}     ${ThroughFlashPresent_Value}


########## VERIFICATION #######################################################
Verify - Varnish
    Verify flashes - Setup

    should be equal as strings  ${VarnishFlashPresent_Value}    true
    should be equal as strings  ${UVFlashPresent_Value}         false
    should be equal as strings  ${BacksideFlashPresent_Value}   false
    should be equal as strings  ${ThroughFlashPresent_Value}    false


Verify - Varnish + Backside
    Verify flashes - Setup

    should be equal as strings  ${VarnishFlashPresent_Value}    true
    should be equal as strings  ${UVFlashPresent_Value}         false
    should be equal as strings  ${BacksideFlashPresent_Value}   true
    should be equal as strings  ${ThroughFlashPresent_Value}    false


Verify - Varnish + Backside + Through
    Verify flashes - Setup

    should be equal as strings  ${VarnishFlashPresent_Value}    true
    should be equal as strings  ${UVFlashPresent_Value}         false
    should be equal as strings  ${BacksideFlashPresent_Value}   true
    should be equal as strings  ${ThroughFlashPresent_Value}    true


Verify - Varnish + UV
    Verify flashes - Setup

    should be equal as strings  ${VarnishFlashPresent_Value}    true
    should be equal as strings  ${UVFlashPresent_Value}         true
    should be equal as strings  ${BacksideFlashPresent_Value}   false
    should be equal as strings  ${ThroughFlashPresent_Value}    false


Verify - Varnish + UV + Backside
    Verify flashes - Setup

    should be equal as strings  ${VarnishFlashPresent_Value}    true
    should be equal as strings  ${UVFlashPresent_Value}         true
    should be equal as strings  ${BacksideFlashPresent_Value}   true
    should be equal as strings  ${ThroughFlashPresent_Value}    false


Verify - Varnish + UV + Backside + Through
    Verify flashes - Setup

    should be equal as strings  ${VarnishFlashPresent_Value}    true
    should be equal as strings  ${UVFlashPresent_Value}         true
    should be equal as strings  ${BacksideFlashPresent_Value}   true
    should be equal as strings  ${ThroughFlashPresent_Value}    true


Verify - No additional flashes
    Verify flashes - Setup

    should be equal as strings  ${VarnishFlashPresent_Value}    false
    should be equal as strings  ${UVFlashPresent_Value}         false
    should be equal as strings  ${BacksideFlashPresent_Value}   false
    should be equal as strings  ${ThroughFlashPresent_Value}    false


Verify - Backside
    Verify flashes - Setup

    should be equal as strings  ${VarnishFlashPresent_Value}    false
    should be equal as strings  ${UVFlashPresent_Value}         false
    should be equal as strings  ${BacksideFlashPresent_Value}   true
    should be equal as strings  ${ThroughFlashPresent_Value}    false


Verify - Backside + Through
    Verify flashes - Setup

    should be equal as strings  ${VarnishFlashPresent_Value}    false
    should be equal as strings  ${UVFlashPresent_Value}         false
    should be equal as strings  ${BacksideFlashPresent_Value}   true
    should be equal as strings  ${ThroughFlashPresent_Value}    true


Verify - UV
    Verify flashes - Setup

    should be equal as strings  ${VarnishFlashPresent_Value}    false
    should be equal as strings  ${UVFlashPresent_Value}         true
    should be equal as strings  ${BacksideFlashPresent_Value}   false
    should be equal as strings  ${ThroughFlashPresent_Value}    false


Verify - UV + Backside
    Verify flashes - Setup

    should be equal as strings  ${VarnishFlashPresent_Value}    false
    should be equal as strings  ${UVFlashPresent_Value}         true
    should be equal as strings  ${BacksideFlashPresent_Value}   true
    should be equal as strings  ${ThroughFlashPresent_Value}    false


Verify - UV + Backside + Through
    Verify flashes - Setup

    should be equal as strings  ${VarnishFlashPresent_Value}    false
    should be equal as strings  ${UVFlashPresent_Value}         true
    should be equal as strings  ${BacksideFlashPresent_Value}   true
    should be equal as strings  ${ThroughFlashPresent_Value}    true

