*** Settings ***
Resource    ../../resources/base.resource

Suite Setup       Start Session
Suite Teardown    End Session

*** Test Cases ***
Delete Cart Successfully
    [Documentation]    Cenário: Carrinho deletado com sucesso
    
    # Implementar teste de deletar carrinho
    # Endpoint: /carrinhos/cancelar-compra
    # Expected: Status 200, mensagem de sucesso
    
    Log    Teste de deletar carrinho - implementar