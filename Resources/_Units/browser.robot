*** Settings ***
Resource  ${EXECDIR}/Resources/_LibraryAdapters/SeleniumLibraryAdapter.robot

*** Variables ***
${browser_type}  firefox
${firefox_profile_path}

*** Keywords ***
open a new browser instance

    [Arguments]  ${browser_type}

    open browser  ${browser_type}  ff_profile_dir=${firefox_profile_path}
