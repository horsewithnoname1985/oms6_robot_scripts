*** Settings ***
Library  robot.libraries.DateTime

*** Keywords ***
get the current date in format %Y%m%d_%H%M%S
    ${current_time}=  get current date  exclude_millis=yes
    ${converted_time}=  convert date  ${current_time}  result_format=%Y%m%d_%H%M%S

    [Return]  ${converted_time}
