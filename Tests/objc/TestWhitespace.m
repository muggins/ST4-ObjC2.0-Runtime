#import "TestWhitespace.h"

@implementation TestWhitespace

- (void) testTrimmedSubtemplates {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"test" arg1:@"names" arg2:@"<names:{n | <n>}>!"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"names" arg1:@"Ter"];
  [st add:@"names" arg1:@"Tom"];
  [st add:@"names" arg1:@"Sumana"];
  NSString * expected = @"TerTomSumana!";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testTrimmedSubtemplatesNoArgs {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"test" arg1:@"[<foo({ foo })>]"];
  [group defineTemplate:@"foo" arg1:@"x" arg2:@"<x>"];
  ST * st = [group getInstanceOf:@"test"];
  NSString * expected = @"[ foo ]";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testTrimmedSubtemplatesArgs {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"test" arg1:@"names" arg2:@"<names:{x|  foo }>"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"names" arg1:@"Ter"];
  [st add:@"names" arg1:@"Tom"];
  [st add:@"names" arg1:@"Sumana"];
  NSString * expected = @" foo  foo  foo ";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testTrimJustOneWSInSubtemplates {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"test" arg1:@"names" arg2:@"<names:{n |  <n> }>!"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"names" arg1:@"Ter"];
  [st add:@"names" arg1:@"Tom"];
  [st add:@"names" arg1:@"Sumana"];
  NSString * expected = @" Ter  Tom  Sumana !";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testTrimNewlineInSubtemplates {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"test" arg1:@"names" arg2:[@"<names:{n |\n" stringByAppendingString:@"<n>}>!"]];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"names" arg1:@"Ter"];
  [st add:@"names" arg1:@"Tom"];
  [st add:@"names" arg1:@"Sumana"];
  NSString * expected = @"TerTomSumana!";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testLeaveNewlineOnEndInSubtemplates {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"test" arg1:@"names" arg2:[[@"<names:{n |\n" stringByAppendingString:@"<n>\n"] stringByAppendingString:@"}>!"]];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"names" arg1:@"Ter"];
  [st add:@"names" arg1:@"Tom"];
  [st add:@"names" arg1:@"Sumana"];
  NSString * expected = [[[[@"Ter" stringByAppendingString:newline] stringByAppendingString:@"Tom"] + newline stringByAppendingString:@"Sumana"] + newline stringByAppendingString:@"!"];
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testTabBeforeEndInSubtemplates {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"test" arg1:@"names" arg2:[[@"  <names:{n |\n" stringByAppendingString:@"    <n>\n"] stringByAppendingString:@"  }>!"]];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"names" arg1:@"Ter"];
  [st add:@"names" arg1:@"Tom"];
  [st add:@"names" arg1:@"Sumana"];
  NSString * expected = [[[[@"    Ter" stringByAppendingString:newline] stringByAppendingString:@"    Tom"] + newline stringByAppendingString:@"    Sumana"] + newline stringByAppendingString:@"!"];
  NSString * result = [st render];
  [st.impl dump];
  [self assertEquals:expected arg1:result];
}

- (void) testEmptyExprAsFirstLineGetsNoOutput {
  ST * t = [[[ST alloc] init:[@"<users>\n" stringByAppendingString:@"end\n"]] autorelease];
  NSString * expecting = [@"end" stringByAppendingString:newline];
  NSString * result = [t render];
  [self assertEquals:expecting arg1:result];
}

- (void) testEmptyLineWithIndent {
  ST * t = [[[ST alloc] init:[[@"begin\n" stringByAppendingString:@"    \n"] stringByAppendingString:@"end\n"]] autorelease];
  NSString * expecting = [[@"begin" stringByAppendingString:newline] + newline stringByAppendingString:@"end"] + newline;
  NSString * result = [t render];
  [self assertEquals:expecting arg1:result];
}

- (void) testEmptyLine {
  ST * t = [[[ST alloc] init:[[@"begin\n" stringByAppendingString:@"\n"] stringByAppendingString:@"end\n"]] autorelease];
  NSString * expecting = [[@"begin" stringByAppendingString:newline] + newline stringByAppendingString:@"end"] + newline;
  NSString * result = [t render];
  [self assertEquals:expecting arg1:result];
}

- (void) testSizeZeroOnLineByItselfGetsNoOutput {
  ST * t = [[[ST alloc] init:[[[[@"begin\n" stringByAppendingString:@"<name>\n"] stringByAppendingString:@"<users>\n"] stringByAppendingString:@"<users>\n"] stringByAppendingString:@"end\n"]] autorelease];
  NSString * expecting = @"begin\nend\n";
  NSString * result = [t render];
  [self assertEquals:expecting arg1:result];
}

- (void) testSizeZeroOnLineWithIndentGetsNoOutput {
  ST * t = [[[ST alloc] init:[[[[@"begin\n" stringByAppendingString:@"  <name>\n"] stringByAppendingString:@"	<users>\n"] stringByAppendingString:@"	<users>\n"] stringByAppendingString:@"end\n"]] autorelease];
  NSString * expecting = [[@"begin" stringByAppendingString:newline] stringByAppendingString:@"end"] + newline;
  NSString * result = [t render];
  [self assertEquals:expecting arg1:result];
}

- (void) testSizeZeroOnLineWithMultipleExpr {
  ST * t = [[[ST alloc] init:[[[@"begin\n" stringByAppendingString:@"  <name>\n"] stringByAppendingString:@"	<users><users>\n"] stringByAppendingString:@"end\n"]] autorelease];
  NSString * expecting = [[@"begin" stringByAppendingString:newline] stringByAppendingString:@"end"] + newline;
  NSString * result = [t render];
  [self assertEquals:expecting arg1:result];
}

- (void) testIFExpr {
  ST * t = [[[ST alloc] init:[[@"begin\n" stringByAppendingString:@"<if(x)><endif>\n"] stringByAppendingString:@"end\n"]] autorelease];
  NSString * expecting = [[@"begin" stringByAppendingString:newline] stringByAppendingString:@"end"] + newline;
  NSString * result = [t render];
  [self assertEquals:expecting arg1:result];
}

- (void) testIndentedIFExpr {
  ST * t = [[[ST alloc] init:[[@"begin\n" stringByAppendingString:@"    <if(x)><endif>\n"] stringByAppendingString:@"end\n"]] autorelease];
  NSString * expecting = [[@"begin" stringByAppendingString:newline] stringByAppendingString:@"end"] + newline;
  NSString * result = [t render];
  [self assertEquals:expecting arg1:result];
}

- (void) testIFElseExpr {
  ST * t = [[[ST alloc] init:[[@"begin\n" stringByAppendingString:@"<if(users)><else><endif>\n"] stringByAppendingString:@"end\n"]] autorelease];
  NSString * expecting = [[@"begin" stringByAppendingString:newline] stringByAppendingString:@"end"] + newline;
  NSString * result = [t render];
  [self assertEquals:expecting arg1:result];
}

- (void) testIFOnMultipleLines {
  ST * t = [[[ST alloc] init:[[[[[[@"begin\n" stringByAppendingString:@"<if(users)>\n"] stringByAppendingString:@"foo\n"] stringByAppendingString:@"<else>\n"] stringByAppendingString:@"bar\n"] stringByAppendingString:@"<endif>\n"] stringByAppendingString:@"end\n"]] autorelease];
  NSString * expecting = [[[@"begin" stringByAppendingString:newline] stringByAppendingString:@"bar"] + newline stringByAppendingString:@"end"] + newline;
  NSString * result = [t render];
  [self assertEquals:expecting arg1:result];
}

- (void) testNestedIFOnMultipleLines {
  ST * t = [[[ST alloc] init:[[[[[[[[@"begin\n" stringByAppendingString:@"<if(x)>\n"] stringByAppendingString:@"<if(y)>\n"] stringByAppendingString:@"foo\n"] stringByAppendingString:@"<else>\n"] stringByAppendingString:@"bar\n"] stringByAppendingString:@"<endif>\n"] stringByAppendingString:@"<endif>\n"] stringByAppendingString:@"end\n"]] autorelease];
  [t add:@"x" arg1:@"x"];
  NSString * expecting = [[[@"begin" stringByAppendingString:newline] stringByAppendingString:@"bar"] + newline stringByAppendingString:@"end"] + newline;
  NSString * result = [t render];
  [self assertEquals:expecting arg1:result];
}

- (void) testLineBreak {
  ST * st = [[[ST alloc] init:[[@"Foo <\\\\>" stringByAppendingString:newline] stringByAppendingString:@"  \t  bar"] + newline] autorelease];
  StringWriter * sw = [[[StringWriter alloc] init] autorelease];
  [st write:[[[AutoIndentWriter alloc] init:sw arg1:@"\n"] autorelease]];
  NSString * result = [sw description];
  NSString * expecting = @"Foo bar\n";
  [self assertEquals:expecting arg1:result];
}

- (void) testLineBreak2 {
  ST * st = [[[ST alloc] init:[[@"Foo <\\\\>       " stringByAppendingString:newline] stringByAppendingString:@"  \t  bar"] + newline] autorelease];
  StringWriter * sw = [[[StringWriter alloc] init] autorelease];
  [st write:[[[AutoIndentWriter alloc] init:sw arg1:@"\n"] autorelease]];
  NSString * result = [sw description];
  NSString * expecting = @"Foo bar\n";
  [self assertEquals:expecting arg1:result];
}

- (void) testLineBreakNoWhiteSpace {
  ST * st = [[[ST alloc] init:[[@"Foo <\\\\>" stringByAppendingString:newline] stringByAppendingString:@"bar\n"]] autorelease];
  StringWriter * sw = [[[StringWriter alloc] init] autorelease];
  [st write:[[[AutoIndentWriter alloc] init:sw arg1:@"\n"] autorelease]];
  NSString * result = [sw description];
  NSString * expecting = @"Foo bar\n";
  [self assertEquals:expecting arg1:result];
}

- (void) testNewlineNormalizationInTemplateString {
  ST * st = [[[ST alloc] init:[@"Foo\r\n" stringByAppendingString:@"Bar\n"]] autorelease];
  StringWriter * sw = [[[StringWriter alloc] init] autorelease];
  [st write:[[[AutoIndentWriter alloc] init:sw arg1:@"\n"] autorelease]];
  NSString * result = [sw description];
  NSString * expecting = @"Foo\nBar\n";
  [self assertEquals:expecting arg1:result];
}

- (void) testNewlineNormalizationInTemplateStringPC {
  ST * st = [[[ST alloc] init:[@"Foo\r\n" stringByAppendingString:@"Bar\n"]] autorelease];
  StringWriter * sw = [[[StringWriter alloc] init] autorelease];
  [st write:[[[AutoIndentWriter alloc] init:sw arg1:@"\r\n"] autorelease]];
  NSString * result = [sw description];
  NSString * expecting = @"Foo\r\nBar\r\n";
  [self assertEquals:expecting arg1:result];
}

- (void) testNewlineNormalizationInAttribute {
  ST * st = [[[ST alloc] init:[@"Foo\r\n" stringByAppendingString:@"<name>\n"]] autorelease];
  [st add:@"name" arg1:@"a\nb\r\nc"];
  StringWriter * sw = [[[StringWriter alloc] init] autorelease];
  [st write:[[[AutoIndentWriter alloc] init:sw arg1:@"\n"] autorelease]];
  NSString * result = [sw description];
  NSString * expecting = @"Foo\na\nb\nc\n";
  [self assertEquals:expecting arg1:result];
}

- (void) testCommentOnlyLineGivesNoOutput {
  ST * t = [[[ST alloc] init:[[@"begin\n" stringByAppendingString:@"<! ignore !>\n"] stringByAppendingString:@"end\n"]] autorelease];
  NSString * expecting = [[@"begin" stringByAppendingString:newline] stringByAppendingString:@"end"] + newline;
  NSString * result = [t render];
  [self assertEquals:expecting arg1:result];
}

- (void) testCommentOnlyLineGivesNoOutput2 {
  ST * t = [[[ST alloc] init:[[@"begin\n" stringByAppendingString:@"    <! ignore !>\n"] stringByAppendingString:@"end\n"]] autorelease];
  NSString * expecting = [[@"begin" stringByAppendingString:newline] stringByAppendingString:@"end"] + newline;
  NSString * result = [t render];
  [self assertEquals:expecting arg1:result];
}

@end
