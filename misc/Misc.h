//#import "File.h"
//#import "Field.h"
//#import "InvocationTargetException.h"
//#import "Method.h"
//#import "NSEnumerator.h"
#import "Coordinate.h"
#import <objc/runtime.h>


//@class Method;

@interface Misc : NSObject {
}

+ (NSString *) newline;
+ (NSString *) join:(NSEnumerator *)iter separator:(NSString *)separator;
+ (NSString *) strip:(NSString *)s n:(NSInteger)n;
+ (NSString *) trimOneStartingNewline:(NSString *)s;
+ (NSString *) trimOneTrailingNewline:(NSString *)s;
+ (NSString *) getFileNameNoSuffix:(NSString *)f;
+ (NSString *) getFileName:(NSString *)fullFileName;
+ (NSString *) getPrefix:(NSString *)name;
+ (NSString *) replaceEscapes:(NSString *)s;
+ (Coordinate *) getLineCharPosition:(NSString *)s index:(NSInteger)index;
#pragma mark error fix accessField
//#ifdef DONTUSEYET
+ (id) accessField:(Ivar)f obj:(id)obj value:(id)value;
//#endif
+ (id) invokeMethod:(Method *)m obj:(id)obj value:(id)value;
+ (Method *) getMethod:(id)c methodName:(NSString *)methodName;
@end
