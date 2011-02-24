//
//  Writer.h
//  StringTemplate
//
//  Created by Alan Condit on 1/24/11.
//  Copyright 2011 Alan's MachineWorks. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Writer : NSMutableString {
    NSInteger capacity;
    NSMutableData *data;
    char *ptr;
}

@property (assign, getter=getCapacity, setter=setCapacity:) NSInteger capacity;

+ (id) newWriter;
+ (id) newWriterWithCapacity;
+ (id) stringWithCapacity:(NSUInteger)len;

- (id) init;
- (id) initWithCapacity:(NSUInteger)aLen;
- (NSUInteger) count;
- (void) appendString:(NSString *)aString;
- (void) writeChar:(NSInteger)aChar;
- (void) writeStr:(NSString *)str;
- (void) replaceCharactersInRange:(NSRange)range withString:(NSString *)aString;
- (void) ensureCapacity:(NSInteger)len;
@end
