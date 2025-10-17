*** Settings ***
Resource    base.resource

*** Keywords ***
Test API Connectivity
    
    Access ServeRest API    ${API_URL}

    ${alias}                  Set Variable    serverest
    ${url}                    Set Variable    /
    ${expected_status}        Set Variable    200

    ${response}=           GET On Session    
    ...                    alias=${alias}
    ...                    url=${url}
    ...                    expected_status=${expected_status}

    Status Should Be    ${expected_status}

Verify API Status
    Access ServeRest API    ${API_URL}
    Get Url    should contain    localhost:3000