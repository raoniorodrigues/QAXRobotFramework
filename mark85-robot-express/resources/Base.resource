*** Settings ***

Library     libs/database.py
Library     Browser
Library     JSONLibrary

Resource    pages/components/Notice.resource
Resource    pages/components/Alert.resource
Resource    pages/components/Header.resource

Resource    env.resource
Resource    pages/SignupPage.resource
Resource    pages/LoginPage.resource
Resource    pages/TaskCreatePage.resource
Resource    pages/TasksListPage.resource

Resource    Services.resource


*** Keywords ***
Start Session
    New Browser        browser=${BROWSER}    headless=false
    New Page           ${BASE_URL}


#Helper
Get fixture
    [Arguments]        ${file_name}        ${scenario}
    ${data}    Load Json From File    
    ...    ${EXECDIR}/resources/fixtures/${file_name}.json
    ...    encoding=utf-8
    [Return]    ${data}[${scenario}]

Reset User from database
    [Arguments]                 ${user}
    
    Clean user from database    [user][email]
    Insert user from database   [user]