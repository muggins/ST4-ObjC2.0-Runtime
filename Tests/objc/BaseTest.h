#import <cocoa/cocoa.h>
#import <ANTLR/ANTLR.h>
#import "CommonTokenStream.h"
#import "Token.h"
#import "Before.h"
#import "STGroup.h"
#import "Compiler.h"
#import "STLexer.h"
#import "Misc.h"
#import "BufferedWriter.h"
#import "File.h"
#import "FileWriter.h"
#import "IOException.h"
#import "Assert.h"

@interface User : NSObject {
  int num;
  NSString * name;
}

@property(nonatomic, readonly) BOOL manager;
@property(nonatomic, retain, readonly) NSString *name;
- (id) init:(int)aNum name:(NSString *)aName;
- (BOOL) hasParkingSpot;
@end

@interface HashableUser : User {
}

- (id) init:(int)aNum name:(NSString *)name;
- (int) hash;
- (BOOL) isEqualTo:(NSObject *)o;
@end

extern NSString * const tmpdir;
extern NSString * const newline;

@interface BaseTest : NSObject {
}

@property(nonatomic, retain, readonly) NSString *randomDir;
- (void) setUp;
+ (void) writeFile:(NSString *)dir fileName:(NSString *)fileName content:(NSString *)content;
- (void) checkTokens:(NSString *)template expected:(NSString *)expected;
- (void) checkTokens:(NSString *)template expected:(NSString *)expected delimiterStartChar:(unichar)delimiterStartChar delimiterStopChar:(unichar)delimiterStopChar;
@end
