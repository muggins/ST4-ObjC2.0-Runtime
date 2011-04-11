#import "STErrorListener.h"
#import "STDump.h"
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
#import "ST.h"
#import "CompiledST.h"
#import "Misc.h"
#import "AMutableArray.h"

NSInteger compare(NSString *s1, NSString *s2, void *context);

static STDump *d;

@implementation STDump

@synthesize who;

+ (void) initialize
{
    d = [STDump newSTDumpWithWho:nil];
}

+ (id) newSTDumpWithWho:(ST *) aWho
{
    return [[[STDump alloc] initWithWho:(ST *)aWho] retain];
}

+ (NSString *) toString:(ST *)aWho
{
    d.who = aWho;
    return [d description];
}

+ (NSString *) description:(ST *)aWho {
    d.who = aWho;
    return [d description];
}

- (id) initWithWho:(ST *)aWho
{
    self=[super init];
    if ( self != nil ) {
        who = aWho;
    }
    return self;
}

- (NSString *) description
{
    return [self description:0];
}

- (NSString *) toString
{
    return [self description:0];
}

- (NSString *) toString:(NSInteger)n
{
    return [self description:n];
}

- (NSString *) description:(NSInteger)n
{
    NSMutableString *buf = [NSMutableString stringWithCapacity:16];
    [buf appendFormat:@"%@:", [self getTemplateDeclaratorString]];
    n++;
    NSMutableDictionary *attributes = [who getAttributes];
    if (attributes != nil) {
        AMutableArray *attrNames = [AMutableArray arrayWithCapacity:16];
        [attrNames addObjectsFromArray:[attributes allKeys]];
        [attrNames sortUsingFunction:compare context:nil];
        NSString *longestName = [attrNames objectAtIndex:0];
        NSInteger w = [longestName length];
        
        NSString *fmtStr;
        fmtStr = [NSString stringWithFormat:@"\%-%d$@= \%@", w];
        for (id attrName in attrNames) {
            NSString *name = (NSString *)attrName;
            [buf appendString:@"\n"];
            [self indent:buf n:n];
            [buf appendFormat:fmtStr, name];
            id value = [attributes objectForKey:name];
            [buf appendString:[self getValueDebugString:value n:n]];
        }
        
    }
    [buf appendString:[Misc newline]];
    n--;
    [self indent:buf n:n];
    [buf appendString:@"]"];
    return buf;
}
            
- (NSString *) getValueDebugString:(id)value n:(NSInteger)n
{
    NSMutableString *buf = [NSMutableString stringWithCapacity:16];
    value = [Interpreter convertAnythingIteratableToIterator:value];
    if ([value isKindOfClass:[ST class]]) {
        STDump *d = [[STDump alloc] initWithWho:(ST *)value];
        [buf appendString:[d toString:n]];
    }
    else if ([value isKindOfClass:[ArrayIterator class]]) {
        ArrayIterator *it = (ArrayIterator *)value;
        id obj;
        
        while (obj = [it nextObject]) {
            NSString *v = [self getValueDebugString:obj n:n];
            [buf appendString:v];
            if ([it hasNext])
                [buf appendString:@", "];
        }
    }
    else {
        [buf appendString:value];
    }
    return buf;
}

- (NSString *) getTemplateDeclaratorString
{
    NSMutableString *buf = [NSMutableString stringWithCapacity:16];
    [buf appendFormat:@"<%@(", [who getName]];
    if (((CompiledST *)who.impl).formalArguments != nil) {
        ArrayIterator *it = [ArrayIterator newIteratorForDictKey:who.impl.formalArguments];
        id obj;
        while (obj = [it nextObject]) {
            [buf appendString:obj];
            if ([it hasNext])
                [buf appendString:@", "];
        }
    }
    [buf appendString:@")@"];
    [buf appendFormat:@"%d", [self hash]];
    [buf appendString:@">"];
    return buf;
}

- (void) indent:(NSMutableString *)buf n:(NSInteger)n {
    
    for (NSInteger i = 1; i <= n; i++)
        [buf appendString:@"   "];
    
}

- (void) dealloc {
    [self release];
    [super dealloc];
}

@end

NSInteger compare(NSString *s1, NSString *s2, void *context)
{
    int v1 = [s1 length];
    int v2 = [s2 length];
    if (v1 < v2)
        return NSOrderedAscending;
    else if (v1 > v2)
        return NSOrderedDescending;
    return NSOrderedSame;
}


