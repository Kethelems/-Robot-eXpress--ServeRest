*** Settings ***
Library    Browser

Resource    ../env.robot

*** Keywords ***
Login With Valid Credentials
    [Arguments]    ${email}    ${password}
    Go To    ${WEB_BASE_URL}/login
    Wait For Load State    networkidle
    Fill Text    css=[data-testid="email"]    ${email}
    Fill Text    css=[data-testid="senha"]    ${password}
    Click    css=[data-testid="entrar"]
    Wait For Load State    networkidle
    Get Text    text=Bem Vindo teste    ==    Bem Vindo teste