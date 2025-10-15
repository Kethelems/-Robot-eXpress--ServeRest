*** Settings ***
Library    Browser

Resource    env.robot
Resource    pages/login_page.resource
Resource    pages/usuario_page.resource
Resource    pages/produto_page.resource
Resource    keywords/produto_keywords.resource

*** Keywords ***
Start Session
    New Browser    chromium    headless=false
    New Page    ${BASE_URL}

End Session
    Close Browser