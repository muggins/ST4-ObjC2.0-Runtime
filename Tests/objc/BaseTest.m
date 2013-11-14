//
//  BaseTest.m
//  BaseTest
//
//  Created by Alan Condit on 4/3/11.
//  Copyright 2011 Alan's MachineWorks. All rights reserved.
//

#import "BaseTest.h"
#import "STGroup.h"
#import "STLexer.h"
#import "Writer.h"
#import "ErrorManager.h"
#import "STGroup.h"
#import "Compiler.h"
#import "Interpreter.h"

NSString *const tmpdir = @"/tmp";
NSString *const newline = @"\n"/* Misc.newline */;

@implementation User

@synthesize num;
@synthesize name;
@synthesize manager;
@synthesize parkingSpot;

+ (id) new
{
    return [[User alloc] init];
}

+ (id) newUser:(NSInteger)aNum name:(NSString *)aName
{
    return [[User alloc] init:aNum name:aName];
}

- (id) init
{
    if ( (self=[super init]) != nil ) {
        num = [ACNumber numberWithInteger:0];
        name = @"";
        manager = YES;
        parkingSpot = YES;
    }
    return self;
}

- (id) init:(NSInteger)aNum name:(NSString *)aName
{
    if ( (self=[super init]) != nil ) {
        num = [ACNumber numberWithInteger:aNum];
        name = aName;
        manager = YES;
        parkingSpot = YES;
    }
    return self;
}

- (void) dealloc
{
#ifdef DEBUG_DEALLOC
    NSLog( @"called dealloc in User" );
#endif
    num = nil;
    name = nil;
    // [super dealloc];
}

- (ACNumber *)getNum
{
    return num;
}

- (void) setNum:(ACNumber *)aNum
{
    num = aNum;
}

- (BOOL) hasParkingSpot
{
    return YES;
}

@end

@implementation HashableUser

- (id) init:(NSInteger)aNum name:(NSString *)aName
{
    self=[super init:aNum name:aName];
    if ( self ) {
    }
    return self;
}

- (void)dealloc
{
    // [super dealloc];
}

- (NSInteger) hash
{
    return [num integerValue];
}

- (BOOL) isEqualTo:(NSObject *)obj
{
    if ([obj isKindOfClass:[HashableUser class]]) {
        HashableUser *hu = (HashableUser *)obj;
        return [num integerValue] == [hu.num integerValue] && [name isEqualTo:hu.name];
    }
    return NO;
}

@end

@implementation BaseTest

@synthesize randomDir;
@synthesize tmpdir;

- (void)setUp
{
//     [super setUp];
    // Set-up code here.
    [STGroup resetDefaultGroup];
    tmpdir = @"/tmp";
    randomDir = @"";
}

- (void)tearDown
{
    // Tear-down code here.
//    [super tearDown];
}

- (void) dealloc
{
#ifdef DEBUG_DEALLOC
    NSLog( @"called dealloc in BaseTest" );
#endif
    randomDir = nil;
    tmpdir = nil;
    // [super dealloc];
}

- (void) writeFile:(NSString *)dir fileName:(NSString *)fileName content:(NSString *)content
{
    NSString *path;
    NSFileHandle *fh;
    NSError *error;
    NSString *str;
    NSArray *cs;
    BOOL isDirectory;
    BOOL dirExists;
    
    @try {
        NSFileManager *nfm = [[NSFileManager alloc] init];
        path = [dir stringByExpandingTildeInPath];
        path = [path stringByAppendingPathComponent:fileName];
        fileName = [path lastPathComponent];
        path = [path stringByDeletingLastPathComponent];
        dirExists = [nfm fileExistsAtPath:path isDirectory:&isDirectory];
        if ( !dirExists ) {
            [nfm createDirectoryAtPath:(NSString *)path withIntermediateDirectories:YES attributes:nil error:&error];
        }
        path = [path stringByAppendingPathComponent:fileName];
        // NSFileHandle *f = [[File alloc] init:dir arg1:fileName];
        fh = [NSFileHandle fileHandleForWritingAtPath:path];
        if (fh == nil) {
//            NSData *data = [NSData dataWithContentsOfFile:content];
            NSData *data = [content dataUsingEncoding:NSASCIIStringEncoding];
            if ([nfm createFileAtPath:path contents:data attributes:nil]) {
                fh = [NSFileHandle fileHandleForWritingAtPath:path];
            }
        }
#ifdef DONTUSENOMO
        if (![[f parentFile] exists])
            [[f parentFile] mkdirs];
#endif
        FileWriter *fw = [FileWriter newWriterWithFH:fh];
        BufferedWriter *bw = [BufferedWriter newWriter:fw];
        [bw writeStr:content];
//        [fw writeStr:content];
        [bw close];
        [fw close];
    }
    @catch (IOException *ioe) {
        //[System.err println:@"can't write file"];
        //NSLog( @"can't write file" );
        //[ioe printStackTrace:System.err];
        cs = [ioe callStackSymbols];
        for (NSInteger i=0; i < [cs count]; i++ ) {
            str = [cs objectAtIndex:i];
            //NSLog( @"CallStack = %@\n", str );
        }
    }
}

- (void) checkTokens:(NSString *)template expected:(NSString *)expected
{
    [self checkTokens:template expected:expected delimiterStartChar:'<' delimiterStopChar:'>'];
}

- (void) checkTokens:(NSString *)template expected:(NSString *)expected delimiterStartChar:(unichar)delimiterStartChar delimiterStopChar:(unichar)delimiterStopChar
{
    STLexer *lexer = [STLexer newSTLexer:ErrorManager.DEFAULT_ERR_MGR input:[ANTLRStringStream newANTLRStringStream:template] templateToken:nil delimiterStartChar:delimiterStartChar delimiterStopChar:delimiterStopChar];
    CommonTokenStream *tokens = [CommonTokenStream newCommonTokenStreamWithTokenSource:lexer];
    NSMutableString *buf = [NSMutableString stringWithCapacity:35];
    [buf appendString:@"["];
    NSInteger i = 1;
    CommonToken *t = [tokens LT:i];
    while (t.type != TokenTypeEOF) {
        if (i > 1)
            [buf appendString:@", "];
        [buf appendString:[t description]];
        i++;
        t = [tokens LT:i];
    }
    
    [buf appendString:@"]"];
    NSString *result = [NSString stringWithString:buf];
    //    STAssertTrue( [expected isEqualToString:result], @"Expected %@, but got \"%@\"", expected, result );
    [self assertEquals:expected result:result];
}

- (NSString *) getRandomDir
{
    BOOL isDir;
    NSError *error;
    NSFileManager *defaultManager;
    randomDir = [NSString stringWithFormat:@"%@/tmpdir%d", [tmpdir stringByExpandingTildeInPath], (int)arc4random()];
    defaultManager = [NSFileManager defaultManager];
    if (![defaultManager fileExistsAtPath:randomDir isDirectory:&isDir]) {
        if ([defaultManager createDirectoryAtPath:randomDir withIntermediateDirectories:YES attributes:nil error:&error] ) {
            //NSLog( @"Created \"%@\"", randomDir );
            return randomDir;
        }
    }
    return nil;
}

- (void) assertEquals:(NSString *)expected result:(NSString *)result
{
    STAssertTrue( [expected isEqualTo:result], @"Expected \"%@\" BUT GOT \"%@\"", expected, result );
}

- (void) assertNotNil:(id)ptr msg:(NSString *)msg
{
    STAssertNotNil( ptr, @"%@ equal to nil", (msg==nil?@"":msg)  );
}

@end

@implementation Strings

@synthesize thisArray;

+ (id) newStringsWithArray:(AMutableArray *)anArray
{
    return [[Strings alloc] initWithArray:(AMutableArray *)anArray];
}

- (id) initWithArray:(AMutableArray *)anArray
{
    self=[super init];
    if ( self != nil ) {
        if ( [anArray isKindOfClass:[NSArray class]] ) {
            thisArray = anArray;
        }
    }
    return self;
}

- (void) dealloc
{
#ifdef DEBUG_DEALLOC
    NSLog( @"called dealloc in Strings" );
#endif
    thisArray = nil;
    // [super dealloc];
}

- (void) addObject:(id)anObject
{
    [thisArray addObject:anObject];
}

- (id) objectAtIndex:(NSInteger)idx
{
    return [thisArray objectAtIndex:idx];
}

- (NSString *)description
{
    NSInteger i;
    NSMutableString *str = nil;

    if (thisArray != nil) {
        NSInteger count;
        count = [thisArray count];
        id obj;
        str = [NSMutableString stringWithString:@"["];
        for (i=0; i < count; i++ ) {
            obj = [thisArray objectAtIndex:i];
            if ( obj != nil ) {
                if ([obj isKindOfClass:[NSString class]]) {
                    [str appendString:obj];
                    //NSLog( @"String %d = %@\n", i, obj);
                } else {
                    [str appendString:[obj description]];
                }
            }
            else {
                [str appendString:@"obj=<nil>"];
            }
            if ( i < count-1) {
                [str appendString:@", "];
            }
        }
        [str appendString:@"]"];
    }
    return [NSString stringWithString:str];
}

- (NSString *) toString
{
    return [self description];
}

@end

