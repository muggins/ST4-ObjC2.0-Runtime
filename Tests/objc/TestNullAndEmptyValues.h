#import <Foundation/Foundation.h>
#import <ANTLR/ANTLR.h>
#import "BaseTest.h"

@interface TestNullAndEmptyValues_Anon1 : LinkedHashMap {
}

- (id) init;
@end

@interface TestNullAndEmptyValues : BaseTest {
}

- (void) test01SeparatorWithNullFirstValue;
- (void) test02TemplateAppliedToNullIsEmpty;
- (void) test03TemplateAppliedToMissingValueIsEmpty;
- (void) test04SeparatorWithNull2ndValue;
- (void) test05SeparatorWithNullLastValue;
- (void) test06SeparatorWithTwoNullValuesInRow;
- (void) test07TwoNullValues;
- (void) test08NullListItemNotCountedForIteratorIndex;
- (void) test09SizeZeroButNonNullListGetsNoOutput;
- (void) test10NullListGetsNoOutput;
- (void) test11EmptyListGetsNoOutput;
- (void) test12MissingDictionaryValue;
- (void) test13MissingDictionaryValue2;
- (void) test14MissingDictionaryValue3;
- (void) test15SeparatorEmittedForEmptyIteratorValue;
- (void) test16SeparatorEmittedForEmptyIteratorValue2;
@end
