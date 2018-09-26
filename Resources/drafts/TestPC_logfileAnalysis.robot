*** Settings ***
Library     OperatingSystem
Library     ../../Libraries/Logging.py
Library     ../../Libraries/MyString.py
Resource    ../ServerPC/ServerPC_commands.robot

*** Variables ***
${TESTPC_ELVIRA_GUI_LOGFILE_DIR}            ./Resources/temp/ext_log
${TESTPC_ELVIRA_GUI_LOGFILE_NAME}           el-gui.log
${SERVER_ELVIRA_GUI_LOGFILE_PATH}           /elscan/log/el-gui-1.log

${ELVIRA_GUI_LOGFILE_ALARM_BEGIN_PATTERN}   ****** Alarms received: ******
${ELVIRA_GUI_LOGFILE_ALARM_END_PATTERN}     ******************************


*** Keywords ***

search elviraGUI logfile for uncleared alarms
    ${el_gui_logfile}=  ServerPC_commands.get file with timestamp
    ...  ${SERVER_ELVIRA_GUI_LOGFILE_PATH}
    ...  ${TESTPC_ELVIRA_GUI_LOGFILE_DIR}
    ...  ${TESTPC_ELVIRA_GUI_LOGFILE_NAME}

    ${el_gui_logfile_content}=  OperatingSystem.get file  ${el_gui_logfile}

    ${last_alarm_begin_line}=  get last line number containing pattern
    ...  ${el_gui_logfile_content}
    ...  ${ELVIRA_GUI_LOGFILE_ALARM_BEGIN_PATTERN}

    log  Last alarm begin line: ${last_alarm_begin_line}

#    ${el_gui_logfile_content}=  OperatingSystem.get file  ${el_gui_logfile}  # save file content as variable
#
#    # TODO: 6. Search the logfile for the lastest 'alarms received' block line
#    # convert string file into list of line
#
#    # Get starting line of all alarms blocks inside the logfile
#    ${alarm_blocks}=  get lines containing string
#    ...  ${el_gui_logfile_content}
#    ...  ${ELVIRA_GUI_LOGFILE_ALARM_BEGIN_PATTERN}
#
#    ${amount_of_alarm_blocks}=  get line count  ${alarm_blocks}
#
#    debug_log  ${alarm_blocks}
#
#    ${last_alarm_block_begin}= ${alarm_blocks}
#
#    @{alarm_blocks_list}=  split string  ${alarm_blocks}  separator=\n
#
#+++++++++++++++++++++++++

#    log  @{alarm_blocks_list}
    # Get starting line of last alarm block inside the logfile


    # search all lines for content
#    :FOR  @{line}  IN  @{logfile_lines}
#
#
#    ${lastest_alarm_package_line} =


     # TODO: 7. Inside the block search for 'STATUS_RAISED' entries
     # TODO: 8. If any entry is found, mark test cycle as failed, otherwise as passed
     # TODO: 9. In case of failure, attach current 'el-gui.log' file to report (at current cycle)
