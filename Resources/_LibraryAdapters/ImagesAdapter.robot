*** Settings ***
Library  ${EXECDIR}/Libraries/Images.py

*** Keywords ***

compare both images

    [Documentation]  Sample is compared with the reference image using opencv2. If the sample image does match its
    ...  reference, the sample image is deleted (to avoid huge amount of images)
    [Arguments]  ${reference_screenshot_path}  ${sample_screenshot_path}  ${allowed_image_diff_ssim}

    ${success}=  compare_images  ${reference_screenshot_path}  ${sample_screenshot_path}  ${allowed_image_diff_ssim}
    should be true  '${success}' == 'True'  "Startup screenshot does not match the reference"
    run keyword if  '${success}' == 'True'
    ...  run keywords
    ...  remove file  ${sample_screenshot_path}
    ...  AND  log  Image has been deleted
