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
novalinha = \R
letra        	= [A-Za-z]
digito          = [0-9]
alfanumerico    = {letra}|{digito}
underline	= _
identificador   = ({letra}|{underline})({alfanumerico}|{underline})*
inteiro     	= {digito}+
real            = {inteiro}\.{inteiro}
comentario      = "-""-"
branco	= \s
string		= (\"([^\"])*\" )|(\'([^\'])*\')
notcoment = .+

%state COMMENT

%%
/**
 * expressoes regulares e a saida deles
 */
<YYINITIAL>{
and             { System.out.println("token and");
					return newSym(sym.AND); }
break		{ System.out.println("token break");
				return newSym(sym.BREAK) ; }
do		{ System.out.println("token do");
			return newSym(sym.DO) ; }
else            {	System.out.println("token else"); return newSym(sym.ELSE); }
elseif		{ System.out.println("token elseif");	return newSym(sym.ELSEIF); }
end             { System.out.println("token end");	return newSym(sym.END); }
false		{ System.out.println("token false");	return newSym(sym.FALSE) ; }
for		{ System.out.println("token for");	return newSym(sym.FOR) ; }
function	{ System.out.println("token function");	return newSym(sym.FUNCTION) ; }
if              { System.out.println("token if"); return newSym(sym.IF); }
in		{ System.out.println("token in"); return newSym(sym.IN) ; }
local		{ System.out.println("token local"); return newSym(sym.LOCAL) ; }
nil		{ System.out.println("token nil"); return newSym(sym.NIL) ; }
not		{ System.out.println("token not"); return newSym(sym.NOT) ; }
or              { System.out.println("token or"); return newSym(sym.OR); }
repeat		{ System.out.println("token repeat"); return newSym(sym.REPEAT) ; }
return		{ System.out.println("token return"); return newSym(sym.RETURN) ; }
then            { System.out.println("token then"); return newSym(sym.THEN); }
true		{ System.out.println("token true"); return newSym(sym.TRUE) ; }
until		{ System.out.println("token until"); return newSym(sym.UNTIL) ; }
while		{ System.out.println("token while"); return newSym(sym.WHILE) ; }
"*"             { System.out.println("token *"); return newSym(sym.VEZES); }
"+"             { System.out.println("token +"); return newSym(sym.MAIS); }
"-"             { System.out.println("token -"); return newSym(sym.MENOS); }
"/"             { System.out.println("token /"); return newSym(sym.DIVIDE); }
";"             { System.out.println("token ;"); return newSym(sym.PVIRG); }
","             { System.out.println("token ,"); return newSym(sym.VIRG); }
"("             { System.out.println("token ("); return newSym(sym.PARENE); }
")"             { System.out.println("token )"); return newSym(sym.PAREND); }
"{"             { System.out.println("token {");	return newSym(sym.CHAVEE); }
"}"             { System.out.println("token }"); return newSym(sym.CHAVED); }
"="             { System.out.println("token ="); return newSym(sym.IGUAL); }
"=="            { System.out.println("token =="); return newSym(sym.IGUALI); }
"<"             { System.out.println("token <"); return newSym(sym.MENOR); }
">"             { System.out.println("token >"); return newSym(sym.MAIOR); }
"<="            { System.out.println("token <="); return newSym(sym.MENORI); }
">="            { System.out.println("token >=}"); return newSym(sym.MAIORI); }
":"             { System.out.println("token :"); return newSym(sym.PONTOS); }
"~="            { System.out.println("token ~="); return newSym(sym.TILI); }
"."             { System.out.println("token ."); return newSym(sym.PONTO); }
".."            { System.out.println("token .."); return newSym(sym.DPONTOS); }
"..."           { System.out.println("token ..."); return newSym(sym.TPONTOS); }
"^"             { System.out.println("token ^"); return newSym(sym.EXPO); }
"%"             { System.out.println("token %"); return newSym(sym.RESTO); }
"#"             { System.out.println("token #"); return newSym(sym.TRALHA); }
"["		{ System.out.println("token ["); return newSym(sym.COLCHEE); }
"]"		{ System.out.println("token ]"); return newSym(sym.COLCHED); }
{branco}		{}
{novalinha}		{}
{identificador} { System.out.println("token id"); return newSym(sym.IDENT, yytext()); }
{inteiro}       { System.out.println("token int"); return newSym(sym.INT, new Integer(yytext())); }
{real}          { System.out.println("token real"); return newSym(sym.REAL, new Double(yytext())); }
{string}	{ System.out.println("token String"); return newSym(sym.STRING, new String(yytext())) ; }
{comentario}	{System.out.println("Início do comentário");	yybegin(COMMENT);}
}
<COMMENT>{
{novalinha}	{System.out.println("Fim do comentário");	yybegin(YYINITIAL);}
{notcoment}	{System.out.println("token notcoment");	}
}

