*** Settings ***
Resource  ${EXECDIR}/Resources/_Units/ServerPC/Weasel/weasel.robot
Resource  ${EXECDIR}/Resources/_Units/ServerPC/Weasel/wizard.robot
Resource  ${EXECDIR}/Resources/_Units/browser.robot
Resource  ${EXECDIR}/Resources/_Units/ServerPC/ConfigurationFiles/Wizard/bs_traverse.robot
Resource  ${EXECDIR}/Resources/_Units/ServerPC/ConfigurationFiles/Wizard/flashes.robot
Resource  ${EXECDIR}/Resources/_Units/ServerPC/ConfigurationFiles/Wizard/orientation.robot
Resource  ${EXECDIR}/Resources/_Units/ServerPC/ConfigurationFiles/Wizard/others.robot

*** Keywords ***
########## NAVIGATION #########################################################
the weasel wizard is launched
    go to wizard page


the wizard configuration is submitted
    the 'Submit' button is clicked


########## SELECTION ##########################################################
a valid orientation configuration is selected

    [Arguments]  ${camera_orientation}  ${web_direction}  ${image_orientation}

    select no backside traverse

    insert number of teeth  1200
    insert encoder circumference  361283
    insert repeat length  600
    insert traverse zero offset  0

    run keyword if  '${camera_orientation}' == 'camera_normal'  select normal camera orientation
    run keyword if  '${camera_orientation}' == 'camera_rotated'  select rotated camera orientation
    run keyword if  '${web_direction}' == 'web_topdown'  select top down web movement
    run keyword if  '${web_direction}' == 'web_bottomup'  select bottom up web movement
    run keyword if  '${image_orientation}' == 'image_rightsideup'  select right side up image orientation
    run keyword if  '${image_orientation}' == 'image_upsidedown'  select upside down image orientation


a valid flash configuration is selected

    [Arguments]  ${varnish_flash}  ${uv_flash}  ${backside_flash}  ${throughflash}  ${backside_traverse}

    select normal camera orientation
    select top down web movement
    select right side up image orientation

    insert number of teeth  1200
    insert encoder circumference  361283
    insert repeat length  600
    insert traverse zero offset  0

    run keyword if  '${varnish_flash}' == 'varnish_YES'  select varnish flash
    run keyword if  '${uv_flash}' == 'uv_YES'  select UV flash
    run keyword if  '${backside_flash}' == 'back_YES'  select backside flash
    run keyword if  '${throughflash}' == 'through_YES'  select throughflash

    run keyword if  '${backside_traverse}' == 'bt_no_traverse'  select no backside traverse
    run keyword if  '${backside_traverse}' == 'bt_normal'  select standard backside traverse
    run keyword if  '${backside_traverse}' == 'bt_inverted'  select inverted backside traverse
    run keyword if  '${backside_traverse}' == 'bt_full'  select full width backside flash


a valid backside traverse configuration is selected

    [Arguments]  ${backside_traverse}

    #TODO: Add new front camera orientation for inverted backside traverse

    select normal camera orientation
    select top down web movement
    select right side up image orientation

    insert number of teeth  1200
    insert encoder circumference  361283
    insert repeat length  600
    insert traverse zero offset  0

    run keyword if  '${backside_traverse}' == 'bt_no_traverse'  select no backside traverse
    run keyword if  '${backside_traverse}' == 'bt_normal'  select standard backside traverse
    run keyword if  '${backside_traverse}' == 'bt_inverted'  select inverted backside traverse
    run keyword if  '${backside_traverse}' == 'bt_full'  select full width backside flash


a valid encoder, repeat and traverse offset setting is selected

    [Arguments]  ${number_of_teeth}  ${encoder_circumference}  ${repeat_length}  ${traverse_zero_offset}

    select normal camera orientation
    select top down web movement
    select right side up image orientation
    select no backside traverse

    insert number of teeth  ${number_of_teeth}
    insert encoder circumference  ${encoder_circumference}
    insert repeat length  ${repeat_length}
    insert traverse zero offset  ${traverse_zero_offset}


########## VERIFICATION #######################################################
the correct orientation parameter values are set

    [Arguments]  ${camera_orientation}  ${web_direction}  ${image_orientation}

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

    [Arguments]  ${backside_traverse}

    run keyword if  '${backside_traverse}' == 'bt_no_traverse'
    ...  Verify - No backside traverse
    run keyword if  '${backside_traverse}' == 'bt_normal'
    ...  Verify - Standard backside traverse
    run keyword if  '${backside_traverse}' == 'bt_inverted'
    ...  Verify - Inverted backside traverse
    run keyword if  '${backside_traverse}' == 'bt_full'
    ...  Verify - Full width backflash


the correct values are set for the encoder, repeat and traverse offset setting

    [Arguments]  ${number_of_teeth}  ${encoder_circumference}  ${repeat_length}  ${traverse_zero_offset}

    Verify - Number of teeth, encoder circumference, repeat length and traverse zero offset
    ...  ${number_of_teeth}  ${encoder_circumference}  ${repeat_length}  ${traverse_zero_offset}