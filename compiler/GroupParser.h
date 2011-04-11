// $ANTLR 3.3.1-SNAPSHOT Mar 09, 2011 24:00:43 /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g 2011-03-30 13:18:01

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

/*
 * [The "BSD license"]
 *  Copyright (c) 2011 Terence Parr and Alan Condit
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions
 *  are met:
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  3. The name of the author may not be used to endorse or promote products
 *     derived from this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 *  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 *  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 *  NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
#define T__13 13
#define T__14 14
#define T__15 15
#define T__16 16
#define T__17 17
#define T__18 18
#define T__19 19
#define T__20 20
#define T__21 21
#define T__22 22
#define T__23 23
#define T__24 24
#define T__25 25
#define T__26 26
#define T__27 27
#define ID 4
#define WS 5
#define STRING 6
#define ANONYMOUS_TEMPLATE 7
#define COMMENT 8
#define LINE_COMMENT 9
#define T_BIGSTRING 10
#define T_BIGSTRING_NO_NL 11
#define T_TRUE 12
#define T_FALSE 13
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

/* ObjC start of actions.(actionScope).properties */

@property (retain) STGroup *group;

/* ObjC end of actions.(actionScope).properties */
/* ObjC start of properties */
/* ObjC end of properties */

+ (void) initialize;
+ (id) newGroupParser:(id<ANTLRTokenStream>)aStream;
/* ObjC start of actions.(actionScope).methodsDecl */

+ (NSInteger) TBIGSTRING;
+ (NSInteger) TBIGSTRING_NO_NL;
+ (NSInteger) TTRUE;
- (void) displayRecognitionError:(AMutableArray *) tokenNames e:(ANTLRRecognitionException *)e;
- (NSString *) getSourceName;
- (void) error:(NSString *)msg;
- (NSString *) getErrorMessage:(NSException *)e TokenNames:(AMutableArray *)TokenNames;

/* ObjC end of actions.(actionScope).methodsDecl */

/* ObjC start of methodsDecl */
/* ObjC end of methodsDecl */

- (void)group:(STGroup *)aGroup arg1:(NSString *)prefix ; 
- (void)oldStyleHeader; 
- (NSString *)groupName; 
- (void)def:(NSString *)prefix ; 
- (void)templateDef:(NSString *)prefix ; 
- (AMutableArray *)formalArgs; 
- (void)formalArg:(AMutableArray *)args ; 
- (void)formalArgWithDefaultValue:(AMutableArray *)args ; 
- (void)dictDef; 
- (NSMutableDictionary *)dict; 
- (void)dictPairs:(NSMutableDictionary *)mapping ; 
- (void)defaultValuePair:(NSMutableDictionary *)mapping ; 
- (void)keyValuePair:(NSMutableDictionary *)mapping ; 
- (id)keyValue; 


@end /* end of GroupParser interface */
