#import <ANTLR/ANTLR.h>
#import "ST.h"
//#import "ANTLRInputStream.h"
//#import "CommonTokenStream.h"
//#import "RecognitionException.h"
#import "CompiledST.h"
#import "GroupLexer.h"
#import "GroupParser.h"
#import "ErrorType.h"
#import "Misc.h"
//#import "File.h"
//#import "FileNotFoundException.h"
//#import "IOException.h"
//#import "InputStream.h"
//#import "MalformedURLException.h"
//#import "URL.h"

/**
 * A directory or directory tree full of templates and/or group files.
 * We load files on-demand. If we fail to find a file, we look for it via
 * the CLASSPATH as a resource.  I track everything with URLs not file names.
 */

@interface STGroupDir : STGroup {
  NSString *groupDirName;
  NSURL *root;
}

@property(retain, getter=getGroupDirName, setter=setGroupDirName:) NSString *groupDirName;
@property(retain, getter=getRoot, setter=setRoot:) NSURL *root;

+ (id) newSTGroupDir:(NSString *)aDirName;
+ (id) newSTGroupDir:(NSString *)aDirName encoding:(NSStringEncoding)theEncoding;
+ (id) newSTGroupDir:(NSString *)aDirName delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar;
+ (id) newSTGroupDir:(NSString *)aDirName encoding:(NSStringEncoding)theEncoding delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar;
+ (id) newSTGroupDirWithURL:(NSURL *)theRoot encoding:(NSStringEncoding)theEncoding delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar;

- (id) init:(NSString *)dirName encoding:(NSStringEncoding)theEncoding delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar;
- (id) initWithURL:(NSURL *)theRoot encoding:(NSStringEncoding)theEncoding delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar;
- (CompiledST *) load:(NSString *)name;
- (CompiledST *) loadTemplateFile:(NSString *)prefix fileName:(NSString *)fileName;
@end
