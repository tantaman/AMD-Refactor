%lex

%{
	/*
	*/
%}

NOT_COMMENT [^*/]+
NOT_DBL_QUOTE [^"]+
NOT_SINGLE_QUOTE [^']+
NOT_NEWLINE (?:[^\r\n]|\r(?!\n))+

%s DEFINE BLOCK_COMMENT LINE_COMMENT IGNORE IMPORT_DBL IMPORT_SINGLE

%%

<INITIAL>\s+		/**/
<INITIAL>"/*"		this.begin('BLOCK_COMMENT');
<INITIAL>"//"		this.begin('LINE_COMMENT');
<INITIAL>"define"	this.begin('DEFINE'); return 'DEFINE';
<INITIAL>.+			this.begin('IGNORE');

<DEFINE>\s+		/**/
<DEFINE>"("		return 'LEFT_PAREN';
<DEFINE>"["		return 'LEFT_BRACKET';
<DEFINE>'"'		this.begin('IMPORT_DBL'); return 'QUOTE';
<DEFINE>"'"		this.begin('IMPORT_SINGLE'); return 'QUOTE';
<DEFINE>","		return 'COMMA';
<DEFINE>"]"		this.begin('IGNORE'); return 'RIGHT_BRACKET';
<DEFINE>.{1}	this.begin('IGNORE');

<BLOCK_COMMENT>"*/"		this.popState();
<BLOCK_COMMENT>"*"		/**/
<BLOCK_COMMENT>"/"		/**/
<BLOCK_COMMENT>{NOT_COMMENT} /**/

<LINE_COMMENT>\n|\r\n			this.popState();
<LINE_COMMENT>{NOT_NEWLINE}	/**/

<IGNORE>\s+		/**/
<IGNORE>.+		/**/

<IMPORT_DBL>\s+				/**/
<IMPORT_DBL>'"'				this.popState(); return 'QUOTE';
<IMPORT_DBL>{NOT_DBL_QUOTE}	return 'IMPORT';

<IMPORT_SINGLE>\s+			/**/
<IMPORT_SINGLE>"'"			this.popState(); return 'QUOTE';
<IMPORT_SINGLE>{NOT_SINGLE_QUOTE}	return 'IMPORT';

/lex

%%

file
	: DEFINE LEFT_PAREN LEFT_BRACKET imports RIGHT_BRACKET
	| DEFINE LEFT_PAREN
	| DEFINE
	|
	;

imports
	: import COMMA imports
	| import
	|
	;

import
	: QUOTE IMPORT QUOTE
		{ 
			FrontEnd.newImport($2,
				{
				line: @2.first_line,
				startCol: @2.first_column,
				endCol: @2.last_column
				});
		}
	;
