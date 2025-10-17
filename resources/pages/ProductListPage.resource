*** Settings ***
Documentation        Keywords dá página de Lista de Produtos


Library    Browser

Resource    ../base.resource

*** Keywords ***
Check product list display
    ${element}        Set Variable    div[class="App"] h1

    Wait For Elements State        css=${element}    visible    5
    Get Text        css=${element}    equal    Lista dos Produtos

Check product register
    [Arguments]    ${product}
    
    ${keys}           Get Dictionary Keys    ${product}
    ${keys_lenght}    Get Length    ${keys}
    ${keys_lenght}    Evaluate    ${keys_lenght} + 1

    ${values}        Get Dictionary Values    ${product}

    ${nome}                  Get From List    ${values}    1
    ${preco}                 Get From List    ${values}    2
    ${descricao}             Get From List    ${values}    0
    ${quantidade}            Get From List    ${values}    3

    
    # Ordena os valores do dicionário para virem na ordem da row da coluna
    ${ordered_values}        Create List 
    ...                      ${nome}
    ...                      ${preco}
    ...                      ${descricao}
    ...                      ${quantidade}        
    
    ${j}        Set Variable    0

    FOR    ${i}    IN RANGE    1    ${keys_lenght}

        ${element}        Set Variable
        ...               //td[text()="${product}[nome]"]/parent::tr/td[${i}]

        ${text}    Get Text        xpath=${element}
        
#        Log To Console    \n\n Texto da linha: ${text} IGUAL ${ordered_values}[${j}]
        Should Be Equal    ${text}    ${ordered_values}[${j}]
       
        ${j}    Evaluate    ${j} + 1

        
    END
