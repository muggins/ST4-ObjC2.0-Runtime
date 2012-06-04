#import <Foundation/Foundation.h>
#import <ANTLR/ANTLR.h>
#import "BaseTest.h"
#import "ST.h"
#import "STGroup.h"
#import "STGroupFile.h"
#import "ErrorBuffer.h"
#import "Misc.h"

@interface UserHiddenName : NSObject {
  NSString *name;
}

- (id) initWithName:(NSString *)name;
- (NSString *) getName;
@end

@interface UserHiddenNameField : NSObject {
  NSString *name;
}

- (id) initWithName:(NSString *)name;
@end

@interface TestInterptimeErrors : BaseTest {
}

- (void) test01MissingEmbeddedTemplate;
- (void) test02MissingSuperTemplate;
- (void) test03NoPropertyNotError;
- (void) test04HiddenPropertyNotError;
- (void) test05HiddenFieldNotError;
- (void) test06SoleArg;
- (void) test07SoleArgUsingApplySyntax;
- (void) test08UndefinedAttr;
- (void) test09ParallelAttributeIterationWithMissingArgs;
- (void) test10StringTypeMismatch;
- (void) test11StringTypeMismatch2;
@end
