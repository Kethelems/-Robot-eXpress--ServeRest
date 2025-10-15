*** Settings ***
Resource    ../../resources/base.resource

Suite Setup       Start Session
Suite Teardown    End Session

*** Test Cases ***
Delete Cart Successfully
    [Documentation]    Cenário: Carrinho deletado com sucesso
    
    # Acessar página inicial
    Go To    ${BASE_URL}
    
    # Fazer login (necessário para ter carrinho)
    Click    xpath=//a[text()='Login']
    Fill Text    input[name="email"]    fulano@qa.com
    Fill Text    input[name="password"]    teste
    Click    xpath=//button[text()='Entrar']
    
    # Adicionar produto ao carrinho
    Click    xpath=//button[contains(text(), 'Adicionar')][1]
    
    # Ir para o carrinho
    Click    xpath=//a[contains(text(), 'Lista de Compras')]
    
    # Cancelar compra (deletar carrinho)
    Click    xpath=//button[contains(text(), 'Cancelar Compra')]
    
    # Validar que o carrinho foi deletado
    Wait For Elements State    xpath=//div[contains(@class, 'alert')]    visible    5s
    Get Text    xpath=//div[contains(@class, 'alert')]    should contain    Compra cancelada com sucesso