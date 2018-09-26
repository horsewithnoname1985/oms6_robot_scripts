*** Settings ***
Documentation    This high level keyword file contains all keywords for
...  creating tests cases for the Elscan OMS6 Setup Wizard
...  = Weasel Wizard variables =
...     | = Variable =  |   = Explanation =     |
...     |   ${BTN_SUBMIT_SELECTION_XPATH}   |   Xpath of the 'Submit' button    |
...     |   ${WIZARD_URL}                   |   URL of the Wizard |

Library     SeleniumLibrary
Library     SSHLibrary
Resource    ${EXECDIR}/Resources/ServerPC/Weasel/wizard/selections/main.robot
Resource    ${EXECDIR}/Resources/ServerPC/Weasel/wizard/checks/orientation.robot
Resource    ${EXECDIR}/Resources/ServerPC/Weasel/wizard/checks/flashes.robot
Resource    ${EXECDIR}/Resources/ServerPC/Weasel/wizard/checks/bs_traverse.robot
Resource    ${EXECDIR}/Resources/Others/browser.robot
Resource    ${EXECDIR}/Resources/Others/time.robot

# python -m robot.libdoc -v 0.1 ./Resources/ServerPC/Weasel/wizard/weasel_wizard.robot ./Resources/ServerPC/Weasel/wizard/weasel_wizard_doc.html

*** Variables ***
# XPath locators must start with '//' robotframework
${BTN_SUBMIT_SELECTION_XPATH}               //html/body/div[3]/div/form/input
${WIZARD_URL}                               http://${SERVER_HOST_IP}/elsetupwizard.jsp


*** Keywords ***
the weasel wizard is launched
    [Documentation]  Navigates to the weasel wizard page (user must already be
    ...  logged into Weasel)

    go to  ${WIZARD_URL}
    wait until page contains  Set Up Wizard


I select a valid orientation configuration
    [Documentation]  A valid selection for the camera orientation,
    ...  specified by ``${camera_orientation}``, ``${web_direction}`` and
    ...  ``${image_orientation}`` is done inside the wizard
    ...
    ...     |   =Parameter=            |    =Possible values=   |
    ...     |   ${camera_orientation}  |    camera_normal, camera_rotated |
    ...     |   ${image_orientation}   |    image_rightsideup, image_upsidedown |
    ...     |   ${web_direction}       |    web_topdown, web_bottomup  |

    [Arguments]  ${camera_orientation}  ${web_direction}  ${image_orientation}

    # when comparing two string variables, those must be inside quotes ('')
    run keyword if  '${camera_orientation}' == 'camera_normal'  select normal camera orientation
    run keyword if  '${camera_orientation}' == 'camera_rotated'  select rotated camera orientation
    run keyword if  '${web_direction}' == 'web_topdown'  select top down web movement
    run keyword if  '${web_direction}' == 'web_bottomup'  select bottom up web movement
    run keyword if  '${image_orientation}' == 'image_rightsideup'  select right side up image orientation
    run keyword if  '${image_orientation}' == 'image_upsidedown'  select upside down image orientation


I select a valid flash configuration
    [Documentation]  A valid selection for the flash selection,
    ...  specified by ``${varnish_flash}``, ``${uv_flash}``,
    ...  ``${backside_flash}``, ``${throughflash}`` and ``${backside_traverse}``
    ...  is done inside the wizard
    ...
    ...     |   =Parameter=             |   =Possible values=   |
    ...     |   ${backside_flash}       |   back_YES, back_NO   |
    ...     |   ${backside_traverse}    |   bt_no_traverse, bt_normal, bt_inverted, bt_full |
    ...     |   ${throughflash}         |   through_YES, through_NO |
    ...     |   ${uv_flash}             |   uv_YES, uv_NO   |
    ...     |   ${varnish_flash}        |   varnish_YES, varnish_NO |

    [Arguments]  ${varnish_flash}  ${uv_flash}  ${backside_flash}  ${throughflash}  ${backside_traverse}

    # Select mandatory orientation settings -> won't be verified
    select normal camera orientation
    select top down web movement
    select right side up image orientation
    insert number of teeth  1200
    insert encoder circumference  361283
    insert repeat length  600
    insert traverse zero offset  0

    # Insert test parameters
    # when comparing two string variables, those must be inside quotes ('')
    run keyword if  '${varnish_flash}' == 'varnish_YES'  select varnish flash
    run keyword if  '${uv_flash}' == 'uv_YES'  select UV flash
    run keyword if  '${backside_flash}' == 'back_YES'  select backside flash
    run keyword if  '${throughflash}' == 'through_YES'  select throughflash

    run keyword if  '${backside_traverse}' == 'bt_no_traverse'  select no backside traverse
    run keyword if  '${backside_traverse}' == 'bt_normal'  select standard backside traverse
    run keyword if  '${backside_traverse}' == 'bt_inverted'  select inverted backside traverse
    run keyword if  '${backside_traverse}' == 'bt_full'  select full width backside flash


I select a valid backside traverse configuration
    [Documentation]  A valid selection for the backside traverse selection,
    ...  specified by ``${backside_traverse}`` is done inside the wizard
    ...
    ...     |   =Parameter=             |   =Possible Values=   |
    ...     |   ${backside_traverse}    |   bt_no_traverse, bt_normal, bt_inverted, bt_full |

    [Arguments]  ${backside_traverse}

    # Select mandatory orientation settings -> won't be verified
    select normal camera orientation
    select top down web movement
    select right side up image orientation
    insert number of teeth  1200
    insert encoder circumference  361283
    insert repeat length  600
    insert traverse zero offset  0

    # Insert test parameters
    run keyword if  '${backside_traverse}' == 'bt_no_traverse'  select no backside traverse
    run keyword if  '${backside_traverse}' == 'bt_normal'  select standard backside traverse
    run keyword if  '${backside_traverse}' == 'bt_inverted'  select inverted backside traverse
    run keyword if  '${backside_traverse}' == 'bt_full'  select full width backside flash


I select a valid set of field values
    [Documentation]  A valid set of synchonization values is entered into the
    ...  designated fields of the wizard. All values are required:
    ...
    ...     |   =Parameter=                 |   =Explanation=   |
    ...     |   ${number_of_teeth}          |   Amount of teeth/impulses that the encoder delivers per circumference    |
    ...     |   ${encoder_circumference}    |   Circumference of the used encoder wheel (in mm)  |
    ...     |   ${repeat_length}            |   Initial repeat length after the next restart (in mm)    |
    ...     |   ${traverse_zero_offset}     |   Initial traverse offset (crossweb direction, in mm) |

    [Arguments]  ${number_of_teeth}=1024  ${encoder_circumference}=304.7  ${repeat_length}=1000  ${traverse_zero_offset}=0

    # Select mandatory orientation settings -> won't be verified
    select normal camera orientation
    select top down web movement
    select right side up image orientation
    select no backside traverse

    # Insert test parameters
    insert number of teeth  ${number_of_teeth}
    insert encoder circumference  ${encoder_circumference}
    insert repeat length  ${repeat_length}
    insert traverse zero offset  ${traverse_zero_offset}


I click the 'Submit' button
    [Documentation]  Submits the form data by clicking the 'Submit' button.
    ...
    ...  From weasel version v2.0 on the following keywords must be executed
    ...  first, as the 'Submit' button expects required data to be given:
    ...  `I select a valid orientation configuration`,
    ...  `I select a valid flash configuration`,
    ...  `I select a valid backside traverse configuration`

    scroll to bottom
    click element  ${BTN_SUBMIT_SELECTION_XPATH}


the correct orientation parameter values are set
    [Documentation]  Starts the evaluation of the orientation parameters in
    ...  according to the values set for ``${camera_orientation}``,
    ...  ``${web_direction}`` and ``${image_orientation}``.
    ...
    ...  Please see `I select a valid orientation configuration` for possible
    ...  values of the above stated required parameters.

    [Arguments]  ${camera_orientation}  ${web_direction}  ${image_orientation}

    # Select mandatory orientation settings -> won't be verified
    select no backside traverse
    insert number of teeth  1200
    insert encoder circumference  361283
    insert repeat length  600
    insert traverse zero offset  0

    # Cannot break text between 'and' statements -> must be in one line :-(
    run keyword if  '${camera_orientation}' == 'camera_normal' and '${web_direction}' == 'web_bottomup' and '${image_orientation}' == 'image_rightsideup'
    ...  Verify - CO: Normal + WD: Bottom up + IO: Right side up
    run keyword if  '${camera_orientation}' == 'camera_rotated' and '${web_direction}' == 'web_bottomup' and '${image_orientation}' == 'image_rightsideup'
    ...  Verify - CO: Rotated + WD: Bottom up + IO: Right side up
    run keyword if  '${camera_orientation}' == 'camera_normal' and '${web_direction}' == 'web_topdown' and '${image_orientation}' == 'image_rightsideup'
    ...  Verify - CO: Normal + WD: Top down + IO: Right side up
    run keyword if  '${camera_orientation}' == 'camera_rotated' and '${web_direction}' == 'web_topdown' and '${image_orientation}' == 'image_rightsideup'
    ...  Verify - CO: Rotated + WD: Top down + IO: Right side up
    run keyword if  '${camera_orientation}' == 'camera_normal' and '${web_direction}' == 'web_bottomup' and '${image_orientation}' == 'image_upsidedown'
    ...  Verify - CO: Normal + WD: Bottom up + IO: Upside down
    run keyword if  '${camera_orientation}' == 'camera_rotated' and '${web_direction}' == 'web_bottomup' and '${image_orientation}' == 'image_upsidedown'
    ...  Verify - CO: Rotated + WD: Bottom up + IO: Upside down
    run keyword if  '${camera_orientation}' == 'camera_normal' and '${web_direction}' == 'web_topdown' and '${image_orientation}' == 'image_upsidedown'
    ...  Verify - CO: Normal + WD: Top down + IO: Upside down
    run keyword if  '${camera_orientation}' == 'camera_rotated' and '${web_direction}' == 'web_topdown' and '${image_orientation}' == 'image_upsidedown'
    ...  Verify - CO: Rotated + WD: Top down + IO: Upside down


the correct flash parameter values are set
    [Documentation]  Starts the evaluation of the orientation parameters in
    ...  according to the values set for ``${varnish_flash}``, ``${uv_flash}``,
    ...  ``${backside_flash}``, ``${throughflash}`` and ``${backside_traverse}``.
    ...
    ...  Please see `I select a valid flash configuration` for possible
    ...  values of the above stated required parameters.

    [Arguments]  ${varnish_flash}  ${uv_flash}  ${backside_flash}  ${throughflash}  ${backside_traverse}

    run keyword if  '${varnish_flash}' == 'varnish_YES' and '${uv_flash}' == 'uv_NO' and '${backside_flash}' == 'back_NO' and '${throughflash}' == 'through_NO' and '${backside_traverse}' == 'bt_no_traverse'
    ...  Verify - Varnish
    run keyword if  '${varnish_flash}' == 'varnish_YES' and '${uv_flash}' == 'uv_NO' and '${backside_flash}' == 'back_YES' and '${throughflash}' == 'through_NO' and '${backside_traverse}' == 'bt_normal'
    ...  Verify - Varnish + Backside
    run keyword if  '${varnish_flash}' == 'varnish_YES' and '${uv_flash}' == 'uv_NO' and '${backside_flash}' == 'back_YES' and '${throughflash}' == 'through_YES' and '${backside_traverse}' == 'bt_normal'
    ...  Verify - Varnish + Backside + Through
    run keyword if  '${varnish_flash}' == 'varnish_YES' and '${uv_flash}' == 'uv_YES' and '${backside_flash}' == 'back_NO' and '${throughflash}' == 'through_NO' and '${backside_traverse}' == 'bt_no_traverse'
    ...  Verify - Varnish + UV
    run keyword if  '${varnish_flash}' == 'varnish_YES' and '${uv_flash}' == 'uv_YES' and '${backside_flash}' == 'back_YES' and '${throughflash}' == 'through_NO' and '${backside_traverse}' == 'bt_normal'
    ...  Verify - Varnish + UV + Backside
    run keyword if  '${varnish_flash}' == 'varnish_YES' and '${uv_flash}' == 'uv_YES' and '${backside_flash}' == 'back_YES' and '${throughflash}' == 'through_YES' and '${backside_traverse}' == 'bt_normal'
    ...  Verify - Varnish + UV + Backside + Through
    run keyword if  '${varnish_flash}' == 'varnish_NO' and '${uv_flash}' == 'uv_NO' and '${backside_flash}' == 'back_NO' and '${throughflash}' == 'through_NO' and '${backside_traverse}' == 'bt_no_traverse'
    ...  Verify - No additional flashes
    run keyword if  '${varnish_flash}' == 'varnish_NO' and '${uv_flash}' == 'uv_NO' and '${backside_flash}' == 'back_YES' and '${throughflash}' == 'through_NO' and '${backside_traverse}' == 'bt_normal'
    ...  Verify - Backside
    run keyword if  '${varnish_flash}' == 'varnish_NO' and '${uv_flash}' == 'uv_NO' and '${backside_flash}' == 'back_YES' and '${throughflash}' == 'through_YES' and '${backside_traverse}' == 'bt_normal'
    ...  Verify - Backside + Through
    run keyword if  '${varnish_flash}' == 'varnish_NO' and '${uv_flash}' == 'uv_YES' and '${backside_flash}' == 'back_NO' and '${throughflash}' == 'through_NO' and '${backside_traverse}' == 'bt_no_traverse'
    ...  Verify - UV
    run keyword if  '${varnish_flash}' == 'varnish_NO' and '${uv_flash}' == 'uv_YES' and '${backside_flash}' == 'back_YES' and '${throughflash}' == 'through_NO' and '${backside_traverse}' == 'bt_normal'
    ...  Verify - UV + Backside
    run keyword if  '${varnish_flash}' == 'varnish_NO' and '${uv_flash}' == 'uv_YES' and '${backside_flash}' == 'back_YES' and '${throughflash}' == 'through_YES' and '${backside_traverse}' == 'bt_normal'
    ...  Verify - UV + Backside + Through


the correct backside traverse parameter values are set
    [Documentation]  Starts the evaluation of the orientation parameters in
    ...  according to the value set for  ``${backside_traverse}``.
    ...
    ...  Please see `I select a valid backside traverse configuration` for
    ...  possible values of the above stated required parameters.

    [Arguments]  ${backside_traverse}

    run keyword if  '${backside_traverse}' == 'bt_no_traverse'
    ...  Verify - No backside traverse
    run keyword if  '${backside_traverse}' == 'bt_normal'
    ...  Verify - Standard backside traverse
    run keyword if  '${backside_traverse}' == 'bt_inverted'
    ...  Verify - Inverted backside traverse
    run keyword if  '${backside_traverse}' == 'bt_full'
    ...  Verify - Full width backflash


the correct field values are set
    Verify - Encoder, repeat and traverse parameter values
