*** Settings ***
Documentation  This is a high level keyword file for all basic interactions
...  with the web based service tool of OMS6 (called _weasel_)
...  = Weasel variables =
...     |   = Variable =                        |   = Explanation = |
...     |   ${WEASEL_HOMEPAGE_URL}              |   Homepage URL of the weasel  |
...     |   ${WEASEL_USERNAME}                  |   Weasel login username   |
...     |   ${WEASEL_PASSWORD}                  |   Weasel login password   |
...     |   ${WEASEL_HOMEPAGE_URL_AUTOLOGIN}    |   Homepage URL of weasel with automatic login using _${WEASEL_USERNAME}_ and _${WEASEL_PASSWORD}_ as credentials  |

Library     ${EXECDIR}/Libraries/SendKeys.py
Library     SeleniumLibrary

Resource    ${EXECDIR}/Resources/Others/time.robot
Resource    ${EXECDIR}/Resources/ServerPC.robot

# python -m robot.libdoc ./Resources/ServerPC/Weasel/weasel.robot ./Resources/ServerPC/Weasel/weasel_doc.html
# python -m robot.libdoc -v 0.1 ./Resources/ServerPC/Weasel/weasel.robot ./Resources/ServerPC/Weasel/weasel_doc.html

*** Variables ***
${WEASEL_HOMEPAGE_URL}                      http://${SERVER_HOST_IP}/home.jsp
${WEASEL_USERNAME}                          admin
${WEASEL_PASSWORD}                          Elv1ra!oms
${WEASEL_HOMEPAGE_URL_AUTOLOGIN}            http://${WEASEL_USERNAME}:${WEASEL_PASSWORD}@${SERVER_HOST_IP}/home.jsp


*** Keywords ***
open browser and login weasel
    [Documentation]  A browser instance ``${browser}`` (see
    ...  [http://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#Open%20Browser|here]
    ...  for possible values) is created and
    ...  navigated to ``${WEASEL_HOMEPAGE_URL_AUTOLOGIN}``. The keyword accepts
    ...  the optional argument ``${firefox_profile_dir}``, which defines the
    ...  path to a firefox profile
    [Arguments]  ${browser}  ${firefox_profile_dir}=None
    open browser  ${WEASEL_HOMEPAGE_URL_AUTOLOGIN}  browser=${browser}  ff_profile_dir=${firefox_profile_dir}
    wait until page contains  System Overview
