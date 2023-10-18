*** Settings ***

Documentation        online

Resource    ../resources/Base.robot
Library    FakerLibrary

*** Test Cases ***
Devo Cadastrar um novo usuário
    ${name}            FakerLibrary.Name
    ${email}           FakerLibrary.Email
    ${password}        Set Variable     pwd123
    
    Start Session
    Go To              ${BASE_URL}/signup        
    Get Title          equal    Mark85 by QAx


    # Checkpoints
    Wait For Elements State    css=h1    visible    5
    Get Text                   css=h1    equal      Faça seu cadastro

    Fill Text    id=name             ${name}    
    Fill Text    id=email            ${email}   
    Fill Text    id=password         ${password}
    
    Click        id=buttonSignup

    Wait For Elements State    css=.notice p    visible    5
    Get Text                   css=.notice p    equal    Boas vindas ao Mark85, o seu gerenciador de tarefas.
 


    # Sleep    10