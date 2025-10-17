*** Settings ***
Resource    ../resources/base.resource

Suite Setup       Start Session
Suite Teardown    End Session

*** Test Cases ***
Create Cart Successfully
    [Documentation]    Cenário: Carrinho cadastrado com sucesso
    
    Go To    ${BASE_URL}
    Click    xpath=//a[text()='Login']
    Fill Text    input[name="email"]    fulano@qa.com
    Fill Text    input[name="password"]    teste
    Click    xpath=//button[text()='Entrar']
    Click    xpath=//button[contains(text(), 'Adicionar')][1]
    Click    xpath=//a[contains(text(), 'Lista de Compras')]
    Wait For Elements State    xpath=//h1[contains(text(), 'Lista de Compras')]    visible    5s
    Get Text    xpath=//tbody//td    should not be empty