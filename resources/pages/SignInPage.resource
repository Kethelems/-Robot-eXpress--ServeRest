*** Settings ***
Documentation        Keywords dá página de login


Library    Browser

Resource             ../env/env.robot
Resource    ../base.resource

*** Keywords ***
Submit login form
    [Arguments]        ${user}    
#checkpoint
    Wait For Elements State        css=h1    visible    5
    Get Text        css=h1    equal    Login
    
    Fill Text        input[name="email"]        ${user}[email]
    Fill Text        input[name="password"]        ${user}[password]

    Click        css=button[type=submit] >> text=Entrar