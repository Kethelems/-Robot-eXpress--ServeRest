*** Settings ***
Resource    base.resource
Resource    env.robot

*** Keywords ***
Test API Connectivity
    Access ServeRest API    ${BASE_URL}
    Get Title    ==    ServeRest

Verify API Status
    Access ServeRest API    ${BASE_URL}
    Get Url    should contain    localhost:3000