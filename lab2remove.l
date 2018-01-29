         /* simple lex program which removes comments from a source program
            The main key is that a variable "comment" is set when the start of a comment
            is seen and then unset when the ending set is seen.  It is possible to have
            two starts closed by on end.

            Shaun Cooper
            January 2015
 
         */
        int comment = 0;
        int debug=0;  /* prints out debug statements if desired */
        int lineNumber = 1; /* line count for printing error location - Ian Johnson, 1-26-2018*/
%%
"/*"	{
	      /* prints error message for nested comments and the line number the error occured
             Ian Johnson, 1-26-2018 */
	      if (comment) printf("Error: Nested comment present at line %d", lineNumber);
          comment = 1;
	    }

"\n"	{
	     /* rule added to count number of lines - Ian Johnson, 1-26-2018 */
	     ++lineNumber;
	     printf("\n");
	    }

"*/"	{
	      /* print error message for unmatched close comment*/
          if (!comment) printf("Error: Close comment present without open comment at line %d \n", lineNumber); 
  	      comment = 0;
	    }

.       { if (!comment) printf("%s",yytext);}

%%

int yywrap(void)
{ 
return 1;
}

main()
{
  yylex();
  printf("Number of lines present: %d \n", lineNumber);
}
