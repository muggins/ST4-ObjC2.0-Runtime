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
#import "STErrorListener.h"
#import "STRuntimeMessage.h"
#import "Interval.h"
#import "Coordinate.h"
#import "Misc.h"
#import "ST.h"
#import "CompiledST.h"
#import "AMutableArray.h"

@implementation STRuntimeMessage

@synthesize ip;

+ (id) newMessage:(ErrorTypeEnum)anError ip:(NSInteger)anIp;
{
    return [[[STRuntimeMessage alloc] init:anError ip:anIp] retain];
}

+ (id) newMessage:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho;
{
    return [[[STRuntimeMessage alloc] init:anError ip:anIp who:aWho] retain];
}

+ (id) newMessage:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho arg:(id)anArg;
{
    return [[[STRuntimeMessage alloc] init:anError ip:anIp who:aWho arg:anArg] retain];
}

+ (id) newMessage:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho cause:(NSException *)e arg:(id)anArg;
{
    return [[[STRuntimeMessage alloc] init:anError ip:anIp who:aWho cause:e arg:anArg] retain];
}

+ (id) newMessage:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho cause:(NSException *)e arg:(id)anArg arg2:(id)anArg2;
{
    return [[[STRuntimeMessage alloc] init:anError ip:anIp who:aWho cause:e arg:anArg arg2:anArg2] retain];
}

+ (id) newMessage:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho cause:(NSException *)e arg:(id)anArg arg2:(id)anArg2 arg3:(id)anArg3;
{
    return [[[STRuntimeMessage alloc] init:anError ip:anIp who:aWho cause:e arg:anArg arg2:anArg2 arg3:anArg3] retain];
}


- (id) init:(ErrorTypeEnum)anError ip:(NSInteger)anIp
{
    self=[super init:anError];
    if ( self != nil ) {
        ip = anIp;
    }
    return self;
}

- (id) init:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho
{
    self=[super init:anError who:aWho];
    if ( self != nil ) {
        ip = anIp;
    }
    return self;
}

- (id) init:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho arg:(NSObject *)anArg
{
    self=[super init:anError who:aWho cause:nil arg:anArg];
    if ( self !=nil ) {
        ip = anIp;
    }
    return self;
}

- (id) init:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho cause:(NSException *)e arg:(id)anArg
{
    self=[super init:anError who:aWho cause:e arg:anArg];
    if ( self !=nil ) {
        ip = anIp;
    }
    return self;
}

- (id) init:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho cause:(NSException *)e arg:(id)anArg arg2:(id)anArg2
{
    self=[super init:anError who:aWho cause:e arg:anArg arg2:anArg2];
    if ( self !=nil ) {
        ip = anIp;
    }
    return self;
}

- (id) init:(ErrorTypeEnum)anError ip:(NSInteger)anIp who:(ST *)aWho cause:(NSException *)e arg:(id)anArg arg2:(id)anArg2 arg3:(id)anArg3
{
    self=[super init:anError who:aWho cause:e arg:anArg arg2:anArg2 arg3:anArg3];
    if ( self !=nil ) {
        ip = anIp;
    }
    return self;
}


/**
 * Given an ip (code location), get it's range in source template then
 * return it's template line:col.
 */
- (NSString *) getSourceLocation
{
    if (ip < 0)
        return nil;
    Interval *I = [((ST *)who).impl.sourceMap objectAtIndex:ip];
    if (I == nil)
        return nil;
    NSInteger i = I.a;
    Coordinate *loc = [Misc getLineCharPosition:((ST *)who).impl.template index:i];
    return [loc description];
}

- (NSString *) description
{
    NSMutableString *buf = [NSMutableString stringWithCapacity:16];
    NSString *loc = [self getSourceLocation];
    if (who != nil) {
        [buf appendFormat:@"context [%@]", [who getEnclosingInstanceStackString]];
    }
    if (loc != nil)
        [buf appendFormat:@" %@", loc];
    [buf appendFormat:@" %@", [super description]];
    return buf;
}

- (NSString *) toString
{
    return [self description];
}

@end
