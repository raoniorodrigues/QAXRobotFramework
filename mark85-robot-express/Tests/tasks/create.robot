*** Settings ***

Documentation            Cenários de cadastro de tarefas
Library                  JSONLibrary

Resource                 ../../resources/Base.resource

Test Setup       Start Session
Test Teardown    Take Screenshot

*** Test Cases ***

Deve poder cadastrar uma nova tarefas
    ${data}    Get fixture    
    ...    tasks    
    ...    create

    Clean user from database    ${data}[user][email]
    Insert user from database   ${data}[user]
    Submit login form           ${data}[user]
    User should be logged in    ${data}[user][name]
    
    Go to task form
    Submit task form    ${data}[task]
    Log To Console      ${data}

    Task should be registered    ${data}[task][name]

Não deve cadastrar uma tarefa com nome duplicado
    [Tags]    dup
    ${data}    Get fixture    
    ...    tasks    
    ...    duplicate
    
    # Dado que eu tenho um novo usuário
    Clean user from database    ${data}[user][email]
    Insert user from database   ${data}[user]
    
    # E que esse usuário já cadastrou uma tarefa
    POST user session           ${data}[user]
    POST a new task             ${data}[task]
    
    # E que estou logado na aplicação web
    Submit login form           ${data}[user]
    User should be logged in    ${data}[user][name]
    
    # Quando faço um cadastro dessa maneira que já foi cadastrada
    Go to task form
    Submit task form    ${data}[task]
    
    # Então devo receber uma notificação de duplicidade
    Notice should be    Oops! Tarefa duplicada.    
Não deve cadastrar uma nova tarefa quando atinge o limite de tags
    [Tags]     tags_limit
    ${data}    Get fixture    
    ...    tasks    
    ...    tags_limit
    
    # Dado que eu tenho um novo usuário
    Clean user from database    ${data}[user][email]
    Insert user from database   ${data}[user]
    
    # E que estou logado na aplicação web
    Submit login form           ${data}[user]
    User should be logged in    ${data}[user][name]
    
    # Quando faço um cadastro dessa maneira que já foi cadastrada
    Go to task form
    Submit task form    ${data}[task]
    
    # Então devo receber uma notificação de limite de tags
    Notice should be    Oops! Limite de tags atingido.