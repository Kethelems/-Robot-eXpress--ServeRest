*** Settings ***
Resource    ../../resources/base.resource

Test Setup        Start Session
Test Teardown     End Session

*** Test Cases ***
UN-91 - Cenário produto cadastrado com sucesso
    [Documentation]    Testa o cadastro de produto com dados válidos
    [Tags]    produto    cadastro    sucesso
    
    Go To    https://front.serverest.dev/login
    Fill Text    input[name="email"]    fulano@qa.com
    Fill Text    input[name="password"]    teste
    Click    xpath=//button[text()='Entrar']
    
    Click    xpath=//a[text()='Cadastrar Produtos']
    Fill Text    input[name="nome"]    Produto Teste Automatizado
    Fill Text    input[name="preco"]    100
    Fill Text    input[name="descricao"]    Produto criado via automação
    Fill Text    input[name="quantidade"]    10
    
    Click    xpath=//button[text()='Cadastrar']
    
    Wait For Elements State    xpath=//div[contains(@class, 'alert-success')]    visible    5s