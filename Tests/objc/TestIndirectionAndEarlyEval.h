#import <Foundation/Foundation.h>
#import <ANTLR/ANTLR.h>
#import "BaseTest.h"
#import "ST.h"
#import "STGroup.h"

@interface TestIndirectionAndEarlyEval : BaseTest {
}

- (void) test01EarlyEval;
- (void) test02IndirectTemplateInclude;
- (void) test03IndirectTemplateIncludeWithArgs;
- (void) test04IndirectTemplateIncludeViaTemplate;
- (void) test05IndirectProp;
- (void) test06IndirectMap;
- (void) test07NonStringDictLookup;
@end
