//
//  MemBuffer.m
//
//  Created by Alan Condit on 6/9/10.
// [The "BSD licence"]
// Copyright (c) 2010 Alan Condit
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions
// are met:
// 1. Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
// 3. The name of the author may not be used to endorse or promote products
//    derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
// IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
// OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
// IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
// NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
// THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#define SUCCESS (0)
#define FAILURE (-1)

#import "MemBuffer.h"

/*
 * Start of MemBuffer
 */
@implementation MemBuffer

@synthesize BuffSize;
@synthesize buffer;
@synthesize ptrBuffer;
@synthesize count;
@synthesize ptr;

+(MemBuffer *)newMemBuffer
{
    return [[MemBuffer alloc] init];
}

+(MemBuffer *)newMemBufferWithLen:(NSInteger)cnt
{
    return [[MemBuffer alloc] initWithLen:cnt];
}

-(id)init
{
    NSInteger idx;
    
	if ((self = [super init]) != nil) {
        BuffSize  = BUFFSIZE;
        ptr = 0;
        buffer = [NSMutableData dataWithLength:(NSUInteger)BuffSize * sizeof(id)];
        [buffer retain];
        ptrBuffer = (char *)[buffer mutableBytes];
        for( idx = 0; idx < BuffSize; idx++ ) {
            ptrBuffer[idx] = 0;
        }
	}
    return( self );
}

-(id)initWithLen:(NSInteger)cnt
{
    NSInteger idx;
    
	if ((self = [super init]) != nil) {
        BuffSize  = cnt;
        ptr = 0;
        buffer = [NSMutableData dataWithLength:(NSUInteger)BuffSize * sizeof(id)];
        [buffer retain];
        ptrBuffer = (char *)[buffer mutableBytes];
        for( idx = 0; idx < BuffSize; idx++ ) {
            ptrBuffer[idx] = 0;
        }
	}
    return( self );
}

-(void)dealloc
{
    [buffer release];
	[super dealloc];
}

- (id) copyWithZone:(NSZone *)aZone
{
    MemBuffer *copy;
    
    copy = [[[self class] allocWithZone:aZone] init];
    if ( buffer )
        copy.buffer = [buffer copyWithZone:aZone];
    copy.ptrBuffer = ptrBuffer;
    copy.ptr = ptr;
    return copy;
}

- (void)clear
{
    NSInteger idx;

    for( idx = 0; idx < BuffSize; idx++ ) {
        ptrBuffer[idx] = 0;
    }
}

- (NSMutableData *)getBuffer
{
	return( buffer );
}

- (void)setBuffer:(NSMutableData *)np
{
    buffer = np;
}

- (NSInteger)getCount
{
	return( count );
}

- (void)setCount:(NSInteger)aCount
{
    count = aCount;
}

- (char *)getPtrBuffer
{
	return( ptrBuffer );
}

- (void)setPtrBuffer:(char *)np
{
    ptrBuffer = np;
}

- (NSInteger)getPtr
{
	return( ptr );
}

- (void)setPtr:(NSInteger)aPtr
{
    ptr = aPtr;
}

- (void) addChar:(char) v
{
	[self ensureCapacity:ptr];
	ptrBuffer[ptr++] = v;
    count++;
}

- (void) push:(char) v
{
    if ( ptr >= BuffSize - 1 ) {
        [self ensureCapacity:ptr];
    }
    ptrBuffer[ptr++] = v;
    count++;
}

- (char) pop
{
	char v = 0;
    if ( ptr > 0 ) {
        v = ptrBuffer[--ptr];
        ptrBuffer[ptr] = 0;
    }
    count--;
	return v;
}

- (char) peek
{
	char v = 0;
    if ( ptr > 0 ) {
        v = ptrBuffer[ptr-1];
    }
	return v;
}

- (NSInteger)count
{
    return count;
}

- (NSInteger)length
{
    return BuffSize;
}

- (NSInteger)size
{
    return BuffSize;
}

- (void) insertChar:(char)aChar atIndex:(NSInteger)idx
{
    if ( idx >= BuffSize ) {
        [self ensureCapacity:idx];
    }
    ptrBuffer[idx] = aChar;
}

- (char) charAtIndex:(NSInteger)idx
{
    if ( idx < BuffSize ) {
        return ptrBuffer[idx];
    }
    return 0;
}

- (void)addCharsFromArray:(MemBuffer *)anArray
{
    NSInteger cnt, i;
    cnt = [anArray count];
    for( i = 0; i < cnt; i++) {
        char tmp = [anArray charAtIndex:i];
        [self insertChar:tmp atIndex:i];
    }
    return;
}

- (void)removeAllChars
{
    int i;
    for ( i = 0; i < BuffSize; i++ ) {
        ptrBuffer[i] = 0;
    }
    count = 0;
    ptr = 0;
}

- (short) shortAtIndex:(NSInteger)idx
{
    if ( idx >= BuffSize-1 )
        return -1;
    NSInteger b1 = ptrBuffer[idx] & 0xFF;
    NSInteger b2 = ptrBuffer[idx + 1] & 0xFF;
    NSInteger word = ((b1 << 8) | b2);
    return word;
}

/**
 * Write value at index into a byte array highest to lowest byte,
 * left to right.
 */
- (void) insertShort:(short)value atIndex:(NSInteger)idx
{
    if (idx >= BuffSize )
        ensureCapacity:idx+1;
    ptrBuffer[idx + 0] = (char)((value >> (8 * 1)) & 0xFF);
    ptrBuffer[idx + 1] = (char)(value & 0xFF);
}

- (void) ensureCapacity:(NSInteger) index
{
	if ((index * sizeof(char)) >= [buffer length])
	{
		NSInteger newSize = [buffer length] * 2;
		if (index > newSize) {
			newSize = index + 1;
		}
        BuffSize = newSize;
		[buffer setLength:(BuffSize * sizeof(char))];
        ptrBuffer = [buffer mutableBytes];
	}
}

- (NSString *) toString
{
    NSMutableString *str;
    NSInteger idx, cnt;
    cnt = [self count];
    str = [NSMutableString stringWithCapacity:cnt];
    [str appendString:@"["];
    for (idx = 0; idx < cnt; idx++ ) {
        [str appendFormat:@"%d", (NSInteger)*(ptrBuffer+idx)];
        if ( idx < cnt-1 ) [str appendString:@","];
    }
    [str appendString:@"]"];
    return str;
}

@end
