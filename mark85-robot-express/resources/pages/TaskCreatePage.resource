*** Settings ***
Documentation        Ações e elementos da página de cadastro de tarefa

Library        Browser

*** Keywords ***
Submit task form
    [Arguments]    ${task}
    Fill Text      css=input[placeholder="Nome da tarefa"]    ${task}[name]

    ${tags_locator}    Set Variable    css=input[name=tags]

    FOR    ${tag}    IN    @{task}[tags]
        Fill Text          ${tags_locator}        ${tag}  
        Press Keys         ${tags_locator}        Enter         
    END
                  
    Click          css=button >> text=Cadastrar

   