*** Settings ***
Documentation    Elementos e ações da página de login

Library    Browser
Library    String

*** Keywords ***
Submit login form
    [Arguments]    ${user}
    Fill Text      id=email       ${user}[email]
    Fill Text      id=password    ${user}[password]
    Click          id=buttonLogin

User should be logged in
    [Arguments]        ${name}
    @{splited_name}    Split String     ${name}
    Log                ${splited_name}
    ${element}         Set Variable     css=header .right small
    
    Wait For Elements State    
    ...    ${element}
    ...    visible    5
    
    Get Text    
    ...    ${element}
    ...    equal
    ...    Olá, ${splited_name}[0]