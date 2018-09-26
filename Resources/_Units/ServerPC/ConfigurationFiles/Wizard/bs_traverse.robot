*** Settings ***
Documentation  This unit keyword file manages the verification for
...  all backside traverse parameters. The `Verify backside traverse - Setup` keyword
...  is called from within the _'Verification'_ keywords, therefor it is not
...  required to run it first.

Resource    ${EXECDIR}/Resources/_LibraryAdapters/JavaPropertiesAdapter.robot
Resource    ${EXECDIR}/Resources/_LibraryAdapters/SSHLibraryAdapter.robot
Resource    ${EXECDIR}/Resources/_Units/ServerPC/ConfigurationFiles/_path_variables.robot
Resource    ${EXECDIR}/Resources/_Units/ServerPC/ssh_connection.robot

# python -m robot.libdoc --Name "Backside traverse config verification" ./Resources/_Units/ServerPC/ConfigurationFiles/Wizard/bs_traverse.robot ./Resources/_Units/ServerPC/ConfigurationFiles/Wizard/_doc/bs_traverse_doc.html

*** Variables ***
# PARAMETERS
# acquireModule.properties
${BACKFLASH_TRAVERSE_TYPE}                  AcquireModule.system.traverse.BackflashTraverseType

# camera.properties
${BACKFLASH_INVERT_CROSS_WEB_DIRECTION}     de.elsis.elscan.camera.backflash.InvertCrossWebDirection
${BACKFLASH_MOVE_SYNCHRONIZED}              de.elsis.elscan.camera.backflash.MoveSynchronized

*** Keywords ***
########## SETUP ##############################################################
Verify backside traverse - Setup

    [Documentation]  Assigns the current values of the backflash parameter to
    ...  the a variable. In the process, the required properties files are
    ...  copied to ``${PROP_DIR}`` directory (and replace any residing files
    ...  with the same name inside that directory).

    Open SSH connection to server PC

    # double backlashes ('\\') required on windows, otherwise leads to IOError: [Errno 13] Permission denied
    # linux does not use backslashes in paths but is still fine with this
    get file via existing SSH connection  ${ACQUIRE_MODULE_PROPERTIES_PATH}  ${PROP_DIR}${/}
    get file via existing SSH connection  ${CAMERA_PROPERTIES_PATH}  ${PROP_DIR}${/}

    close current SSH connection

#    ${AcquireModulePropertiesContent}=          get properties file content  ${ACQUIRE_MODULE_PROPERTIES_LOCAL_PATH}
#    ${CameraPropertiesContent}=                 get properties file content  ${CAMERA_PROPERTIES_LOCAL_PATH}

    ${Backflash_TraverseType_Value}=                get properties value  ${ACQUIRE_MODULE_PROPERTIES_LOCAL_PATH}    ${BackflashTraverseType}
    ${Backflash_MoveSynchronized_Value}=            get properties value  ${CAMERA_PROPERTIES_LOCAL_PATH}            ${Backflash_MoveSynchronized}
    ${Backflash_InvertCrossWebDirection_Value}=     get properties value  ${CAMERA_PROPERTIES_LOCAL_PATH}            ${Backflash_InvertCrossWebDirection}

    set test variable  ${BackflashTraverseType_Value}               ${BackflashTraverseType_Value}
    set test variable  ${Backflash_MoveSynchronized_Value}          ${Backflash_MoveSynchronized_Value}
    set test variable  ${Backflash_InvertCrossWebDirection_Value}   ${Backflash_InvertCrossWebDirection_Value}


########## VERIFICATION #######################################################
Verify - No backside traverse

    [Documentation]  Verifies that the correct parameter values for the setting
    ...  _No backside traverse_ are set

    Verify backside traverse - Setup

    # acquireModule.properties
    should be equal as strings  ${BackflashTraverseType_Value}              none

    # camera.properties
    should be equal as strings  ${Backflash_MoveSynchronized_Value}         false
    should be equal as strings  ${Backflash_InvertCrossWebDirection_Value}  false


Verify - Standard backside traverse

    [Documentation]  Verifies that the correct parameter values for the setting
    ...  _Standard backside traverse_ are set

    Verify backside traverse - Setup

    # acquireModule.properties
    should be equal as strings  ${BackflashTraverseType_Value}              AG8

    # camera.properties
    should be equal as strings  ${Backflash_MoveSynchronized_Value}         true
    should be equal as strings  ${Backflash_InvertCrossWebDirection_Value}  false


Verify - Inverted backside traverse

    [Documentation]  Verifies that the correct parameter values for the setting
    ...  _Inverted backside traverse_ are set

    Verify backside traverse - Setup

    # acquireModule.properties
    should be equal as strings  ${BackflashTraverseType_Value}              AG8

    # camera.properties
    should be equal as strings  ${Backflash_MoveSynchronized_Value}         true
    should be equal as strings  ${Backflash_InvertCrossWebDirection_Value}  true


Verify - Full width backflash

    [Documentation]  Verifies that the correct parameter values for the setting
    ...  _Full width backflash_ are set

    Verify backside traverse - Setup

    # acquireModule.properties
    should be equal as strings  ${BackflashTraverseType_Value}              none

    # camera.properties
    should be equal as strings  ${Backflash_MoveSynchronized_Value}         false
    should be equal as strings  ${Backflash_InvertCrossWebDirection_Value}  false

