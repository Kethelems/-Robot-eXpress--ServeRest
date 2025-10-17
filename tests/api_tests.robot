*** Settings ***
Resource    ../resources/base.resource
Resource    ../resources/online.robot

Suite Setup       Start Session
Suite Teardown    End Session

*** Test Cases ***
Test ServeRest API Connectivity
    Test API Connectivity

Verify ServeRest API Status
    Verify API Status
