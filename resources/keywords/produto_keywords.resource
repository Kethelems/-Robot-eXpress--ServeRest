*** Settings ***
Resource    ../pages/usuario_page.resource
Resource    ../pages/login_page.resource
Resource    ../pages/produto_page.resource

*** Keywords ***
Fazer Login No Sistema
    ${email}    ${password}=    Obter Credenciais Fixas
    Login With Valid Credentials    ${email}    ${password}

Cadastrar Produto Com Sucesso
    [Arguments]    ${nome}    ${preco}    ${descricao}    ${quantidade}
    Fazer Login No Sistema
    Acessar Cadastro De Produtos
    Preencher Dados Do Produto    ${nome}    ${preco}    ${descricao}    ${quantidade}
    Cadastrar Produto
    Verificar Produto Na Lista    ${nome}

Tentar Cadastrar Produto Duplicado
    [Arguments]    ${nome}    ${preco}    ${descricao}    ${quantidade}
    Fazer Login No Sistema
    # Primeiro cadastro
    Acessar Cadastro De Produtos
    Preencher Dados Do Produto    ${nome}    ${preco}    ${descricao}    ${quantidade}
    Cadastrar Produto
    # Voltar e tentar cadastrar o mesmo produto
    Go To    ${WEB_BASE_URL}/admin/home
    Wait For Load State    networkidle
    Acessar Cadastro De Produtos
    Preencher Dados Do Produto    ${nome}    ${preco}    ${descricao}    ${quantidade}
    Cadastrar Produto
    Verificar Mensagem De Erro Produto Duplicado

    