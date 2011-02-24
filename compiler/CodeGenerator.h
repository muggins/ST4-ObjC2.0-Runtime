// $ANTLR 3.3.1-SNAPSHOT Feb 24, 2011 11:25:29 /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g 2011-02-24 11:32:12

/* =============================================================================
 * Standard antlr3 OBJC runtime definitions
 */
#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLR.h>
/* End of standard antlr3 runtime definitions
 * =============================================================================
 */

/* treeParserHeaderFile */
/* =============================================================================
 * This is what the grammar programmer asked us to put at the top of every file.
 */

#import "Compiler.h"
#import "CompiledST.h"
#import "CompilationState.h"
#import "ErrorManager.h"
//#import "ErrorType.h"
#import "Bytecode.h"
//#import "STLexer.h"
//#import "Misc.h"
//#import "GroupLexer.h"
//#import "FormalArgument.h"

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
/* start of ruleAttributeScopeInterface */

@interface template_Scope : ANTLRSymbolsScope {
    CompilationState * state;

}

/* start properties */

@property (assign, getter=getstate, setter=setstate:) CompilationState * state;

/* end properties */

+ (template_Scope *)newtemplate_Scope;
- (id) init;
- (CompilationState *)getstate;
- (void)setstate:(CompilationState *)aVal;


@end /* end of ruleAttributeScopeInterface */

#pragma mark Rule Return Scopes start
/* returnScopeInterface CodeGenerator_region_return */
@interface CodeGenerator_region_return :ANTLRTreeRuleReturnScope { /* returnScopeInterface line 1838 */
 /* ObjC start of memVars() */
NSString * name;
}
/* start properties */
@property (assign, getter=getname, setter=setname:) NSString * name;

/* end properties */
+ (CodeGenerator_region_return *)newCodeGenerator_region_return;
/* this is start of set and get methods */
  /* methodsDecl */
/* start of iterated get and set functions */

- (NSString *)getname;
- (void)setname:(NSString *)aVal;


/* End of iterated get and set functions */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface CodeGenerator_subtemplate_return */
@interface CodeGenerator_subtemplate_return :ANTLRTreeRuleReturnScope { /* returnScopeInterface line 1838 */
 /* ObjC start of memVars() */
NSString * name;

NSInteger nargs;
}
/* start properties */
@property (assign, getter=getname, setter=setname:) NSString * name;

@property (assign, getter=getnargs, setter=setnargs:) NSInteger nargs;

/* end properties */
+ (CodeGenerator_subtemplate_return *)newCodeGenerator_subtemplate_return;
/* this is start of set and get methods */
  /* methodsDecl */
/* start of iterated get and set functions */

- (NSString *)getname;
- (void)setname:(NSString *)aVal;


- (NSInteger)getnargs;
- (void)setnargs:(NSInteger)aVal;


/* End of iterated get and set functions */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface CodeGenerator_conditional_return */
@interface CodeGenerator_conditional_return :ANTLRTreeRuleReturnScope { /* returnScopeInterface line 1838 */
 /* ObjC start of memVars() */
}
/* start properties */
+ (CodeGenerator_conditional_return *)newCodeGenerator_conditional_return;
/* this is start of set and get methods */
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface CodeGenerator_primary_return */
@interface CodeGenerator_primary_return :ANTLRTreeRuleReturnScope { /* returnScopeInterface line 1838 */
 /* ObjC start of memVars() */
}
/* start properties */
+ (CodeGenerator_primary_return *)newCodeGenerator_primary_return;
/* this is start of set and get methods */
  /* methodsDecl */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface CodeGenerator_args_return */
@interface CodeGenerator_args_return :ANTLRTreeRuleReturnScope { /* returnScopeInterface line 1838 */
 /* ObjC start of memVars() */
NSInteger n;

BOOL namedArgs;
}
/* start properties */
@property (assign, getter=getn, setter=setn:) NSInteger n;

@property (assign, getter=getnamedArgs, setter=setnamedArgs:) BOOL namedArgs;

/* end properties */
+ (CodeGenerator_args_return *)newCodeGenerator_args_return;
/* this is start of set and get methods */
  /* methodsDecl */
/* start of iterated get and set functions */

- (NSInteger)getn;
- (void)setn:(NSInteger)aVal;


- (BOOL)getnamedArgs;
- (void)setnamedArgs:(BOOL)aVal;


/* End of iterated get and set functions */
@end /* end of returnScopeInterface interface */

/* returnScopeInterface CodeGenerator_listElement_return */
@interface CodeGenerator_listElement_return :ANTLRTreeRuleReturnScope { /* returnScopeInterface line 1838 */
 /* ObjC start of memVars() */
}
/* start properties */
+ (CodeGenerator_listElement_return *)newCodeGenerator_listElement_return;
/* this is start of set and get methods */
  /* methodsDecl */
@end /* end of returnScopeInterface interface */



/* Interface grammar class */
@interface CodeGenerator : ANTLRTreeParser { /* line 572 */
/* ObjC start of ruleAttributeScopeMemVar */
/* ruleAttributeScopeMemVar */

template_Scope *template_scope;

/* ObjC end of ruleAttributeScopeMemVar */
/* ObjC start of globalAttributeScopeMemVar */


/* ObjC end of globalAttributeScopeMemVar */
/* ObjC start of actions.(actionScope).memVars */

	NSString *outermostTemplateName;	// name of overall template
	CompiledST *outermostImpl;
	ANTLRCommonToken *templateToken;			// overall template token
	NSString *template;  				// overall template text
	ErrorManager *errMgr;

/* ObjC end of actions.(actionScope).memVars */
/* ObjC start of memVars */
/* ObjC end of memVars */

 }

/* ObjC start of globalAttributeScopeMemVar */
// 

/* ObjC start of actions.(actionScope).properties */

	@property(retain, getter=getOutermostTemplateName, setter=setOutermostTemplateName:) NSString *outermostTemplateName; // name of overall template
	@property(retain, getter=getOutermostImpl, setter=setOutermostImpl:) CompiledST *outermostImpl;
	@property(retain, getter=getTemplateToken, setter=setTemplateToken:) ANTLRCommonToken *templateToken;// overall template token
	@property(retain, getter=getTemplate, setter=setTemplate:) NSString *template; // overall template text
	@property(retain, getter=getErrMgr, setter=setErrMgr:) ErrorManager *errMgr;

/* ObjC end of actions.(actionScope).properties */
/* ObjC start of properties */
/* ObjC end of properties */

+ (id) newCodeGenerator:(id<ANTLRTreeNodeStream>)aStream;
/* ObjC start of actions.(actionScope).methodsDecl */

+ (id) newCodeGenerator:(id<ANTLRTreeNodeStream>)input
                 errMgr:(ErrorManager *)anErrMgr
                   name:(NSString *)aName
               template:(NSString *)aTemplate
                  token:(ANTLRCommonToken *)aTemplateToken;

- (id) init:(id<ANTLRTreeNodeStream>)input
                     errMgr:(ErrorManager *)anErrMgr
                   name:(NSString *)aName
               template:(NSString *)aTemplate
                  token:(ANTLRCommonToken *)aTemplateToken;

// convience funcs to hide offensive sending of emit messages to
// CompilationState temp data object.

- (void) emit:(short)anOpcode;
- (void) emit:(ANTLRCommonTree *)opAST opcode:(short)anOpcode;
- (void) emit1:(ANTLRCommonTree *)opAST opcode:(short)anOpcode arg:(NSInteger)arg;
- (void) emit1:(ANTLRCommonTree *)opAST opcode:(short)anOpcode s:(NSString *)arg;
- (void) emit2:(ANTLRCommonTree *)opAST opcode:(short)anOpcode arg:(NSInteger)anArg arg2:(NSInteger)anArg2;
- (void) emit2:(ANTLRCommonTree *)opAST opcode:(short)anOpcode s:(NSString *)s arg2:(NSInteger)anArg;
- (void) insert:(NSInteger)addr opcode:(short)anOpcode s:(NSString *)s;
- (void) setOption:(ANTLRCommonTree *)anID;
- (void) write:(NSInteger)addr value:(short)value;
- (NSInteger) address;
- (void) func:(ANTLRCommonTree *)aTree;
- (void) refAttr:(ANTLRCommonTree *)aTree;
- (NSInteger) defineString:(NSString *)s;

/* ObjC end of actions.(actionScope).methodsDecl */

/* ObjC start of methodsDecl */
/* ObjC end of methodsDecl */

- (void)templateAndEOF; 
- (CompiledST *)template:(NSString *)name arg1:(NSMutableArray *)args ; 
- (void)chunk; 
- (void)element; 
- (void)exprElement; 
- (CodeGenerator_region_return *)region; 
- (CodeGenerator_subtemplate_return *)subtemplate; 
- (void)ifstat; 
- (CodeGenerator_conditional_return *)conditional; 
- (void)exprOptions; 
- (void)option; 
- (void)expr; 
- (void)prop; 
- (void)mapTemplateRef:(NSInteger)num_exprs ; 
- (void)includeExpr; 
- (CodeGenerator_primary_return *)primary; 
- (void)arg; 
- (CodeGenerator_args_return *)args; 
- (void)list; 
- (CodeGenerator_listElement_return *)listElement; 


@end /* end of CodeGenerator interface */
