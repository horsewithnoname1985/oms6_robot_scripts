*** Settings ***
Resource  ${EXECDIR}/Resources/_LibraryAdapters/SeleniumLibraryAdapter.robot
Resource  ${EXECDIR}/Resources/_Units/ServerPC/ssh_connection.robot

*** Variables ***
${WEASEL_HOMEPAE_URL_AUTO_LOG_IN}           http://${WEASEL_LOGIN_USERNAME}:${WEASEL_LOGIN_PASSWORD}@${SERVER_IP}/home.jsp
${WEASEL_HOMPAGE_VERIFICATION_CONTENT}      System Overview
${WEASEL_LOGIN_USERNAME}                    admin
${WEASEL_LOGIN_PASSWORD}                    Elv1ra!oms

*** Keywords ***
go to weasel homepage
    go to page and wait for content  ${WEASEL_HOMEPAE_URL_AUTO_LOG_IN}  ${WEASEL_HOMPAGE_VERIFICATION_CONTENT}
