*** Settings ***
Resource  ${EXECDIR}/Resources/_LibraryAdapters/SeleniumLibraryAdapter.robot

*** Variables ***
# XPath locators must start with '//' robotframework
${BTN_SUBMIT_SELECTION_XPATH}                   //html/body/div[3]/div/form/input
${WIZARD_URL}                                   http://${SERVER_IP}/elsetupwizard.jsp
${WIZARD_PAGE_VERIFICATION_CONTENT}             Set Up Wizard

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
go to wizard page

    [Documentation]  Navigates to the weasel wizard page (user must already be
    ...  logged into Weasel)

    go to page and wait for content  ${WIZARD_URL}  ${WIZARD_PAGE_VERIFICATION_CONTENT}


the 'Submit' button is clicked

    [Documentation]  Submits the form data by clicking the 'Submit' button.
    ...
    ...  From weasel version v2.0 on the following keywords must be executed
    ...  first, as the 'Submit' button expects required data to be given:
    ...  `I select a valid orientation configuration`,
    ...  `I select a valid flash configuration`,
    ...  `I select a valid backside traverse configuration`

    scroll to page bottom
    click this button  ${BTN_SUBMIT_SELECTION_XPATH}


#Orientation
Select normal camera orientation
    scroll to element and click button
    ...  button_locator=${btn_camera_normal_value}
    ...  scroll_element_locator=${menu_camera_orientation_xpath}


Select rotated camera orientation
    scroll to element and click button
    ...  button_locator=${btn_camera_rotated_value}
    ...  scroll_element_locator=${menu_camera_orientation_xpath}


Select bottom up web movement
    scroll to element and click button
    ...  button_locator=${btn_web_movement_bottom_up_value}
    ...  scroll_element_locator=${menu_web_direction_xpath}


Select top down web movement
    scroll to element and click button
    ...  button_locator=${btn_web_movement_top_down_value}
    ...  scroll_element_locator=${menu_web_direction_xpath}


Select right side up image orientation
    scroll to element and click button
    ...  button_locator=${btn_image_orientation_right_side_up_value}
    ...  scroll_element_locator=${menu_image_direction_xpath}


Select upside down image orientation
    scroll to element and click button
    ...  button_locator=${btn_image_orientation_upside_down_value}
    ...  scroll_element_locator=${menu_image_direction_xpath}


#Additional flashes
Select varnish flash
    scroll to element and click button
    ...  button_locator=${btn_varnish_flash_value}
    ...  scroll_element_locator=${menu_flash_configuration_xpath}


Select UV flash
    scroll to element and click button
    ...  button_locator=${btn_uv_flash_value}
    ...  scroll_element_locator=${menu_flash_configuration_xpath}


Select backside flash
    scroll to element and click button
    ...  button_locator=${btn_backside_flash_value}
    ...  scroll_element_locator=${menu_flash_configuration_xpath}


Select throughflash
    scroll to element and click button
    ...  button_locator=${btn_throughflash_value}
    ...  scroll_element_locator=${menu_flash_configuration_xpath}


#Backside traverse
select no backside traverse
    scroll to element and click button
    ...  button_locator=${btn_bt_none_value}
    ...  scroll_element_locator=${menu_backside_traverse_xpath}


select standard backside traverse
    scroll to element and click button
    ...  button_locator=${btn_bt_normal_value}
    ...  scroll_element_locator=${menu_backside_traverse_xpath}


select inverted backside traverse
    scroll to element and click button
    ...  button_locator=${btn_bt_inverted_value}
    ...  scroll_element_locator=${menu_backside_traverse_xpath}


select full width backside flash
    scroll to element and click button
    ...  button_locator=${btn_bt_full_value}
    ...  scroll_element_locator=${menu_backside_traverse_xpath}


#Fields
insert number of teeth

    [Arguments]  ${value}

    scroll to element and write into field
    ...  ${fld_numberofteeth_name}
    ...  ${value}
    ...  scroll_element_locator=${menu_encoder_xpath}


insert encoder circumference

    [Arguments]  ${value}

    scroll to element and write into field
    ...  ${fld_encodercircumference_name}
    ...  ${value}
    ...  scroll_element_locator=${menu_encoder_xpath}

insert repeat length

    [Arguments]  ${value}

    scroll to element and write into field
    ...  ${fld_repeatlength_name}
    ...  ${value}
    ...  scroll_element_locator=${menu_repeat_xpath}

insert traverse zero offset

    [Arguments]  ${value}

    scroll to element and write into field
    ...  ${fld_traversezerooffset_name}
    ...  ${value}
    ...  scroll_element_locator=${menu_traverse_xpath}
