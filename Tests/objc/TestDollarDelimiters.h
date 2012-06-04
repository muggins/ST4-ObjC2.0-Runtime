#import <Foundation/Foundation.h>
#import <ANTLR/ANTLR.h>
#import "BaseTest.h"
#import "ST.h"
#import "STGroup.h"
#import "STGroupFile.h"

@interface TestDollarDelimiters : BaseTest {
}

- (void) test01Attr;
- (void) test02ParallelMap;
- (void) test03RefToAnotherTemplateInSameGroup;
- (void) test04DefaultArgument;
@end
