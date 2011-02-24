#import "TestOptions.h"

@implementation TestOptions

- (void) testSeparator {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"test" arg1:@"name" arg2:@"hi <name; separator=\", \">!"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"name" arg1:@"Ter"];
  [st add:@"name" arg1:@"Tom"];
  [st add:@"name" arg1:@"Sumana"];
  NSString * expected = @"hi Ter, Tom, Sumana!";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testSeparatorWithSpaces {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  STGroup.debug = YES;
  [group defineTemplate:@"test" arg1:@"name" arg2:@"hi <name; separator= \", \">!"];
  ST * st = [group getInstanceOf:@"test"];
  [System.out println:[st.impl.ast toStringTree]];
  [st add:@"name" arg1:@"Ter"];
  [st add:@"name" arg1:@"Tom"];
  [st add:@"name" arg1:@"Sumana"];
  NSString * expected = @"hi Ter, Tom, Sumana!";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testAttrSeparator {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"test" arg1:@"name,sep" arg2:@"hi <name; separator=sep>!"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"sep" arg1:@", "];
  [st add:@"name" arg1:@"Ter"];
  [st add:@"name" arg1:@"Tom"];
  [st add:@"name" arg1:@"Sumana"];
  NSString * expected = @"hi Ter, Tom, Sumana!";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testIncludeSeparator {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"foo" arg1:@"|"];
  [group defineTemplate:@"test" arg1:@"name,sep" arg2:@"hi <name; separator=foo()>!"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"sep" arg1:@", "];
  [st add:@"name" arg1:@"Ter"];
  [st add:@"name" arg1:@"Tom"];
  [st add:@"name" arg1:@"Sumana"];
  NSString * expected = @"hi Ter|Tom|Sumana!";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testSubtemplateSeparator {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"test" arg1:@"name,sep" arg2:@"hi <name; separator={<sep> _}>!"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"sep" arg1:@","];
  [st add:@"name" arg1:@"Ter"];
  [st add:@"name" arg1:@"Tom"];
  [st add:@"name" arg1:@"Sumana"];
  NSString * expected = @"hi Ter, _Tom, _Sumana!";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testSeparatorWithNullFirstValueAndNullOption {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"test" arg1:@"name" arg2:@"hi <name; null=\"n/a\", separator=\", \">!"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"name" arg1:nil];
  [st add:@"name" arg1:@"Tom"];
  [st add:@"name" arg1:@"Sumana"];
  NSString * expected = @"hi n/a, Tom, Sumana!";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testSeparatorWithNull2ndValueAndNullOption {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"test" arg1:@"name" arg2:@"hi <name; null=\"n/a\", separator=\", \">!"];
  ST * st = [group getInstanceOf:@"test"];
  [st.impl dump];
  [st add:@"name" arg1:@"Ter"];
  [st add:@"name" arg1:nil];
  [st add:@"name" arg1:@"Sumana"];
  NSString * expected = @"hi Ter, n/a, Sumana!";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testNullValueAndNullOption {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"test" arg1:@"name" arg2:@"<name; null=\"n/a\">"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"name" arg1:nil];
  NSString * expected = @"n/a";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testListApplyWithNullValueAndNullOption {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"test" arg1:@"name" arg2:@"<name:{n | <n>}; null=\"n/a\">"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"name" arg1:@"Ter"];
  [st add:@"name" arg1:nil];
  [st add:@"name" arg1:@"Sumana"];
  NSString * expected = @"Tern/aSumana";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testDoubleListApplyWithNullValueAndNullOption {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"test" arg1:@"name" arg2:@"<name:{n | <n>}:{n | [<n>]}; null=\"n/a\">"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"name" arg1:@"Ter"];
  [st add:@"name" arg1:nil];
  [st add:@"name" arg1:@"Sumana"];
  NSString * expected = @"[Ter]n/a[Sumana]";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testMissingValueAndNullOption {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"test" arg1:@"name" arg2:@"<name; null=\"n/a\">"];
  ST * st = [group getInstanceOf:@"test"];
  NSString * expected = @"n/a";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testOptionDoesntApplyToNestedTemplate {
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group defineTemplate:@"foo" arg1:@"<zippo>"];
  [group defineTemplate:@"test" arg1:@"zippo" arg2:@"<foo(); null=\"n/a\">"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"zippo" arg1:nil];
  NSString * expected = @"";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testIllegalOption {
  ErrorBuffer * errors = [[[ErrorBuffer alloc] init] autorelease];
  STGroup * group = [[[STGroup alloc] init] autorelease];
  [group setListener:errors];
  [group defineTemplate:@"test" arg1:@"name" arg2:@"<name; bad=\"ugly\">"];
  ST * st = [group getInstanceOf:@"test"];
  [st add:@"name" arg1:@"Ter"];
  NSString * expected = @"Ter";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
  expected = @"[test 1:7: no such option: bad]";
  [self assertEquals:expected arg1:[errors.errors description]];
}

@end
