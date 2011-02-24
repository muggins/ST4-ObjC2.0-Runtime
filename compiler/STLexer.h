#import <ANTLR/ANTLR.h>
#import "STGroup.h"
#import "ErrorManager.h"
#import "Misc.h"
#import "STParser.h"
//#import "NSMutableArray.h"
//#import "NSMutableArray.h"

/**
 * We build STToken tokens instead of relying on ANTLRCommonToken so we
 * can override toString(). It just converts token types to
 * token names like 23 to LDELIM.
 */

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

@interface STToken : ANTLRCommonToken {
}

+ (id) newToken:(id<ANTLRCharStream>)input type:(NSInteger)type start:(NSInteger)aStart stop:(NSInteger)aStop;
+ (id) newToken:(NSInteger)type text:(NSString *)text;

- (id) initWithInput:(id<ANTLRCharStream>)input type:(NSInteger)type start:(NSInteger)aStart stop:(NSInteger)aStop;
- (id) init:(NSInteger)type text:(NSString *)text;
- (NSString *) description;
@end

/**
 * This class represents the tokenizer for templates. It operates in two modes:
 * inside and outside of expressions. It behaves like an ANTLR TokenSource,
 * implementing nextToken().  Outside of expressions, we can return these
 * token types: TEXT, INDENT, LDELIM (start of expr), RCURLY (end of subtemplate),
 * and NEWLINE.  Inside of an expression, this lexer returns all of the tokens
 * needed by the STParser. From the parser's point of view, it can treat a
 * template as a simple stream of elements.
 * 
 * This class defines the token types and communicates these values to STParser.g
 * via STLexer.tokens file (which must remain consistent).
 */

@interface STLexer : NSObject <ANTLRTokenSource> {
    
    /**
     * What char starts an expression?
     */
    unichar delimiterStartChar;
    unichar delimiterStopChar;
    
    /**
     * This keep track of the mode of the lexer. Are we inside or outside
     * an ST expression?
     */
    BOOL scanningInsideExpr;
    
    /**
     * To be able to properly track the inside/outside mode, we need to
     * track how deeply nested we are in some templates. Otherwise, we
     * know whether a '}' and the outermost subtemplate to send this back to
     * outside mode.
     */
    NSInteger subtemplateDepth;
    ErrorManager * errMgr;
    ANTLRCommonToken * templateToken;
    id<ANTLRCharStream> input;
    unichar c;
    
    /**
     * When we started token, track initial coordinates so we can properly
     * build token objects.
     */
    NSInteger startCharIndex;
    NSInteger startLine;
    NSInteger startCharPositionInLine;
    
    /**
     * Our lexer routines might have to emit more than a single token. We
     * buffer everything through this list.
     */
    NSMutableArray *tokens;
}

@property (retain, getter=SKIP, setter=setSKIP:) ANTLRCommonToken *SKIP;
@property (assign, getter=delimiterStartChar, setter=setDelimiterStartChar:) unichar delimiterStartChar;
@property (assign, getter=delimiterStopChar, setter=setDelimiterStopChar:) unichar delimiterStopChar;
@property (assign, getter=scanningInsideExpr, setter=setScanningInsideExpr:) BOOL scanningInsideExpr;
@property (assign, getter=subtemplateDepth, setter=setSubtemplateDepth:) NSInteger subtemplateDepth;
@property (retain, getter=errMgr, setter=setErrMgr:) ErrorManager *errMgr;
@property (retain, getter=templateToken, setter=setTemplateToken:) ANTLRCommonToken *templateToken;
@property (retain, getter=input, setter=setInput:) id<ANTLRCharStream> input;
@property (assign, getter=c, setter=setC:) unichar c;
@property (assign, getter=getCharIndex, setter=setStartCharIndex:) NSInteger startCharIndex;
@property (assign, getter=startLine, setter=setStartLine:) NSInteger startLine;
@property (assign, getter=startCharPositionInLine, setter=setStartCharPositionInLine:) NSInteger startCharPositionInLine;
@property (retain, getter=tokens, setter=setTokens:) NSMutableArray *tokens;

//@property (nonatomic, retain, readonly) NSString *errorHeader;
//@property (nonatomic, retain, readonly) NSString *sourceName;

+ (ANTLRCommonToken *) SKIP;
+ (char) Token_EOF;
+ (NSInteger) EOF_TYPE;

+ (void) initialize;

+ (id) newSTLexer:(id<ANTLRCharStream>)input;
+ (id) newSTLexer:(ErrorManager *)errMgr
            input:(id<ANTLRCharStream>)input
    templateToken:(ANTLRCommonToken *)templateToken;
+ (id) newSTLexer:(ErrorManager *)errMgr
            input:(id<ANTLRCharStream>)input
    templateToken:(ANTLRCommonToken *)templateToken
delimiterStartChar:(unichar)delimiterStartChar
delimiterStopChar:(unichar)delimiterStopChar;

- (id) initWithInput:(id<ANTLRCharStream>)input;
- (id) init:(ErrorManager *)errMgr input:(id<ANTLRCharStream>)input templateToken:(ANTLRCommonToken *)templateToken;
- (id) init:(ErrorManager *)errMgr
      input:(id<ANTLRCharStream>)input
templateToken:(ANTLRCommonToken *)templateToken
delimiterStartChar:(unichar)delimiterStartChar
delimiterStopChar:(unichar)delimiterStopChar;

- (ANTLRCommonToken *) nextToken;
- (void) match:(unichar)x;
- (void) consume;
- (void) emit:(ANTLRCommonToken *)token;
- (ANTLRCommonToken *) _nextToken;
- (ANTLRCommonToken *) outside;
- (ANTLRCommonToken *) inside;
- (ANTLRCommonToken *) subTemplate;
- (ANTLRCommonToken *) mESCAPE;
- (ANTLRCommonToken *) mUNICODE;
- (ANTLRCommonToken *) mTEXT;
- (ANTLRCommonToken *) mID;
- (ANTLRCommonToken *) mSTRING;
- (void) mWS;
- (void) mCOMMENT;
- (void) mLINEBREAK;
+ (BOOL) isIDStartLetter:(unichar)c;
+ (BOOL) isIDLetter:(unichar)c;
+ (BOOL) isWS:(unichar)c;
+ (BOOL) isUnicodeLetter:(unichar)c;
- (ANTLRCommonToken *) newToken:(NSInteger)ttype;
- (ANTLRCommonToken *) newTokenFromPreviousChar:(NSInteger)ttype;
- (ANTLRCommonToken *) newToken:(NSInteger)ttype text:(NSString *)text pos:(NSInteger)pos;
- (ANTLRCommonToken *) newToken:(NSInteger)ttype text:(NSString *)text;
- (id) copyWithZone:(NSZone *)aZone;
- (NSString *) getSourceName;

@end
