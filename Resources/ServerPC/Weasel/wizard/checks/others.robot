*** Settings ***
Resource  ${EXECDIR}/Resources/ServerPC/Weasel/wizard/weasel_wizard.robot


*** Variables ***
# PARAMETERS
# pixelbox_0.ini
${pulsesPerRoundAB}         /Application/TriggerModel/encoderInput[0]>pulsesPerRoundAB
${encoderCircumference}     /Application/TriggerModel/encoderInput[0]>circumference

# TODO: Find a way to extract paramter values from ini files


# PATHS

*** Keywords ***
Verify - Encoder, repeat and traverse parameter values

