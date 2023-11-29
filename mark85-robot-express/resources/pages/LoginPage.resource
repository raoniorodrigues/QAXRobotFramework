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