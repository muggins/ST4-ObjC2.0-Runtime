#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLR.h>
#import "Compiler.h"
#import "CodeGenerator.h"
#import "ST.h"
#import "CompiledST.h"
#import "Bytecode.h"
#import "Interpreter.h"
#import "STException.h"
#import "ErrorManager.h"
#import "STParser.h"

@implementation Compiler_Anon1

- (id) init {
    if (self = [super init]) {
        [self setObject:@"anchor" forKey:[NSNumber numberWithInteger:ANCHOR]];
        [self setObject:@"format" forKey:[NSNumber numberWithInteger:FORMAT]];
        [self setObject:@"null" forKey:[NSNumber numberWithInteger:_NULL]];
        [self setObject:@"separator" forKey:[NSNumber numberWithInteger:SEPARATOR]];
        [self setObject:@"wrap" forKey:[NSNumber numberWithInteger:WRAP]];
    }
    return self;
}

@end

@implementation Compiler_Anon2

- (id) init {
    if (self = [super init]) {
        [self setObject:@"anchor" forKey:@"true"];
        [self setObject:@"wrap" forKey:@"\n"];
    }
    return self;
}

@end

@implementation Compiler_Anon3

- (id) init {
    if (self = [super init]) {
        [self setObject:@"first" forKey:[NSNumber numberWithShort:Bytecode.INSTR_FIRST]];
        [self setObject:@"last" forKey:[NSNumber numberWithShort:Bytecode.INSTR_LAST]];
        [self setObject:@"rest" forKey:[NSNumber numberWithShort:Bytecode.INSTR_REST]];
        [self setObject:@"trunc" forKey:[NSNumber numberWithShort:Bytecode.INSTR_TRUNC]];
        [self setObject:@"strip" forKey:[NSNumber numberWithShort:Bytecode.INSTR_STRIP]];
        [self setObject:@"trim" forKey:[NSNumber numberWithShort:Bytecode.INSTR_TRIM]];
        [self setObject:@"length" forKey:[NSNumber numberWithShort:Bytecode.INSTR_LENGTH]];
        [self setObject:@"strlen" forKey:[NSNumber numberWithShort:Bytecode.INSTR_STRLEN]];
        [self setObject:@"reverse" forKey:[NSNumber numberWithShort:Bytecode.INSTR_REVERSE]];
    }
    return self;
}

@end

@implementation Compiler

static NSMutableDictionary *supportedOptions;
static NSInteger NUM_OPTIONS;
static NSMutableDictionary *defaultOptionValues;
static NSMutableDictionary *funcs;
/**
 * Name subtemplates _sub1, _sub2, ...
 */
static NSInteger subtemplateCount;
static NSString *SUBTEMPLATE_PREFIX;
static NSInteger TEMPLATE_INITIAL_CODE_SIZE = 15;


@synthesize delimiterStartChar;
@synthesize delimiterStopChar;
@synthesize errMgr;

+ (void) initialize
{
    supportedOptions = [[Compiler_Anon1 alloc] init];
    NUM_OPTIONS = [supportedOptions count];
    defaultOptionValues = [[Compiler_Anon2 alloc] init];
    funcs = [[Compiler_Anon3 alloc] init];
    subtemplateCount = 0;
    SUBTEMPLATE_PREFIX = @"_sub";
}

+ (NSString *) SUBTEMPLATE_PREFIX
{
    return SUBTEMPLATE_PREFIX;
}

+ (NSString *) getNewSubtemplateName
{
    subtemplateCount++;
    return [NSString stringWithFormat:@"%@%d", SUBTEMPLATE_PREFIX, subtemplateCount];
}

+ (NSInteger) supportedOptions
{
    return [supportedOptions count];
}

+ (NSMutableDictionary *) getSupportedOptions
{
    return supportedOptions;
}

+ (NSInteger) NUM_OPTIONS
{
    return NUM_OPTIONS;
}

+ (NSMutableDictionary *) defaultOptionValues
{
    return defaultOptionValues;
}

+ (NSMutableDictionary *) funcs
{
    return funcs;
}

+ (NSInteger) subtemplateCount
{
    return subtemplateCount;
}

+ (CompiledST *) defineBlankRegion:(CompiledST *)outermostImpl name:(NSString *)name {
    NSString * outermostTemplateName = outermostImpl.name;
    NSString * mangled = [STGroup getMangledRegionName:outermostTemplateName name:name];
    CompiledST * blank = [[CompiledST alloc] init];
    blank.isRegion = YES;
    blank.regionDefType = IMPLICIT;
    blank.name = mangled;
    [outermostImpl addImplicitlyDefinedTemplate:blank];
    return blank;
}

+ (NSString *) newSubtemplateName {
    subtemplateCount++;
    return [SUBTEMPLATE_PREFIX stringByAppendingFormat:@"%d", subtemplateCount];
}

+ (Compiler *) newCompiler
{
    return [[Compiler alloc] init];
}

+ (Compiler *) newCompilerWithErrorManager:(ErrorManager *)anErrMgr
{
    return [[Compiler alloc] initWithErrorManager:anErrMgr];
}

+ (Compiler *) newCompiler:(unichar)aStartChar delimiterStopChar:(unichar)aStopChar
{
    return [[Compiler alloc] init:aStartChar delimiterStopChar:aStopChar];
}

+ (Compiler *) newCompilerWithErrorManager:(ErrorManager *)anErrMgr delimiterStartChar:(unichar)aStartChar delimiterStopChar:(unichar)aStopChar
{
    return [[Compiler alloc] initWithErrorManager:anErrMgr delimiterStartChar:aStartChar delimiterStopChar:aStopChar];
}

- (id) init
{
    if (self = [super init]) {
        errMgr = STGroup.DEFAULT_ERR_MGR;
        delimiterStartChar = '<';
        delimiterStopChar = '>';
    }
    return self;
}

- (id) initWithErrorManager:(ErrorManager *)anErrMgr
{
    if (self = [super init]) {
        errMgr = anErrMgr;
        delimiterStartChar = '<';
        delimiterStopChar = '>';
    }
    return self;
}

- (id) init:(unichar)aStartChar delimiterStopChar:(unichar)aStopChar
{
    if (self = [super init]) {
        errMgr = STGroup.DEFAULT_ERR_MGR;
        delimiterStartChar = aStartChar;
        delimiterStopChar = aStopChar;
    }
    return self;
}

- (id) initWithErrorManager:(ErrorManager *)anErrMgr delimiterStartChar:(unichar)aStartChar delimiterStopChar:(unichar)aStopChar
{
    if (self = [super init]) {
        errMgr = anErrMgr;
        delimiterStartChar = aStartChar;
        delimiterStopChar = aStopChar;
    }
    return self;
}

/**
 * To compile a template, we need to know what the
 * enclosing template is (if any) in case of regions.
 */
- (CompiledST *) compile:(NSString *)template
{
    CompiledST *code = [self compile:nil name:nil args:nil template:template templateToken:nil];
    code.hasFormalArgs = NO;
    return code;
}


/**
 * Compile full template with unknown formal args.
 */
- (CompiledST *) compile:(NSString *)name template:(NSString *)template
{
    CompiledST * code = [self compile:nil name:name args:nil template:template templateToken:nil];
    code.hasFormalArgs = NO;
    return code;
}


/**
 * Compile full template with respect to a list of formal args.
 */
- (CompiledST *) compile:(NSString *)srcName name:(NSString *)name args:(NSMutableArray *)args template:(NSString *)template templateToken:(ANTLRCommonToken *)aTemplateToken
{
    ANTLRStringStream *is = [[ANTLRStringStream alloc] initWithString:template];
    is.name = (srcName != nil) ? srcName : name;
    STLexer *lexer = [STLexer newSTLexer:errMgr input:is templateToken:aTemplateToken delimiterStartChar:delimiterStartChar delimiterStopChar:delimiterStopChar];
    ANTLRCommonTokenStream *tokens = [ANTLRCommonTokenStream newANTLRCommonTokenStreamWithTokenSource:lexer];
    STParser *p = [[STParser alloc] init:tokens error:errMgr token:aTemplateToken];
    STParser_templateAndEOF_return *r = nil;
    
    @try {
        r = [p templateAndEOF];
    }
    @catch (ANTLRRecognitionException * re) {
        [self reportMessageAndThrowSTException:tokens templateToken:aTemplateToken aParser:p re:re];
        return nil;
    }
    if ([p getNumberOfSyntaxErrors] > 0 || [r getTree] == nil) {
        CompiledST * impl = [[CompiledST alloc] init];
        [impl defineFormalArgs:args];
        return impl;
    }
    ANTLRCommonTreeNodeStream * nodes = [ANTLRCommonTreeNodeStream newANTLRCommonTreeNodeStream:[r getTree]];
    [nodes setTokenStream:tokens];
    CodeGenerator *gen = [CodeGenerator newCodeGenerator:nodes errMgr:errMgr name:name template:template token:aTemplateToken];
    CompiledST * impl = nil;
    
    @try {
        impl = [gen template:name arg1:args];
        if (STGroup.debug) {
            impl.ast = (ANTLRCommonTree *)[r getTree];
            [impl.ast setUnknownTokenBoundaries];
            impl.tokens = tokens;
        }
    }
    @catch (ANTLRRecognitionException *re) {
        [errMgr internalError:nil msg:@"bad tree structure" e:re];
    }
    return impl;
}

- (void) reportMessageAndThrowSTException:(ANTLRCommonTokenStream *)tokens templateToken:(ANTLRCommonToken *)templateToken aParser:(ANTLRParser *)aParser re:(ANTLRRecognitionException *)re
{
    NSString *msg;
    if ([re.token getType] == STLexer.EOF_TYPE) {
        msg = @"premature EOF";
        [errMgr compileTimeError:SYNTAX_ERROR templateToken:templateToken t:re.token arg:msg];
    }
    else if ([re isKindOfClass:[ANTLRNoViableAltException class]]) {
        msg = [[@"'" stringByAppendingString:[re.token getText]] stringByAppendingString:@"' came as a complete surprise to me"];
        [errMgr compileTimeError:SYNTAX_ERROR templateToken:templateToken t:re.token arg:msg];
    }
    else if ([tokens getIndex] == 0) {
        msg = [[@"this doesn't look like a template: \"" stringByAppendingString:[tokens toString]] stringByAppendingString:@"\""];
        [errMgr compileTimeError:SYNTAX_ERROR templateToken:templateToken t:re.token arg:msg];
    }
    else if ([tokens LA:1] == LDELIM) {
        msg = @"doesn't look like an expression";
        [errMgr compileTimeError:SYNTAX_ERROR templateToken:templateToken t:re.token arg:msg];
    }
    else {
        msg = [aParser getErrorMessage:re TokenNames:[aParser getTokenNames]];
        [errMgr compileTimeError:SYNTAX_ERROR templateToken:templateToken t:re.token arg:msg];
    }
    @throw [STException newException:msg];
}

- (void) dealloc {
    [errMgr release];
    [super dealloc];
}

@end
