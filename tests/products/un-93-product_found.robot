//
//Dado que tenho um usuário administrador préviamente cadastrado
//E fiz login com este usuário administrador obetendo o token
//E tenho um produto préviamente cadastrado também
//Quando clico no botão para listar produtos com título "Listar"
//Então meu produto é listado com nome, preço, descrição, quantidade e dois botões de ações    
//

*** Settings ***
Documentation        Teste do caso de teste UN-93: Cenario Produto Encontrado

Resource             ../../resources/base.resource
Resource             ../../resources/online.robot

Suite Setup         Start Session
Test Teardown       Take Screenshot
Suite Teardown      End Session
Library    Collections
Library    OperatingSystem

*** Test Cases ***

Cenario Produto Encontrado
# Dado que tenho um usuário administrador préviamente cadastrado
    POST create user

# E tenho um produto préviamente cadastrado também
    POST create product

# E fiz login com este usuário administrador obtendo o token
    ${user}        Create Dictionary
    ...        nome=Fulano da Silva
    ...        email=fulano@qa.com
    ...        password=teste
    
    Go To        ${BASE_URL}/login

    Submit login form    ${user}

    Check user login    ${user}   

# Quando clico no botão para listar produtos com título "Listar"
    Click on "Listar" button
    Check product list display

# Então meu produto é listado com nome, preço, descrição, quantidade
    ${product}        Create Dictionary
    ...               nome=Nintendo DS
    ...               preco=4500
    ...               descricao=Um console
    ...               quantidade=10

    Check product register    ${product}

    Sleep        5
