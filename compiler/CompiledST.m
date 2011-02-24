#import "CompiledST.h"
#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLR.h>
#import "ST.h"
#import "STGroup.h"
#import "Interval.h"
#import "Misc.h"
//#import "PrintWriter.h"
//#import "StringWriter.h"
#import "BytecodeDisassembler.h"

@implementation CompiledST

@synthesize name;
@synthesize template;
@synthesize tokens;
@synthesize ast;
@synthesize formalArguments;
@synthesize hasFormalArgs;
@synthesize implicitlyDefinedTemplates;
@synthesize nativeGroup;
@synthesize isRegion;
//@synthesize numberOfArgsWithDefaultValues;
//@synthesize templateSource;
//@synthesize templateRange;
@synthesize regionDefType;
@synthesize isAnonSubtemplate;
@synthesize strings;
@synthesize instrs;
@synthesize codeSize;
@synthesize sourceMap;

+ (id) newCompiledST
{
    return [[CompiledST alloc] init];
}

- (id) init
{
    if (self = [super init]) {
        nativeGroup = STGroup.defaultGroup;
        instrs = [MemBuffer newMemBufferWithLen:100];
        sourceMap = [NSArray array];
        template = @"";
    }
    return self;
}

- (void) addImplicitlyDefinedTemplate:(CompiledST *)sub
{
    if (implicitlyDefinedTemplates == nil) {
        implicitlyDefinedTemplates = [NSMutableArray arrayWithCapacity:16];
    }
    [implicitlyDefinedTemplates addObject:sub];
}

- (NSInteger) getNumberOfArgsWithDefaultValues
{
    if (formalArguments == nil)
        return 0;
    NSInteger n = 0;
    
    for (NSString * arg in [formalArguments allKeys]) {
        if (((FormalArgument *)[formalArguments objectForKey:arg]).defaultValueToken != nil)
            n++;
    }
    
    return n;
}

- (void) defineArgDefaultValueTemplates:(STGroup *)group
{
    if (formalArguments == nil)
        return;
    
    for (NSString * a in [formalArguments allKeys]) {
        FormalArgument * fa = [formalArguments objectForKey:a];
        if (fa.defaultValueToken != nil) {
            NSString * argSTname = [fa.name stringByAppendingString:@"_default_value"];
            Compiler * c2 = [Compiler newCompiler:group.errMgr delimiterStartChar:group.delimiterStartChar delimiterStopChar:group.delimiterStopChar];
            NSString * defArgTemplate = [Misc strip:[fa.defaultValueToken getText] n:1];
            fa.compiledDefaultValue = [c2 compile:[nativeGroup fileName] name:argSTname args:nil template:defArgTemplate templateToken:fa.defaultValueToken];
            fa.compiledDefaultValue.name = argSTname;
        }
    }
    
}

- (void) defineFormalArgs:(NSMutableArray *)args
{
    hasFormalArgs = YES;
    if (args == nil)
        formalArguments = nil;
    else
        
        for (FormalArgument * a in args)
            [self addArg:a];
    
}


/**
 * Used by ST.add() to add args one by one w/o turning on full formal args definition signal
 */
- (void) addArg:(FormalArgument *)a
{
    if (formalArguments == nil) {
        formalArguments = [NSMutableDictionary dictionaryWithCapacity:16];
    }
    a.index = [formalArguments count];
    [formalArguments setObject:a forKey:a.name];
}

- (void) defineImplicitlyDefinedTemplates:(STGroup *)group
{
    if (implicitlyDefinedTemplates != nil) {
        
        for (CompiledST * sub in implicitlyDefinedTemplates) {
            [group rawDefineTemplate:sub.name code:sub defT:nil];
            [sub defineImplicitlyDefinedTemplates:group];
        }
        
    }
}

- (NSString *) templateSource
{
    Interval * r = [self templateRange];
    return [template substringWithRange:NSMakeRange(r.a, r.b + 1)];
}

- (Interval *) templateRange
{
    if (isAnonSubtemplate) {
        Interval *aStart = [sourceMap objectAtIndex:0];
        Interval *aStop = nil;
        
        for (NSInteger i = [sourceMap count] - 1; i > 0; i--) {
            Interval * I = [sourceMap objectAtIndex:i];
            if (I != nil) {
                aStop = I;
                break;
            }
        }
        if (template != nil)
            return [Interval newInterval:aStart.a b:aStop.b];
    }
    return [[Interval alloc] init:0 b:[template length] - 1];
}

- (MemBuffer *) instrs
{
    BytecodeDisassembler *dis = [BytecodeDisassembler newBytecodeDisassembler:self];
    return [dis instrs];
}

- (void) dump
{
    BytecodeDisassembler *dis = [BytecodeDisassembler newBytecodeDisassembler:self];
    NSLog( @"%@:", name);
    NSLog(@"Strings:%@", [dis disassemble]);
    NSLog(@"Strings:%@", [dis strings]);
    NSLog(@"Bytecode to template map:%@",[dis sourceMap]);
}

- (NSString *) disasm
{
    BytecodeDisassembler * dis = [[BytecodeDisassembler alloc] initWithCode:self];
    StringWriter * sw = [[StringWriter alloc] init];
    PrintWriter * pw = [PrintWriter newWithStringWriter:sw];
    [pw println:[dis disassemble]];
    [pw println:@"Strings:"];
    [pw println:[dis strings]];
    [pw println:@"Bytecode to template map:"];
    [pw println:[dis sourceMap]];
    [pw close];
    return [sw description];
}

- (void) dealloc
{
    [name release];
    [template release];
    [tokens release];
    [ast release];
    [formalArguments release];
    [implicitlyDefinedTemplates release];
    [nativeGroup release];
    [strings release];
    [instrs release];
    [sourceMap release];
    [super dealloc];
}

- (NSString *) getName
{
    return name;
}

- (void) setName:(NSString *)aName
{
    name = aName;
}

- (NSString *) getTemplate
{
    return template;
}

- (void) setTemplate:(NSString *)aTemplate
{
    template = aTemplate;
}

- (ANTLRCommonTokenStream *) getTokens
{
    return tokens;
}

- (void) setTokens:(ANTLRCommonTokenStream *)theTokens
{
    tokens = theTokens;
}

- (ANTLRCommonTree *) getAst
{
    return ast;
}

- (void) setAst:(ANTLRCommonTree *)anAST
{
    ast = anAST;
}

- (NSMutableDictionary *) getFormalArguments
{
    return formalArguments;
}

- (void) setFormalArguments:(NSMutableDictionary *)theFormalArguments
{
    formalArguments = theFormalArguments;
}

- (BOOL) getHasFormalArgs
{
    return hasFormalArgs;
}

- (void) setHasFormalArgs:(BOOL)FormalArgs
{
    hasFormalArgs = FormalArgs;
}

- (NSMutableArray *) getImplicitlyDefinedTemplates
{
    return implicitlyDefinedTemplates;
}

- (void) setImplicitlyDefinedTemplates:(NSMutableArray *)Templates
{
    implicitlyDefinedTemplates = Templates;
}

- (STGroup *) getNativeGroup
{
    return nativeGroup;
}

- (void) setNativeGroup:(STGroup *)aNativeGroup
{
    nativeGroup = aNativeGroup;
}

- (BOOL) getIsRegion
{
    return isRegion;
}

- (void) setIsRegion:(BOOL)Region
{
    isRegion = Region;
}

//@property(nonatomic, readonly(NSInteger numberOfArgsWithDefaultValues;
//@property(nonatomic, retain, readonly(NSString *templateSource;
//@property(nonatomic, retain, readonly(Interval *templateRange;
- (RegionTypeEnum) getRegionDefType
{
    return regionDefType;
}

- (void) setRegionDefType:(RegionTypeEnum)aRegionDefType
{
    regionDefType = aRegionDefType;
}

- (BOOL) getIsAnonSubtemplate
{
    return isAnonSubtemplate;
}

- (void) setIsAnonSubtemplate:(BOOL)AnonSubtemplate
{
    isAnonSubtemplate = AnonSubtemplate;
}

- (NSMutableArray *) getStrings
{
    return strings;
}

- (void) setStrings:(NSMutableArray *)theStrings
{
    strings = theStrings;
}

- (MemBuffer *) getInstrs
{
    return instrs;
}

- (void) setInstrs:(MemBuffer *)theInstrs
{
    instrs = theInstrs;
}

- (NSInteger) getCodeSize
{
    return codeSize;
}

- (void) setCodeSize:(NSInteger)theCodeSize
{
    codeSize = theCodeSize;
}

- (NSMutableArray *) getSourceMap
{
    return sourceMap;
}

- (void) setSourceMap:(NSMutableArray *)aSourceMap
{
    sourceMap = aSourceMap;
}
@end
