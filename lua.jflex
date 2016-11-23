/*-***
 *
 *Scanner para Lua
 *
 */


import java_cup.runtime.*;


%%
/*-*
 * LEXICAL FUNCTIONS:
 */

%cup
%line
%column
%unicode
%class LuaLexer

/*
* Essa parte entre %{ e %} sera inserida exatamente como está no arquivo .java final
*/

%{

//Funcao que retorna um token(tipo do java: Symbol) composto apenas por {tokenId}(a variavel do tipo int argumento da função)

Symbol newSym(int tokenId) {
    return new Symbol(tokenId, yyline, yycolumn);
}


//Funcao que retorna um token composto pelo par {tokenId, value} que sao o tipo do token e o "valor" respectivamente
Symbol newSym(int tokenId, Object value) {
    return new Symbol(tokenId, yyline, yycolumn, value);
}

%}


/*-*
 * Macros (atalhos para expressoes regulares):
 */
letra        	= [A-Za-z]
digito          = [0-9]
alfanumerico    = {letra}|{digito}
underline	    = _
identificador   = ({letra}|{underline})({alfanumerico}|{underline})*
inteiro     	= {digito}+
real            = {inteiro}\.{inteiro}
char            = '.'
comentario      = (--([^\R])*\R)|(--[[([^"]"]|("]"[^"]"]))*]])
whitespace      = [ \n\t]
string			= \"([^\"])*\" | \'([^\'])*\'


%%
/**
 * expressoes regulares e a saida deles
 */
and             { return newSym(sym.AND); }
break			{ return newSym(sym.BREAK) ; }
do				{ return newSym(sym.DO) ; }
else            { return newSym(sym.ELSE); }
elseif			{ return newSym(sym.ELSEIF); }
end             { return newSym(sym.END); }
false			{ return newSym(sym.FALSE) ; }
for				{ return newSym(sym.FOR) ; }
function		{ return newSym(sym.FUNCTION) ; }
if              { return newSym(sym.IF); }
in				{ return newSym(sym.IN) ; }
local			{ return newSym(sym.LOCAL) ; }
nil				{ return newSym(sym.NIL) ; }
not				{ return newSym(sym.NOT) ; }
of              { return newSym(sym.OF); }
or              { return newSym(sym.OR); }
repeat			{ return newSym(sym.REPEAT) ; }
return			{ return newSym(sym.RETURN) ; }
then            { return newSym(sym.THEN); }
true			{ return newSym(sym.TRUE) ; }
until			{ return newSym(sym.UNTIL) ; }
while			{ return newSym(sym.WHILE) ; }
"*"             { return newSym(sym.VEZES); }
"+"             { return newSym(sym.MAIS); }
"-"             { return newSym(sym.MENOS); }
"/"             { return newSym(sym.DIVIDE); }
";"             { return newSym(sym.PVIRG); }
","             { return newSym(sym.VIRG); }
"("             { return newSym(sym.PARENE); }
")"             { return newSym(sym.PAREND); }
"{"             { return newSym(sym.CHAVEE); }
"}"             { return newSym(sym.CHAVED); }
"="             { return newSym(sym.IGUAL); }
"=="            { return newSym(sym.IGUALI); }
"<"             { return newSym(sym.MENOR); }
">"             { return newSym(sym.MAIOR); }
"<="            { return newSym(sym.MENORI); }
">="            { return newSym(sym.MAIORI); }
":"             { return newSym(sym.PONTOS); }
"~="            { return newSym(sym.TILI); }
"."             { return newSym(sym.PONTO); }
".."            { return newSym(sym.DPONTOS); }
"..."           { return newSym(sym.TPONTOS); }
"^"             { return newSym(sym.ELOGICO); }
"%"             { return newSym(sym.RESTO); }
"#"             { return newSym(sym.TRALHA); }
{identificador} { return newSym(sym.IDENT, yytext()); }
{inteiro}       { return newSym(sym.INT, new Integer(yytext())); }
{real}          { return newSym(sym.REAL, new Double(yytext())); }
{char}          { return newSym(sym.CHAR, new Character(yytext().charAt(1))); }
{string}		{ return newSym(sym.STRING, new String(yytext()) ; }
{comentario}    { /* Printando os comentarios*/
                  System.out.println("Comentario: " + yytext()); }
{whitespace}    { /*  */ }
.               { System.out.println("Illegal char, '" + yytext() +
                    "' line: " + yyline + ", column: " + yychar); }