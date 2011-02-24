// $ANTLR 3.3.1-SNAPSHOT Feb 24, 2011 11:25:29 /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g 2011-02-24 11:32:43

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

#import "STGroup.h"
#import "ErrorType.h"
#import "STLexer.h"
#import "Misc.h"
#import "GroupLexer.h"
#import "FormalArgument.h"

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
#define T__38 38
#define T__39 39
#define T__40 40
#define BIGSTRING 35
#define ANONYMOUS_TEMPLATE 20
#define COMMENT 36
#define LINE_COMMENT 37
#pragma mark Dynamic Global Scopes
#pragma mark Dynamic Rule Scopes
#pragma mark Rule Return Scopes start

/* Interface grammar class */
@interface GroupParser : ANTLRParser { /* line 572 */
/* ObjC start of ruleAttributeScopeMemVar */


/* ObjC end of ruleAttributeScopeMemVar */
/* ObjC start of globalAttributeScopeMemVar */


/* ObjC end of globalAttributeScopeMemVar */
/* ObjC start of actions.(actionScope).memVars */

STGroup *group;

/* ObjC end of actions.(actionScope).memVars */
/* ObjC start of memVars */
/* ObjC end of memVars */

 }

/* ObjC start of globalAttributeScopeMemVar */
// 

/* ObjC start of actions.(actionScope).properties */

@property (retain, getter=getGroup, setter=setGroup:) STGroup *group;

/* ObjC end of actions.(actionScope).properties */
/* ObjC start of properties */
/* ObjC end of properties */

+ (id) newGroupParser:(id<ANTLRTokenStream>)aStream;
/* ObjC start of actions.(actionScope).methodsDecl */

- (void) displayRecognitionError:(NSMutableArray *) tokenNames e:(ANTLRRecognitionException *)e;
- (NSString *) getSourceName;
- (void) error:(NSString *)msg;
- (NSString *) getErrorMessage:(NSException *)e TokenNames:(NSArray *)TokenNames;

/* ObjC end of actions.(actionScope).methodsDecl */

/* ObjC start of methodsDecl */
/* ObjC end of methodsDecl */

- (void)group:(STGroup *)aGroup arg1:(NSString *)prefix ; 
- (NSString *)groupName; 
- (void)def:(NSString *)prefix ; 
- (void)templateDef:(NSString *)prefix ; 
- (NSMutableArray *)formalArgs; 
- (void)formalArg:(NSMutableArray *)args ; 
- (void)formalArgWithDefaultValue:(NSMutableArray *)args ; 
- (void)dictDef; 
- (NSMutableDictionary *)dict; 
- (void)dictPairs:(NSMutableDictionary *)mapping ; 
- (void)defaultValuePair:(NSMutableDictionary *)mapping ; 
- (void)keyValuePair:(NSMutableDictionary *)mapping ; 
- (id)keyValue; 


@end /* end of GroupParser interface */
