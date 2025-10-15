*** Settings ***
Resource    ../../resources/base.resource

Test Setup        Start Session
Test Teardown     End Session

*** Test Cases ***
UN-91 - Cenário produto cadastrado com sucesso
    [Documentation]    Testa o cadastro de produto com dados válidos
    [Tags]    produto    cadastro    sucesso
    
    ${timestamp}=    Get Time    epoch
    Cadastrar Produto Com Sucesso    Produto Teste    100    Descrição do produto teste    ${timestamp}

Cenário produto duplicado deve falhar
    [Documentation]    Testa que não é possível cadastrar produto com nome duplicado
    [Tags]    produto    duplicado    erro
    
    Tentar Cadastrar Produto Duplicado    Produto Duplicado Teste    150    Descrição do produto teste    5
    Sleep    1s

