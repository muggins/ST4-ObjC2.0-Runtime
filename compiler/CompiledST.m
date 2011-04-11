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
#import "CompiledST.h"
#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLR.h>
#import "STErrorListener.h"
#import "ST.h"
#import "STGroup.h"
#import "Interval.h"
#import "Misc.h"
#import "PrintWriter.h"
#import "StringWriter.h"
#import "BytecodeDisassembler.h"
#import "AMutableArray.h"
#import "GroupParser.h"
#import "Bytecode.h"

@implementation CompiledST

@synthesize name;
@synthesize template;
@synthesize templateDefStartToken;
@synthesize tokens;
@synthesize ast;
@synthesize formalArguments;
@synthesize hasFormalArgs;
@synthesize numberOfArgsWithDefaultValues;
@synthesize implicitlyDefinedTemplates;
@synthesize nativeGroup;
@synthesize isRegion;
@synthesize regionDefType;
@synthesize isAnonSubtemplate;
@synthesize strings;
@synthesize instrs;
@synthesize codeSize;
@synthesize sourceMap;

+ (id) newCompiledST
{
    return [[[CompiledST alloc] init] retain];
}

- (id) init
{
    self=[super init];
    if ( self != nil ) {
        nativeGroup = STGroup.defaultGroup;
        instrs = [MemBuffer newMemBufferWithLen:30];
        sourceMap = [AMutableArray arrayWithCapacity:6];
        strings = [AMutableArray arrayWithCapacity:5];
        template = @"";
    }
    return self;
}

- (id) copyWithZone:(NSZone *)aZone
{
    CompiledST *copy;
    
    copy = [[[self class] allocWithZone:aZone] init];
    if ( instrs ) {
        [copy.instrs release];
        copy.instrs = [instrs copyWithZone:aZone];
    }
    if ( sourceMap ) {
        [copy.sourceMap release];
        copy.sourceMap = [sourceMap copyWithZone:aZone];
    }
    if ( strings ) {
        [copy.strings release];
        copy.strings = [strings copyWithZone:aZone];
    }
    return copy;
}

- (void) addImplicitlyDefinedTemplate:(CompiledST *)sub
{
    if ( implicitlyDefinedTemplates == nil ) {
        implicitlyDefinedTemplates = [AMutableArray arrayWithCapacity:5];
    }
    [implicitlyDefinedTemplates addObject:sub];
}

- (void) defineArgDefaultValueTemplates:(STGroup *)group
{
    if ( formalArguments == nil )
        return;
    for (NSString *s in [formalArguments allKeys]) {
        FormalArgument *fa = [formalArguments objectForKey:s];
        if (fa.defaultValueToken != nil) {
            numberOfArgsWithDefaultValues++;
            if ( fa.defaultValueToken.type == ANONYMOUS_TEMPLATE ) {
                NSString *argSTname = [NSString stringWithFormat:@"%@%@",
                   fa.name, @"_default_value"];
                Compiler *c2 = [Compiler newCompiler:group];
                NSString *defArgTemplate = [Misc strip:[fa.defaultValueToken getText] n:1];
                fa.compiledDefaultValue = [c2 compile:[nativeGroup getFileName] name:argSTname
                       args:nil template:defArgTemplate templateToken:fa.defaultValueToken];
                fa.compiledDefaultValue.name = argSTname;
				[fa.compiledDefaultValue defineImplicitlyDefinedTemplates:group];
            }
            else if ( fa.defaultValueToken.type == T_STRING ) {
                fa.defaultValue = [Misc strip:[fa.defaultValueToken getText] n:1];
            }
            else {
                fa.defaultValue = (id)((fa.defaultValueToken.type == GroupParser.TTRUE)? YES : NO);
            }
        }
    }
}

- (void) defineFormalArgs:(AMutableArray *)args
{
    hasFormalArgs = YES;
    if ( args == nil )
        formalArguments = nil;
    else {
        [args retain];
        FormalArgument *a;
        for (FormalArgument *a in args)
            [self addArg:a];
//        ArrayIterator *it = (ArrayIterator *)[args objectEnumerator];
//        while ( (a = [it nextObject]) != nil ) {
//            [self addArg:a];
//        }
        [args release];
    }
}


/**
 *Used by ST.add() to add args one by one w/o turning on full formal args definition signal
 */
- (void) addArg:(FormalArgument *)a
{
    [a retain];
    if (formalArguments == nil) {
        formalArguments = [[NSMutableDictionary dictionaryWithCapacity:16] retain];
    }
    a.index = [formalArguments count];
    [formalArguments setObject:a forKey:a.name];
    [a release];
}

- (void) defineImplicitlyDefinedTemplates:(STGroup *)group
{
    if (implicitlyDefinedTemplates != nil) {
        for (CompiledST *sub in implicitlyDefinedTemplates) {
            [group rawDefineTemplate:sub.name code:sub defT:sub.templateDefStartToken];
            [sub defineImplicitlyDefinedTemplates:group];
        }
        
    }
}

- (NSString *) getTemplateSource
{
    Interval *r = [self getTemplateRange];
    return [template substringWithRange:NSMakeRange(r.a, (r.b + 1)-r.a)];
}

- (Interval *) getTemplateRange
{
    if (isAnonSubtemplate) {
        Interval *aStart = [sourceMap objectAtIndex:0];
        Interval *aStop = nil;
        
        for (NSInteger i = [sourceMap count] - 1; i >= 0; i--) {
            Interval *I = [sourceMap objectAtIndex:i];
            if (I != nil) {
                aStop = I;
                break;
            }
        }
        return [Interval newInterval:aStart.a b:aStop.b];
    }
    return [[Interval alloc] init:0 b:[template length] - 1];
}

- (NSString *) dis_instrs
{
    BytecodeDisassembler *dis = [BytecodeDisassembler newBytecodeDisassembler:self];
    return [dis instrs];
}

- (void) dump
{
    BytecodeDisassembler *dis = [BytecodeDisassembler newBytecodeDisassembler:self];
    NSLog( @"%@:%@", name, [dis disassemble]);
    NSLog(@"Strings:%@", [dis strings]);
    NSLog(@"Bytecode to template map:%@",[dis sourceMap]);
}

- (NSString *) disasm
{
    BytecodeDisassembler *dis = [[BytecodeDisassembler alloc] initWithCode:self];
    StringWriter *sw = [StringWriter newWriter];
    PrintWriter *pw = [PrintWriter newWithStringWriter:sw];
    [pw println:[dis disassemble]];
    [pw println:[NSString stringWithFormat:@"Strings:%@", [dis strings]]];
    [pw println:[NSString stringWithFormat:@"Bytecode to template map:%@", [dis sourceMap]]];
    [pw close];
    return [sw toString];
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

- (STGroup *)getNativeGroup
{
    if (nativeGroup == nil)
        nativeGroup = STGroup.defaultGroup;
    return nativeGroup;
}
   
   @end
