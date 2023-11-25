*** Settings ***
Documentation        Cenários de tentativa de cadastro com senha muito curta

Resource             ../resources/Base.resource
Test Template        Short password

Test Setup           Start Session
Test Teardown        Take Screenshot

*** Test Cases ***
Não deve cadastrar com senha de 1 dígito    1
Não deve cadastrar com senha de 2 dígito    12
Não deve cadastrar com senha de 3 dígito    123
Não deve cadastrar com senha de 4 dígito    1234
Não deve cadastrar com senha de 5 dígito    12345

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

