*** Settings ***
Resource    ../resources/base.resource

Suite Setup       Start Session
Suite Teardown    End Session

*** Test Cases ***
Delete Cart Successfully
    [Documentation]    Cenário: Carrinho deletado com sucesso
    
    Go To    ${BASE_URL}
    Click    xpath=//a[text()='Login']
    Fill Text    input[name="email"]    fulano@qa.com
    Fill Text    input[name="password"]    teste
    Click    xpath=//button[text()='Entrar']
    Click    xpath=//button[contains(text(), 'Adicionar')][1]
    Click    xpath=//a[contains(text(), 'Lista de Compras')]
    Click    xpath=//button[contains(text(), 'Cancelar Compra')]
    Wait For Elements State    xpath=//div[contains(@class, 'alert')]    visible    5s
    Get Text    xpath=//div[contains(@class, 'alert')]    should contain    Compra cancelada com sucesso