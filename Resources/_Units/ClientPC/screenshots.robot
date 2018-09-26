*** Settings ***
Resource    ${EXECDIR}/Resources/_LibraryAdapters/DateTimeAdapter.robot
Resource    ${EXECDIR}/Resources/_LibraryAdapters/OperatingSystemAdapter.robot
Resource    ${EXECDIR}/Resources/_LibraryAdapters/SSHLibraryAdapter.robot
Resource    ${EXECDIR}/Resources/_LibraryAdapters/ImagesAdapter.robot

# robot -d ../Results -i screenshot Resources/ClientPC.robot

*** Variables ***
${SCREENSHOT_FILENAME}          Startup_GUI.png
${REMOTE_SCREENSHOT_DIR}        C:\\\\Screenshots  # requires 4 backslashes due to psexec64
${LOCAL_SCREENSHOT_DIR}         ${EXECDIR}/Resources/temp/robot_screenshots
${REFERENCE_SCREENSHOT_PATH}    ${EXECDIR}/Resources/temp/reference_screenshots/Startup_GUI_Reference.png
${ALLOWED_IMAGE_DIFF_SSIM}      0.95

*** Keywords ***
get screenshot from remote client PC via SSH connection

    [Documentation]  Done by PSexec - due to double escape character usage (ssh + cmd) a single '\' in the command requires '\\\\'
    ...  The command is executed locally, psexec must NOT be available via ssh on the remote machine

    ${current_date_and_time}=  get the current date in format %Y%m%d_%H%M%S
    Run command on local operating system (no return value)
    ...  psexec64 \\\\${CLIENT_IP} -u ${CLIENT_SSH_USERNAME} -p ${CLIENT_SSH_PASSWORD} -i nircmd savescreenshot ${REMOTE_SCREENSHOT_DIR}\\${current_date_and_time}_${SCREENSHOT_FILENAME}
    get file via existing SSH connection
    ...  ${REMOTE_SCREENSHOT_DIR}/${current_date_and_time}_${SCREENSHOT_FILENAME}
    ...  ${LOCAL_SCREENSHOT_DIR}/${current_date_and_time}_${SCREENSHOT_FILENAME}

    [Return]  ${LOCAL_SCREENSHOT_DIR}/${current_date_and_time}_${SCREENSHOT_FILENAME}


compare startup screenshot with reference

    [Arguments]  ${sample_screenshot_path}

    compare both images  ${REFERENCE_SCREENSHOT_PATH}  ${sample_screenshot_path}  ${ALLOWED_IMAGE_DIFF_SSIM}
