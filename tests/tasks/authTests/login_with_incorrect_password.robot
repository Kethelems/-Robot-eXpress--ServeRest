
*** Settings ***
Resource   ../../../resources/base.resource
Library    FakerLibrary
Suite Setup    Start Session
Suite Teardown    End Session

*** Test Cases ***
Login User With Incorrect Password
    [Documentation]    Cenário de login com senha inválida
    [Tags]    login    

    Go To    ${BASE_URL}
    Fill Text    input[name="email"]    fulano@qa.com
    Fill Text    input[name="password"]    senhaerrada123
    Click    xpath=//button[text()='Entrar']
    Wait For Elements State    xpath=//span[contains(text(),'Email e/ou senha inválidos')]    visible    5