#import <Foundation/Foundation.h>
#import <ANTLR/ANTLR.h>
#import "BaseTest.h"
#import "ST.h"
#import "STGroup.h"
#import "STGroupFile.h"
#import "ErrorBuffer.h"
#import "Misc.h"

@interface TestGroupSyntax : BaseTest {
}

- (void) test01SimpleGroup;
- (void) test02MultiTemplates;
- (void) test03SingleTemplateWithArgs;
- (void) test04DefaultValues;
- (void) test05DefaultValueTemplateWithArg;
- (void) test06NestedTemplateInGroupFile;
- (void) test07NestedDefaultValueTemplate;
- (void) test08NestedDefaultValueTemplateWithEscapes;
- (void) test09MessedUpTemplateDoesntCauseRuntimeError;
@end
