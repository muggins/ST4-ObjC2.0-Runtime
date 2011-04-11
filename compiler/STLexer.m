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
#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLR.h>
#import "STErrorListener.h"
#import "STToken.h"
#import "STLexer.h"
#import "STException.h"
#import "STParser.h"
#import "AMutableArray.h"

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
#define ID 4
#define WS 5
#define STRING 6
#define ANONYMOUS_TEMPLATE 7
#define COMMENT 8
#define LINE_COMMENT 9
#define BIGSTRING 10
#define T_FALSE 11
#define T_TRUE 12
#define IF 13
#define ELSE 14
#define ELSEIF 15
#define ENDIF 16
#define SUPER 17
#define SEMI 18
#define BANG 19
#define ELLIPSIS 20
#define EQUALS 21
#define COLON 22
#define LPAREN 23
#define RPAREN 24
#define LBRACK 25
#define RBRACK 26
#define COMMA 27
#define DOT 28
#define LCURLY 29
//#define RCURLY 30
#define TEXT 31
//#define LDELIM 32
#define RDELIM 33
#define PIPE 34
#define OR 35
#define AND 36
#define INDENT 37
#define NEWLINE 38
#define AT 39
#define REGION_END 40
#define EXPR 41
#define OPTIONS 42
#define PROP 43
#define PROP_IND 44
#define INCLUDE 45
#define INCLUDE_IND 46
#define EXEC_FUNC 47
#define INCLUDE_SUPER 48
#define INCLUDE_SUPER_REGION 49
#define INCLUDE_REGION 50
#define TO_STR 51
#define LIST 52
#define MAP 53
#define ZIP 54
#define SUBTEMPLATE 55
#define ARGS 56
#define ELEMENTS 57
#define REGION 58
#define T_NULL 59
#define INDENTED_EXPR 60

@implementation STLexer

static STToken *SKIP;
static char Token_EOF = (char)-1;            // EOF char
static NSInteger EOF_TYPE = ANTLRTokenTypeEOF;  // EOF token type
static NSInteger RCURLY = 30;
static NSInteger LDELIM = 32;

+ (NSInteger) LDELIM
{
    return LDELIM;
}

+ (NSInteger) RCURLY
{
    return RCURLY;
}

+ (STToken *) SKIP
{
    return SKIP;
}

+ (char) Token_EOF
{
    return (char)Token_EOF;
}

+ (NSInteger) EOF_TYPE
{
    return EOF_TYPE;
}

+ (NSString *) str:(NSInteger)aChar {
    if (aChar == (unichar) ANTLRTokenTypeEOF)
        return @"<EOF>";
    return [NSString stringWithFormat:@"\\u%4x", (unichar)aChar];
//    return [NSString stringWithFormat:@"%c", aChar];
}

+ (void) initialize
{
    SKIP = [[STToken alloc] init:-1 text:@"<skip>"];
}

+ (id) newSTLexer:(id<ANTLRCharStream>)anInput
{
    return [[STLexer alloc] initWithInput:anInput];
}

+ (id) newSTLexer:(ErrorManager *)anErrMgr
            input:(id<ANTLRCharStream>)anInput
    templateToken:(STToken *)aTemplateToken
{
    return [[STLexer alloc] init:anErrMgr input:anInput templateToken:aTemplateToken];
}

+ (id) newSTLexer:(ErrorManager *)anErrMgr
            input:(id<ANTLRCharStream>)anInput
    templateToken:(STToken *)aTemplateToken
delimiterStartChar:(unichar)aStartChar
delimiterStopChar:(unichar)aStopChar
{
    return [[STLexer alloc] init:anErrMgr input:anInput templateToken:aTemplateToken delimiterStartChar:aStartChar delimiterStopChar:aStopChar];
}

- (id) initWithInput:(id<ANTLRCharStream>)anInput
{
    self=[super init];
    if ( self != nil ) {
        delimiterStartChar = '<';
        delimiterStopChar = '>';
        scanningInsideExpr = NO;
        subtemplateDepth = 0;
        tokens = [AMutableArray arrayWithCapacity:16];
        errMgr = STGroup.DEFAULT_ERR_MGR;
        input = anInput;
        c = (unichar)[input LA:1];
        templateToken = nil;
    }
    return self;
}

- (id) init:(ErrorManager *)anErrMgr input:(id<ANTLRCharStream>)anInput templateToken:(STToken *)aTemplateToken
{
    self=[super init];
    if ( self != nil ) {
        delimiterStartChar = '<';
        delimiterStopChar = '>';
        scanningInsideExpr = NO;
        subtemplateDepth = 0;
        tokens = [AMutableArray arrayWithCapacity:16];
        errMgr = anErrMgr;
        input = anInput;
        c = (unichar)[input LA:1];
        templateToken = aTemplateToken;
    }
    return self;
}

- (id) init:(ErrorManager *)anErrMgr input:(id<ANTLRCharStream>)anInput templateToken:(STToken *)aTemplateToken delimiterStartChar:(unichar)aStartChar delimiterStopChar:(unichar)aStopChar
{
    self=[super init];
    if ( self != nil ) {
        delimiterStartChar = aStartChar;
        delimiterStopChar = aStopChar;
        scanningInsideExpr = NO;
        subtemplateDepth = 0;
        tokens = [AMutableArray arrayWithCapacity:16];
        errMgr = anErrMgr;
        input = anInput;
        c = (unichar)[input LA:1];
        templateToken = aTemplateToken;
    }
    return self;
}


/**
 * Ensure x is next character on the input stream
 */
- (void) match:(unichar)x
{
    if (c == x) {
        [self consume];
    }
    else {
        @throw [NSException exceptionWithName:@"No Viable Alt Exception" reason:[NSString stringWithFormat:@"%@: expecting '%c' found '%@'", [input getSourceName], x, [STLexer str:c]] userInfo:nil];
    /*
    NoViableAltException * e = [[[NoViableAltException alloc] init:@"" param1:0 state:0 stream:input] autorelease];
    [errMgr lexerError:[input sourceName] param1:[[[@"expecting '" stringByAppendingString:x] stringByAppendingString:@"', found '"] + [self str:c] stringByAppendingString:@"'"] param2:templateToken param3:e];
     */
    }
}

- (void) consume
{
    [input consume];
    c = (unichar)[input LA:1];
}

- (void) emit:(STToken *)token
{
    [tokens addObject:token];
}

- (STToken *) nextToken
{
    STToken *t = nil;
    if ([tokens count] > 0) {
        t = [tokens objectAtIndex:0];
        [tokens removeObjectAtIndex:0];
        return t;
    }
    else {
        t = [self _nextToken];
    }
    return t;
}

- (STToken *) _nextToken
{
    
    while (YES) {
        startCharIndex = [input getIndex];
        startLine = [input getLine];
        startCharPositionInLine = [input getCharPositionInLine];
        if (c == (unichar) EOF_TYPE)
            return [self newToken:ANTLRTokenTypeEOF];
        STToken *t;
        if (scanningInsideExpr)
            t = [self inside];
        else
            t = [self outside];
        if (t != SKIP)
            return t;
    }
    
}

- (STToken *) outside
{
    if ([input getCharPositionInLine] == 0 && (c == ' ' || c == '\t')) {
        
        while (c == ' ' || c == '\t')
            [self consume];
        
        if (c != (unichar) EOF_TYPE)
            return [self newToken:INDENT];
        return [self newToken:TEXT];
    }
    if (c == delimiterStartChar) {
        [self consume];
        if (c == '!') {
            [self mCOMMENT];
            return SKIP;
        }
        if (c == '\\')
            return [self mESCAPE];
        scanningInsideExpr = YES;
        return [self newToken:LDELIM];
    }
    if (c == '\r') {
        if ([input LA:1] == '\n') [self consume];
        [self consume];
        return [self newToken:NEWLINE];
    }
    if (c == '\n') {
        [self consume];
        return [self newToken:NEWLINE];
    }
    if (c == '}' && subtemplateDepth > 0) {
        scanningInsideExpr = YES;
        subtemplateDepth--;
        [self consume];
        return [self newTokenFromPreviousChar:RCURLY];
    }
    return [self mTEXT];
}

- (STToken *) inside
{
    
    while (YES) {
        
        switch (c) {
            case ' ':
            case '\t':
            case '\n':
            case '\r':
                [self consume];
                return SKIP;
            case '.':
                [self consume];
                if ([input LA:1] == '.' && [input LA:2] == '.') {
                    [self consume];
                    [self match:'.'];
                    return [self newToken:ELLIPSIS];
                }
                return [self newToken:DOT];
            case ',': [self consume]; return [self newToken:COMMA];
            case ':': [self consume]; return [self newToken:COLON];
            case ';': [self consume]; return [self newToken:SEMI];
            case '(': [self consume]; return [self newToken:LPAREN];
            case ')': [self consume]; return [self newToken:RPAREN];
            case '[': [self consume]; return [self newToken:LBRACK];
            case ']': [self consume]; return [self newToken:RBRACK];
            case '=': [self consume]; return [self newToken:EQUALS];
            case '!': [self consume]; return [self newToken:BANG];
            case '@':
                [self consume];
                if (c == 'e' && [input LA:2] == 'n' && [input LA:3] == 'd') {
                    [self consume]; [self consume]; [self consume];
                    return [self newToken:REGION_END];
                }
                return [self newToken:AT];
            case '"':
                return [self mSTRING];
            case '&': [self consume]; [self match:'&']; return [self newToken:AND];
            case '|': [self consume]; [self match:'|']; return [self newToken:OR];
            case '{': return [self subTemplate];
            default:
                if (c == delimiterStopChar) {
                    [self consume];
                    scanningInsideExpr = NO;
                    return [self newToken:RDELIM];
                }
                if ([STLexer isIDStartLetter:c]) {
                    STToken *anID = [self mID];
                    NSString *name = [anID getText];
                    if ([name isEqualToString:@"if"])
                        return [self newToken:IF];
                    else if ([name isEqualToString:@"endif"])
                        return [self newToken:ENDIF];
                    else if ([name isEqualToString:@"else"])
                        return [self newToken:ELSE];
                    else if ([name isEqualToString:@"elseif"])
                        return [self newToken:ELSEIF];
                    else if ([name isEqualToString:@"super"])
                        return [self newToken:SUPER];
                    else if ([name isEqualToString:@"true"])
                        return [self newToken:T_TRUE];
                    else if ([name isEqualToString:@"false"])
                        return [self newToken:T_FALSE];
                    return anID;
                }
                ANTLRNoViableAltException *re = [ANTLRNoViableAltException newException:0 state:0 stream:input];
                re.line = startLine;
                re.charPositionInLine = startCharPositionInLine;
                if (c == (unichar)Token_EOF) {
                    @throw [STException newException:[NSString stringWithFormat:@"EOF inside ST expression at %@:%d %@", re.line, re.charPositionInLine, re]];
                }
                [errMgr lexerError:[input getSourceName] msg:[NSString stringWithFormat:@"invalid character '%c'", c] templateToken:templateToken e:re];
                if (c == (unichar)Token_EOF) {
                    return [self newToken:EOF_TYPE];
                }
                [self consume];
        }
    }
    
}

- (STToken *) subTemplate
{
    subtemplateDepth++;
    NSInteger m = [input mark];
    NSInteger curlyStartChar = startCharIndex;
    NSInteger curlyLine = startLine;
    NSInteger curlyPos = startCharPositionInLine;
    AMutableArray *argTokens = [AMutableArray arrayWithCapacity:16];
    [self consume];
    STToken *curly = [self newTokenFromPreviousChar:LCURLY];
    [self mWS];
    [argTokens addObject:[self mID]];
    [self mWS];
    
    while (c == ',') {
        [self consume];
        [argTokens addObject:[self newTokenFromPreviousChar:COMMA]];
        [self mWS];
        [argTokens addObject:[self mID]];
        [self mWS];
    }
    
    [self mWS];
    if (c == '|') {
        [self consume];
        [argTokens addObject:[self newTokenFromPreviousChar:PIPE]];
        if ([STLexer isWS:c])
            [self consume];
        
        for (STToken *t in argTokens)
            [self emit:t];
        
        [input release:m];
        scanningInsideExpr = NO;
        startCharIndex = curlyStartChar;
        startLine = curlyLine;
        startCharPositionInLine = curlyPos;
        return curly;
    }
    [input rewind:m];
    startCharIndex = curlyStartChar;
    startLine = curlyLine;
    startCharPositionInLine = curlyPos;
    [self consume];
    scanningInsideExpr = NO;
    return curly;
}

- (STToken *) mESCAPE
{
    startCharIndex = [input getIndex];
    startCharPositionInLine = [input getCharPositionInLine];
    [self consume];
    if (c == 'u') return [self mUNICODE];
    NSString *text = nil;
    ANTLRNoViableAltException *e;
    
    switch (c) {
        case '\\': [self mLINEBREAK]; return SKIP;
        case 'n': text = @"\n"; break;
        case 't': text = @"\t"; break;
        case ' ': text = @" "; break;
        default:
            e = [ANTLRNoViableAltException newException:0 state:0 stream:input];
            [errMgr lexerError:[input getSourceName] msg:[NSString stringWithFormat:@"invalid escaped char: '%c'", c] templateToken:templateToken e:e];
            [self consume];
            [self match:delimiterStopChar];
            return SKIP;
    }
    [self consume];
    STToken *t = [self newToken:TEXT text:text pos:[input getCharPositionInLine]-2];
    [self match:delimiterStopChar];
    return t;
}

- (STToken *) mUNICODE
{
    [self consume];
    char chars[5];
    if (![STLexer isUnicodeLetter:c]) {
        ANTLRNoViableAltException *e = [ANTLRNoViableAltException newException:0 state:0 stream:input];
        [errMgr lexerError:[input getSourceName] msg:[NSString stringWithFormat:@"invalid unicode char: '%c'", c] templateToken:templateToken e:e];
    }
    chars[0] = c;
    [self consume];
    if (![STLexer isUnicodeLetter:c]) {
        ANTLRNoViableAltException *e = [ANTLRNoViableAltException newException:0 state:0 stream:input];
        [errMgr lexerError:[input getSourceName] msg:[NSString stringWithFormat:@"invalid unicode char: '%c'", c] templateToken:templateToken e:e];
    }
    chars[1] = c;
    [self consume];
    if (![STLexer isUnicodeLetter:c]) {
        ANTLRNoViableAltException *e = [ANTLRNoViableAltException newException:0 state:0 stream:input];
        [errMgr lexerError:[input getSourceName] msg:[NSString stringWithFormat:@"invalid unicode char: '%c'", c] templateToken:templateToken e:e];
    }
    chars[2] = c;
    [self consume];
    if (![STLexer isUnicodeLetter:c]) {
        ANTLRNoViableAltException *e = [ANTLRNoViableAltException newException:0 state:0 stream:input];
        [errMgr lexerError:[input getSourceName] msg:[NSString stringWithFormat:@"invalid unicode char: '%c'", c] templateToken:templateToken e:e];
    }
    chars[3] = c;
    chars[4] = '\0';
        // ESCAPE kills >
        //NSString *utext = [NSString stringWithCString:chars encoding:NSASCIIStringEncoding];
    unichar uc = (unichar)[[NSString stringWithCString:chars encoding:NSASCIIStringEncoding] intValue];
    STToken *t = [self newToken:TEXT text:[NSString stringWithFormat:@"%4x", uc] pos:[input getCharPositionInLine]-6];
    [self consume];
    [self match:delimiterStopChar];
    return t;
}

- (STToken *) mTEXT
{
    BOOL modifiedText = NO;
    NSMutableString *buf = [NSMutableString stringWithCapacity:16];
    
    while (c != (unichar) EOF_TYPE && c != delimiterStartChar) {
        if (c == '\r' || c == '\n') break;
        if (c == '}' && subtemplateDepth > 0) break;
        if (c == '\\') {
            if ([input LA:2] == '\\') {
                [self consume]; [self consume]; [buf appendFormat:@"%c", '\\'];
                modifiedText = YES;
                continue;
            }
            if ([input LA:2] == delimiterStartChar || [input LA:2] == '}') {
                modifiedText = YES;
                [self consume];
                [buf appendFormat:@"%c", c];
                [self consume];
            }
            else {
                [buf appendFormat:@"%c", c];
                [self consume];
            }
            continue;
        }
        [buf appendFormat:@"%c", c];
        [self consume];
    }
    
    if (modifiedText)
        return [self newToken:TEXT text:buf];
    else
        return [self newToken:TEXT];
}


/**
 * ID  :   ('a'..'z'|'A'..'Z'|'_'|'/') ('a'..'z'|'A'..'Z'|'0'..'9'|'_'|'/')* ;
 */
- (STToken *) mID
{
    startCharIndex = [input getIndex];
    startLine = [input getLine];
    startCharPositionInLine = [input getCharPositionInLine];
    [self consume];
    while ([STLexer isIDLetter:c]) {
        [self consume];
    }
    return [self newToken:ID];
}


/**
 * STRING : '"' ( '\\' '"' | '\\' ~'"' | ~('\\'|'"') )* '"' ;
 */
- (STToken *) mSTRING
{
    BOOL sawEscape = NO;
    NSMutableString *buf = [NSMutableString stringWithCapacity:16];
    [buf appendFormat:@"%c", c];
    [self consume];
    
    while (c != '"') {
        if (c == '\\') {
            sawEscape = YES;
            [self consume];
            
            switch (c) {
                case 'n': [buf appendFormat:@"%c", '\n']; break;
                case 'r': [buf appendFormat:@"%c", '\r']; break;
                case 't': [buf appendFormat:@"%c", '\t']; break;
                default:
                    [buf appendFormat:@"%c", c]; break;
            }
            [self consume];
            continue;
        }
        [buf appendFormat:@"%c", c];
        [self consume];
        if (c == (unichar) EOF_TYPE) {
            ANTLRRecognitionException *re = [ANTLRMismatchedTokenException newException:'"' Stream:input];
            re.line = [input getLine];
            re.charPositionInLine = [input getCharPositionInLine];
            [errMgr lexerError:[input getSourceName] msg:@"EOF in string" templateToken:templateToken e:re];
        }
    }
    [buf appendFormat:@"%c", c];
    [self consume];
    if (sawEscape)
        return [self newToken:STRING text:buf];
    else
        return [self newToken:STRING];
}

- (void) mWS
{
    while (c == ' ' || c == '\t' || c == '\n' || c == '\r')
        [self consume];
}

- (void) mCOMMENT
{
    [self match:'!'];
    while (!(c == '!' && [input LA:2] == delimiterStopChar)) {
        if (c == (unichar)EOF) {
            ANTLRRecognitionException *re = [ANTLRMismatchedTokenException newException:(NSInteger)'!' Stream:input];
            re.line = [input getLine];
            re.charPositionInLine = [input getCharPositionInLine];
            [errMgr lexerError:[input getSourceName] msg:[NSString stringWithFormat:@"Nonterminated comment starting at %d:%d: '!%c' missing", startLine, startCharPositionInLine, delimiterStopChar] templateToken:templateToken e:re];
        break;
        }
        [self consume];
    }
    [self consume];
    [self consume];
}

- (void) mLINEBREAK
{
    [self match:'\\'];
    [self match:delimiterStopChar];
    while (c == ' ' || c == '\t')
        [self consume];
    if (c == '\r') [self consume];
    if (c == '\n') [self match:'\n'];
    while (c == ' ' || c == '\t') [self consume];
}

+ (BOOL) isIDStartLetter:(unichar)c
{
    return c >= 'a' && c <= 'z' || c >= 'A' && c <= 'Z' || c == '_';
}

+ (BOOL) isIDLetter:(unichar)c
{
    return c >= 'a' && c <= 'z' || c >= 'A' && c <= 'Z' || c >= '0' && c <= '9' || c == '_' || c == '/';
}

+ (BOOL) isWS:(unichar)c
{
    return c == ' ' || c == '\t' || c == '\n' || c == '\r';
}

+ (BOOL) isUnicodeLetter:(unichar)c
{
    return c >= 'a' && c <= 'f' || c >= 'A' && c <= 'F' || c >= '0' && c <= '9';
}

- (STToken *) newToken:(NSInteger)ttype
{
    STToken *t = [[STToken newToken:input type:ttype start:startCharIndex stop:[input getIndex]-1] retain];
    [t setLine:startLine];
    [t setCharPositionInLine:startCharPositionInLine];
    return t;
}

- (STToken *) newTokenFromPreviousChar:(NSInteger)ttype
{
    STToken *t = [[STToken newToken:input type:ttype start:[input getIndex]-1 stop:[input getIndex]-1] retain];
    [t setLine:[input getLine]];
    [t setCharPositionInLine:[input getCharPositionInLine]-1];
    return t;
}

- (STToken *) newToken:(NSInteger)ttype text:(NSString *)text pos:(NSInteger)pos
{
    STToken *t = [[STToken newToken:ttype text:text] retain];
    [t setLine:[input getLine]];
    [t setCharPositionInLine:pos];
    return t;
}

- (STToken *) newToken:(NSInteger)ttype text:(NSString *)text
{
    STToken *t = [[STToken newToken:ttype text:text] retain];
    [t setStart:startCharIndex];
    [t setStop:[input getIndex] - 1];
    [t setLine:startLine];
    [t setCharPositionInLine:startCharPositionInLine];
    return t;
}

- (NSString *) errorHeader
{
    return [NSString stringWithFormat:@"%d:%d", startLine, startCharPositionInLine];
}

- (void) dealloc
{
    [errMgr release];
    [templateToken release];
    [input release];
    [tokens release];
    [super dealloc];
}

- (NSString *) getSourceName
{
    return @"no idea";
}

- (id) copyWithZone:(NSZone *)aZone
{
    return self;
}

@synthesize delimiterStartChar;
@synthesize delimiterStopChar;
@synthesize scanningInsideExpr;
@synthesize subtemplateDepth;
@synthesize errMgr;
@synthesize templateToken;
@synthesize input;
@synthesize c;
@synthesize startCharIndex;
@synthesize startLine;
@synthesize startCharPositionInLine;
@synthesize tokens;
//@synthesize errorHeader;
//@synthesize sourceName;

@end
