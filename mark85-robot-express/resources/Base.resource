*** Settings ***

Library     libs/database.py
Library     Browser

Resource    pages/components/Notice.resource
Resource    pages/components/Alert.resource

Resource    env.resource
Resource    pages/SignupPage.resource
Resource    pages/LoginPage.resource

*** Keywords ***
Start Session
    New Browser        browser=chromium    headless=false
    New Page           ${BASE_URL}