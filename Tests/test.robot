*** Settings ***
Documentation  This test suite contains only dummy tests to test RF features

Library     SeleniumLibrary
Library     ../Libraries/Common.py
Library     ../Libraries/SendKeys.py
Library     ../Libraries/MouseActions.py
Resource    ../Resources/PowerControlSwitch/PowerControlSwitch_commands.robot
Resource    ../Resources/Others/time.robot

# robot -d Results Tests/test.robot
# robot -d Results -i test Tests/test.robot
# robot -d Results -i selenium Tests/test.robot

# python -m robot.testdoc ./Tests/test.robot ./Tests/test_doc.html
# python -m robot.testdoc -T  "My Title" ./Tests/test.robot ./Tests/test_doc.html
# python -m robot.testdoc -N  "My TestSuite Name" ./Tests/test.robot ./Tests/test_doc.html
# python -m robot.testdoc -D  "This is my new TS documentation" ./Tests/test.robot ./Tests/test_doc.html
# python -m robot.testdoc -t  "Key driven - Add two numbers" ./Tests/test.robot ./Tests/test_doc.html

*** Test Cases ***
Key driven - Add two numbers
    [Template]  Add two numbers
    2  2  4
    4  4  8

# template works, 'keyword defintion not found' error is only a plugin bug
Log something
    Log  something

Go to login page & go to other pagerebot
    [Tags]  selenium
    Open browser  https://www.google.de  browser=chrome  ff_profile_dir=C:\\Users\\wohletzar\\AppData\\Local\\Mozilla\\Firefox\\Profiles\\thmgq74y.selenium
#    Open browser  http://admin:Elv1ra!oms@10.80.11.181/home.jsp  browser=firefox
    wait for x seconds  2
    Go to  https://www.spiegel.de


#Kill all switch
#    [Tags]  notest
#    open connection  10.6.3.96  22
#    login  root  root
#    Kill all ports  10.6.3.100
#
#run keyword if test
#    [Tags]  Test
#    run keyword if  'a' == 'a' AND
#    ...             'b' == 'c'
#    ...             log something
#    Log  This is the end


*** Keywords ***
Add two numbers
    [Arguments]  ${number_one}  ${number_two}  ${expected_result}
    ${number_one} =  convert to integer  ${number_one}
    ${number_two} =  convert to integer  ${number_two}
    ${expected_result} =  convert to integer  ${expected_result}
    ${result} =  add  ${number_one}  ${number_two}
    should be equal  ${result}  ${expected_result}

log something
    Log  This worked
    Add two numbers  2  2  6