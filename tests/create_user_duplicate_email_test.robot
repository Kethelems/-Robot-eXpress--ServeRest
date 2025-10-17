*** Settings ***
Resource    ../resources/base.resource
Library     FakerLibrary

Suite Setup       Start Session
Suite Teardown    End Session

*** Test Cases ***
Create User With Duplicate Email
    [Documentation]    Cenário: Tentar criar usuário com email já existente
    
    ${fake_name1}=            FakerLibrary.Name
    ${fake_name2}=            FakerLibrary.Name
    ${duplicate_email}=       FakerLibrary.Email
    ${fake_password}=         FakerLibrary.Password
    
    Go To    ${BASE_URL}/cadastrarusuarios
    
    Fill Text    input[name="nome"]      ${fake_name1}
    Fill Text    input[name="email"]     ${duplicate_email}
    Fill Text    input[name="password"]  ${fake_password}
    
    Click    xpath=//button[text()="Cadastrar"]

    Wait For Elements State    xpath=//h1    visible    5s
    
    #segundo cadastro
    Go To    ${BASE_URL}/cadastrarusuarios
    
    Fill Text    input[name="nome"]      ${fake_name2}
    Fill Text    input[name="email"]     ${duplicate_email}
    Fill Text    input[name="password"]  ${fake_password}
    
    Click    xpath=//button[text()="Cadastrar"]
    
    
    Wait For Elements State    text=Este email já está sendo usado    visible    5s
