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

*** Test Cases ***

Dado que tenho um usuário administrador préviamente cadastrado
    POST create user

E fiz login com este usuário administrador obetendo o token
    POST user session

E tenho um produto préviamente cadastrado também
    POST create product