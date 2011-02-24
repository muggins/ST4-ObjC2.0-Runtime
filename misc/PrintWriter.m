//
//  PrintWriter.m
//  ST4
//
//  Created by Alan Condit on 1/29/11.
//  Copyright 2011 Alan's MachineWorks. All rights reserved.
//

#import "PrintWriter.h"


@implementation PrintWriter

+ (id) new
{
    return [[PrintWriter alloc] initWithCapacity:16];
}

+ (id) newWithStringWriter:(StringWriter *)sw
{
    return [[PrintWriter alloc] initWithCapacity:16];
}

+ (id) stringWithCapacity:(NSUInteger)aLen
{
    return [[PrintWriter alloc] initWithCapacity:aLen];
}

- (id) initWithCapacity:(NSUInteger)aLen
{
    if (self = [super initWithCapacity:aLen]) {
    }
    return self;
}

- (NSString *)description
{
    return self;
}

- (void) print:(id)msg
{
    NSLog( @"self=%@--msg=%@", [self description], msg );
}

- (void) println:(id)msg
{
    NSLog( @"self=%@--msg=%@\n", [self description], msg );
}

- (void) close;
{
}

@end
