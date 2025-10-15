*** Settings ***

Resource   ../../../resources/base.resource
Library    FakerLibrary

Suite Setup    Start Session
Suite Teardown    End Session

*** Test Cases ***

Login User With Unregistered Email

    [Documentation]  Cenário de login com email não cadastrado

    [Tags]   login
    
    ${fake_email}=  FakerLibrary.Email
    
    Go To    ${BASE_URL}

    Fill Text    input[name="email"]    ${fake_email}
    Fill Text    input[name="password"]    teste

    Click    xpath=//button[text()='Entrar']

    Wait For Elements State    text=Email e/ou senha inválidos    visible    5