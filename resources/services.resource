*** Settings ***
Resource    base.resource
Resource    env.robot

*** Keywords ***

POST create user
    ${alias}                  Set Variable    serverest
    ${url}                    Set Variable    /usuarios
    ${expected_status}        Set Variable    201
    ${payload}                Get fixture     data    product_found

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

    Set Global Variable        ${USER_ID}    ${_id}[0]
    Log To Console           \nuser id: ${USER_ID}

POST user session
    ${alias}                  Set Variable    serverest
    ${url}                    Set Variable    /login
    ${expected_status}        Set Variable    200
    ${json}                   Get fixture     data    product_found
    
    ${payload}                Create Dictionary    
    ...                       email=${json}[usuario][email]
    ...                       password=${json}[usuario][password]

    Access ServeRest API    ${API_URL}
    
    ${response}=           POST On Session
    ...                    alias=${alias}
    ...                    url=${url}
    ...                    expected_status=${expected_status}
    ...                    json=${payload}
    
    ${token}        Get Value From Json    ${response.json()}    $..authorization

    Set Global Variable        ${AUTH_TOKEN}    ${token}[0]
    Log To Console             \ntoken auth:${AUTH_TOKEN}

POST create product
    ${alias}                  Set Variable    serverest
    ${url}                    Set Variable    /produtos
    ${expected_status}        Set Variable    201
    ${payload}                Get fixture     data    product_found
    
    ${headers}                Create Dictionary    
    ...                       authorization=${AUTH_TOKEN}
    
    Log To Console    ${headers}

    Access ServeRest API    ${API_URL}
    
    ${response}            POST On Session
    ...                    alias=${alias}
    ...                    url=${url}
    ...                    expected_status=${expected_status}
    ...                    json=${payload}[produto]
    ...                    headers=${headers}
    
    ${_id}        Get Value From Json       ${response.json()}
    ...                                     $.._id
    ${message}    Get Value From Json       ${response.json()}
    ...                                     $..message
    Set Test Variable    ${PRODUCT_ID}      ${_id}[0]

    Should Not Be Empty    ${_id}
    Should Be Equal        Cadastro realizado com sucesso    ${message}[0]
    Log To Console         \nproduct id: ${PRODUCT_ID}

DELETE erase user
    ${alias}                  Set Variable    serverest
    ${url}                    Set Variable    /carrinhos
    ${expected_status}        Set Variable    200
    ${payload}                Get fixture    data    product_found

    Access ServeRest API    ${API_URL}
    
    POST user session    # <---- Faz o login

    ${headers}                Create Dictionary    
    ...                       authorization=${AUTH_TOKEN}

#    GET /carrinhos
#    aqui vem o código para pegar o id do carrinho a ser excluido    
#    DELETE /carrinhos
#    aqui vem o código que deleta os carrinhos associados ao user

    ${url}                 Set Variable    /produtos

#    GET /produtos pelo nome
    ${response}           GET On Session
    ...                    alias=${alias}
    ...                    url=${url}?nome=${payload}[produto][nome]
    ...                    expected_status=${expected_status}
    ...                    headers=${headers}
    
    ${_id}        Get Value From Json       ${response.json()}
    ...                                     $.produtos[0]._id
    
    Set Test Variable        ${PRODUCT_ID}    ${id}[0]    
    Log To Console    ${PRODUCT_ID}

#    DELETE /produtos
    ${response}           DELETE On Session
    ...                    alias=${alias}
    ...                    url=${url}/${PRODUCT_ID}
    ...                    expected_status=${expected_status}
    ...                    headers=${headers}
    
    ${url}                 Set Variable    /usuarios

#    GET /usuarios pelo email
    ${response}           GET On Session
    ...                    alias=${alias}
    ...                    url=${url}?email=${payload}[usuario][email]
    ...                    expected_status=${expected_status}
    ...                    headers=${headers}
    
    ${_id}        Get Value From Json       ${response.json()}
    ...                                     $.usuarios[0]._id
    
    Set Test Variable        ${USER_ID}    ${id}[0]    
    Log To Console    ${USER_ID}


    #DELETE /usuarios    
    ${response}=           DELETE On Session
    ...                    alias=${alias}
    ...                    url=${url}/${USER_ID}
    ...                    expected_status=${expected_status}