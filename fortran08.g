/**
 * \file    fortran08.g
 * \author  Scott Wales <scott.wales@unimelb.edu.au>
 *
 * Copyright 2014 ARC Centre of Excellence for Climate Systems Science
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

grammar fortran08;

// Comments are section numbers in the Fortran 2008 draft

// Keywords
END                             : E N D;
PROGRAM                         : P R O G R A M;

// Generic rules
// R101
// xyzList                     : xyz (',' xyz)* ;
// R102
// xyzName                     : Name ;
// R103
// scalarXyz                   : xyz ;

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

// R213
executableConstruct             : actionStmt
                                | associateConstruct
                                | blockConstruct
                                | caseConstruct
                                | criticalConstruct
                                | doConstruct
                                | forallConstruct
                                | ifConstruct
                                | selectTypeConstruct
                                | whereConstruct
                                ;
// R 214
actionStmt                      : allocateStmt
                                | assignmentStmt
                                | backspaceStmt
                                | callStmt
                                | closeStmt
                                | continueStmt
                                | cycleStmt
                                | deallocateStmt
                                | endFunctionStmt
                                | endMpSubprogramStmt
                                | endProgramStmt
                                | endSubroutineStmt
                                | endfileStmt
                                | errorStopStmt
                                | exitStmt
                                | flushStmt
                                | forallStmt
                                | gotoStmt
                                | ifStmt
                                | inquireStmt
                                | lockStmt
                                | nullifyStmt
                                | openStmt
                                | pointerAssignmentStmt
                                | printStmt
                                | readStmt
                                | returnStmt
                                | rewindStmt
                                | stopStmt
                                | syncAllStmt
                                | syncImagesStmt
                                | syncMemoryStmt
                                | unlockStmt
                                | waitStmt
                                | whereStmt
                                | writeStmt
                                | arithmeticIfStmt
                                | computedGotoStmt
                                ;

// R215
keyword                         : Name ;

// Clause 3
// R301
fragment AlphanumericCharacter  : Letter
                                | Digit
                                | Underscore
                                ;

fragment Letter                 : [A-Za-z]
                                ;

fragment Digit                  : [0-9]
                                ;

// R302
fragment Underscore             : '_'
                                ;

// R303
Name                            : Letter AlphanumericCharacter*
                                ;

// R304
constant                        : literalConstant
                                | namedConstant
                                ;

// R305
literalConstant                 : intLiteralConstant
                                | realLiteralConstant
                                | complexLiteralConstant
                                | logicalLiteralConstant
                                | charLiteralConstant
                                | bozLiteralConstant
                                ;

// R306
namedConstant                   : Name ;

// R307
intConstant                     : constant ;

// R308
charConstant                    : constant ;

// R309
intrinsicOperator               : powerOp
                                | multiOp
                                | addOp
                                | concatOp
                                | relOp
                                | notOp
                                | andOp
                                | orOp
                                | equivOp
                                ;

// R310
definedOperator                 : definedUnaryOp
                                | definedBinaryOp
                                | extendedIntrinsicOp
                                ;

// R311
extendedIntrinsicOp             : intrinsicOperator ;

// R312
label                           : Digit 
                                    (Digit 
                                    (Digit 
                                    (Digit
                                    (Digit
                                    Digit?)?)?)?)?
                                ;

// 3.3.2.2
Whitespace : [ \n] -> skip;

// Clause 4

// R401
typeParamValue                  : scalarIntExpr
                                | '*'
                                | ':'
                                ;

// R402
typeSpec                        : intrinsicTypeSpec
                                | derivedTypeSpec
                                ;

// R403
declarationTypeSpec             : intrinsicTypeSpec
                                | TYPE '(' intrinsicTypeSpec ')'
                                | TYPE '(' derivedTypeSpec ')'
                                | CLASS '(' derivedTypeSpec ')'
                                | CLASS '(' '*' ')'
                                ;

// R404
intrinsicTypeSpec               : INTEGER kindSelector?
                                | REAL kindSelector?
                                | DOUBLE PRECISION
                                | COMPLEX kindSelector?
                                | CHARACTER charSelector?
                                | LOGICAL kindSelector?
                                ;
// R405
kindSelector                    : '(' 
                                    (KIND '=')? 
                                    scalarIntConstantExpr 
                                    ')'
                                ;

// R406
signedIntLiteralConstant        : sign? intLiteralConstant ;
// R407
intLiteralConstant              : digitString 
                                    ('_' kindParam)? 
                                ;
// R408
kindParam                       : digitString
                                | scalarIntConstantName
                                ;
scalarIntConstantName           : Name ;
// R409
signedDigitString               : sign? digitString ;
// R410
digitString                     : Digit+ ;
// R411
sign                            : '+' | '-' ;
// R412
signedRealLiteralConstant       : sign? realLiteralConstant ;
// R413
realLiteralConstant             : significand
                                    (exponentLetter exponent)?
                                    ('_' kindParam)?
                                | digitString
                                    exponentLetter exponent
                                    ('_' kindParam)?
                                ;
// R414
significand                     : digitString '.' digitString?
                                | '.' digitString
                                ;
// R415
exponentLetter                  : E | D ;
// R416
exponent                        : signedDigitString ;
// R417
complexLiteralConstant          : '(' realPart ',' imagPart ')' ;
// R418
realPart                        : signedIntLiteralConstant
                                | signedRealLiteralConstant
                                | namedConstant
                                ;
// R419
imagPart                        : signedIntLiteralConstant
                                | signedRealLiteralConstant
                                | namedConstant
                                ;
// R420
charSelector                    : lengthSelector
                                | '(' LEN '=' typeParamValue ','
                                    KIND '=' scalarIntConstantExpr ')'
                                | '(' typeParamValue ','
                                    (KIND '=')? scalarIntConstantExpr ')'
                                | '(' KIND '=' scalarIntConstantExpr
                                    (',' LEN '=' typeParamValue)? ')'
                                ;
// R421
lengthSelector                  : '(' (LEN '=')? typeParamValue ')'
                                | '*' charLength ','?
                                ;

// R422
charLength                      : '(' typeParamValue ')'
                                | intLiteralConstant
                                ;

// R423
charLiteralConstant             : (kindParam '_')? '\'' repChar* '\''
                                | (kindParam '_')? '"' repChar* '"'
                                ; 
// R424
logicalLiteralConstant          : '.' TRUE '.' ('_' kindParam)?
                                | '.' FALSE '.' ('_' kindParam)?
                                ;
// R425
derivedTypeDef                  : derivedTypeStmt
                                    typeParamDefStmt?
                                    privateOrSequence?
                                    componentPart?
                                    typeBoundProcedurePart?
                                    endTypeStmt
                                ;
// R426
derivedTypeStmt                 : TYPE ((',' typeAttrSpecList)? '::')?
                                    typeName
                                    ('(' typeParamNameList ')')?
                                ;
typeName                        : Name ;
typeParamName                   : Name ;
typeParamNameList               : typeParamName (',' typeParamName)* ;
 

// R427
typeAttrSpec                    : ABSTRACT
                                | accessSpec
                                | BIND '(' C ')'
                                | EXTENDS '(' parentTypeName ')'
                                ;
parentTypeName                  : Name ;
typeAttrSpecList                : typeAttrSpec (',' typeAttrSpec)* ;
// R428
privateOrSequence               : privateComponentsStmt
                                | sequenceStmt
                                ;
// R429
endTypeStmt                     : END TYPE (typeName)? ;
// R430
sequenceStmt                    : SEQUENCE ;
// R431
typeParamDefStmt                : INTEGER (kindSelector)? ','
                                    typeParamAttrSpec '::'
                                    typeParamDeclList
                                ;
typeParamDeclList               : typeParamDecl (',' typeParamDecl)* ;
// R432
typeParamDecl                   : typeParamName
                                    ( '=' scalarIntConstantExpr )?
                                ;
// R433
typeParamAttrSpec               : KIND
                                | LEN
                                ;
// R434
componentPart                   : componentDefStmt* ;
// R435
componentDefStmt                : dataComponentDefStmt
                                | procComponentDefStmt
                                ;
// R436
dataComponentDefStmt            : declarationTypeSpec
                                    ((',' componentAttrSpecList)? '::')?
                                    componentDeclList
                                ;
componentAttrSpecList           : componentAttrSpec (',' componentAttrSpec)* ;
componentDeclList               : componentDecl (',' componentDecl)* ;
// R437
componentAttrSpec               : accessSpec
                                | ALLOCATABLE
                                | CODIMENSION '[' coarraySpec ']'
                                | CONTIGUOUS
                                | DIMENSION '(' componentArraySpec ')'
                                | POINTER
                                ;
// R438
componentDecl                   : componentName 
                                    ('(' componentArraySpec ')')?
                                    ('[' coarraySpec ']')?
                                    ('*' charLength)?
                                    (componentInitialization)?
                                ;
componentName                   : Name ;
// R439
componentArraySpec              : explicitShapeSpecList
                                | deferredShapeSpecList
                                ;
explicitShapeSpecList           : explicitShapeSpec (',' explicitShapeSpec)* ;
deferredShapeSpecList           : deferredShapeSpec (',' deferredShapeSpec)* ;
// R440
procComponentDefStmt            : PROCEDURE '(' (procInterface)? ')' ','
                                    procComponentAttrSpecList '::'
                                    procDeclList
                                ;
procComponentAttrSpecList       : procComponentAttrSpec (',' procComponentAttrSpec)* ;
procDeclList                    : procDecl (',' procDecl)* ;
// R441
procComponentAttrSpec           : POINTER
                                | PASS ('(' argName ')')?
                                | NOPASS
                                | accessSpec
                                ;
argName                         : Name ;

// TODO

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
