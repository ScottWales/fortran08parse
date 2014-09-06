all: fortran08Lexer.py fortran08Lexer.java

ANTLR=antlr4

clean:
	$(RM) *.pyc
	$(RM) *Lexer.py *.tokens *Listener.py *Parser.py

%Lexer.java %Lexer.tokens %.tokens %Listener.java %Parser.java: %.g
	$(ANTLR) $<
%Lexer.py %Lexer.tokens %.tokens %Listener.py %Parser.py: %.g
	$(ANTLR) -Dlanguage=Python2 $<
