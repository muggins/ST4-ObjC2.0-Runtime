// $ANTLR 3.3.1-SNAPSHOT Feb 24, 2011 11:25:29 /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g 2011-02-24 11:32:23

/* =============================================================================
 * Standard antlr3 OBJC runtime definitions
 */
#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLR.h>
/* End of standard antlr3 runtime definitions
 * =============================================================================
 */

/* parserHeaderFile */
/* =============================================================================
 * This is what the grammar programmer asked us to put at the top of every file.
 */

#import "Compiler.h"
#import "ErrorManager.h"
#import "ErrorType.h"

/* End of Header action.
 * =============================================================================
 */
#ifndef ANTLR3TokenTypeAlreadyDefined
#define ANTLR3TokenTypeAlreadyDefined
typedef enum {
    ANTLR_EOF = -1,
    INVALID,
    EOR,
    DOWN,
    UP,
    MIN
} ANTLR3TokenType;
#endif

#pragma mark Cyclic DFA interface start DFA2
@interface DFA2 : ANTLRDFA {
}
+ newDFA2WithRecognizer:(ANTLRBaseRecognizer *)theRecognizer;
- initWithRecognizer:(ANTLRBaseRecognizer *)recognizer;
@end /* end of DFA2 interface  */

#pragma mark Cyclic DFA interface end DFA2
#pragma mark Cyclic DFA interface start DFA28
@interface DFA28 : ANTLRDFA {
}
+ newDFA28WithRecognizer:(ANTLRBaseRecognizer *)theRecognizer;
- initWithRecognizer:(ANTLRBaseRecognizer *)recognizer;
@end /* end of DFA28 interface  */

#pragma mark Cyclic DFA interface end DFA28

#pragma mark Tokens
#ifdef EOF
#undef EOF
#endif
#define EOF -1
#define IF 4
#define ELSE 5
#define ELSEIF 6
#define ENDIF 7
#define SUPER 8
#define SEMI 9
#define BANG 10
#define ELLIPSIS 11
#define EQUALS 12
#define COLON 13
#define LPAREN 14
#define RPAREN 15
#define LBRACK 16
#define RBRACK 17
#define COMMA 18
#define DOT 19
#define LCURLY 20
#define RCURLY 21
#define TEXT 22
#define LDELIM 23
#define RDELIM 24
#define ID 25
#define STRING 26
#define WS 27
#define PIPE 28
#define OR 29
#define AND 30
#define INDENT 31
#define NEWLINE 32
#define AT 33
#define REGION_END 34
#define EXPR 35
#define OPTIONS 36
#define PROP 37
#define PROP_IND 38
#define INCLUDE 39
#define INCLUDE_IND 40
#define EXEC_FUNC 41
#define INCLUDE_SUPER 42
#define INCLUDE_SUPER_REGION 43
#define INCLUDE_REGION 44
#define TO_STR 45
#define LIST 46
#define MAP 47
#define ZIP 48
#define SUBTEMPLATE 49
#define ARGS 50
#define ELEMENTS 51
#define REGION 52
#define A_NULL 53
#pragma mark Dynamic Global Scopes
#pragma mark Dynamic Rule Scopes
#pragma mark Rule Return Scopes start
/* returnScopeInterface STParser_templateAndEOF_return */
@interface STParser_templateAndEOF_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_templateAndEOF_return *)newSTParser_templateAndEOF_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface STParser_template_return */
@interface STParser_template_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_template_return *)newSTParser_template_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface STParser_element_return */
@interface STParser_element_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_element_return *)newSTParser_element_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface STParser_text_return */
@interface STParser_text_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_text_return *)newSTParser_text_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface STParser_exprTag_return */
@interface STParser_exprTag_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_exprTag_return *)newSTParser_exprTag_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface STParser_region_return */
@interface STParser_region_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_region_return *)newSTParser_region_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface STParser_subtemplate_return */
@interface STParser_subtemplate_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_subtemplate_return *)newSTParser_subtemplate_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface STParser_ifstat_return */
@interface STParser_ifstat_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_ifstat_return *)newSTParser_ifstat_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface STParser_conditional_return */
@interface STParser_conditional_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_conditional_return *)newSTParser_conditional_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface STParser_andConditional_return */
@interface STParser_andConditional_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_andConditional_return *)newSTParser_andConditional_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface STParser_notConditional_return */
@interface STParser_notConditional_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_notConditional_return *)newSTParser_notConditional_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface STParser_notConditionalExpr_return */
@interface STParser_notConditionalExpr_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_notConditionalExpr_return *)newSTParser_notConditionalExpr_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface STParser_exprOptions_return */
@interface STParser_exprOptions_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_exprOptions_return *)newSTParser_exprOptions_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface STParser_option_return */
@interface STParser_option_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_option_return *)newSTParser_option_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface STParser_exprNoComma_return */
@interface STParser_exprNoComma_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_exprNoComma_return *)newSTParser_exprNoComma_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface STParser_expr_return */
@interface STParser_expr_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_expr_return *)newSTParser_expr_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface STParser_mapExpr_return */
@interface STParser_mapExpr_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_mapExpr_return *)newSTParser_mapExpr_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface STParser_mapTemplateRef_return */
@interface STParser_mapTemplateRef_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_mapTemplateRef_return *)newSTParser_mapTemplateRef_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface STParser_memberExpr_return */
@interface STParser_memberExpr_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_memberExpr_return *)newSTParser_memberExpr_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface STParser_includeExpr_return */
@interface STParser_includeExpr_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_includeExpr_return *)newSTParser_includeExpr_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface STParser_primary_return */
@interface STParser_primary_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_primary_return *)newSTParser_primary_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface STParser_args_return */
@interface STParser_args_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_args_return *)newSTParser_args_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface STParser_argExprList_return */
@interface STParser_argExprList_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_argExprList_return *)newSTParser_argExprList_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface STParser_arg_return */
@interface STParser_arg_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_arg_return *)newSTParser_arg_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface STParser_namedArg_return */
@interface STParser_namedArg_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_namedArg_return *)newSTParser_namedArg_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface STParser_list_return */
@interface STParser_list_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_list_return *)newSTParser_list_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface STParser_listElement_return */
@interface STParser_listElement_return :ANTLRParserRuleReturnScope { /* returnScopeInterface line 1838 */
/* AST returnScopeInterface.memVars */
ANTLRCommonTree *tree; /* ObjC start of memVars() */
}
/* start properties */
/* AST returnScopeInterface.properties */
@property (retain, getter=getTree, setter=setTree:) ANTLRCommonTree *tree;
+ (STParser_listElement_return *)newSTParser_listElement_return;
/* this is start of set and get methods */
/* AST returnScopeInterface.methodsDecl */
- (ANTLRCommonTree *)getTree;

- (void) setTree:(ANTLRCommonTree *)aTree;
  /* methodsDecl */
@end /* end of returnScopeInterface interface */



/* Interface grammar class */
@interface STParser : ANTLRParser { /* line 572 */
/* ObjC start of ruleAttributeScopeMemVar */


/* ObjC end of ruleAttributeScopeMemVar */
/* ObjC start of globalAttributeScopeMemVar */


/* ObjC end of globalAttributeScopeMemVar */
/* ObjC start of actions.(actionScope).memVars */

ErrorManager *errMgr;
ANTLRCommonToken *templateToken;

/* ObjC end of actions.(actionScope).memVars */
/* ObjC start of memVars */
/* AST parserHeaderFile.memVars */
NSInteger ruleLevel;
NSArray *ruleNames;
  /* AST super.memVars */
/* AST parserMemVars */
id<ANTLRTreeAdaptor> treeAdaptor;   /* AST parserMemVars */
/* ObjC end of memVars */

DFA2 *dfa2;
DFA28 *dfa28;
 }

/* ObjC start of globalAttributeScopeMemVar */
// 

/* ObjC start of actions.(actionScope).properties */

@property (retain, getter=getErrorManager, setter=setErrorManager:) ErrorManager *errMgr;
@property (retain, getter=getTemplateToken, setter=setTemplateToken:) ANTLRCommonToken *templateToken;

/* ObjC end of actions.(actionScope).properties */
/* ObjC start of properties */
/* AST parserHeaderFile.properties */
  /* AST super.properties */
/* AST parserProperties */
@property (retain, getter=getTreeAdaptor, setter=setTreeAdaptor:) id<ANTLRTreeAdaptor> treeAdaptor;   /* AST parserproperties */
/* ObjC end of properties */

+ (id) newSTParser:(id<ANTLRTokenStream>)aStream;
/* ObjC start of actions.(actionScope).methodsDecl */

+ (id) newSTParser:(id<ANTLRTokenStream>)anInput error:(ErrorManager *)anErrMgr token:(ANTLRCommonToken *)aTemplateToken;
- (id) init:(id<ANTLRTokenStream>)anInput error:(ErrorManager *)anErrMgr token:(ANTLRCommonToken *)aTemplateToken;
- (id) recoverFromMismatchedToken:(id<ANTLRIntStream>)anInput type:(NSInteger)ttype follow:(ANTLRBitSet *)follow;

/* ObjC end of actions.(actionScope).methodsDecl */

/* ObjC start of methodsDecl */
/* AST parserHeaderFile.methodsDecl */
  /* AST super.methodsDecl */
/* AST parserMethodsDecl */
- (id<ANTLRTreeAdaptor>) getTreeAdaptor;
- (void) setTreeAdaptor:(id<ANTLRTreeAdaptor>)theTreeAdaptor;   /* AST parsermethodsDecl */
/* ObjC end of methodsDecl */

- (STParser_templateAndEOF_return *)templateAndEOF; 
- (STParser_template_return *)template; 
- (STParser_element_return *)element; 
- (STParser_text_return *)text; 
- (STParser_exprTag_return *)exprTag; 
- (STParser_region_return *)region; 
- (STParser_subtemplate_return *)subtemplate; 
- (STParser_ifstat_return *)ifstat; 
- (STParser_conditional_return *)conditional; 
- (STParser_andConditional_return *)andConditional; 
- (STParser_notConditional_return *)notConditional; 
- (STParser_notConditionalExpr_return *)notConditionalExpr; 
- (STParser_exprOptions_return *)exprOptions; 
- (STParser_option_return *)option; 
- (STParser_exprNoComma_return *)exprNoComma; 
- (STParser_expr_return *)expr; 
- (STParser_mapExpr_return *)mapExpr; 
- (STParser_mapTemplateRef_return *)mapTemplateRef; 
- (STParser_memberExpr_return *)memberExpr; 
- (STParser_includeExpr_return *)includeExpr; 
- (STParser_primary_return *)primary; 
- (STParser_args_return *)args; 
- (STParser_argExprList_return *)argExprList; 
- (STParser_arg_return *)arg; 
- (STParser_namedArg_return *)namedArg; 
- (STParser_list_return *)list; 
- (STParser_listElement_return *)listElement; 


@end /* end of STParser interface */
/** Build an AST from a single StringTemplate template */