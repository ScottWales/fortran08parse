grammar fortran;

// Comments are section numbers in the Fortran 2008 draft

// Keywords
END     : E N D;
PROGRAM : P R O G R A M;
ENDPROGRAM : E N D P R O G R A M;


// 2.1
// R201
program : (programUnit)+ 
        ;

// R202
programUnit : mainProgram
//          | externalSubprogram
//          | module
//          | submodule
//          | blockData
            ;


// 3.1.1
// R301
fragment AlphanumericCharacter  : Letter
                                | Digit
                                | Underscore;

// 3.1.2
fragment Letter : [A-Za-z];

// 3.1.3
fragment Digit  : [0-9];

// 3.1.4
fragment Underscore : '_';

// 3.2.2
// R303
Name    : Letter AlphanumericCharacter*;

// 3.3.2.2
Whitespace : [ \n] -> skip;

// 11.1
// R1101
mainProgram : (programStmt)? 
//              (specificationPart)? 
//              (executionPart)?
//              (internalSubprogramPart)?
                endProgramStmt
            ;

// R1102
programStmt : PROGRAM Name;

// R1103
endProgramStmt  : END ( PROGRAM (Name)? )?
                | ENDPROGRAM (Name)?
                ;

// Case insensitve stuff

// Letters
fragment A:('a'|'A');
fragment B:('b'|'B');
fragment C:('c'|'C');
fragment D:('d'|'D');
fragment E:('e'|'E');
fragment F:('f'|'F');
fragment G:('g'|'G');
fragment H:('h'|'H');
fragment I:('i'|'I');
fragment J:('j'|'J');
fragment K:('k'|'K');
fragment L:('l'|'L');
fragment M:('m'|'M');
fragment N:('n'|'N');
fragment O:('o'|'O');
fragment P:('p'|'P');
fragment Q:('q'|'Q');
fragment R:('r'|'R');
fragment S:('s'|'S');
fragment T:('t'|'T');
fragment U:('u'|'U');
fragment V:('v'|'V');
fragment W:('w'|'W');
fragment X:('x'|'X');
fragment Y:('y'|'Y');
fragment Z:('z'|'Z');
