*** Settings ***
Resource    base.resource
Resource    env.robot

*** Keywords ***

POST create user
    ${payload}=               Get fixture     data    product_found
    ${alias}=                 Set Variable    serverest
    ${alias}                  Set Variable    serverest
    ${url}                    Set Variable    /usuarios
    ${expected_status}        Set Variable    201

    Access ServeRest API    ${API_URL}
    
    ${response}=           POST On Session
    ...                    alias=${alias}
    ...                    url=${url}
    ...                    expected_status=${expected_status}
    ...                    json=${payload}[usuario]
    
    ${_id}        Get Value From Json       ${response.json()}
    ...                                     $.._id
    ${message}    Get Value From Json       ${response.json()}
    ...                                     $..message

    Should Not Be Empty    ${_id}
    Should Be Equal        Cadastro realizado com sucesso    ${message}[0]
    Status Should Be       ${expected_status}

    Set Test Variable    ${_id}

DELETE erase user
    ${alias}=                 Set Variable    serverest
    ${alias}                  Set Variable    serverest
    ${url}                    Set Variable    /usuarios
    ${expected_status}        Set Variable    200

    Access ServeRest API    ${API_URL}
    
    ${response}=           DELETE On Session
    ...                    alias=${alias}
    ...                    url=${url}/${_id}
    ...                    expected_status=${expected_status}