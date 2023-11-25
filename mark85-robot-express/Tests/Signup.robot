*** Settings ***

Documentation        online

Resource    ../resources/Base.resource

Suite Setup         Log    Ocorre antes da suite de testes
Suite Teardown      Log    Ocorre depois da suite de testes

Test Setup       Start Session
Test Teardown    Take Screenshot
Library    FakerLibrary

*** Test Cases ***
Devo Cadastrar um novo usuário
    ${user}            Create Dictionary
    ...                name=Raoni Rodrigues    
    ...                email=raoni.rodriguess@gmail.com    
    ...                password=pwd123

    Remove user from database    ${user}[email]

    Go to signup page
    Submit signup form     ${user}
    Notice should be       Boas vindas ao Mark85, o seu gerenciador de tarefas.

Não devo Cadastrar um usuário duplicado
    [Tags]    duplicado

    ${user}            Create Dictionary
    ...                name=Raoni Candido    
    ...                email=raoni.Candidos@gmail.com    
    ...                password=pwd123
    
    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Go to signup page
    Submit signup form     ${user}
    Notice should be       Oops! Já existe uma conta com o e-mail informado.

Campos Obrigatórios
    [Tags]    required

    ${user}    Create Dictionary
    ...        name=${EMPTY}
    ...        email=${EMPTY}
    ...        password=${EMPTY}
    
    Go to signup page
    Submit signup form    ${user}


    Alert should be        Informe seu nome completo                 
    Alert should be        Informe seu e-email                       
    Alert should be        Informe uma senha com pelo menos 6 digitos
Não deve cadastrar com email incorreto
    [Tags]    EmailRequired

    ${user}    Create Dictionary
    ...        name=Charles Xavier
    ...        email=xavier.com.br
    ...        password=123456
    
    Go to signup page
    Submit signup form    ${user}


    Alert should be        Digite um e-mail válido
Não deve cadastrar com senha muito curta
    [Tags]    Temp
    @{password_list}        
    ...    Create List    
    ...    1    12    123    1234    12345
    ...    
    FOR    ${password}    IN    @{password_list}
        Log To Console    ${password}
        ${user}    Create Dictionary
        ...        name=Charles Xavier
        ...        email=xavier@gmail.com.br
        ...        password=${password}
            
        Go to signup page
        Submit signup form    ${user}
        Alert should be        Informe uma senha com pelo menos 6 digitos  
    END
Não deve cadastrar com senha de 1 dígito
    [Tags]    ShortPass
    [Template]    
    Short password    1
Não deve cadastrar com senha de 2 dígito
    [Tags]    ShortPass
    [Template]    
    Short password    12
Não deve cadastrar com senha de 3 dígito
    [Tags]    ShortPass
    [Template]    
    Short password    123
Não deve cadastrar com senha de 4 dígito
    [Tags]    ShortPass
    [Template]    
    Short password    1234
Não deve cadastrar com senha de 5 dígito
    [Tags]    ShortPass
    [Template]    
    Short password    12345

*** Keywords ***
Short password
    [Arguments]        ${short_pass}

    ${user}    Create Dictionary
    ...        name=Charles Xavier
    ...        email=xavier@gmail.com.br
    ...        password=${short_pass}
    
    Go to signup page
    Submit signup form    ${user}


    Alert should be        Informe uma senha com pelo menos 6 digitos