*** Settings ***

Documentation            Cenários testes de remoção de tarefas

Resource                 ../../resources/Base.resource

Test Setup       Start Session
Test Teardown    Take Screenshot

*** Test Cases ***

Deve poder apagar uma tarefa indesejada
    ${data}    Get fixture    
    ...    tasks    
    ...    delete

    # Dado que eu tenho um novo usuário
    Clean user from database    ${data}[user][email]
    Insert user from database   ${data}[user]
    
    # E que esse usuário já cadastrou uma tarefa
    POST user session           ${data}[user]
    POST a new task             ${data}[task]
    
    # E que estou logado na aplicação web
    Submit login form           ${data}[user]
    User should be logged in    ${data}[user][name]
    
    # E excluo a tarefa
    Request removal             ${data}[task][name]
    # Então valido que a tarefa como concluída
    Task should be not exist    ${data}[task][name]