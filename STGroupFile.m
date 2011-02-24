#import <Cocoa/Cocoa.h>
#import "STGroupFile.h"
#import "STException.h"
#import "ErrorManager.h"

@implementation STGroupFile

@synthesize alreadyLoaded;
@synthesize fileName;
@synthesize URL;

+ (id) newSTGroupFile:(NSString *)aFileName
{
    return [[STGroupFile alloc] initWithFileName:aFileName encoding:NSASCIIStringEncoding delimiterStartChar:'<' delimiterStopChar:'>'];
}

+ (id) newSTGroupFile:(NSString *)aFileName encoding:(NSStringEncoding)theEncoding
{
    return [[STGroupFile alloc] initWithFileName:aFileName encoding:theEncoding delimiterStartChar:'<' delimiterStopChar:'>'];
}

+ (id) newSTGroupFile:(NSString *)aFileName delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar
{
    return [[STGroupFile alloc] initWithFileName:aFileName encoding:NSASCIIStringEncoding delimiterStartChar:aDelimiterStartChar delimiterStopChar:aDelimiterStopChar];
}

+ (id) newSTGroupFile:(NSString *)aFileName encoding:(NSStringEncoding)theEncoding delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar
{
    return [[STGroupFile alloc] initWithFileName:aFileName encoding:theEncoding delimiterStartChar:aDelimiterStartChar delimiterStopChar:aDelimiterStopChar];
}

+ (id) newSTGroupFileWithFQFN:(NSString *)aFileName encoding:(NSStringEncoding)theEncoding;
{
    return [[STGroupFile alloc] initWithFQFN:aFileName encoding:theEncoding delimiterStartChar:'<' delimiterStopChar:'>'];
}

+ (id) newSTGroupFileWithFQFN:(NSString *)aFileName encoding:(NSStringEncoding)theEncoding delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar;
{
    return [[STGroupFile alloc] initWithFQFN:aFileName encoding:theEncoding delimiterStartChar:aDelimiterStartChar delimiterStopChar:aDelimiterStopChar];
}

+ (id) newSTGroupFileWithURL:(NSURL *)aURL encoding:(NSStringEncoding)theEncoding delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar
{
    return [[STGroupFile alloc] initWithURL:aURL encoding:theEncoding delimiterStartChar:aDelimiterStartChar delimiterStopChar:aDelimiterStopChar];
}

- (id) initWithFileName:(NSString *)aFileName encoding:(NSStringEncoding)theEncoding delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar
{
    BOOL fExists, isDir;
    if (self = [super init:aDelimiterStartChar delimiterStopChar:aDelimiterStopChar]) {
        alreadyLoaded = NO;
        if (![fileName hasSuffix:@".stg"]) {
            @throw [ANTLRRuntimeException newANTLRIllegalArgumentException:[NSString stringWithFormat:@"Group file names must end in .stg: %@", aFileName]];
        }
        
        @try {
            NSFileManager *fm;
            fm = [NSFileManager defaultManager];
            fExists = [fm fileExistsAtPath:aFileName isDirectory:&isDir];
            if (fExists && isDir) {
                URL = [NSURL fileURLWithPath:aFileName];
            }
            else {
#ifdef DONTUSEYET
                ClassLoader * cl = [[Thread currentThread] contextClassLoader];
                URL = [cl getResource:aFileName];
                if (URL == nil) {
                    cl = [[self class] classLoader];
                    URL = [cl getResource:aFileName];
                }
                if (URL == nil) {
                    @throw [ANTLRRuntimeException newANTLRIllegalArgumentException:[NSString stringWithFormat:@"No such group file: %@", aFileName]];
                }
#endif
            }
        }
        @catch (NSException * e) {
            [errMgr internalError:nil msg:[NSString stringWithFormat:@"can't load group file %@", aFileName] e:e];
        }
        fileName = aFileName;
        encoding = theEncoding;
    }
    return self;
}

- (id) initWithFQFN:(NSString *)fullyQualifiedFileName encoding:(NSStringEncoding)theEncoding delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar
{
    if (self = [super init:aDelimiterStartChar delimiterStopChar:aDelimiterStopChar]) {
        alreadyLoaded = NO;
        URL = [NSURL fileURLWithPath:fullyQualifiedFileName];
        encoding = theEncoding;
    }
    return self;
}

- (id) initWithURL:(NSURL *)aURL encoding:(NSStringEncoding)theEncoding delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar
{
    if (self = [super init:aDelimiterStartChar delimiterStopChar:aDelimiterStopChar]) {
        alreadyLoaded = NO;
        URL = aURL;
        encoding = theEncoding;
    }
    return self;
}

- (BOOL) isDefined:(NSString *)name
{
    if (!alreadyLoaded)
        [self load];
    return [super isDefined:name];
}

- (void) unload {
    [super unload];
    alreadyLoaded = NO;
}

- (CompiledST *) load:(NSString *)aName {
    if (!alreadyLoaded)
        [self load];
    return [templates objectForKey:aName];
}

- (void) load {
    if (alreadyLoaded)
        return;
    alreadyLoaded = YES;
    [self loadGroupFile:@"" fileName:[URL description]];
}

- (NSString *) show {
    if (!alreadyLoaded)
        [self load];
    return [super show];
}

- (NSString *) name {
    return [Misc getFileNameNoSuffix:fileName];
}

- (void) dealloc {
    [fileName release];
    [URL release];
    [super dealloc];
}

@end
