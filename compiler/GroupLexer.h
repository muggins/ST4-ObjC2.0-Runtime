// $ANTLR 3.3.1-SNAPSHOT Feb 24, 2011 11:25:29 /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g 2011-02-24 11:32:43

/* =============================================================================
 * Standard antlr3 OBJC runtime definitions
 */
#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLR.h>
/* End of standard antlr3 runtime definitions
 * =============================================================================
 */


/* =============================================================================
 * This is what the grammar programmer asked us to put at the top of every file.
 */

#import "STGroup.h"
#import "ErrorType.h"
#import "STLexer.h"

/* End of Header action.
 * =============================================================================
 */
/* Start cyclicDFAInterface */
#pragma mark Cyclic DFA interface start DFA7
@interface DFA7 : ANTLRDFA {
}
+ newDFA7WithRecognizer:(ANTLRBaseRecognizer *)theRecognizer;
- initWithRecognizer:(ANTLRBaseRecognizer *)recognizer;
@end /* end of DFA7 interface  */

#pragma mark Cyclic DFA interface end DFA7


#pragma mark Rule return scopes start
#pragma mark Rule return scopes end
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
/* interface lexer class */
@interface GroupLexer : ANTLRLexer { // line 283
DFA7 *dfa7;
/* ObjC start of actions.lexer.memVars */

STGroup *group;

/* ObjC end of actions.lexer.memVars */
}
+ (GroupLexer *)newGroupLexerWithCharStream:(id<ANTLRCharStream>)anInput;
/* ObjC start actions.lexer.methodsDecl */

@property (retain, getter=getGroup, setter=setGroup:) STGroup *group;

- (void) reportError:(ANTLRRecognitionException *)e;
- (NSString *) getSourceName;

/* ObjC end actions.lexer.methodsDecl */
- (void)
mT__38
; 
- (void)
mT__39
; 
- (void)
mT__40
; 
- (void)
mID
; 
- (void)
mSTRING
; 
- (void)
mBIGSTRING
; 
- (void)
mANONYMOUS_TEMPLATE
; 
- (void)
mCOMMENT
; 
- (void)
mLINE_COMMENT
; 
- (void)
mWS
; 
- (void)
mTokens
; 

@end /* end of GroupLexer interface */
