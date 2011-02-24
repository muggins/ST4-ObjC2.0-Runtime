#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLR.h>
#import "STLexer.h"
#import "STException.h"
#import "STParser.h"

@implementation STToken

+ (id) newToken:(id<ANTLRCharStream>)input type:(NSInteger)aType start:(NSInteger)aStart stop:(NSInteger)aStop
{
    return [[STToken alloc] initWithInput:input type:aType start:aStart stop:aStop];
}

+ (id) newToken:(NSInteger)aType text:(NSString *)theText
{
    return [[STToken alloc] init:aType text:theText];
}

- (id) init:(NSInteger)aType text:(NSString *)aText {
    if (self = [super initWithType:aType Text:aText]) {
    }
    return self;
}

- (id) initWithInput:(id<ANTLRCharStream>)anInput type:(NSInteger)aType start:(NSInteger)aStart stop:(NSInteger)aStop {
    if (self = [super initWithInput:anInput Type:aType Channel:ANTLRTokenChannelDefault Start:aStart Stop:aStop]) {
    }
    return self;
}

- (NSString *) description {
    NSString *channelStr = @"";
    if (channel > 0) {
        channelStr = [NSString stringWithFormat:@",channel=%d", channel];
    }
    NSString *txt = [self getText];
    if (txt != nil)
        txt = [Misc replaceEscapes:txt];
    else
        txt = @"<no text>";
    return [NSString stringWithFormat:@"[@%d, %d:%d='%@',<%@>%@,%d:%d]", [self getTokenIndex], startIndex, stopIndex, txt, [[STParser getTokenNames] objectAtIndex:type], channelStr, line, charPositionInLine];
}

@end

@implementation STLexer

static ANTLRCommonToken *SKIP;
static char Token_EOF = (char)-1;            // EOF char
static NSInteger EOF_TYPE = ANTLRTokenTypeEOF;  // EOF token type

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
+ (ANTLRCommonToken *) SKIP
{
    return SKIP;
}

+ (char) Token_EOF
{
    return Token_EOF;
}

+ (NSInteger) EOF_TYPE
{
    return EOF_TYPE;
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
    templateToken:(ANTLRCommonToken *)aTemplateToken
{
    return [[STLexer alloc] init:anErrMgr input:anInput templateToken:aTemplateToken];
}

+ (id) newSTLexer:(ErrorManager *)anErrMgr
            input:(id<ANTLRCharStream>)anInput
    templateToken:(ANTLRCommonToken *)aTemplateToken
delimiterStartChar:(unichar)aStartChar
delimiterStopChar:(unichar)aStopChar
{
    return [[STLexer alloc] init:anErrMgr input:anInput templateToken:aTemplateToken delimiterStartChar:aStartChar delimiterStopChar:aStopChar];
}

- (ANTLRCommonToken *) nextToken {
    ANTLRCommonToken *aTok;
    if ([tokens count] > 0) {
        aTok = [tokens objectAtIndex:0];
        [tokens removeObjectAtIndex:0];
        return aTok;
    }
    return [self _nextToken];
}

- (id) initWithInput:(id<ANTLRCharStream>)anInput
{
    if (self = [super init]) {
        delimiterStartChar = '<';
        delimiterStopChar = '>';
        scanningInsideExpr = NO;
        subtemplateDepth = 0;
        tokens = [NSMutableArray arrayWithCapacity:16];
        errMgr = STGroup.DEFAULT_ERR_MGR;
        input = anInput;
        c = (unichar)[input LA:1];
        templateToken = nil;
    }
    return self;
}

- (id) init:(ErrorManager *)anErrMgr input:(id<ANTLRCharStream>)anInput templateToken:(ANTLRCommonToken *)aTemplateToken
{
    if (self = [super init]) {
        delimiterStartChar = '<';
        delimiterStopChar = '>';
        scanningInsideExpr = NO;
        subtemplateDepth = 0;
        tokens = [NSMutableArray arrayWithCapacity:16];
        errMgr = anErrMgr;
        input = anInput;
        c = (unichar)[input LA:1];
        templateToken = aTemplateToken;
    }
    return self;
}

- (id) init:(ErrorManager *)anErrMgr input:(id<ANTLRCharStream>)anInput templateToken:(ANTLRCommonToken *)aTemplateToken delimiterStartChar:(unichar)aStartChar delimiterStopChar:(unichar)aStopChar
{
    if (self = [super init]) {
        delimiterStartChar = aStartChar;
        delimiterStopChar = aStopChar;
        scanningInsideExpr = NO;
        subtemplateDepth = 0;
        tokens = [NSMutableArray arrayWithCapacity:16];
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
    if (c == x)
        [self consume];
    else
        @throw [NSException exceptionWithName:[NSString stringWithFormat:@"%@: expecting %c; found %c", [input getSourceName], x, c] reason:nil userInfo:nil];
}

- (void) consume
{
    [input consume];
    c = (unichar)[input LA:1];
}

- (void) emit:(ANTLRCommonToken *)token
{
    [tokens addObject:token];
}

- (ANTLRCommonToken *) _nextToken
{
    
    while (YES) {
        startCharIndex = [input getIndex];
        startLine = [input getLine];
        startCharPositionInLine = [input getCharPositionInLine];
        if (c == EOF_TYPE)
            return [self newToken:ANTLRTokenTypeEOF];
        ANTLRCommonToken * t;
        if (scanningInsideExpr)
            t = [self inside];
        else
            t = [self outside];
        if (t != SKIP)
            return t;
    }
    
}

- (ANTLRCommonToken *) outside
{
    if ([input getCharPositionInLine] == 0 && (c == ' ' || c == '\t')) {
        
        while (c == ' ' || c == '\t')
            [self consume];
        
        if (c != EOF_TYPE)
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
        [self consume];
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

- (ANTLRCommonToken *) inside
{
    
    while (YES) {
        
        switch (c) {
            case ' ':
            case '\t':
            case '\n':
            case '\r':
                [self consume];
                continue;
            case '.':
                [self consume];
                if ([input LA:1] == '.' && [input LA:2] == '.') {
                    [self consume];
                    [self match:'.'];
                    return [self newToken:ELLIPSIS];
                }
                return [self newToken:DOT];
            case ',':
                [self consume];
                return [self newToken:COMMA];
            case ':':
                [self consume];
                return [self newToken:COLON];
            case ';':
                [self consume];
                return [self newToken:SEMI];
            case '(':
                [self consume];
                return [self newToken:LPAREN];
            case ')':
                [self consume];
                return [self newToken:RPAREN];
            case '[':
                [self consume];
                return [self newToken:LBRACK];
            case ']':
                [self consume];
                return [self newToken:RBRACK];
            case '=':
                [self consume];
                return [self newToken:EQUALS];
            case '!':
                [self consume];
                return [self newToken:BANG];
            case '@':
                [self consume];
                if (c == 'e' && [input LA:2] == 'n' && [input LA:3] == 'd') {
                    [self consume];
                    [self consume];
                    [self consume];
                    return [self newToken:REGION_END];
                }
                return [self newToken:AT];
            case '"':
                return [self mSTRING];
            case '&':
                [self consume];
                [self match:'&'];
                return [self newToken:AND];
            case '|':
                [self consume];
                [self match:'|'];
                return [self newToken:OR];
            case '{':
                return [self subTemplate];
            default:
                if (c == delimiterStopChar) {
                    [self consume];
                    scanningInsideExpr = NO;
                    return [self newToken:RDELIM];
                }
                if ([STLexer isIDStartLetter:c]) {
                    ANTLRCommonToken *anID = [self mID];
                    NSString * name = [anID getText];
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
                    return anID;
                }
                ANTLRNoViableAltException * re = [ANTLRNoViableAltException newANTLRNoViableAltException:0 state:0 stream:input];
                re.line = startLine;
                re.charPositionInLine = startCharPositionInLine;
                if (c == Token_EOF) {
                    @throw [STException newException:[NSString stringWithFormat:@"EOF inside ST expression at %@:%d %@", re.line, re.charPositionInLine, re]];
                }
                [errMgr lexerError:[input getSourceName] msg:[NSString stringWithFormat:@"invalid character '%c'", c] templateToken:templateToken e:re];
                [self consume];
        }
    }
    
}

- (ANTLRCommonToken *) subTemplate
{
    subtemplateDepth++;
    NSInteger m = [input mark];
    NSInteger curlyStartChar = startCharIndex;
    NSInteger curlyLine = startLine;
    NSInteger curlyPos = startCharPositionInLine;
    NSMutableArray *argTokens = [NSMutableArray arrayWithCapacity:16];
    [self consume];
    ANTLRCommonToken *curly = [self newTokenFromPreviousChar:LCURLY];
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
        
        for (ANTLRCommonToken * t in argTokens)
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

- (ANTLRCommonToken *) mESCAPE
{
    [self consume];
    ANTLRCommonToken * t = nil;
    ANTLRNoViableAltException *e;
    
    switch (c) {
        case '\\':
            [self mLINEBREAK];
            return SKIP;
        case 'n':
            t = [self newToken:TEXT text:@"\n" pos:[input getCharPositionInLine] - 2];
            break;
        case 't':
            t = [self newToken:TEXT text:@"\t" pos:[input getCharPositionInLine] - 2];
            break;
        case ' ':
            t = [self newToken:TEXT text:@" " pos:[input getCharPositionInLine] - 2];
            break;
        case 'u':
            t = [self mUNICODE];
            break;
        default:
            e = [ANTLRNoViableAltException newANTLRNoViableAltException:0 state:0 stream:input];
            [errMgr lexerError:[input getSourceName] msg:[NSString stringWithFormat:@"invalid escaped char: '%c'", c] templateToken:templateToken e:e];
    }
    [self consume];
    [self match:delimiterStopChar];
    return t;
}

- (ANTLRCommonToken *) mUNICODE
{
    [self consume];
    char chars[5];
    if (![STLexer isUnicodeLetter:c]) {
        ANTLRNoViableAltException *e = [ANTLRNoViableAltException newANTLRNoViableAltException:0 state:0 stream:input];
        [errMgr lexerError:[input getSourceName] msg:[NSString stringWithFormat:@"invalid unicode char: '%c'", c] templateToken:templateToken e:e];
    }
    chars[0] = c;
    [self consume];
    if (![STLexer isUnicodeLetter:c]) {
        ANTLRNoViableAltException *e = [ANTLRNoViableAltException newANTLRNoViableAltException:0 state:0 stream:input];
        [errMgr lexerError:[input getSourceName] msg:[NSString stringWithFormat:@"invalid unicode char: '%c'", c] templateToken:templateToken e:e];
    }
    chars[1] = c;
    [self consume];
    if (![STLexer isUnicodeLetter:c]) {
        ANTLRNoViableAltException *e = [ANTLRNoViableAltException newANTLRNoViableAltException:0 state:0 stream:input];
        [errMgr lexerError:[input getSourceName] msg:[NSString stringWithFormat:@"invalid unicode char: '%c'", c] templateToken:templateToken e:e];
    }
    chars[2] = c;
    [self consume];
    if (![STLexer isUnicodeLetter:c]) {
        ANTLRNoViableAltException *e = [ANTLRNoViableAltException newANTLRNoViableAltException:0 state:0 stream:input];
        [errMgr lexerError:[input getSourceName] msg:[NSString stringWithFormat:@"invalid unicode char: '%c'", c] templateToken:templateToken e:e];
    }
    chars[3] = c;
    chars[4] = '\0';
    unichar uc = (unichar)[[NSString stringWithCString:chars encoding:NSASCIIStringEncoding] intValue];
    return [self newToken:TEXT text:[NSString stringWithFormat:@"%c", uc] pos:[input getCharPositionInLine] - 6];
}

- (ANTLRCommonToken *) mTEXT
{
    BOOL modifiedText = NO;
    NSMutableString *buf = [NSMutableString stringWithCapacity:16];
    
    while (c != EOF_TYPE && c != delimiterStartChar) {
        if (c == '\r' || c == '\n')
            break;
        if (c == '}' && subtemplateDepth > 0)
            break;
        if (c == '\\') {
            if ([input LA:2] == '\\') {
                [self consume];
                [self consume];
                [buf appendFormat:@"%c", '\\'];
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
        return [self newToken:TEXT text:[buf description]];
    else
        return [self newToken:TEXT];
}


/**
 * ID  :   ('a'..'z'|'A'..'Z'|'_'|'/') ('a'..'z'|'A'..'Z'|'0'..'9'|'_'|'/')* ;
 */
- (ANTLRCommonToken *) mID
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
- (ANTLRCommonToken *) mSTRING
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
                case 'n':
                    [buf appendFormat:@"%c", '\n'];
                    break;
                case 'r':
                    [buf appendFormat:@"%c", '\r'];
                    break;
                case 't':
                    [buf appendFormat:@"%c", '\t'];
                    break;
                default:
                    [buf appendFormat:@"%c", c];
                    break;
            }
            [self consume];
            continue;
        }
        [buf appendFormat:@"%c", c];
        [self consume];
        if (c == EOF_TYPE) {
            ANTLRRecognitionException *re = [ANTLRMismatchedTokenException newANTLRMismatchedTokenException:'"' Stream:input];
            re.line = [input getLine];
            re.charPositionInLine = [input getCharPositionInLine];
            // @throw [STException newException:[NSString stringWithFormat:@"EOF inside string/template at %d:%d", startLine, startCharPositionInLine] reason:re];
            [errMgr lexerError:[input getSourceName] msg:@"EOF in string" templateToken:templateToken e:re];
        }
    }
    
    [buf appendFormat:@"%c", c];
    [self consume];
    if (sawEscape)
        return [self newToken:STRING text:[buf description]];
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
    
    while (!(c == '!' && [input LA:2] == delimiterStopChar))
        [self consume];
    
    [self consume];
    [self consume];
}

- (void) mLINEBREAK
{
    [self match:'\\'];
    [self match:delimiterStopChar];
    
    while (c == ' ' || c == '\t')
        [self consume];
    
    if (c == '\r')
        [self consume];
    [self match:'\n'];
    
    while (c == ' ' || c == '\t')
        [self consume];
    
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

- (ANTLRCommonToken *) newToken:(NSInteger)ttype
{
    STToken * t = [STToken newToken:input type:ttype start:startCharIndex stop:[input getIndex] - 1];
    [t setLine:startLine];
    [t setCharPositionInLine:startCharPositionInLine];
    return t;
}

- (ANTLRCommonToken *) newTokenFromPreviousChar:(NSInteger)ttype
{
    STToken * t = [STToken newToken:input type:ttype start:[input getIndex] - 1 stop:[input getIndex] - 1];
    [t setLine:[input getLine]];
    [t setCharPositionInLine:[input getCharPositionInLine] - 1];
    return t;
}

- (ANTLRCommonToken *) newToken:(NSInteger)ttype text:(NSString *)text pos:(NSInteger)pos
{
    STToken * t = [STToken newToken:ttype text:text];
    [t setLine:[input getLine]];
    [t setCharPositionInLine:pos];
    return t;
}

- (ANTLRCommonToken *) newToken:(NSInteger)ttype text:(NSString *)text
{
    STToken * t = [STToken newToken:ttype text:text];
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
    return [input getSourceName];
}

- (id) copyWithZone:(NSZone *)aZone
{
    return self;
}

@end
