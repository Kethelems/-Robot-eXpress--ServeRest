*** Settings ***
Documentation
Library    Browser

*** Keywords ***
Start Session
    New Browser    chromium    headless=false
    New Page       about:blank

