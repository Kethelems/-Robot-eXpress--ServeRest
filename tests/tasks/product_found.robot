//
//Dado que tenho um usuário administrador préviamente cadastrado
//E um produto préviamente cadastrado também
//E fiz login com este usuário administrador
//E obtive o token deste usuário administrador
//Quando clico no botão para listar produtos com título "Listar"
//Então meu produto é listado com nome, preço, descrição, quantidade e dois botões de ações    
//

*** Settings ***
Documentation        Teste do caso de teste UN-93: Cenario Produto Encontrado

Resource             ../../resources/base.resource
Resource             ../../resources/online.robot

#Test Setup         Start Session
#Test Teardown      End Session
Library    Collections

*** Test Cases ***

Dado que tenho um usuário administrador préviamente cadastrado
    POST create user
    DELETE erase user
