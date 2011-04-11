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
#import "StringTable.h"
#import "AMutableArray.h"

@implementation StringTable

- (id) init
{
    self=[super init];
    if ( self != nil ) {
        table = [NSMutableDictionary dictionaryWithCapacity:10];
        i = -1;
    }
    return self;
}

- (NSInteger) addObject:(NSString *)s
{
    NSString *I = [table objectForKey:s];
    
    if (I != nil)
        return [I intValue];
    i++;
    [table setObject:[NSString stringWithFormat:@"%d", i] forKey:s];
    return i;
}

- (AMutableArray *) toArray
{
    AMutableArray *a = [AMutableArray arrayWithCapacity:5];
    NSInteger count = [table count];
    for (int idx = 0; idx < count; idx++) {
        [a addObject:@""];
    }
    for (NSString *s in [table allKeys]) {
        i = [(NSString *)[table objectForKey:s] integerValue];
        [a replaceObjectAtIndex:i withObject:s];
    }
    return a;
}

- (void) setObject:(id)obj forKey:(id)aKey
{
    [table setObject:obj forKey:aKey];
}

- (void) dealloc
{
    [table release];
    [super dealloc];
}

@synthesize table;
@synthesize i;
@end
