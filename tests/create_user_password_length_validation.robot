*** Settings ***
Resource    ../resources/base.resource
Library     FakerLibrary

Suite Setup       Start Session
Suite Teardown    End Session

*** Test Cases ***
Create User With Short Password
    [Documentation]    Cenário: Criar usuário com senha menor que 5 caracteres
    
    ${fake_name}=          FakerLibrary.Name
    ${fake_email}=         FakerLibrary.Email
    ${short_password}=     FakerLibrary.Password    length=4
    
    Go To    ${BASE_URL}/cadastrarusuarios
    
    Fill Text    input[name="nome"]      ${fake_name}
    Fill Text    input[name="email"]     ${fake_email}
    Fill Text    input[name="password"]  ${short_password}
    
    Click    xpath=//button[text()="Cadastrar"]
    

Create User With Long Password
    [Documentation]    Cenário: Criar usuário com senha maior que 10 caracteres
    
    ${fake_name}=      FakerLibrary.Name
    ${fake_email}=     FakerLibrary.Email
    ${long_password}=  FakerLibrary.Password    length=12
    
    Go To    ${BASE_URL}/cadastrarusuarios
    
    Fill Text    input[name="nome"]      ${fake_name}
    Fill Text    input[name="email"]     ${fake_email}
    Fill Text    input[name="password"]  ${long_password}
    
    Click    xpath=//button[text()="Cadastrar"]
    