*** Settings ***
Documentation        Keywords dá página Home


Library    Browser

Resource    ../base.resource

*** Keywords ***
Check user login
    [Arguments]        ${user}

    ${element}        Set Variable    div[class="jumbotron"] h1

    Wait For Elements State        css=${element}    visible    5
    Get Text        css=${element}    equal    Bem Vindo ${user}[nome]

Click on "Listar" button

    ${element}        Set Variable    div[class="card-body"] a[data-testid="listarProdutos"] >> text=Listar
    
    Wait For Elements State        css=${element}    visible    5
    
    Click        css=${element}