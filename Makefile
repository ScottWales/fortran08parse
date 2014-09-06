all: fortranLexer.py

clean:
	$(RM) *.pyc
	$(RM) *Lexer.py *.tokens *Listener.py *Parser.py

%Lexer.py %Lexer.tokens %.tokens %Listener.py %Parser.py: %.g4
	antlr4 -Dlanguage=Python2 $<
