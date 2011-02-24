//
//  Writer.m
//  StringTemplate
//
//  Created by Alan Condit on 1/24/11.
//  Copyright 2011 Alan's MachineWorks. All rights reserved.
//

#import "Writer.h"


@implementation Writer

+ (id) newWriter
{
    return [[Writer alloc] initWithCapacity:16];
}

+ (id) newWriterWithCapacity:(NSUInteger)len
{
    return [[Writer alloc] initWithCapacity:len];
}

+ (id) stringWithCapacity:(NSUInteger)len
{
    return [[Writer alloc] initWithCapacity:len];
}

- (id) init
{
    if (self = [super initWithCapacity:16]) {
        capacity = 16;
        data = [NSMutableData dataWithCapacity:16];
        ptr = [data mutableBytes];
        for (int i = 0; i < capacity; i++) {
            ptr[i] = '\0';
        }
    }
    return self;
}

- (id) initWithCapacity:(NSUInteger)len
{
    if (self = [super init]) {
        capacity = len;
        data = [NSMutableData dataWithCapacity:len];
        ptr = [data mutableBytes];
        for (int i = 0; i < capacity; i++) {
            ptr[i] = '\0';
        }
    }
    return self;
}

- (NSUInteger) length
{
    NSInteger i = 0;
    for (i = 0; i < capacity; i++ ) {
        if ( ptr[i] == '\0' ) break;
    }
    return i;
}

- (unichar) characterAtIndex:(NSUInteger)index
{
    NSInteger i;
    if ( index < capacity ) return (unichar) ptr[i];
    return (unichar) '\0';
}

- (NSUInteger) count
{
    return [self length];
}

- (void) appendString:(NSString *)aString
{
    NSInteger i, len, len2;
    len = [self length];
    len2 = [aString length];
    [self ensureCapacity:len+len2+2];
    for (i = 0; i < len2; i++) {
        ptr[len+i] = (char) [aString characterAtIndex:i];
    }
}

- (void) writeChar:(NSInteger)aChar
{
    [self appendFormat:@"%c", aChar];
}

- (void) writeStr:(NSString *)str
{
    [self appendString:str];
}

- (void) writeStr:(NSString *)str pos:(NSInteger)offset len:(NSInteger)len
{
    NSRange aRange;
    aRange = NSMakeRange(offset, len);
    [self appendString:[str substringWithRange:aRange]];
}

- (id) description
{
    NSLog( @"%@", [NSString stringWithCString:(const char *)ptr encoding:NSASCIIStringEncoding] );
    return [NSString stringWithCString:ptr encoding:NSASCIIStringEncoding];
}

- (void) replaceCharactersInRange:(NSRange)range withString:(NSString *)aString 
{
    NSInteger i, start;
    start = range.location;
    [self ensureCapacity:start+range.length];
    for (i = 0; i < range.length; i++) {
        ptr[start+i] = (char) [aString characterAtIndex:i];
    }
}

- (void) ensureCapacity:(NSInteger)len
{
    if ( len >= capacity ) {
        capacity = len+2;
        [data setLength:capacity];
        ptr = [data mutableBytes];
    }
}

@end
