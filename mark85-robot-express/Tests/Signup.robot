*** Settings ***

Documentation        online

Resource    ../resources/Base.robot

Suite Setup         Log    Ocorre antes da suite de testes
Suite Teardown      Log    Ocorre depois da suite de testes

Test Setup       Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Devo Cadastrar um novo usuário
    ${user}            Create Dictionary
    ...                name=Raoni Rodrigues    
    ...                email=raoni.rodriguess@gmail.com    
    ...                password=pwd123

    Remove user from database    ${user}[email]

    Go To              ${BASE_URL}/signup        
    Get Title          equal    Mark85 by QAx


    # Checkpoints
    Wait For Elements State    css=h1    visible    5
    Get Text                   css=h1    equal      Faça seu cadastro

    Fill Text    css=input[name=name]             ${user}[name]    
    Fill Text    css=input[name=email]              ${user}[email]
    Fill Text    css=input[name=password]           ${user}[password]
    
    Click        css=button[type=submit] >> text=Cadastrar

    Wait For Elements State    css=.notice p    visible    5
    Get Text                   css=.notice p    equal    Boas vindas ao Mark85, o seu gerenciador de tarefas.
    
 Não devo Cadastrar um usuário duplicado
    [Tags]    duplicado

    ${user}            Create Dictionary
    ...                name=Raoni Candido    
    ...                email=raoni.Candidos@gmail.com    
    ...                password=pwd123
    
    Remove user from database    ${user}[email]
    Insert user from database    ${user}
    
    Go To              ${BASE_URL}/signup        
    Get Title          equal    Mark85 by QAx


    # Checkpoints
    Wait For Elements State    css=h1    visible    5
    Get Text                   css=h1    equal      Faça seu cadastro

    Fill Text        id=name             ${user}[name]    
    Fill Text        id=email            ${user}[email] 
    Fill Text        id=password         ${user}[password] 
    
    Click            id=buttonSignup

    Wait For Elements State    
    ...    css=.notice p    
    ...    visible    
    ...    5
    
    Get Text                   
    ...    css=.notice p    
    ...    equal    
    ...    Oops! Já existe uma conta com o e-mail informado.