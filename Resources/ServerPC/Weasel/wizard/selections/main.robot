*** Settings ***
Library     SeleniumLibrary
Library     ${EXECDIR}/Libraries/MyExtendedSeleniumLibrary.py
Resource    helper.robot
Resource    ${EXECDIR}/Resources/Others/time.robot
Resource    ${EXECDIR}/Resources/Others/browser.robot

*** Variables ***
# XPath locators must start with '//' in Robot Framework
${menu_camera_orientation_xpath}                //html/body/div[3]/div/form/div[1]
${menu_web_direction_xpath}                     //html/body/div[3]/div/form/div[3]
${menu_image_direction_xpath}                   //html/body/div[3]/div/form/div[5]
${menu_flash_configuration_xpath}               //html/body/div[3]/div/form/div[7]
${menu_backside_traverse_xpath}                 //html/body/div[3]/div/form/div[9]
${menu_encoder_xpath}                           //html/body/div[3]/div/form/div[11]
${menu_repeat_xpath}                            //html/body/div[3]/div/form/div[13]
${menu_traverse_xpath}                          //html/body/div[3]/div/form/div[15]

${btn_camera_normal_value}                      CameraOrientation01.png
${btn_camera_rotated_value}                     CameraOrientation02.png
${btn_web_movement_bottom_up_value}             WebDirection01.png
${btn_web_movement_top_down_value}              WebDirection02.png
${btn_image_orientation_right_side_up_value}    ImageOrientationonWeb01.png
${btn_image_orientation_upside_down_value}      ImageOrientationonWeb02.png

${btn_varnish_flash_value}                      FlashConfiguration02.png
${btn_uv_flash_value}                           FlashConfiguration03.png
${btn_backside_flash_value}                     FlashConfiguration05.png
${btn_throughflash_value}                       FlashConfiguration06.png

# bt ... backside traverse
${btn_bt_none_value}                            BackFlashTraverse00.png
${btn_bt_normal_value}                          BackFlashTraverse01.png
${btn_bt_inverted_value}                        BackFlashTraverse02.png
${btn_bt_full_value}                            BackFlashTraverse03.png

${fld_numberofteeth_name}                       NumberofTeeth
${fld_encodercircumference_name}                EncoderCircumference
${fld_repeatlength_name}                        RepeatLength
${fld_traversezerooffset_name}                  TraverseZeroOffset


*** Keywords ***
#Orientation
Select normal camera orientation
    click wizard selection button  ${menu_camera_orientation_xpath}  ${btn_camera_normal_value}

Select rotated camera orientation
    click wizard selection button  ${menu_camera_orientation_xpath}  ${btn_camera_rotated_value}

Select bottom up web movement
    click wizard selection button  ${menu_web_direction_xpath}  ${btn_web_movement_bottom_up_value}

Select top down web movement
    click wizard selection button  ${menu_web_direction_xpath}  ${btn_web_movement_top_down_value}

Select right side up image orientation
    click wizard selection button  ${menu_image_direction_xpath}  ${btn_image_orientation_right_side_up_value}

Select upside down image orientation
    click wizard selection button  ${menu_image_direction_xpath}  ${btn_image_orientation_upside_down_value}

#Additional flashes
Select varnish flash
    click wizard selection button  ${menu_flash_configuration_xpath}  ${btn_varnish_flash_value}

Select UV flash
    click wizard selection button  ${menu_flash_configuration_xpath}  ${btn_uv_flash_value}

Select backside flash
    click wizard selection button  ${menu_flash_configuration_xpath}  ${btn_backside_flash_value}

Select throughflash
    click wizard selection button  ${menu_flash_configuration_xpath}  ${btn_throughflash_value}

#Backside traverse
select no backside traverse
    click wizard selection button  ${menu_backside_traverse_xpath}  ${btn_bt_none_value}

select standard backside traverse
    click wizard selection button  ${menu_backside_traverse_xpath}  ${btn_bt_normal_value}

select inverted backside traverse
    click wizard selection button  ${menu_backside_traverse_xpath}  ${btn_bt_inverted_value}

select full width backside flash
    click wizard selection button  ${menu_backside_traverse_xpath}  ${btn_bt_full_value}

#Fields
insert number of teeth
    [Arguments]  ${value}
    write into wizard field  ${menu_encoder_xpath}  ${fld_numberofteeth_name}  ${value}

insert encoder circumference
    [Arguments]  ${value}
    write into wizard field  ${menu_encoder_xpath}  ${fld_encodercircumference_name}  ${value}

insert repeat length
    [Arguments]  ${value}
    write into wizard field  ${menu_repeat_xpath}  ${fld_repeatlength_name}  ${value}

insert traverse zero offset
    [Arguments]  ${value}
    write into wizard field  ${menu_traverse_xpath}  ${fld_traversezerooffset_name}  ${value}
