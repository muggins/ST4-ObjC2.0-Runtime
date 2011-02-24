// $ANTLR 3.3.1-SNAPSHOT Feb 05, 2011 11:06:56 /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/t.g 2011-02-05 13:16:12

/* =============================================================================
 * Standard antlr3 OBJC runtime definitions
 */
#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLR.h>
/* End of standard antlr3 runtime definitions
 * =============================================================================
 */

/* parserHeaderFile */

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
#define A 4
#pragma mark Dynamic Global Scopes
#pragma mark Dynamic Rule Scopes
#pragma mark Rule Return Scopes start
#pragma mark Rule return scopes end
@interface tParser : ANTLRParser { /* line 572 */
/* ObjC start of globalAttributeScopeMemVar */


/* ObjC start of actions.(actionScope).memVars */
/* ObjC end of actions.(actionScope).memVars */
/* ObjC start of ruleAttributeScopeMemVar */


/* ObjC start of memVars */
/* ObjC end of memVars */

 }

+ (id) newtParser:(id<ANTLRTreeNodeStream>)aStream;
/* ObjC start of actions.(actionScope).methodsDecl */
/* ObjC end of actions.(actionScope).methodsDecl */

/* ObjC start of methodsDecl */
/* ObjC end of methodsDecl */

- (void)a; 


@end /* end of tParser interface */
