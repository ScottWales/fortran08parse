grammar fortran08;

// Comments are section numbers in the Fortran 2008 draft

// Keywords
END                             : E N D;
PROGRAM                         : P R O G R A M;

// Generic rules
// R101
// xyz-list                     : xyz (',' xyz) ;
// R102
// xyz-name                     : Name ;
// R103
// scalar-xyz                   : xyz ;

// 2.1
// R201
program                         : (programUnit)+ ;

// R202
programUnit                     : mainProgram
                                | externalSubprogram
                                | module
                                | submodule
                                | blockData
                                ;

// R203
externalSubprogram              : functionSubprogram
                                | subroutineSubprogram
                                ;

// R204
specificationPart               : useStmt?
                                    importStmt?
                                    implicitPart?
                                    declarationConstruct?
                                ;

// R205
implictPart                     : implicitPartStmt? implicitStmt ;

// R206
implicitPartStmt                : implicitStmt
                                | parameterStmt
                                | formatStmt
                                | entryStmt
                                ;

// R207
declarationConstruct            : derivedTypeDef
                                | entryStmt
                                | enumDef
                                | formatStmt
                                | interfaceBlock
                                | parameterStmt
                                | procedureDeclarationStmt
                                | otherSpecificationStmt
                                | typeDeclarationStmt
                                | stmtFunctionStmt
                                ;

// R208
executionPart                   : executableConstruct
                                    executionPartConstruct?
                                ;

// R209
executionPartConstruct          : executableConstruct 
                                | formatStmt
                                | entryStmt
                                | dataStmt
                                ;

// R210
internalSubprogramPart          : containsStmt
                                    internalSubprogram?
                                ;

// R211
internalSubprogram              : functionSubprogram
                                | subroutineSubprogram
                                ;

// R212
otherSpecificationStmt          : accessStmt
                                | allocatableStmt
                                | asynchronousStmt
                                | bindStmt
                                | codimensionStmt
                                | commonStmt
                                | dataStmt
                                | dimensionStmt
                                | equivalenceStmt
                                | externalStmt
                                | intentStmt
                                | intrinsicStmt
                                | namelistStmt
                                | optionalStmt
                                | pointerStmt
                                | protectedStmt
                                | saveStmt
                                | targetStmt
                                | volatileStmt
                                | valueStmt
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

// 4.3.1.1
// R402
typeSpec            : intrinsicTypeSpec
                    | derivedTypeSpec
                    ;
declarationTypeSpec : intrinsicTypeSpec
                    | TYPE '(' intrinsicTypeSpec ')'
                    | TYPE '(' derivedTypeSpec ')'
                    | CLASS '(' derivedTypeSpec ')'
                    | CLASS '(' '*' ')'
                    ;

// 4.4.1
// R404
intrinsicTypeSpec   : INTEGER kindSelector?
                    | REAL kindSelector?
                    | DOUBLE PRECISION
                    | COMPLEX kindSelector?
                    | CHARACTER charSelector?
                    | LOGICAL kindSelector?
                    ;
// R405
kindSelector        : '(' (KIND '=')? scalarIntConstantExpr ')';

// 7.1.2.3
// R703
definedUnaryOp  : '.' Letter+ '.';

// 7.1.2.8
definedBinaryOp : '.' Letter+ '.';

// 11.1
// R1101
mainProgram : programStmt? 
//              specificationPart? 
//              executionPart?
//              internalSubprogramPart?
                endProgramStmt
            ;

// R1102
programStmt : PROGRAM Name;

// R1103
endProgramStmt  : END ( PROGRAM Name? )?
                | ENDPROGRAM Name?
                ;

// 11.2.1
// R1104
module                  : moduleStmt
//                          specificationPart?
//                          moduleSubprogramPart?
                            endModuleStmt
                        ;

// R1105
moduleStmt              : MODULE Name;

// R1106
endModuleStmt           : END (MODULE NAME?)?;

// R1107
moduleSubprogramPart    : containsStmt
                            moduleSubprogram*
                        ;

// R1108
moduleSubprogram        : functionSubprogram
                        | subroutineSubprogram
                        | separateModuleSubprogram
                        ;

// 11.2.2
// R1109
useStmt                 : USE 
                            ((',' moduleNature)? '::')?
                            Name
                            (',' renameList)?
                        | USE
                            ((',' moduleNature)? '::')?
                            Name
                            ',' ONLY ':' onlyList
                        ;

// R1110
moduleNature            : INTRINSIC
                        | NON_INTRINSIC
                        ;

// R1111
rename                  : Name '=>' Name
                        | OPERATOR '(' localDefinedOperator ')' 
                            '=>'
                            OPERATOR '(' useDefinedOperator ')' 
                        ;
renameList              : rename (',' rename)*;

// R1112
only                    : genericSpec
                        | onlyUseName
                        | rename
                        ;
onlyList                : only (',' only)*;

// R1113
onlyUseName             : Name;

// R1114
localDefinedOperator    : definedUnaryOp
                        | definedBinaryOp
                        ;

// R1113
useDefinedOperator      : definedUnaryOp
                        | definedBinaryOp
                        ;

// 12.6.2.1
prefix                  : prefixSpec+;
prefixSpec              : declarationTypeSpec
                        | ELEMENTAL
                        | IMPURE
                        | MODULE
                        | PURE
                        | RECURSIVE
                        ;

// 12.6.2.2
// R1227
functionSubprogram      : functionStmt
//                          specificationPart?
//                          executionPart?
//                          internalSubprogramPart?
                            endFunctionStmt
                        ;
// R1228
functionStmt            : prefix? 
                            FUNCTION Name 
                            '(' dummyArgNameList? ')'
                            suffix?
                        ;

// R1229
procLanguageBindingSpec : languageBindingSpec ;

// R1230
dummyArgName            : Name;
dummyArgNameList        : dummyArgName (',' dummyArgName)*;

// R1231
suffix                  : procLanguageBindingSpec
                            (RESULT '(' Name ')')?
                        | RESULT '(' Name ')'
                            procLanguageBindingSpec?
                        ;

// R1232
endFunctionStmt         : END (FUNCTION Name?)?;

// 12.6.2.8
// R1242
containsStmt            : CONTAINS ;

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
