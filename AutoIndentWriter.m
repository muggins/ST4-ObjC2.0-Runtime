#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLR.h>
#import "AutoIndentWriter.h"
//#import "IOException.h"
#import "Writer.h"
#import "ST.h"

@implementation AutoIndentWriter

@synthesize indents;
@synthesize anchors;
@synthesize anchors_sp;
@synthesize newline;
@synthesize writer;
@synthesize atStartOfLine;
@synthesize charPosition;
@synthesize charIndex;
@synthesize lineWidth;

+ (id) newWriter:(Writer *)aWriter
{
    return [AutoIndentWriter newWriter:aWriter];
}

- (id) initWithWriter:(Writer *)aWriter {
    if (self = [super init]) {
        indents = [NSMutableArray arrayWithCapacity:16];
        anchors = [ANTLRIntArray newArrayWithLen:30];
        anchors_sp = -1;
        atStartOfLine = YES;
        charPosition = 0;
        charIndex = 0;
        lineWidth = ST.NO_WRAP;
        writer = aWriter;
        [indents addObject:nil];
        newline = @"\n";
    }
    return self;
}

- (id) init:(Writer *)aWriter newline:(NSString *)aNewline {
    if (self = [super init]) {
        indents = [NSMutableArray arrayWithCapacity:16];
        anchors = [ANTLRIntArray newArrayWithLen:30];
        anchors_sp = -1;
        atStartOfLine = YES;
        charPosition = 0;
        charIndex = 0;
        lineWidth = ST.NO_WRAP;
        writer = aWriter;
        [indents addObject:nil];
        newline = aNewline;
    }
    return self;
}

- (void) setLineWidth:(NSInteger)aLineWidth {
    lineWidth = aLineWidth;
}

- (void) pushIndentation:(NSString *)anIndent {
    [indents addObject:anIndent];
}

- (NSString *) popIndentation {
    NSString *ret = [indents objectAtIndex:[indents count]-1];
    [indents removeLastObject];
    return ret;
}

- (void) pushAnchorPoint {
    anchors_sp++;
    [anchors push:charPosition];
}

- (NSInteger) popAnchorPoint {
    anchors_sp--;
    return [anchors pop];
}

- (NSInteger) index {
    return charIndex;
}


/**
 * Write out a string literal or attribute expression or expression element.
 */
- (NSInteger) write:(NSString *)str {
    NSInteger n = 0;
    
    for (NSInteger i = 0; i < [str length]; i++) {
        unichar c = [str characterAtIndex:i];
        if (c == '\r')
            continue;
        if (c == '\n') {
            atStartOfLine = YES;
            charPosition = -1;
            [writer writeStr:newline];
            n += [newline length];
            charIndex += [newline length];
            charPosition += n;
            continue;
        }
        if (atStartOfLine) {
            n += [self indent];
            atStartOfLine = NO;
        }
        n++;
        [writer writeChar:c];
        charPosition++;
        charIndex++;
    }
    
    return n;
}

- (NSInteger) writeSeparator:(NSString *)str {
    return [self write:str];
}


/**
 * Write out a string literal or attribute expression or expression element.
 * 
 * If doing line wrap, then check wrap before emitting this str.  If
 * at or beyond desired line width then emit a \n and any indentation
 * before spitting out this str.
 */
- (NSInteger) write:(NSString *)str wrap:(NSString *)wrap {
    NSInteger n = [self writeWrap:wrap];
    return n + [self write:str];
}

- (NSInteger) writeWrap:(NSString *)wrap {
    NSInteger n = 0;
    if (lineWidth != ST.NO_WRAP && wrap != nil && !atStartOfLine && charPosition >= lineWidth) {
        
        for (NSInteger i = 0; i < [wrap length]; i++) {
            unichar c = [wrap characterAtIndex:i];
            if (c == '\n') {
                [writer writeStr:newline];
                n += [newline length];
                charPosition = 0;
                charIndex += [newline length];
                n += [self indent];
            }
            else {
                n++;
                [writer writeChar:c];
                charPosition++;
                charIndex++;
            }
        }
        
    }
    return n;
}

- (NSInteger) indent {
    NSInteger n = 0;
    
    for (NSString * ind in indents) {
        if (ind != nil) {
            n += [ind length];
            [writer writeStr:ind];
        }
    }
    
    NSInteger indentWidth = n;
    if (anchors_sp >= 0 && [anchors integerAtIndex:anchors_sp] > indentWidth) {
        NSInteger remainder = [anchors integerAtIndex:anchors_sp] - indentWidth;
        
        for (NSInteger i = 1; i <= remainder; i++)
            [writer writeChar:' '];
        
        n += remainder;
    }
    charPosition += n;
    charIndex += n;
    return n;
}

- (void) dealloc {
    [indents release];
    [anchors release];
    [newline release];
    [writer release];
    [super dealloc];
}

@end
