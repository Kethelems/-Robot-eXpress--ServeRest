*** Settings ***
Resource    ../resources/base.resource
Library     FakerLibrary

Suite Setup       Start Session
Suite Teardown    End Session

*** Test Cases ***
Create Valid User
    [Documentation]    Cenário: Criar usuário com dados válidos
    
    ${fake_name}=      FakerLibrary.Name
    ${fake_email}=     FakerLibrary.Email
    ${fake_password}=  FakerLibrary.Password    length=8
    
    Go To    ${BASE_URL}/cadastrarusuarios
    
    Fill Text       input[name="nome"]     ${fake_name}
    Fill Text       input[name="email"]    ${fake_email}
    Fill Text       input[name="password"]     ${fake_password}

    Click    xpath=//button[text()="Cadastrar"]
    
    Wait For Elements State    xpath=//h1    visible        5

