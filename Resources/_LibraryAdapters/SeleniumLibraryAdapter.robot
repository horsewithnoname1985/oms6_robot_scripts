*** Settings ***
Library  SeleniumLibrary
Library  ${EXECDIR}/Libraries/MyExtendedSeleniumLibrary.py

*** Keywords ***
click this button
    [Arguments]  ${button_locator}

    click button  ${button_locator}


go to page and wait for content
    [Arguments]  ${url}  ${content_string}

    go to  ${url}
    wait until page contains  ${content_string}


open a browser window
    [Arguments]  ${browser_type}  ${firefox_profile_path}=None

    open browser  about:blank  browser=${browser_type}  ff_profile_dir=${firefox_profile_path}


scroll to element and click button
    [Arguments]  ${button_locator}  ${scroll_element_locator}

    Wait Until Element Is Visible  ${scroll_element_locator}
    scroll to element  ${scroll_element_locator}
    click button  ${button_locator}


scroll to element and write into field
    [Arguments]  ${field_locator}  ${value}  ${scroll_element_locator}

    Wait Until Element Is Visible  ${scroll_element_locator}
    scroll to element  ${scroll_element_locator}
    input text  ${field_locator}  ${value}


scroll to page bottom
    Execute javascript  return window.scrollTo(0, document.body.scrollHeight);