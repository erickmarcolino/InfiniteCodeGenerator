/*************************************************************************************************************
**       Programa: codeGenerator.p
**           Data: 21/07/2021
**       Objetivo: Gera‡Æo de c¢digos alphanum‚ricos sequenciais infinitos 
**          Autor: Erick Oliveira Marcolino
**          
**************************************************************************************************************
**        
**         Versao: 1.00.000 - Fase Inicial 
**************************************************************************************************************
**      Descricao: Exemplo de uso, chamar a fun‡Æo nextCode("XXX") passando como parametro o ultimo c¢digo
**                 gerado, se o c¢digo informado for o ultimo com aquela quantidade de caracteres incrementa 1
**                 digito no c¢digo e come‡a novamente completando os digitos com o primeiro caracter da lista.
*************************************************************************************************************/


FUNCTION incrementCode RETURNS CHAR (INPUT NumCaracter AS INT, pos AS INT, INPUT lastCode AS CHAR):
    DEF VAR availCharacters AS CHAR.
    DEF VAR currentChar     AS CHAR.
    DEF VAR nextChar        AS CHAR.
    DEF VAR posCurrentChar  AS INT.
    DEF VAR newCode         As CHAR.
   
    ASSIGN availCharacters = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ". //'!@#$%&*
   
    If pos = 0 Then
        LEAVE.
   
    ASSIGN 
        currentChar = SUBSTRING(lastCode, pos, 1).
        posCurrentChar = INDEX(availCharacters, currentChar)
    .
   
    IF posCurrentChar < LENGTH(availCharacters) THEN DO:
        ASSIGN 
            nextChar = SUBSTRING(availCharacters, posCurrentChar + 1, 1)
            newCode = SUBSTRING(lastCode, 1, pos - 1) + nextChar
        .
        If pos < LENGTH(lastCode) THEN
            ASSIGN newCode = newCode + SUBSTRING(lastCode, pos + 1).
    END. ELSE IF pos - 1 > 0 THEN DO:
        ASSIGN 
            nextChar = SUBSTRING(availCharacters, 1, 1)
            newCode = SUBSTRING(lastCode, 1, pos - 1) + nextChar
        .
        If pos < LENGTH(lastCode) THEN
            ASSIGN newCode = newCode + SUBSTRING(lastCode, pos + 1).
        ASSIGN newCode = incrementCode(NumCaracter, pos - 1, newCode).
    END. ELSE DO:
        ASSIGN 
            nextChar = SUBSTRING(availCharacters, 1, 1)
            newCode  = FILL(nextChar, NumCaracter + 1)
        .
    END.
   
    RETURN newCode.
END FUNCTION.

FUNCTION nextCode RETURNS CHAR (INPUT lastCode AS CHAR):
    DEF VAR newCode AS CHAR.
    
    newCode = incrementCode(INPUT LENGTH(lastCode), INPUT LENGTH(lastCode), INPUT lastCode).
    
    RETURN newCode.
END FUNCTION.



/* ************* Exemplos de uso ************* */ 
DEF VAR newCode AS CHAR.
DEF VAR i       AS INT.
DEF VAR cResult AS CHAR. 
ASSIGN 
    newCode = "XXX"
    cResult = ""
.

MESSAGE 
    "Exemplo 1:" SKIP
    nextCode(newCode)
    VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

DO WHILE i <= 50:
    ASSIGN 
        newCode = nextCode(newCode)
        cResult = cResult + newCode + " - "
        i       = i + 1
    .
END.

MESSAGE 
    "Exemplo 2:" SKIP
    cResult
    VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
