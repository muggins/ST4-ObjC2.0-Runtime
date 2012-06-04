#import <Foundation/Foundation.h>
#import <ANTLR/ANTLR.h>
#import "BaseTest.h"
#import "ST.h"
#import "STGroup.h"
#import "STGroupFile.h"
#import "ErrorBuffer.h"
#import "ErrorManager.h"

@interface TestScopes : BaseTest {
}

- (void) test01SeesEnclosingAttr;
- (void) test02MissingArg;
- (void) test03UnknownAttr;
- (void) test04ArgWithSameNameAsEnclosing;
- (void) test05IndexAttrVisibleLocallyOnly;
@end
