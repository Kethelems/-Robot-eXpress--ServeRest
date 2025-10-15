*** Settings ***
Library    Browser

Resource    ../env.robot

*** Keywords ***
Acessar Cadastro De Produtos
    Wait For Load State    networkidle
    Sleep    1s
    Click    css=[data-testid="cadastrarProdutos"]
    Wait For Load State    networkidle
    Sleep    1s

Preencher Dados Do Produto
    [Arguments]    ${nome}    ${preco}    ${descricao}    ${quantidade}
    Fill Text    css=[data-testid="nome"]    ${nome}
    Sleep    0.5s
    Fill Text    css=[data-testid="preco"]    ${preco}
    Sleep    0.5s
    Fill Text    css=[data-testid="descricao"]    ${descricao}
    Sleep    0.5s
    Fill Text    css=[data-testid="quantity"]    ${quantidade}
    Sleep    0.5s

Cadastrar Produto
    Click    css=[data-testid="cadastarProdutos"]
    Sleep    2s
    Wait For Load State    networkidle

Verificar Produto Na Lista
    [Arguments]    ${nome_produto}
    Get Text    body    contains    ${nome_produto}

Verificar Mensagem De Erro Produto Duplicado
    Get Text    text=Já existe produto com esse nome    ==    Já existe produto com esse nome