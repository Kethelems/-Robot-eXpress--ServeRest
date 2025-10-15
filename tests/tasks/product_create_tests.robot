*** Settings ***
Library    Browser

*** Test Cases ***
UN-91 - Cenário produto cadastrado com sucesso
    [Documentation]    Testa o cadastro de produto com dados válidos
    [Tags]    produto    cadastro    sucesso
    
    ${random}=    Evaluate    random.randint(1000, 9999)    modules=random
    
    New Browser    chromium    headless=false
    New Page    https://front.serverest.dev/login
    
    Fill Text    css=input[name="email"]    fulano@qa.com
    Fill Text    css=input[name="password"]    teste
    Click    css=button[type="submit"]
    
    Wait For Elements State    css=[data-testid="cadastrarProdutos"]    visible    10s
    Click    css=[data-testid="cadastrarProdutos"]
    
    Wait For Elements State    css=[data-testid="nome"]    visible    10s
    Fill Text    css=[data-testid="nome"]    Produto Teste ${random}
    Fill Text    css=[data-testid="preco"]    100
    Fill Text    css=[data-testid="descricao"]    Descrição do produto teste
    
    Wait For Elements State    css=[data-testid="quantity"]    visible    5s
    Fill Text    css=[data-testid="quantity"]    ${random}
    
    Click    css=[data-testid="cadastarProdutos"]
    
    Wait For Elements State    xpath=//h1[contains(text(), 'Lista dos Produtos')]    visible    10s
    
    Close Browser