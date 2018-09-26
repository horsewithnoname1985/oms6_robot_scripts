*** Settings ***
Documentation   This test suite comprises of test cases, that checks the
...  appliance of the correct parameter values for all possible variations
...  offered by the weasel setup wizard. These comprise of flash, web & camera
...  offered by the weasel setup wizard. These comprise of flash, web & camera
...  orientation, backside traverse and synchronization parameters

Metadata        Version         0.1
Metadata        Creation Date   May 9th 2018
Metadata        Author          Arne Wohletz

Resource        ${EXECDIR}/Resources/_Steps/STPS_setup_wizard_input_verification.robot
Resource        ${EXECDIR}/Resources/_Units/ServerPC/Weasel/weasel.robot
Resource        ${EXECDIR}/Resources/_LibraryAdapters/SeleniumLibraryAdapter.robot
Resource        ${EXECDIR}/Resources/_LibraryAdapters/SSHLibraryAdapter.robot

Test Setup      Wizard Verification - Setup
Test Teardown   Wizard Verification - Teardown

# robot -d Results -i Orientation --loglevel debug Tests/TS_setup_wizard_input_verification.robot
# robot -d Results -i Flashes --loglevel debug Tests/TS_setup_wizard_input_verification.robot
# robot -d Results -i Backside_Traverse --loglevel debug Tests/TS_setup_wizard_input_verification.robot
# robot -d Results -i Tests --loglevel debug Tests/TS_setup_wizard_input_verification.robot
# robot -d Results -i Integer_Values --loglevel debug Tests/TS_setup_wizard_input_verification.robot

# robot -d C:\Results -i Orientation Tests/TS_setup_wizard_input_verification.robot

# robot -d Results -i Tests --loglevel debug --variable BROWSER:chrome Tests/TS_setup_wizard_input_verification.robot
# robot -d Results -i Orientation -i Flashes -i Backside_Traverse -i Integer_Values Tests/TS_setup_wizard_input_verification.robot

*** Variables ***
${BROWSER}                      chrome
${FIREFOX_PROFILE_DIR_LINUX}    /home/mvtest/.mozilla/firefox/npq1rlgl.selenium/
${FIREFOX_PROFILE_DIR_WIN7}     C:\\Users\\wohletzar\\AppData\\Local\\Mozilla\\Firefox\\Profiles\\thmgq74y.selenium

# REMARKS:
# Somehow, launching Firefox takes much longer when refering to a profile
# On the other hand, Firefox does not open any url without a profile :-(

*** Test Cases ***
Correct orientation parameters are set for all valid wizard selections

    [Tags]  Orientation
    [Template]  Correct orientation parameters are set by the wizard

    camera_normal  web_topdown  image_rightsideup
    camera_normal  web_topdown  image_upsidedown
    camera_normal  web_bottomup  image_rightsideup
    camera normal  web_bottomup  image_upsidedown
    camera_rotated  web_topdown  image_rightsideup
    camera_rotated  web_topdown  image_upsidedown
    camera_rotated  web_bottomup  image_rightsideup
    camera_rotated  web_bottomup  image_upsidedown


Correct flash parameters are set for all valid wizard selections

    [Documentation]  All possible flash configuration variants are tested
    [Tags]  Flashes
    [Template]  Correct flash parameters are set by the wizard

    varnish_YES     uv_NO       back_NO      through_NO     bt_no_traverse
    varnish_YES     uv_NO       back_YES     through_NO     bt_normal
    varnish_YES     uv_NO       back_YES     through_YES    bt_normal
    varnish_YES     uv_YES      back_NO      through_NO     bt_no_traverse
    varnish_YES     uv_YES      back_YES     through_NO     bt_normal
    varnish_YES     uv_YES      back_YES     through_YES    bt_normal
    varnish_NO      uv_NO       back_NO      through_NO     bt_no_traverse
    varnish_NO      uv_NO       back_YES     through_NO     bt_normal
    varnish_NO      uv_NO       back_YES     through_YES    bt_normal
    varnish_NO      uv_YES      back_NO      through_NO     bt_no_traverse
    varnish_NO      uv_YES      back_YES     through_NO     bt_normal
    varnish_NO      uv_YES      back_YES     through_YES    bt_normal


Correct traverse parameters are set for all valid wizard selections

    [Tags]  Backside_Traverse
    [Template]  Correct backside traverse parameters are set by the wizard

    bt_no_traverse
    bt_normal
    bt_inverted
    bt_full


Correct encoder, repeat and traverse offset values are set for various entries

    [Tags]  Integer_Values
    [Template]  Wizard values for encoder settings, repeat size and zero offset traverse are properly applied

    #   number_of_teeth     encoder_circumference}    ${repeat_length}    ${traverse_zero_offset}
        1024                361283                    600                 0
        0                   -100                      1234                300
        9999                0                         9999                -100


TEST: Correct parameters are set for this wizard selection

    [Tags]  Tests

    Correct flash parameters are set by the wizard  varnish_YES  uv_YES  back_NO  through_NO  bt_no_traverse
#    Correct orientation parameters are set by the wizard  camera_normal  web_topdown  image_rightsideup
#    Correct backside traverse parameters are set by the wizard  bt_normal



*** Keywords ***
########## SETUP & TEARDOWN ###################################################
Wizard Verification - Setup
    open a browser window  ${BROWSER}  ${FIREFOX_PROFILE_DIR_WIN7}
    go to weasel homepage


Wizard Verification - Teardown
    close browser
    close all connections


########## TEST CASE KEYWORDS #################################################
Correct orientation parameters are set by the wizard

    [Arguments]  ${camera_orientation}  ${web_direction}  ${image_orientation}

    GIVEN the weasel wizard is launched
    WHEN a valid orientation configuration is selected  ${camera_orientation}  ${web_direction}  ${image_orientation}
    AND the wizard configuration is submitted
    THEN the correct orientation parameter values are set  ${camera_orientation}  ${web_direction}  ${image_orientation}


Correct flash parameters are set by the wizard

    [Arguments]  ${varnish_flash}  ${uv_flash}  ${backside_back_flash}  ${backside_through_flash}  ${backside_traverse}

    GIVEN the weasel wizard is launched
    WHEN a valid flash configuration is selected  ${varnish_flash}  ${uv_flash}  ${backside_back_flash}  ${backside_through_flash}  ${backside_traverse}
    AND the wizard configuration is submitted
    THEN the correct flash parameter values are set  ${varnish_flash}  ${uv_flash}  ${backside_back_flash}  ${backside_through_flash}  ${backside_traverse}


Correct backside traverse parameters are set by the wizard

    [Arguments]  ${backside_traverse}

    GIVEN the weasel wizard is launched
    WHEN a valid backside traverse configuration is selected  ${backside_traverse}
    AND the wizard configuration is submitted
    THEN the correct backside traverse parameter values are set  ${backside_traverse}


Wizard values for encoder settings, repeat size and zero offset traverse are properly applied

    [Arguments]  ${number_of_teeth}  ${encoder_circumference}    ${repeat_length}    ${traverse_zero_offset}

    GIVEN the weasel wizard is launched
    WHEN a valid encoder, repeat and traverse offset setting is selected
    ...  ${number_of_teeth}  ${encoder_circumference}    ${repeat_length}    ${traverse_zero_offset}
    AND the wizard configuration is submitted
    THEN the correct values are set for the encoder, repeat and traverse offset setting
    ...  ${number_of_teeth}  ${encoder_circumference}    ${repeat_length}    ${traverse_zero_offset}