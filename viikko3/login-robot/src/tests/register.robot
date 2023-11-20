*** Settings ***
Resource  resource.robot
Test Setup  Create User And Input New Command

*** Test Cases ***
Register With Valid Username And Password
    Input Credentials  test  test1234
    Output Should Contain  New user registered


Register With Already Taken Username And Valid Password
    Input Credentials  kalle  test4321
    Output Should Contain  User with username kalle already exists

Register With Too Short Username And Valid Password
    Input Credentials  te  test1234
    Output Should Contain  Username too short


Register With Long Enough But Invalid Username And Valid Password
    Input Credentials  test1  test123
    Output Should Contain  Invalid username


Register With Valid Username And Too Short Password
    Input Credentials  test  test123
    Output Should Contain  Password too short

Register With Valid Username And Long Enough Password Containing Only Letters
    Input Credentials  test  asdfghjk
    Output Should Contain  Invalid password

*** Keywords ***
Create User And Input New Command
    Create User  kalle  kalle123
    Input New Command
