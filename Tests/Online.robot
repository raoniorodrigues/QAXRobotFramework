*** Settings ***

Documentation        online

Resource    ../resources/Base.robot

*** Test Cases ***
Devo valiar que o Webapp está online
    Start Session 
    Get Title          equal    Mark85 by QAx
