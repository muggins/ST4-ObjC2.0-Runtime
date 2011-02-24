#import "BaseTest.h"

@implementation User

@synthesize manager;
@synthesize name;

- (id) init:(int)aNum name:(NSString *)aName
{
    if (self = [super init]) {
        num = aNum;
        name = aName;
    }
    return self;
}

- (BOOL) hasParkingSpot
{
    return YES;
}

- (void) dealloc {
    [name release];
    [super dealloc];
}

@end

@implementation HashableUser

- (id) init:(int)aNum name:(NSString *)aName {
    if (self = [super init:aNum arg1:aName]) {
    }
    return self;
}

- (int) hash
{
    return num;
}

- (BOOL) isEqualTo:(NSObject *)o
{
    if ([o conformsToProtocol:@protocol(HashableUser)]) {
        HashableUser *hu = (HashableUser *)o;
        return num == hu.num && [name isEqualTo:hu.name];
    }
    return NO;
}

@end

NSString * const tmpdir = [System getProperty:@"java.io.tmpdir"];
NSString * const newline = Misc.newline;

@implementation BaseTest

@synthesize randomDir;

- (void) setUp
{
    STGroup.defaultGroup = [[[STGroup alloc] init] autorelease];
    Compiler.subtemplateCount = 0;
    STGroup.debug = NO;
}

+ (void) writeFile:(NSString *)dir fileName:(NSString *)fileName content:(NSString *)content
{
    
    @try {
        File * f = [[[File alloc] init:dir arg1:fileName] autorelease];
        if (![[f parentFile] exists])
            [[f parentFile] mkdirs];
        FileWriter * w = [[[FileWriter alloc] init:f] autorelease];
        BufferedWriter * bw = [[[BufferedWriter alloc] init:w] autorelease];
        [bw write:content];
        [bw close];
        [w close];
    }
    @catch (IOException * ioe) {
        [System.err println:@"can't write file"];
        [ioe printStackTrace:System.err];
    }
}

- (void) checkTokens:(NSString *)template expected:(NSString *)expected
{
    [self checkTokens:template expected:expected delimiterStartChar:'<' delimiterStopChar:'>'];
}

- (void) checkTokens:(NSString *)template expected:(NSString *)expected delimiterStartChar:(unichar)delimiterStartChar delimiterStopChar:(unichar)delimiterStopChar
{
    STLexer *lexer = [[[STLexer alloc] init:STGroup.DEFAULT_ERR_MGR arg1:[[[ANTLRStringStream alloc] init:template] autorelease] arg2:nil arg3:delimiterStartChar arg4:delimiterStopChar] autorelease];
    ANTLRCommonTokenStream *tokens = [[[ANTLRCommonTokenStream alloc] init:lexer] autorelease];
    NSMutableString *buf = [[NSMutableString stringWithCapacity:30] autorelease];
    [buf append:@"["];
    int i = 1;
    Token * t = [tokens LT:i];
    
    while ([t type] != Token.EOF) {
        if (i > 1)
            [buf append:@", "];
        [buf append:t];
        i++;
        t = [tokens LT:i];
    }
    
    [buf append:@"]"];
    NSString *result = [buf description];
    STAssertTrue( [expected isEqualToString:result], @"Expected %@, but got \"%@\"", expected, result );
}

+ (NSString *) randomDir
{
    NSString * randomDir = [tmpdir stringByAppendingString:@"dir"] + [NSString valueOf:(int)([Math random] * 100000)];
    File * f = [[[File alloc] init:randomDir] autorelease];
    [f mkdirs];
    return randomDir;
}

@end
