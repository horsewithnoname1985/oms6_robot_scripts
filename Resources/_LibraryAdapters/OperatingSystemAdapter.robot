*** Settings ***
Library     OperatingSystem
Resource    ${EXECDIR}/Resources/_LibraryAdapters/StringAdapter.robot

*** Keywords ***
Run command on local operating system (no return value)

    [Arguments]  ${command}

    run  ${command}


compare two images with imagemagick

    [Documentation] This is a tutorial example to compare two images using ImageMagick.
    ...  For more infos go to: https://blog.codecentric.de/en/2017/09/robot-framework-compare-images-screenshots/
    [Arguments]      ${Reference_Image_Path}    ${Test_Image_Path}    ${Allowed_Threshold}

    ${IMAGE_COMPARATOR_COMMAND}=    magick convert __REFERENCE__ __TEST__ -metric RMSE -compare -format "%[distortion]" info:
    ${TEMP}=        Replace content inside a string  ${IMAGE_COMPARATOR_COMMAND}     __REFERENCE__   ${Reference_Image_Path}
    ${COMMAND}=     Replace content inside a string  ${TEMP}                         __TEST__        ${Test_Image_Path}
    Log             Executing: ${COMMAND}
    ${RC}           ${OUTPUT}=  Run And Return Rc And Output  ${COMMAND}
    Log             Return Code: ${RC}
    Log             Return Output: ${OUTPUT}
    ${RESULT}       Evaluate  ${OUTPUT} < ${Allowed_Threshold}
    Should be True  ${RESULT}