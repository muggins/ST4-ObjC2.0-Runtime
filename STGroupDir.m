#import "STGroupDir.h"
#import "STException.h"

@implementation STGroupDir

@synthesize groupDirName;
@synthesize root;

+ (id) newSTGroupDir:(NSString *)aDirName
{
    return [[STGroupDir alloc] init:aDirName encoding:NSASCIIStringEncoding delimiterStartChar:'<' delimiterStopChar:'>'];
}

+ (id) newSTGroupDir:(NSString *)aDirName encoding:(NSStringEncoding)theEncoding
{
    return [[STGroupDir alloc] init:aDirName encoding:theEncoding delimiterStartChar:'<' delimiterStopChar:'>'];
}

+ (id) newSTGroupDir:(NSString *)aDirName delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar
{
    return [[STGroupDir alloc] init:aDirName encoding:NSASCIIStringEncoding delimiterStartChar:aDelimiterStartChar delimiterStopChar:aDelimiterStopChar];
}

+ (id) newSTGroupDir:(NSString *)aDirName encoding:(NSStringEncoding)theEncoding delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar
{
    return [[STGroupDir alloc] init:aDirName encoding:theEncoding delimiterStartChar:aDelimiterStartChar delimiterStopChar:aDelimiterStopChar];
}

+ (id) newSTGroupDirWithURL:(NSURL *)theRoot encoding:(NSStringEncoding)theEncoding delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar
{
    return [[STGroupDir alloc] initWithURL:theRoot encoding:theEncoding delimiterStartChar:aDelimiterStartChar delimiterStopChar:aDelimiterStopChar];
}

- (id) init:(NSString *)aDirName encoding:(NSStringEncoding)theEncoding delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar {
    BOOL fExists, isDir;
    if (self = [super init:aDelimiterStartChar delimiterStopChar:aDelimiterStopChar]) {
        groupDirName = aDirName;
        encoding = theEncoding;
        @try {
            NSFileManager *fm;
            fm = [NSFileManager defaultManager];
            fExists = [fm fileExistsAtPath:aDirName isDirectory:&isDir];
            if (fExists && isDir) {
                root = [NSURL fileURLWithPath:aDirName];
            }
            else {
                [NSThread currentThread];
#ifdef DONTUSEYET
                ClassLoader *cl = [[NSThread currentThread] contextClassLoader];
                root = [cl getResource:aDirName];
                if (root == nil) {
                    cl = [[self class] classLoader];
                    root = [cl getResource:aDirName];
                }
                if (root == nil) {
                    @throw [ANTLRRuntimeException newANTLRIllegalArgumentException:[NSString stringWithFormat@"No such directory: %@", aDirName]];
                }
#endif
            }
        }
        @catch (NSException * e) {
            [errMgr internalError:nil msg:[NSString stringWithFormat:@"can't load group dir %@", aDirName] e:e];
        }
    }
    return self;
}

- (id) initWithURL:(NSURL *)theRoot encoding:(NSStringEncoding)theEncoding delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar {
    if (self = [super init:aDelimiterStartChar delimiterStopChar:aDelimiterStopChar]) {
        root = theRoot;
        encoding = theEncoding;
    }
    return self;
}


/**
 * Load a template from dir or group file.  Group file is given
 * precedence over dir with same name.
 */
- (CompiledST *) load:(NSString *)aName {
    NSString *parent = [Misc getPrefix:aName];
    NSURL *groupFileURL = nil;
    NSString *fileName;
    
    @try {
        // fileName = [NSString stringWithFormat:@"%@.stg", parent] stringByStandardizingPath];
        // groupFileURL = [NSURL fileURLWithPath:[[root URLByAppendingPathComponent:@"%@.stg", parent] stringByStandardizingPath]];
        groupFileURL = [[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@.stg", parent]] URLByStandardizingPath];
    }
    @catch (MalformedURLException *e) {
        [errMgr internalError:nil msg:[NSString stringWithFormat:@"bad URL: %@%@.stg", root, parent] e:e];
        return nil;
    }
    ANTLRInputStream *is = nil;
    
    @try {
        is = [groupFileURL openStream];
    }
    @catch (FileNotFoundException *fnfe) {
        return [self loadTemplateFile:parent fileName:[aName stringByAppendingString:@".st"]];
    }
    @catch (IOException * ioe) {
        [errMgr internalError:nil msg:[@"can't load template file " stringByAppendingString:aName] e:ioe];
    }
    
    @try {
        if (is != nil)
            [is close];
    }
    @catch (IOException * ioe) {
        [errMgr internalError:nil msg:[@"can't close template file stream " stringByAppendingString:aName] e:ioe];
    }
    [self loadGroupFile:parent fileName:[NSString stringWithFormat:@"%@.stg", parent]];
    return [templates objectForKey:aName];
}


/**
 * Load full path name .st file relative to root by prefix
 */
- (CompiledST *) loadTemplateFile:(NSString *)prefix fileName:(NSString *)aFileName {
    NSString * templateName = [Misc getFileNameNoSuffix:aFileName];
    NSURL *f = nil;
    
    @try {
        //f = [NSURL fileURLWithPath:[root URLByAppendingPathComponent:aFileName]];
        f = [NSURL fileURLWithPath:aFileName];
    }
    @catch (MalformedURLException *me) {
        [errMgr runTimeError:nil ip:0 error:INVALID_TEMPLATE_NAME e:me arg:[[root URLByAppendingPathComponent:aFileName] absoluteString]];
        return nil;
    }
    ANTLRInputStream *fs;
    
    @try {
        fs = [ANTLRInputStream newANTLRInputStream:[f openStream] encoding:encoding];
    }
    @catch (IOException *ioe) {
        return nil;
    }
    GroupLexer *lexer = [GroupLexer newGroupLexerWithCharStream:fs];
    fs.name = aFileName;
    ANTLRCommonTokenStream *tokens = [ANTLRCommonTokenStream newANTLRCommonTokenStreamWithTokenSource:lexer];
    GroupParser * aParser = [GroupParser newGroupParser:tokens];
    aParser.group = self;
    lexer.group = self;
    
    @try {
        [aParser templateDef:prefix];
    }
    @catch (ANTLRRecognitionException * re) {
        [errMgr groupSyntaxError:SYNTAX_ERROR srcName:[Misc getFileName:[f file]] e:re msg:[re reason]];
    }
    return [templates objectForKey:templateName];
}

- (NSString *) fileName {
    return [root file];
}

- (void) dealloc {
    [groupDirName release];
    [root release];
    [super dealloc];
}

@end
