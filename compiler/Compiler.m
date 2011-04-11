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
#import "Compiler.h"
#import "CodeGenerator.h"
#import "ST.h"
#import "CompiledST.h"
#import "Bytecode.h"
#import "Interpreter.h"
#import "STException.h"
#import "ErrorManager.h"
#import "STLexer.h"
#import "STParser.h"
#import "AMutableArray.h"

@implementation Compiler_Anon1

+ (id) newCompiler_Anon1
{
    return [[[Compiler_Anon1 alloc] init] retain];
}

- (id) init
{
    if ( (self=[super init]) != nil ) {
        dict = [[NSMutableDictionary dictionaryWithCapacity:16] retain];
        [dict setObject:[NSString stringWithFormat:@"%d", ANCHOR] forKey:@"anchor"];
        [dict setObject:[NSString stringWithFormat:@"%d", FORMAT] forKey:@"format"];
        [dict setObject:[NSString stringWithFormat:@"%d", _NULL] forKey:@"null"];
        [dict setObject:[NSString stringWithFormat:@"%d", SEPARATOR] forKey:@"separator"];
        [dict setObject:[NSString stringWithFormat:@"%d", WRAP] forKey:@"wrap"];
    }
    return self;
}

- (id) getDict
{
    return dict;
}

- (id) objectForKey:(id)aKey
{
    return [dict objectForKey:aKey];
}

- (void) setObject:(id)anObject forKey:(id)aKey
{
    [dict setObject:anObject forKey:aKey];
}

- (NSInteger) count
{
    return [dict count];
}

@synthesize dict;
@end

@implementation Compiler_Anon2

+ (id) newCompiler_Anon2
{
    return [[[Compiler_Anon2 alloc] init] retain];
}

- (id) init
{
    if ( (self=[super init]) != nil ) {
        dict = [[NSMutableDictionary dictionaryWithCapacity:16] retain];
        [dict setObject:@"\"true\"" forKey:@"anchor"];
        [dict setObject:@"\"\n\"" forKey:@"wrap"];
    }
    return self;
}

- (id) copyWithZone:(NSZone *)aZone
{
    Compiler_Anon2 *copy;
    
    copy = [[[self class] allocWithZone:aZone] init];
    if ( dict ) {
        [copy.dict release];
        copy.dict = [dict copyWithZone:aZone];
    }
    return copy;
}

- (id) getDict
{
    return dict;
}

- (id) objectForKey:(id)aKey
{
    return [dict objectForKey:aKey];
}

- (void) setObject:(id)anObject forKey:(id)aKey
{
    [dict setObject:anObject forKey:aKey];
}

- (NSInteger) count
{
    return [dict count];
}

@synthesize dict;
@end

@implementation Compiler_Anon3

+ (id) newCompiler_Anon3
{
    return [[[Compiler_Anon3 alloc] init] retain];
}

- (id) init
{
    if ( (self=[super init]) != nil ) {
        dict = [[NSMutableDictionary dictionaryWithCapacity:16] retain];
        [dict setObject:[NSString stringWithFormat:@"%d", Bytecode.INSTR_FIRST]   forKey:@"first"];
        [dict setObject:[NSString stringWithFormat:@"%d", Bytecode.INSTR_LAST]    forKey:@"last"];
        [dict setObject:[NSString stringWithFormat:@"%d", Bytecode.INSTR_REST]    forKey:@"rest"];
        [dict setObject:[NSString stringWithFormat:@"%d", Bytecode.INSTR_TRUNC]   forKey:@"trunc"];
        [dict setObject:[NSString stringWithFormat:@"%d", Bytecode.INSTR_STRIP]   forKey:@"strip"];
        [dict setObject:[NSString stringWithFormat:@"%d", Bytecode.INSTR_TRIM]    forKey:@"trim"];
        [dict setObject:[NSString stringWithFormat:@"%d", Bytecode.INSTR_LENGTH]  forKey:@"length"];
        [dict setObject:[NSString stringWithFormat:@"%d", Bytecode.INSTR_STRLEN]  forKey:@"strlen"];
        [dict setObject:[NSString stringWithFormat:@"%d", Bytecode.INSTR_REVERSE] forKey:@"reverse"];
    }
    return self;
}

- (id) copyWithZone:(NSZone *)aZone
{
    Compiler_Anon3 *copy;
    
    copy = [[[self class] allocWithZone:aZone] init];
    if ( dict ) {
        [copy.dict release];
        copy.dict = [dict copyWithZone:aZone];
    }
    return copy;
}

- (id) getDict
{
    return dict;
}

- (short) instrForKey:(NSString *)aKey
{
    return (short)[(NSString *)[dict objectForKey:aKey] intValue];
}

- (void) setInstr:(short)anInstr forKey:(id)aKey
{
    [dict setObject:[NSString stringWithFormat:@"%d", anInstr] forKey:aKey];
}

- (NSInteger) count
{
    return [dict count];
}

@synthesize dict;
@end

@implementation Compiler

static Compiler_Anon1 *supportedOptions;
static NSInteger NUM_OPTIONS;
static Compiler_Anon2 *defaultOptionValues;
static Compiler_Anon3 *funcs;
/**
 * Name subtemplates _sub1, _sub2, ...
 */
static NSInteger subtemplateCount = 0;
static NSString *SUBTEMPLATE_PREFIX = @"_sub";
//static NSInteger TEMPLATE_INITIAL_CODE_SIZE = 15;

@synthesize group;

+ (void) initialize
{
    supportedOptions = [Compiler_Anon1 newCompiler_Anon1];
    NUM_OPTIONS = [supportedOptions count];
    defaultOptionValues = [Compiler_Anon2 newCompiler_Anon2];
    funcs = [Compiler_Anon3 newCompiler_Anon3];
}

+ (NSString *) SUBTEMPLATE_PREFIX
{
    return SUBTEMPLATE_PREFIX;
}

+ (NSString *) getNewSubtemplateName
{
    return [NSString stringWithFormat:@"%@%d", SUBTEMPLATE_PREFIX, ++subtemplateCount];
}

+ (NSInteger) supportedOptions
{
    return [supportedOptions count];
}

+ (Compiler_Anon1 *) getSupportedOptions
{
    return supportedOptions;
}

+ (NSInteger) NUM_OPTIONS
{
    return NUM_OPTIONS;
}

+ (Compiler_Anon2 *) defaultOptionValues
{
    return defaultOptionValues;
}

+ (Compiler_Anon3 *) funcs
{
    return funcs;
}

+ (NSInteger) subtemplateCount
{
    return subtemplateCount;
}

+ (Compiler *) newCompiler
{
    return [[[Compiler alloc] init] retain];
}

+ (Compiler *) newCompiler:(STGroup *)aSTGroup
{
    return [[[Compiler alloc] initWithSTGroup:aSTGroup] retain];
}

- (id) init
{
    self=[super init];
    if ( self != nil ) {
        group = STGroup.defaultGroup;
        subtemplateCount = 0;
    }
    return self;
}

- (id) initWithSTGroup:(STGroup *)aSTGroup
{
    self=[super init];
    if ( self != nil ) {
        group = aSTGroup;
        subtemplateCount = 0;
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
    CompiledST *code = [self compile:nil name:name args:nil template:template templateToken:nil];
    code.hasFormalArgs = NO;
    return code;
}

/** Compile full template with respect to a list of formal args. */
- (CompiledST *) compile:(NSString *)srcName
                    name:(NSString *)name
                args:(AMutableArray *)args
                template:(NSString *)template
           templateToken:(STToken *)aTemplateToken
{
    FormalArgument *a;
    if ( [args count] > 0 ) {
        a = [args objectAtIndex:0];
        [a retain];
    }
    ANTLRStringStream *is = [ANTLRStringStream newANTLRStringStream:template];
    is.name = (srcName != nil) ? srcName : name;
    STLexer *lexer = [STLexer newSTLexer:group.errMgr input:is templateToken:aTemplateToken delimiterStartChar:group.delimiterStartChar delimiterStopChar:group.delimiterStopChar];
    ANTLRCommonTokenStream *tokens = [ANTLRCommonTokenStream newANTLRCommonTokenStreamWithTokenSource:lexer];
    STParser *p = [STParser newSTParser:tokens error:group.errMgr token:aTemplateToken];
    STParser_templateAndEOF_return *r = nil;
    
    @try {
        r = [p templateAndEOF];
    }
    @catch (ANTLRRecognitionException *re) {
        [self reportMessageAndThrowSTException:tokens templateToken:aTemplateToken aParser:p re:re];
        return nil;
    }
    if ([p getNumberOfSyntaxErrors] > 0 || r == nil || r.tree == nil) {
        CompiledST *impl = [CompiledST newCompiledST];
        [impl defineFormalArgs:args];
        return impl;
    }
    ANTLRCommonTreeNodeStream *nodes = [ANTLRCommonTreeNodeStream newANTLRCommonTreeNodeStream:r.tree];
    [nodes setTokenStream:tokens];
    CodeGenerator *gen = [CodeGenerator newCodeGenerator:nodes errMgr:group.errMgr name:name template:template token:aTemplateToken];
    CompiledST *impl = nil;
    
    @try {
        impl = [gen template:name arg1:args];
		impl.nativeGroup = group;
		impl.template = template;
        if (STGroup.debug) {
            impl.ast = (ANTLRCommonTree *)r.tree;
            [impl.ast setUnknownTokenBoundaries];
            impl.tokens = tokens;
        }
    }
    @catch (ANTLRRecognitionException *re) {
        [group.errMgr internalError:nil msg:@"bad tree structure" e:re];
    }
    [a release];
    return impl;
}

+ (CompiledST *) defineBlankRegion:(CompiledST *)outermostImpl name:(NSString *)name
{
    NSString *outermostTemplateName = outermostImpl.name;
    NSString *mangled = [STGroup getMangledRegionName:outermostTemplateName name:name];
    CompiledST *blank = [CompiledST newCompiledST];
    blank.isRegion = YES;
    blank.regionDefType = IMPLICIT;
    blank.name = mangled;
    [outermostImpl addImplicitlyDefinedTemplate:blank];
    return blank;
}

- (void) reportMessageAndThrowSTException:(ANTLRCommonTokenStream *)tokens
                            templateToken:(STToken *)templateToken
                                  aParser:(ANTLRParser *)aParser
                                       re:(ANTLRRecognitionException *)re
{
    NSString *msg;
    if ([re.token getType] == STLexer.EOF_TYPE) {
        msg = @"premature EOF";
        [group.errMgr compileTimeError:SYNTAX_ERROR templateToken:templateToken t:re.token arg:msg];
    }
    else if ([re isKindOfClass:[ANTLRNoViableAltException class]]) {
        msg = [NSString stringWithFormat:@"'%@' came as a complete surprise to me", re.token.text];
        [group.errMgr compileTimeError:SYNTAX_ERROR templateToken:templateToken t:re.token arg:msg];
    }
    else if ([tokens getIndex] == 0) {
        msg = [NSString stringWithFormat:@"this doesn't look like a template: \"%@\"", [tokens toString]];
        [group.errMgr compileTimeError:SYNTAX_ERROR templateToken:templateToken t:re.token arg:msg];
    }
    else if ([tokens LA:1] == STLexer.LDELIM) {
        msg = @"doesn't look like an expression";
        [group.errMgr compileTimeError:SYNTAX_ERROR templateToken:templateToken t:re.token arg:msg];
    }
    else {
        msg = [aParser getErrorMessage:re TokenNames:[aParser getTokenNames]];
        [group.errMgr compileTimeError:SYNTAX_ERROR templateToken:templateToken t:re.token arg:msg];
    }
    @throw [STException newException:msg];
}

- (void) dealloc {
    [super dealloc];
}

@end
