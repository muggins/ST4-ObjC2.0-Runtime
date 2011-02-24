//
//  StringWriter.m
//  ST4
//
//  Created by Alan Condit on 1/26/11.
//  Copyright 2011 Alan's MachineWorks. All rights reserved.
//

#import "StringWriter.h"


@implementation StringWriter

+ (id) new
{
    return [[StringWriter alloc] initWithCapacity:16];
}

+ (id) stringWithCapacity:(NSUInteger)aLen
{
    return [[StringWriter alloc] initWithCapacity:aLen];
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

@end
