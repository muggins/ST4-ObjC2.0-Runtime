//
//  PrintWriter.h
//  ST4
//
//  Created by Alan Condit on 1/29/11.
//  Copyright 2011 Alan's MachineWorks. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Writer.h"
#import "StringWriter.h"

@interface PrintWriter : Writer {

}

+ (id) new;
+ (id) newWithStringWriter:(StringWriter *)sw;
+ (id) stringWithCapacity:(NSUInteger)len;

- (id) initWithCapacity:(NSUInteger)aLen;
- (NSString *)description;
- (void) print:(id)msg;
- (void) println:(id)msg;
- (void) close;

@end
