*** Settings ***
Documentation  This file contains all parameter checks about flashes

Library     ${EXECDIR}/Libraries/JavaProperties.py
Library     SSHLibrary
Library     OperatingSystem
Resource    ${EXECDIR}/Resources/ServerPC/ServerPC_connection.robot

*** Variables ***
# PARAMETERS
${VarnishFlashPresent}                  de.elsis.elscan.camera.VarnishFlashPresent
${UVFlashPresent}                       de.elsis.elscan.camera.UvFlashPresent
${BacksideFlashPresent}                 de.elsis.elscan.camera.BacksideFlashPresent
${ThroughFlashPresent}                  de.elsis.elscan.camera.ThroughFlashPresent

# PATHS
# Remote
${FlashHardwareConfigPropertiesPath}        /elscan/config/flashHardwareConfig.properties

# Local
${propDir}                                  .\\Resources\\temp\\properties_files
${FlashHardwareConfigPropertiesLocalPath}   ${propDir}\\flashHardwareConfig.properties


*** Keywords ***
Verify flashes - Setup
    open connection and log in

    SSHLibrary.get file  ${FlashHardwareConfigPropertiesPath}   destination=${propDir}\\

    ${FlashHardwareConfigPropertiesContent}=    get properties file content  ${FlashHardwareConfigPropertiesLocalPath}

    ${VarnishFlashPresent_Value}=               get properties value  ${FlashHardwareConfigPropertiesContent}   ${VarnishFlashPresent}
    ${UVFlashPresent_Value}=                    get properties value  ${FlashHardwareConfigPropertiesContent}   ${UVFlashPresent}
    ${BacksideFlashPresent_Value}=              get properties value  ${FlashHardwareConfigPropertiesContent}   ${BacksideFlashPresent}
    ${ThroughFlashPresent_Value}=               get properties value  ${FlashHardwareConfigPropertiesContent}   ${ThroughFlashPresent}

    set test variable  ${VarnishFlashPresent_Value}     ${VarnishFlashPresent_Value}
    set test variable  ${UVFlashPresent_Value}          ${UVFlashPresent_Value}
    set test variable  ${BacksideFlashPresent_Value}    ${BacksideFlashPresent_Value}
    set test variable  ${ThroughFlashPresent_Value}     ${ThroughFlashPresent_Value}

Verify flashes - Teardown
    close all connections

# Flash configurations
Verify - Varnish
    Verify flashes - Setup

    should be equal as strings  ${VarnishFlashPresent_Value}    true
    should be equal as strings  ${UVFlashPresent_Value}         false
    should be equal as strings  ${BacksideFlashPresent_Value}   false
    should be equal as strings  ${ThroughFlashPresent_Value}    false

    Verify flashes - Teardown

Verify - Varnish + Backside
    Verify flashes - Setup

    should be equal as strings  ${VarnishFlashPresent_Value}    true
    should be equal as strings  ${UVFlashPresent_Value}         false
    should be equal as strings  ${BacksideFlashPresent_Value}   true
    should be equal as strings  ${ThroughFlashPresent_Value}    false

    Verify flashes - Teardown

Verify - Varnish + Backside + Through
    Verify flashes - Setup

    should be equal as strings  ${VarnishFlashPresent_Value}    true
    should be equal as strings  ${UVFlashPresent_Value}         false
    should be equal as strings  ${BacksideFlashPresent_Value}   true
    should be equal as strings  ${ThroughFlashPresent_Value}    true

    Verify flashes - Teardown

Verify - Varnish + UV
    Verify flashes - Setup

    should be equal as strings  ${VarnishFlashPresent_Value}    true
    should be equal as strings  ${UVFlashPresent_Value}         true
    should be equal as strings  ${BacksideFlashPresent_Value}   false
    should be equal as strings  ${ThroughFlashPresent_Value}    false

    Verify flashes - Teardown

Verify - Varnish + UV + Backside
    Verify flashes - Setup

    should be equal as strings  ${VarnishFlashPresent_Value}    true
    should be equal as strings  ${UVFlashPresent_Value}         true
    should be equal as strings  ${BacksideFlashPresent_Value}   true
    should be equal as strings  ${ThroughFlashPresent_Value}    false

    Verify flashes - Teardown

Verify - Varnish + UV + Backside + Through
    Verify flashes - Setup

    should be equal as strings  ${VarnishFlashPresent_Value}    true
    should be equal as strings  ${UVFlashPresent_Value}         true
    should be equal as strings  ${BacksideFlashPresent_Value}   true
    should be equal as strings  ${ThroughFlashPresent_Value}    true

    Verify flashes - Teardown

Verify - No additional flashes
    Verify flashes - Setup

    should be equal as strings  ${VarnishFlashPresent_Value}    false
    should be equal as strings  ${UVFlashPresent_Value}         false
    should be equal as strings  ${BacksideFlashPresent_Value}   false
    should be equal as strings  ${ThroughFlashPresent_Value}    false

    Verify flashes - Teardown

Verify - Backside
    Verify flashes - Setup

    should be equal as strings  ${VarnishFlashPresent_Value}    false
    should be equal as strings  ${UVFlashPresent_Value}         false
    should be equal as strings  ${BacksideFlashPresent_Value}   true
    should be equal as strings  ${ThroughFlashPresent_Value}    false

    Verify flashes - Teardown

Verify - Backside + Through
    Verify flashes - Setup

    should be equal as strings  ${VarnishFlashPresent_Value}    false
    should be equal as strings  ${UVFlashPresent_Value}         false
    should be equal as strings  ${BacksideFlashPresent_Value}   true
    should be equal as strings  ${ThroughFlashPresent_Value}    true

    Verify flashes - Teardown

Verify - UV
    Verify flashes - Setup

    should be equal as strings  ${VarnishFlashPresent_Value}    false
    should be equal as strings  ${UVFlashPresent_Value}         true
    should be equal as strings  ${BacksideFlashPresent_Value}   false
    should be equal as strings  ${ThroughFlashPresent_Value}    false

    Verify flashes - Teardown

Verify - UV + Backside
    Verify flashes - Setup

    should be equal as strings  ${VarnishFlashPresent_Value}    false
    should be equal as strings  ${UVFlashPresent_Value}         true
    should be equal as strings  ${BacksideFlashPresent_Value}   true
    should be equal as strings  ${ThroughFlashPresent_Value}    false

    Verify flashes - Teardown

Verify - UV + Backside + Through
    Verify flashes - Setup

    should be equal as strings  ${VarnishFlashPresent_Value}    false
    should be equal as strings  ${UVFlashPresent_Value}         true
    should be equal as strings  ${BacksideFlashPresent_Value}   true
    should be equal as strings  ${ThroughFlashPresent_Value}    true

    Verify flashes - Teardown

