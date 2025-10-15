*** Settings ***

Resource   ../../../resources/base.resource
Library    FakerLibrary


Suite Setup    Start Session

Suite Teardown    End Session

*** Test Cases ***

Login User With Correct Email And Password 

    [Documentation]  Cenário de login com email e senha válidos

    [Tags]   login
    
    Go To    ${BASE_URL}

    Fill Text    input[name="email"]    fulano@qa.com
    Fill Text    input[name="password"]    teste

    Click    xpath=//button[text()='Entrar']

    Wait For Elements State    xpath=//h1[contains(text(),'Bem Vindo')]    visible    5

