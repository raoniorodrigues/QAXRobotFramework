*** Settings ***

Documentation            Cenários testes de atualização de tarefas

Resource                 ../../resources/Base.resource

Test Setup       Start Session
Test Teardown    Take Screenshot

*** Test Cases ***

Deve poder marcar uma nova tarefa como concluida
    ${data}    Get fixture    
    ...    tasks    
    ...    done

    # Dado que eu tenho um novo usuário
    Clean user from database    ${data}[user][email]
    Insert user from database   ${data}[user]
    
    # E que esse usuário já cadastrou uma tarefa
    POST user session           ${data}[user]
    POST a new task             ${data}[task]
    
    # E que estou logado na aplicação web
    Submit login form           ${data}[user]
    User should be logged in    ${data}[user][name]
    
    # E marco a tarefa como concluída
    Mark task as complete       ${data}[task][name]
    
    # Então valido que a tarefa como concluída
    Task should be complete    ${data}[task][name]