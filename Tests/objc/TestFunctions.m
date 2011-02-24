#import "TestFunctions.h"

@implementation TestFunctions_Anon1

- (void) init {
  if (self = [super init]) {
    [self add:@"Ter"];
    [self add:@"Tom"];
  }
  return self;
}

@end

@implementation TestFunctions_Anon2

- (void) init {
  if (self = [super init]) {
    [self add:@"Ter"];
    [self add:@"Tom"];
  }
  return self;
}

@end

@implementation TestFunctions_Anon3

- (void) init {
  if (self = [super init]) {
    [self add:@"Ter"];
    [self add:nil];
    [self add:@"Tom"];
    [self add:nil];
  }
  return self;
}

@end

@implementation TestFunctions_Anon4

- (void) init {
  if (self = [super init]) {
    [self add:@"Ter"];
  }
  return self;
}

@end

@implementation TestFunctions_Anon5

- (void) init {
  if (self = [super init]) {
    [self add:@"Ter"];
  }
  return self;
}

@end

@implementation TestFunctions_Anon6

- (void) init {
  if (self = [super init]) {
    [self add:m1];
    [self add:m2];
  }
  return self;
}

@end

@implementation TestFunctions_Anon7

- (void) init {
  if (self = [super init]) {
    [self add:m1];
    [self add:m2];
  }
  return self;
}

@end

@implementation TestFunctions

- (void) testFirst {
  NSString * template = @"<first(names)>";
  ST * st = [[[ST alloc] init:template] autorelease];
  NSMutableArray * names = [[[TestFunctions_Anon1 alloc] init] autorelease];
  [st add:@"names" arg1:names];
  NSString * expected = @"Ter";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testLength {
  NSString * template = @"<length(names)>";
  ST * st = [[[ST alloc] init:template] autorelease];
  NSMutableArray * names = [[[TestFunctions_Anon2 alloc] init] autorelease];
  [st add:@"names" arg1:names];
  NSString * expected = @"2";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testLengthWithNullValues {
  NSString * template = @"<length(names)>";
  ST * st = [[[ST alloc] init:template] autorelease];
  NSMutableArray * names = [[[TestFunctions_Anon3 alloc] init] autorelease];
  [st add:@"names" arg1:names];
  NSString * expected = @"4";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) testFirstOp {
  ST * e = [[[ST alloc] init:@"<first(names)>"] autorelease];
  [e add:@"names" arg1:@"Ter"];
  [e add:@"names" arg1:@"Tom"];
  [e add:@"names" arg1:@"Sriram"];
  NSString * expecting = @"Ter";
  [self assertEquals:expecting arg1:[e render]];
}

- (void) testTruncOp {
  ST * e = [[[ST alloc] init:@"<trunc(names); separator=\", \">"] autorelease];
  [e add:@"names" arg1:@"Ter"];
  [e add:@"names" arg1:@"Tom"];
  [e add:@"names" arg1:@"Sriram"];
  NSString * expecting = @"Ter, Tom";
  [self assertEquals:expecting arg1:[e render]];
}

- (void) testRestOp {
  ST * e = [[[ST alloc] init:@"<rest(names); separator=\", \">"] autorelease];
  [e add:@"names" arg1:@"Ter"];
  [e add:@"names" arg1:@"Tom"];
  [e add:@"names" arg1:@"Sriram"];
  NSString * expecting = @"Tom, Sriram";
  [self assertEquals:expecting arg1:[e render]];
}

- (void) testRestOpEmptyList {
  ST * e = [[[ST alloc] init:@"<rest(names); separator=\", \">"] autorelease];
  [e add:@"names" arg1:[[[NSMutableArray alloc] init] autorelease]];
  NSString * expecting = @"";
  [self assertEquals:expecting arg1:[e render]];
}

- (void) testReUseOfRestResult {
  NSString * templates = [[@"a(names) ::= \"<b(rest(names))>\"" stringByAppendingString:newline] stringByAppendingString:@"b(x) ::= \"<x>, <x>\""] + newline;
  [self writeFile:tmpdir arg1:@"t.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[[tmpdir stringByAppendingString:@"/"] stringByAppendingString:@"t.stg"]] autorelease];
  ST * e = [group getInstanceOf:@"a"];
  NSMutableArray * names = [[[NSMutableArray alloc] init] autorelease];
  [names addObject:@"Ter"];
  [names addObject:@"Tom"];
  [e add:@"names" arg1:names];
  NSString * expecting = @"Tom, Tom";
  [self assertEquals:expecting arg1:[e render]];
}

- (void) testLastOp {
  ST * e = [[[ST alloc] init:@"<last(names)>"] autorelease];
  [e add:@"names" arg1:@"Ter"];
  [e add:@"names" arg1:@"Tom"];
  [e add:@"names" arg1:@"Sriram"];
  NSString * expecting = @"Sriram";
  [self assertEquals:expecting arg1:[e render]];
}

- (void) testStripOp {
  ST * e = [[[ST alloc] init:@"<strip(names); null=\"n/a\">"] autorelease];
  [e add:@"names" arg1:nil];
  [e add:@"names" arg1:@"Tom"];
  [e add:@"names" arg1:nil];
  [e add:@"names" arg1:nil];
  [e add:@"names" arg1:@"Sriram"];
  [e add:@"names" arg1:nil];
  NSString * expecting = @"TomSriram";
  [self assertEquals:expecting arg1:[e render]];
}

- (void) testLengthStrip {
  ST * e = [[[ST alloc] init:@"<length(strip(names))>"] autorelease];
  [e add:@"names" arg1:nil];
  [e add:@"names" arg1:@"Tom"];
  [e add:@"names" arg1:nil];
  [e add:@"names" arg1:nil];
  [e add:@"names" arg1:@"Sriram"];
  [e add:@"names" arg1:nil];
  NSString * expecting = @"2";
  [self assertEquals:expecting arg1:[e render]];
}

- (void) testCombinedOp {
  ST * e = [[[ST alloc] init:@"<[first(mine),rest(yours)]; separator=\", \">"] autorelease];
  [e add:@"mine" arg1:@"1"];
  [e add:@"mine" arg1:@"2"];
  [e add:@"mine" arg1:@"3"];
  [e add:@"yours" arg1:@"a"];
  [e add:@"yours" arg1:@"b"];
  NSString * expecting = @"1, b";
  [self assertEquals:expecting arg1:[e render]];
}

- (void) testCatListAndSingleAttribute {
  ST * e = [[[ST alloc] init:@"<[mine,yours]; separator=\", \">"] autorelease];
  [e add:@"mine" arg1:@"1"];
  [e add:@"mine" arg1:@"2"];
  [e add:@"mine" arg1:@"3"];
  [e add:@"yours" arg1:@"a"];
  NSString * expecting = @"1, 2, 3, a";
  [self assertEquals:expecting arg1:[e render]];
}

- (void) testReUseOfCat {
  NSString * templates = [[@"a(mine,yours) ::= \"<b([mine,yours])>\"" stringByAppendingString:newline] stringByAppendingString:@"b(x) ::= \"<x>, <x>\""] + newline;
  [self writeFile:tmpdir arg1:@"t.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[[tmpdir stringByAppendingString:@"/"] stringByAppendingString:@"t.stg"]] autorelease];
  ST * e = [group getInstanceOf:@"a"];
  NSMutableArray * mine = [[[NSMutableArray alloc] init] autorelease];
  [mine addObject:@"Ter"];
  [mine addObject:@"Tom"];
  [e add:@"mine" arg1:mine];
  NSMutableArray * yours = [[[NSMutableArray alloc] init] autorelease];
  [yours addObject:@"Foo"];
  [e add:@"yours" arg1:yours];
  NSString * expecting = @"TerTomFoo, TerTomFoo";
  [self assertEquals:expecting arg1:[e render]];
}

- (void) testCatListAndEmptyAttributes {
  ST * e = [[[ST alloc] init:@"<[x,mine,y,yours,z]; separator=\", \">"] autorelease];
  [e add:@"mine" arg1:@"1"];
  [e add:@"mine" arg1:@"2"];
  [e add:@"mine" arg1:@"3"];
  [e add:@"yours" arg1:@"a"];
  NSString * expecting = @"1, 2, 3, a";
  [self assertEquals:expecting arg1:[e render]];
}

- (void) testNestedOp {
  ST * e = [[[ST alloc] init:@"<first(rest(names))>"] autorelease];
  [e add:@"names" arg1:@"Ter"];
  [e add:@"names" arg1:@"Tom"];
  [e add:@"names" arg1:@"Sriram"];
  NSString * expecting = @"Tom";
  [self assertEquals:expecting arg1:[e render]];
}

- (void) testFirstWithOneAttributeOp {
  ST * e = [[[ST alloc] init:@"<first(names)>"] autorelease];
  [e add:@"names" arg1:@"Ter"];
  NSString * expecting = @"Ter";
  [self assertEquals:expecting arg1:[e render]];
}

- (void) testLastWithOneAttributeOp {
  ST * e = [[[ST alloc] init:@"<last(names)>"] autorelease];
  [e add:@"names" arg1:@"Ter"];
  NSString * expecting = @"Ter";
  [self assertEquals:expecting arg1:[e render]];
}

- (void) testLastWithLengthOneListAttributeOp {
  ST * e = [[[ST alloc] init:@"<last(names)>"] autorelease];
  [e add:@"names" arg1:[[[TestFunctions_Anon4 alloc] init] autorelease]];
  NSString * expecting = @"Ter";
  [self assertEquals:expecting arg1:[e render]];
}

- (void) testRestWithOneAttributeOp {
  ST * e = [[[ST alloc] init:@"<rest(names)>"] autorelease];
  [e add:@"names" arg1:@"Ter"];
  NSString * expecting = @"";
  [self assertEquals:expecting arg1:[e render]];
}

- (void) testRestWithLengthOneListAttributeOp {
  ST * e = [[[ST alloc] init:@"<rest(names)>"] autorelease];
  [e add:@"names" arg1:[[[TestFunctions_Anon5 alloc] init] autorelease]];
  NSString * expecting = @"";
  [self assertEquals:expecting arg1:[e render]];
}

- (void) testRepeatedRestOp {
  ST * e = [[[ST alloc] init:@"<rest(names)>, <rest(names)>"] autorelease];
  [e add:@"names" arg1:@"Ter"];
  [e add:@"names" arg1:@"Tom"];
  NSString * expecting = @"Tom, Tom";
  [self assertEquals:expecting arg1:[e render]];
}

- (void) testIncomingLists {
  ST * e = [[[ST alloc] init:@"<rest(names)>, <rest(names)>"] autorelease];
  [e add:@"names" arg1:@"Ter"];
  [e add:@"names" arg1:@"Tom"];
  NSString * expecting = @"Tom, Tom";
  [self assertEquals:expecting arg1:[e render]];
}

- (void) testFirstWithCatAttribute {
  ST * e = [[[ST alloc] init:@"<first([names,phones])>"] autorelease];
  [e add:@"names" arg1:@"Ter"];
  [e add:@"names" arg1:@"Tom"];
  [e add:@"phones" arg1:@"1"];
  [e add:@"phones" arg1:@"2"];
  NSString * expecting = @"Ter";
  [self assertEquals:expecting arg1:[e render]];
}

- (void) testFirstWithListOfMaps {
  ST * e = [[[ST alloc] init:@"<first(maps).Ter>"] autorelease];
  NSMutableDictionary * m1 = [[[NSMutableDictionary alloc] init] autorelease];
  NSMutableDictionary * m2 = [[[NSMutableDictionary alloc] init] autorelease];
  [m1 setObject:@"Ter" arg1:@"x5707"];
  [e add:@"maps" arg1:m1];
  [m2 setObject:@"Tom" arg1:@"x5332"];
  [e add:@"maps" arg1:m2];
  NSString * expecting = @"x5707";
  [self assertEquals:expecting arg1:[e render]];
  NSMutableArray * list = [[[TestFunctions_Anon6 alloc] init] autorelease];
  [e add:@"maps" arg1:list];
  expecting = @"x5707";
  [self assertEquals:expecting arg1:[e render]];
}

- (void) testFirstWithListOfMaps2 {
  ST * e = [[[ST alloc] init:@"<first(maps):{ m | <m>!}>"] autorelease];
  NSMutableDictionary * m1 = [[[NSMutableDictionary alloc] init] autorelease];
  NSMutableDictionary * m2 = [[[NSMutableDictionary alloc] init] autorelease];
  [m1 setObject:@"Ter" arg1:@"x5707"];
  [e add:@"maps" arg1:m1];
  [m2 setObject:@"Tom" arg1:@"x5332"];
  [e add:@"maps" arg1:m2];
  NSString * expecting = @"Ter!";
  [self assertEquals:expecting arg1:[e render]];
  NSMutableArray * list = [[[TestFunctions_Anon7 alloc] init] autorelease];
  [e add:@"maps" arg1:list];
  expecting = @"Ter!";
  [self assertEquals:expecting arg1:[e render]];
}

- (void) testTrim {
  ST * e = [[[ST alloc] init:@"<trim(name)>"] autorelease];
  [e add:@"name" arg1:@" Ter  \n"];
  NSString * expecting = @"Ter";
  [self assertEquals:expecting arg1:[e render]];
}

- (void) testStrlen {
  ST * e = [[[ST alloc] init:@"<strlen(name)>"] autorelease];
  [e add:@"name" arg1:@"012345"];
  NSString * expecting = @"6";
  [self assertEquals:expecting arg1:[e render]];
}

- (void) testReverse {
  ST * e = [[[ST alloc] init:@"<reverse(names); separator=\", \">"] autorelease];
  [e add:@"names" arg1:@"Ter"];
  [e add:@"names" arg1:@"Tom"];
  [e add:@"names" arg1:@"Sriram"];
  NSString * expecting = @"Sriram, Tom, Ter";
  [self assertEquals:expecting arg1:[e render]];
}

@end
