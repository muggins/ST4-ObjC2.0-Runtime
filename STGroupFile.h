#import "CompiledST.h"
#import "STGroup.h"
#import "Misc.h"
//#import "File.h"
//#import "URL.h"

/**
 * The internal representation of a single group file (which must end in
 * ".stg").  If we fail to find a group file, look for it via the
 * CLASSPATH as a resource.
 */

@interface STGroupFile : STGroup {
  NSString *fileName;
  NSURL *URL;
  BOOL alreadyLoaded;
}

@property (assign, getter=getAlreadyLoaded, setter=setAlreadyLoaded:) BOOL alreadyLoaded;
@property(retain, getter=getFileName, setter=setFileName:) NSString *fileName;
@property(retain, getter=getURL, setter=setURL:) NSURL *URL;

+ (id) newSTGroupFile:(NSString *)aFileName;
+ (id) newSTGroupFile:(NSString *)aFileName encoding:(NSStringEncoding)theEncoding;
+ (id) newSTGroupFile:(NSString *)aFileName delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar;
+ (id) newSTGroupFile:(NSString *)aFileName encoding:(NSStringEncoding)theEncoding delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar;
+ (id) newSTGroupFileWithFQFN:(NSString *)aFileName encoding:(NSStringEncoding)theEncoding;
+ (id) newSTGroupFileWithFQFN:(NSString *)aFileName encoding:(NSStringEncoding)theEncoding delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar;
+ (id) newSTGroupFileWithURL:(NSURL *)aURL encoding:(NSStringEncoding)theEncoding delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar;

- (id) initWithFileName:(NSString *)fileName encoding:(NSStringEncoding)encoding delimiterStartChar:(unichar)delimiterStartChar delimiterStopChar:(unichar)delimiterStopChar;
- (id) initWithFQFN:(NSString *)fullyQualifiedFileName encoding:(NSStringEncoding)encoding delimiterStartChar:(unichar)delimiterStartChar delimiterStopChar:(unichar)delimiterStopChar;
- (id) initWithURL:(NSURL *)aURL encoding:(NSStringEncoding)encoding delimiterStartChar:(unichar)delimiterStartChar delimiterStopChar:(unichar)delimiterStopChar;
- (BOOL) isDefined:(NSString *)name;
- (void) unload;
- (CompiledST *) load:(NSString *)name;
- (void) load;
- (NSString *) show;
@end
