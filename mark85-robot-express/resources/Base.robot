*** Settings ***

Library    libs/database.py
Library    Browser

Resource    env.robot

*** Keywords ***
Start Session
    New Browser        browser=chromium    headless=false
    New Page           ${BASE_URL}