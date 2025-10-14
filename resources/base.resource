*** Settings ***
Library    Browser

*** Keywords ***
Start Session
    New Browser    chromium    headless=false
    New Page       about:blank

End Session
    Close Browser

Access ServeRest API
    [Arguments]    ${url}
    Go To    ${url}