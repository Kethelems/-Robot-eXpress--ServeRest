*** Settings ***
Library    Browser
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections

Resource    env/env.robot

Resource    services/api.resource
Resource    pages/SignInPage.resource
Resource    pages/HomePage.resource
Resource    pages/ProductListPage.resource

*** Keywords ***
Start Session
    New Browser    chromium    headless=false
    New Page       ${BASE_URL}
    Clean residual data


End Session
    Take Screenshot
    Close Browser

Access ServeRest API
    [Arguments]       ${url}
    Create Session    serverest    ${url}    timeout=10

Get fixture
    [Arguments]        ${file_name}    ${scenario}

    ${data}=       Load Json From File    
    ...            ${EXECDIR}/resources/fixtures/${file_name}.json
    ...            encoding=utf-8
    
    RETURN    ${data}[${scenario}]