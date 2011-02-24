//
//  TestMisc.m
//  ST4
//
//  Created by Alan Condit on 1/29/11.
//  Copyright 2011 Alan's MachineWorks. All rights reserved.
//
#import <Cocoa/Cocoa.h>

#import "TestMisc.h"
#import "Coordinate.h"
#import "Writer.h"


@implementation TestMisc

- (void) testCoordinate
{
    Coordinate *aCoord;
    aCoord = [Coordinate newCoordinate:3 b:5];
    STAssertTrue( [[aCoord description] isEqualToString:@"3:5"], @"expected \"3:5\" got %@", [aCoord description]);
    NSLog( @"Coordinate =%@", [aCoord description]);
}

- (void) testWriter
{
    Writer *aWriter;
    aWriter = [Writer newWriter];
    NSInteger len = [aWriter length];
    STAssertTrue( (len == 0), @"Expected len = 1, got len = %d", len);
    [aWriter appendString:@"Test String"];
    STAssertTrue( [@"Test String" compare:aWriter], @"Expected \"Test String\" but got \"%@\".", [aWriter description]);
    STAssertTrue( [aWriter compare:@"Test String"], @"Expected \"Test String\" but got \"%@\".", aWriter);
}

- (void) testWriterWithCapacity
{
    Writer *aWriter;
    aWriter = [Writer newWriterWithCapacity:16];
    NSInteger len = [aWriter count];
    STAssertTrue( (len == 0), @"Expected len = 1, got len = %d", len);
    STAssertTrue( (len == 0), @"Expected len = 1, got len = %d", len);
    [aWriter appendString:@"Test String"];
    STAssertTrue( [@"Test String" compare:aWriter], @"Expected \"Test String\" but got \"%@\".", [aWriter description]);
    STAssertTrue( [aWriter compare:@"Test String"], @"Expected \"Test String\" but got \"%@\".", aWriter);
}

@end
