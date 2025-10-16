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
    ${expected_status}        Set Variable    any
    ${json}                   Get fixture     data    product_found
    
    ${payload}                Create Dictionary    
    ...                       email=${json}[usuario][email]
    ...                       password=${json}[usuario][password]

#    Access ServeRest API    ${API_URL}
    
    ${response}=           POST On Session
    ...                    alias=${alias}
    ...                    url=${url}
    ...                    expected_status=${expected_status}
    ...                    json=${payload}
    
    IF    ${response.status_code} == 200
        ${token}        Get Value From Json    ${response.json()}    $..authorization
        ${token_string}    Convert To String    ${token}[0]

        Set Global Variable        ${AUTH_TOKEN}    ${token_string}
        Log To Console             \ntoken auth:${AUTH_TOKEN}    
    END
    
    RETURN    ${response.status_code}

POST create product
    ${alias}                  Set Variable    serverest
    ${url}                    Set Variable    /produtos
    ${expected_status}        Set Variable    201
    ${payload}                Get fixture     data    product_found
    
    ${headers}                Create Dictionary    
    ...                       authorization=${AUTH_TOKEN}
    
    Log To Console    ${headers}

#    Access ServeRest API    ${API_URL}
    
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
    Set Test Variable    ${PRODUCT_ID}      ${_id}

    Should Not Be Empty    ${_id}
    Should Be Equal        Cadastro realizado com sucesso    ${message}[0]
    Log To Console         \nproduct id: ${PRODUCT_ID}

DELETE erase user
    ${alias}                  Set Variable    serverest
    ${url}                    Set Variable    /carrinhos
    ${expected_status}        Set Variable    200
    ${payload}                Get fixture    data    product_found
    ${headers}                Create Dictionary    
    ...                       authorization=${AUTH_TOKEN}

#    GET /carrinhos aqui vem o código para pegar o id do carrinho a ser excluido    
#    DELETE /carrinhos aqui vem o código que deleta os carrinhos associados ao user
    
    ${url}                 Set Variable    /usuarios

#    GET /usuarios pelo email
    ${response}           GET On Session
    ...                    alias=${alias}
    ...                    url=${url}?email=${payload}[usuario][email]
    ...                    expected_status=${expected_status}
    ...                    headers=${headers}
    
    ${id}        Get Value From Json       ${response.json()}
    ...                                     $.usuarios[0]._id
    ...                                     encoding=utf-8
    
    Set Test Variable        ${USER_ID}    ${id}
    Log To Console    ${USER_ID}


    #DELETE /usuarios    
    ${response}=           DELETE On Session
    ...                    alias=${alias}
    ...                    url=${url}/${USER_ID}[0]
    ...                    expected_status=${expected_status}

DELETE erase product
    ${alias}                  Set Variable    serverest
    ${url}                    Set Variable    /produtos
    ${expected_status}        Set Variable    200
    ${payload}                Get fixture    data    product_found
    ${headers}                Create Dictionary    
    ...                       authorization=${AUTH_TOKEN}
    
    #    GET /produtos pelo nome
    ${response}           GET On Session
    ...                    alias=${alias}
    ...                    url=${url}?nome=${payload}[produto][nome]
    ...                    expected_status=${expected_status}
    ...                    headers=${headers}
    
    ${id}        Get Value From Json       ${response.json()}
    ...                                     $.produtos[0]._id
    ...                                     encoding=utf-8
    
    Set Test Variable        ${PRODUCT_ID}    ${id}
    Log To Console    ${PRODUCT_ID}
    

#    DELETE /produtos -> Vamos ter que dar uma keyword sozinha pra ele
    ${response}           DELETE On Session
    ...                    alias=${alias}
    ...                    url=${url}/${PRODUCT_ID}[0]
    ...                    expected_status=${expected_status}
    ...                    headers=${headers}

Clean residual data
    Access ServeRest API    ${API_URL}
    
    ${login_status_code}=        POST user session    # <---- Faz o login
    Log        ${login_status_code}
    IF    ${login_status_code} == 200
        DELETE erase user
        DELETE erase product
    END