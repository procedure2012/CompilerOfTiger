package Parse;
import ErrorMsg.ErrorMsg;

%% 

%implements Lexer
%function nextToken
%type java_cup.runtime.Symbol
%char

%{

StringBuffer s=new StringBuffer();
int layer;

private void newline() {
  errorMsg.newline(yychar);
}

private void err(int pos, String s) {
  errorMsg.error(pos,s);
}

private void err(String s) {
  err(yychar,s);
}

private java_cup.runtime.Symbol tok(int kind, Object value) {
    return new java_cup.runtime.Symbol(kind, yychar, yychar+yylength(), value);
}

private ErrorMsg errorMsg;

Yylex(java.io.InputStream s, ErrorMsg e) {
  this(s);
  errorMsg=e;
}

%}

%eofval{
	{
		if (yystate()==COMMENT) err("Comment isn't End!");
		if (yystate()==STRING) err("String isn't End!");
		if (yystate()==NOTSTRING) err("String isn't End!");
		return tok(sym.EOF, null);
    }
%eofval}       

id = [a-zA-Z][a-zA-Z0-9_]*
num = [0-9]+
nl = \n|\r|\n\r|\r\n
ws = \n|\r|\n\r|\r\n

%state STRING
%state COMMENT
%state NOTSTRING

%%

<YYINITIAL> \" {s.setLength(0);yybegin(STRING);}
<YYINITIAL> "/*" {layer=1;yybegin(COMMENT);}
<YYINITIAL> "*/" {err("Comment end but never start!");}
<YYINITIAL> " " {}
<YYINITIAL> {ws} {newline();}
<YYINITIAL> "," {return tok(sym.COMMA, null);}
<YYINITIAL> ":" {return tok(sym.COLON, null);}
<YYINITIAL> ";" {return tok(sym.SEMICOLON, null);}
<YYINITIAL> "(" {return tok(sym.LPAREN, null);}
<YYINITIAL> ")" {return tok(sym.RPAREN, null);}
<YYINITIAL> "[" {return tok(sym.LBRACK, null);}
<YYINITIAL> "]" {return tok(sym.RBRACK, null);}
<YYINITIAL> "{" {return tok(sym.LBRACE, null);}
<YYINITIAL> "}" {return tok(sym.RBRACE, null);}
<YYINITIAL> "." {return tok(sym.DOT, null);}
<YYINITIAL> "+" {return tok(sym.PLUS, null);}
<YYINITIAL> "-" {return tok(sym.MINUS, null);}
<YYINITIAL> "*" {return tok(sym.TIMES, null);}
<YYINITIAL> "/" {return tok(sym.DIVIDE, null);}
<YYINITIAL> "=" {return tok(sym.EQ, null);}
<YYINITIAL> "<" {return tok(sym.LT, null);}
<YYINITIAL> ">" {return tok(sym.GT, null);}
<YYINITIAL> "<>" {return tok(sym.NEQ, null);}
<YYINITIAL> "<=" {return tok(sym.LE, null);}
<YYINITIAL> ">=" {return tok(sym.GE, null);}
<YYINITIAL> "&" {return tok(sym.AND, null);}
<YYINITIAL> "|" {return tok(sym.OR, null);}
<YYINITIAL> ":=" {return tok(sym.ASSIGN, null);}
<YYINITIAL> "nil" {return tok(sym.NIL, null);}
<YYINITIAL> "of" {return tok(sym.OF, null);}
<YYINITIAL> "if" {return tok(sym.IF, null);}
<YYINITIAL> "then" {return tok(sym.THEN, null);}
<YYINITIAL> "else" {return tok(sym.ELSE, null);}
<YYINITIAL> "while" {return tok(sym.WHILE, null);}
<YYINITIAL> "do" {return tok(sym.DO, null);}
<YYINITIAL> "for" {return tok(sym.FOR, null);}
<YYINITIAL> "to" {return tok(sym.TO, null);}
<YYINITIAL> "break" {return tok(sym.BREAK, null);}
<YYINITIAL> "let" {return tok(sym.LET, null);}
<YYINITIAL> "in" {return tok(sym.IN, null);}
<YYINITIAL> "end" {return tok(sym.END, null);}
<YYINITIAL> "var" {return tok(sym.VAR, null);}
<YYINITIAL> "type" {return tok(sym.TYPE, null);}
<YYINITIAL> "function" {return tok(sym.FUNCTION, null);}
<YYINITIAL> "array" {return tok(sym.ARRAY, null);}
<YYINITIAL> {id} {return tok(sym.ID, yytext());}
<YYINITIAL> {num} {return tok(sym.INT, new Integer(yytext()));}
<YYINITIAL> [^] {err(yytext()+" charakter not match!");}

<STRING> {
	\" {yybegin(YYINITIAL);return tok(sym.STRING, s.toString());}
	\\ {yybegin(NOTSTRING);}
	\\[0-9][0-9][0-9] {
		int t = Integer.parseInt(yytext().substring(1, 4));
		if (t > 255) err("Don't know this ASCII!"); else s.append((char)t);
	}
	\\n {s.append('\n');}
	\\t {s.append('\t');}
	\\\\ {s.append('\\');}
	\\\" {s.append('\"');}
	[^\n\t\\\"]+ {s.append(yytext());}
	{nl} {err("String can't end now!");}
}

<NOTSTRING> {
	{ws} {}
	\\ {yybegin(STRING);}
	\" {err(" \" not match!");}
	[^] {s.append(yytext());}
}

<COMMENT> {
	"/*" {++layer;}
	"*/" {
		--layer;
		if (layer == 0) yybegin(YYINITIAL);
	}
	[^] {}
}
