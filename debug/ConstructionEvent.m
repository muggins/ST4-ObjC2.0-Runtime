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
#import "ConstructionEvent.h"

@implementation StackTraceElement

+ (id) newStackTraceElement
{
    return [[StackTraceElement alloc] init];
}

+ (id) newStackTraceElement:(NSString *)aMsg
{
    return [[StackTraceElement alloc] initWithMessage:(NSString *)aMsg];
}

- (id) init
{
    self=[super init];
    if ( self != nil ) {
        msg = nil;
    }
    return self;
}

- (id) initWithMessage:(NSString *)aMsg
{
    self=[super init];
    if ( self != nil ) {
        msg = aMsg;
    }
    return self;
}

- (NSString *) description
{
    return msg;
}

- (NSString *) toString
{
    return msg;
}

@synthesize msg;

@end

@implementation ConstructionEvent

- (id) init
{
    self=[super init];
    if ( self != nil ) {
        stack = [[NSException alloc] init];
        sTEntryPoint = [StackTraceElement newStackTraceElement];
    }
    return self;
}

- (NSString *) fileName
{
    return fileName /* [[self sTEntryPoint] fileName] */;
}

- (NSInteger) line
{
    return line /* [[self sTEntryPoint] lineNumber] */;
}

- (id) sTEntryPoint
{
    addrs = [stack callStackReturnAddresses];
    trace = [stack callStackSymbols];
    
    for (NSString *traceStr in trace) {
        NSLog( @"%@", traceStr);
        // TODO: remove special after testing
        if ([traceStr hasPrefix:@"main("] > 0)
            return traceStr;
        if (![traceStr hasPrefix:@"org.stringtemplate"])
            return traceStr;
    }
    return trace;
}

- (void) dealloc
{
    [stack release];
    [super dealloc];
}

@synthesize fileName;
@synthesize line;
@synthesize stack;
@synthesize sTEntryPoint;
@synthesize addrs;
@synthesize trace;

@end
