*** Settings ***
Library    Browser

Resource    env.robot

*** Keywords ***
Start Session
    New Browser    chromium    headless=false
    New Page       ${BASE_URL}

End Session
    Close Browser

Access ServeRest API
    [Arguments]    ${url}
    Go To    ${url}