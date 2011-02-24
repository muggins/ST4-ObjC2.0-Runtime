#import "Test.h"
#import "AutoIndentWriter.h"
#import "ST.h"
#import "STGroup.h"
#import "StringWriter.h"
#import "Assert.h"

@interface TestWhitespace : BaseTest {
}

- (void) testTrimmedSubtemplates;
- (void) testTrimmedSubtemplatesNoArgs;
- (void) testTrimmedSubtemplatesArgs;
- (void) testTrimJustOneWSInSubtemplates;
- (void) testTrimNewlineInSubtemplates;
- (void) testLeaveNewlineOnEndInSubtemplates;
- (void) testTabBeforeEndInSubtemplates;
- (void) testEmptyExprAsFirstLineGetsNoOutput;
- (void) testEmptyLineWithIndent;
- (void) testEmptyLine;
- (void) testSizeZeroOnLineByItselfGetsNoOutput;
- (void) testSizeZeroOnLineWithIndentGetsNoOutput;
- (void) testSizeZeroOnLineWithMultipleExpr;
- (void) testIFExpr;
- (void) testIndentedIFExpr;
- (void) testIFElseExpr;
- (void) testIFOnMultipleLines;
- (void) testNestedIFOnMultipleLines;
- (void) testLineBreak;
- (void) testLineBreak2;
- (void) testLineBreakNoWhiteSpace;
- (void) testNewlineNormalizationInTemplateString;
- (void) testNewlineNormalizationInTemplateStringPC;
- (void) testNewlineNormalizationInAttribute;
- (void) testCommentOnlyLineGivesNoOutput;
- (void) testCommentOnlyLineGivesNoOutput2;
@end
