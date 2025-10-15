*** Settings ***

Resource   ../../../resources/base.resource
Library    FakerLibrary


Suite Setup    Start Session

Suite Teardown    End Session

*** Test Cases ***

Login User With Correct Email And Password 

    [Documentation]  Cenário de login com email e senha inválidos

    [Tags]   login
    
    ${fake_email}=  FakerLibrary.Email
    ${fake_password}=  FakerLibrary.Password
    ${fake_name}=  FakerLibrary.Name

    ${user}  Create Dictionary  email=${fake_email}    password=${fake_password}    name=${fake_name}
    
    Create User  ${user}

    Go To    ${BASE_URL}/login
    Sleep    2

 
    Fill Text    selector    ${fake_email}
    Fill Text    selector    ${fake_password}


    Wait For Elements State    selector    visible    5
    
    Remove User  ${user}

