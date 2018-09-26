*** Settings ***
Documentation  This resource file manages all interactions with the Server PC

#Resource  ./Others/time.robot
#Resource  ./ServerPC/ServerPC_commands.robot
Resource  ./ServerPC/ServerPC_connection.robot
Resource  ./TestPC/TestPC_logfileAnalysis.robot


*** Variables ***

# * Client *
${SERVER_HOST_IP}                               10.80.11.181
${SERVER_SSH_PORT}                              22
${SERVER_SSH_USERNAME}                          root
${SERVER_SSH_PASSWORD}                          Elv1ra!oms

*** Keywords ***

# * CHECKS - State *

the server PC is successfully initialized
    [Tags]  Initialization

    ServerPC_connection.try reconnection

     # TODO: Require a method to check for server status (did backend and middleware achieve initalization?)
     # TODO: Require a method to check, if any alarms are still raised

     # There is no server status that tells the initaialization is successful.
     # In order to verify a proper server startup with its all components, the logfiles
     # of elviraGUI (el-gui.log) must be searched for alarms. Usually several alarms
     # are sent as a package. Alarms are raised, when a certain component does not
     # behave as expected at a certain point in time. At a later point in time, an alarm might
     # have been cleared, if the component then behaves as expected and the package now claims
     # this previous 'STATUS_RAISED' as 'STATUS_CLEARED' alarm and must not be considered
     # as a test failure criteria anymore.
     # The test step only fails, if the last package of alarms still contains raised alarms.
     # The log file check must occur at a point in time in which the server has been
     # initialized under normal circumstances.

     # _Steps:

     # 1. Delete all existing 'el-gui.log' files on the server PC (new file is automatically generated for the next log entry)
     # 2. Shut down client and the server PC and wait a few seconds
     # 3. a) Power up client and server pc at the same time
     #    b) Power up client pc, wait a few seconds, then power up the server pc
     #    c) Power up server pc, wait a few seconds, then power up the client pc
     # 4. Let system start (wait 2 minutes)
     # 5. Copy 'el-gui.log' to drafts directory /Resources/temp/ext_log/<YYYY_MM_DD_hh_mm_ss>_Server_power_up/<YYYY_MM_DD_hh_mm_ss>_el-gui.log
     # 6. Search the logfile for the lastest 'alarms received' block
     # 7. Inside the block search for 'STATUS_RAISED' entries
     # 8. If any entry is found, mark test cycle as failed, otherwise as passed
     # 9. In case of failure, attach current 'el-gui.log' file to report (at current cycle)


the pixelbox is successfully initialized
    # TODO: Require a method to check, if the pixelbox has been initialized successfullly

the WIDE camera is selected
    # TODO:
