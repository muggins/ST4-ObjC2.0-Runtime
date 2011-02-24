#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLR.h>
#import "Misc.h"
#import <FOUNDATION/Foundation.h>
#import <objc/runtime.h>
#import "STException.h"

@implementation Misc

static NSString * const newline = @"\n";

+ (NSString *) newline
{
    return newline;
}

+ (NSString *) join:(NSEnumerator *)iter separator:(NSString *)separator
{
    NSMutableString *buf = [NSMutableString stringWithCapacity:16];
    id obj;
    obj = [iter nextObject];
    while (obj) {
        [buf appendString:obj];
        if (obj = [iter nextObject]) {
            [buf appendString:separator];
        }
    };
    return [buf description];
}

+ (NSString *) strip:(NSString *)s n:(NSInteger)n
{
    return [s substringFromIndex:n];
}

+ (NSString *) trimOneStartingNewline:(NSString *)s
{
    if ([s hasPrefix:@"\r\n"])
        s = [s substringFromIndex:2];
    else if ([s hasPrefix:@"\n"])
        s = [s substringFromIndex:1];
    return s;
}

+ (NSString *) trimOneTrailingNewline:(NSString *)s
{
    if ([s hasSuffix:@"\r\n"])
        s = [s substringToIndex:[s length] - 2];
    else if ([s hasSuffix:@"\n"])
        s = [s substringToIndex:[s length] - 1];
    return s;
}

+ (NSString *) getFileNameNoSuffix:(NSString *)f
{
    return [f pathExtension];
}

+ (NSString *) getFileName:(NSString *)fullFileName
{
    NSError **anError;
    NSURL *aURL = [NSURL fileURLWithPath:[fullFileName stringByStandardizingPath]];
    NSFileWrapper *f = [[NSFileWrapper alloc] initWithURL:aURL options:NSFileWrapperReadingWithoutMapping error:anError];
    return [f filename];
}

+ (NSString *) getPrefix:(NSString *)name {
    if (name == nil)
        return nil;
    name = [name stringByDeletingLastPathComponent];
    if ([name length] > 1 )
        return name;
    return @"";
}

+ (NSString *) replaceEscapes:(NSString *)s
{
    s = [s stringByReplacingOccurrencesOfString:@"\n" withString:@"\\\\n"];
    s = [s stringByReplacingOccurrencesOfString:@"\r" withString:@"\\\\r"];
    s = [s stringByReplacingOccurrencesOfString:@"\t" withString:@"\\\\t"];
    return s;
}


/**
 * Given index into string, compute the line and char position in line
 */
+ (Coordinate *) getLineCharPosition:(NSString *)s index:(NSInteger)index
{
    NSInteger line = 1;
    NSInteger charPos = 0;
    NSInteger p = 0;
    
    while (p < index) {
        if ([s characterAtIndex:p] == '\n') {
            line++;
            charPos = 0;
        }
        else
            charPos++;
        p++;
    }
    
    return [Coordinate newCoordinate:line b:charPos];
}

#pragma mark error fix accessField
//#ifdef DONTUSEYET
+ (id) accessField:(Ivar)f obj:(id)obj value:(id)value
{
    
    @try {
        // [f setAccessible:YES];
        ;
    }
    @catch (ANTLRRuntimeException *se) {
    }
    //  value = [f get:obj];
    //    f = object_getInstanceVariable(id obj, const char *name, &value);
    value = object_getIvar(obj, f);
    return value;
}
//#endif

+ (id) invokeMethod:(Method *)m obj:(id)obj value:(id)value
{
    
    @try {
//        [m setAccessible:YES];
        ;
    }
    @catch (ANTLRRuntimeException *se) {
    }
#pragma mark error
    // value = [m invoke:obj obj:(NSArray *)nil]; // this is a call to Java -- deal with it
    return value;
}

+ (Method *) getMethod:(id)c methodName:(NSString *)methodName
{
    Method * m;
    
    @try {
        m = [c getMethod:methodName methodName:(NSString *)nil];
//        object_getInstanceVariable(c, [methodName cStringUsingEncoding:NSASCIIStringEncoding], void **outValue)
    }
    @catch (STNoSuchMethodException *nsme) {
        m = nil;
    }
    return m;
}

@end
