
%{
    #include <stdio.h>
	int yydebug = 1;
%}

%token tCOMMA tSEMI_COLUMN tSLASH tSTAR tPLUS tMINUS tEQUAL tCLOSED_PARENTHESIS tOPENED_PARENTHESIS tVOID tCONST tINT tMAIN tOPENED_C_BRACKET tCLOSED_C_BRACKET tRETURN tPRINTF tNUMBER tIDENTIFIER

%right tEQUAL
%left tPLUS tMINUS
%left tSTAR tSLASH

%%

S: RETURN_TYPE tMAIN tOPENED_PARENTHESIS tCLOSED_PARENTHESIS BODY {printf("S\n");};
RETURN_TYPE: TYPE | ;

BODY: tOPENED_C_BRACKET LISTE_INSTRUCTIONS tCLOSED_C_BRACKET {printf("BODY\n");};
LISTE_INSTRUCTIONS: INSTRUCTION LISTE_INSTRUCTIONS | {printf("LISTE_INSTRUCTIONS\n");};
INSTRUCTION: DECLARATION|AFFECTATION|AFFICHAGE {printf("INSTRUCTION\n");};

TYPE_OPTION: tCONST {printf("CONST\n");}| ;
TYPE: tINT {printf("TYPE\n");};

DECLARATION: TYPE_OPTION TYPE tIDENTIFIER LIST_IDENTIFIER tSEMI_COLUMN {printf("DECLARATION\n");};
LIST_IDENTIFIER: tCOMMA tIDENTIFIER LIST_IDENTIFIER | ;

AFFECTATION: tIDENTIFIER tEQUAL EXPRESSION tSEMI_COLUMN {printf("AFFECTATION\n");};

AFFICHAGE: tPRINTF tOPENED_PARENTHESIS tIDENTIFIER tCLOSED_PARENTHESIS tSEMI_COLUMN {printf("AFFICHAGE\n");};

EXPRESSION: tOPENED_PARENTHESIS EXPRESSION tCLOSED_PARENTHESIS
	|EXPRESSION tSTAR EXPRESSION 
		{printf("EXPR*EXPR\n");}
	|EXPRESSION tSLASH EXPRESSION 
		{printf("EXPR/EXPR\n");}
	|EXPRESSION tPLUS EXPRESSION 
		{printf("EXPR+EXPR\n");}
	|EXPRESSION tMINUS EXPRESSION 
		{printf("EXPR-EXPR\n");}
	|tIDENTIFIER
		{printf("IDENTIFIER\n");}
	|tMINUS EXPRESSION %prec tSTAR
	|tNUMBER 
		{printf("NUMBER\n");}
	{printf("EXPRESSION\n");};

%%

int yyerror(void){}

int main(){
    yyparse();
}

