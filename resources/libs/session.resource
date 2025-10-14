*** Settings ***
Documentation
Library    Browser

Resource    ../env.robot

*** Keywords ***
Start Session
    New Browser    chromium    headless=false
    New Page       ${BASE_URL}

