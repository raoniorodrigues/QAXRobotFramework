*** Settings ***
Documentation    Ações e elementos do componente de notificações
Library    Browser

*** Keywords ***
Alert should be
    [Arguments]      ${expect_text}
     Wait For Elements State    css=.alert-error >> text=${expect_text}                      visible    5   