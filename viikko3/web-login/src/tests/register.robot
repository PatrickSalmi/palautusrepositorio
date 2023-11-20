*** Settings ***
Resource  resource.robot
Suite Setup  Open And Configure Browser
Suite Teardown  Close Browser
Test Setup  Go To Register Page

*** Test Cases ***
Register With Valid Username And Password
    Set Username  test
    Set Password  test1234
    Set Confirmation Password  test1234
    Submit Register
    Register Should Succeed

Register With Too Short Username And Valid Password
    Set Username  te
    Set Password  test1234
    Set Confirmation Password  test1234
    Submit Register
    Register Should Fail With Message  Username too short

Register With Valid Username And Invalid Password
    Set Username  test
    Set Password  testtest
    Set Confirmation Password  testtest
    Submit Register
    Register Should Fail With Message  Invalid password

Register With Nonmatching Password And Password Confirmation
    Set Username  test
    Set Password  test1234
    Set Confirmation Password  1234test
    Submit Register
    Register Should Fail With Message  Password does not match

Login After Successful Registration
    Set Username  logintest
    Set Password  test1234
    Set Confirmation Password  test1234
    Submit Register
    Go To Login Page
    Set Username  logintest
    Set Password  test1234
    Submit Login
    Login Should Succeed

Login After Failed Registration
    Set Username  logintest
    Set Password  test1
    Set Confirmation Password  test1
    Submit Register
    Go To Login Page
    Set Username  logintest
    Set Password  test1
    Submit Login
    Login Should Fail With Message  Invalid username or password

*** Keywords ***
Register Should Succeed
    Welcome Page Should Be Open

Register Should Fail With Message
    [Arguments]  ${message}
    Register Page Should Be Open
    Page Should Contain  ${message}

Login Should Succeed
    Main Page Should Be Open

Login Should Fail With Message
    [Arguments]  ${message}
    Login Page Should Be Open
    Page Should Contain  ${message}

Set Username
    [Arguments]  ${username}
    Input Text  username  ${username}

Set Password
    [Arguments]  ${password}
    Input Password  password  ${password}

Set Confirmation Password
    [Arguments]  ${password}
    Input Password  password_confirmation  ${password}

Submit Register
    Click Button  Register

Submit Login
    Click Button  Login