#import <Foundation/Foundation.h>
#import <ANTLR/ANTLR.h>
#import "BaseTest.h"

@interface TestTokensForDollarDelimiters : BaseTest {
}

- (void) test01SimpleAttr;
- (void) test02String;
- (void) test03EscInString;
- (void) test04Subtemplate;
- (void) test05NestedSubtemplate;
@end
