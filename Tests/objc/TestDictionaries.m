#import "TestDictionaries.h"

@implementation TestDictionaries

- (void) testDict {
  NSString * templates = [[@"typeInit ::= [\"int\":\"0\", \"float\":\"0.0\"] " stringByAppendingString:newline] stringByAppendingString:@"var(type,name) ::= \"<type> <name> = <typeInit.(type)>;\""] + newline;
  [self writeFile:tmpdir arg1:@"test.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[[tmpdir stringByAppendingString:@"/"] stringByAppendingString:@"test.stg"]] autorelease];
  ST * st = [group getInstanceOf:@"var"];
  [st add:@"type" arg1:@"int"];
  [st add:@"name" arg1:@"x"];
  NSString * expecting = @"int x = 0;";
  NSString * result = [st render];
  [self assertEquals:expecting arg1:result];
}

- (void) testDictValuesAreTemplates {
  NSString * templates = [[@"typeInit ::= [\"int\":{0<w>}, \"float\":{0.0<w>}] " stringByAppendingString:newline] stringByAppendingString:@"var(type,w,name) ::= \"<type> <name> = <typeInit.(type)>;\""] + newline;
  [self writeFile:tmpdir arg1:@"test.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[[tmpdir stringByAppendingString:@"/"] stringByAppendingString:@"test.stg"]] autorelease];
  ST * st = [group getInstanceOf:@"var"];
  [st.impl dump];
  [st add:@"w" arg1:@"L"];
  [st add:@"type" arg1:@"int"];
  [st add:@"name" arg1:@"x"];
  NSString * expecting = @"int x = 0L;";
  NSString * result = [st render];
  [self assertEquals:expecting arg1:result];
}

- (void) testDictKeyLookupViaTemplate {
  NSString * templates = [[@"typeInit ::= [\"int\":{0<w>}, \"float\":{0.0<w>}] " stringByAppendingString:newline] stringByAppendingString:@"var(type,w,name) ::= \"<type> <name> = <typeInit.(type)>;\""] + newline;
  [self writeFile:tmpdir arg1:@"test.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[[tmpdir stringByAppendingString:@"/"] stringByAppendingString:@"test.stg"]] autorelease];
  ST * st = [group getInstanceOf:@"var"];
  [st add:@"w" arg1:@"L"];
  [st add:@"type" arg1:[[[ST alloc] init:@"int"] autorelease]];
  [st add:@"name" arg1:@"x"];
  NSString * expecting = @"int x = 0L;";
  NSString * result = [st render];
  [self assertEquals:expecting arg1:result];
}

- (void) testDictKeyLookupAsNonToStringableObject {
  NSString * templates = [@"foo(m,k) ::= \"<m.(k)>\"" stringByAppendingString:newline];
  [self writeFile:tmpdir arg1:@"test.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[[tmpdir stringByAppendingString:@"/"] stringByAppendingString:@"test.stg"]] autorelease];
  ST * st = [group getInstanceOf:@"foo"];
  NSMutableDictionary * m = [[[NSMutableDictionary alloc] init] autorelease];
  [m setObject:[[[HashableUser alloc] init:99 arg1:@"parrt"] autorelease] arg1:@"first"];
  [m setObject:[[[HashableUser alloc] init:172036 arg1:@"tombu"] autorelease] arg1:@"second"];
  [m setObject:[[[HashableUser alloc] init:391 arg1:@"sriram"] autorelease] arg1:@"third"];
  [st add:@"m" arg1:m];
  [st add:@"k" arg1:[[[HashableUser alloc] init:172036 arg1:@"tombu"] autorelease]];
  NSString * expecting = @"second";
  NSString * result = [st render];
  [self assertEquals:expecting arg1:result];
}

- (void) testDictMissingDefaultValueIsEmpty {
  NSString * templates = [[@"typeInit ::= [\"int\":\"0\", \"float\":\"0.0\"] " stringByAppendingString:newline] stringByAppendingString:@"var(type,w,name) ::= \"<type> <name> = <typeInit.(type)>;\""] + newline;
  [self writeFile:tmpdir arg1:@"test.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[[tmpdir stringByAppendingString:@"/"] stringByAppendingString:@"test.stg"]] autorelease];
  ST * st = [group getInstanceOf:@"var"];
  [st add:@"w" arg1:@"L"];
  [st add:@"type" arg1:@"double"];
  [st add:@"name" arg1:@"x"];
  NSString * expecting = @"double x = ;";
  NSString * result = [st render];
  [self assertEquals:expecting arg1:result];
}

- (void) testDictMissingDefaultValueIsEmptyForNullKey {
  NSString * templates = [[@"typeInit ::= [\"int\":\"0\", \"float\":\"0.0\"] " stringByAppendingString:newline] stringByAppendingString:@"var(type,w,name) ::= \"<type> <name> = <typeInit.(type)>;\""] + newline;
  [self writeFile:tmpdir arg1:@"test.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[[tmpdir stringByAppendingString:@"/"] stringByAppendingString:@"test.stg"]] autorelease];
  ST * st = [group getInstanceOf:@"var"];
  [st add:@"w" arg1:@"L"];
  [st add:@"type" arg1:nil];
  [st add:@"name" arg1:@"x"];
  NSString * expecting = @" x = ;";
  NSString * result = [st render];
  [self assertEquals:expecting arg1:result];
}

- (void) testDictHiddenByFormalArg {
  NSString * templates = [[@"typeInit ::= [\"int\":\"0\", \"float\":\"0.0\"] " stringByAppendingString:newline] stringByAppendingString:@"var(typeInit,type,name) ::= \"<type> <name> = <typeInit.(type)>;\""] + newline;
  [self writeFile:tmpdir arg1:@"test.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[[tmpdir stringByAppendingString:@"/"] stringByAppendingString:@"test.stg"]] autorelease];
  ST * st = [group getInstanceOf:@"var"];
  [st add:@"type" arg1:@"int"];
  [st add:@"name" arg1:@"x"];
  NSString * expecting = @"int x = ;";
  NSString * result = [st render];
  [self assertEquals:expecting arg1:result];
}

- (void) testDictEmptyValueAndAngleBracketStrings {
  NSString * templates = [[@"typeInit ::= [\"int\":\"0\", \"float\":, \"double\":<<0.0L>>] " stringByAppendingString:newline] stringByAppendingString:@"var(type,name) ::= \"<type> <name> = <typeInit.(type)>;\""] + newline;
  [self writeFile:tmpdir arg1:@"test.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[[tmpdir stringByAppendingString:@"/"] stringByAppendingString:@"test.stg"]] autorelease];
  ST * st = [group getInstanceOf:@"var"];
  [st add:@"type" arg1:@"float"];
  [st add:@"name" arg1:@"x"];
  NSString * expecting = @"float x = ;";
  NSString * result = [st render];
  [self assertEquals:expecting arg1:result];
}

- (void) testDictDefaultValue {
  NSString * templates = [[@"typeInit ::= [\"int\":\"0\", default:\"null\"] " stringByAppendingString:newline] stringByAppendingString:@"var(type,name) ::= \"<type> <name> = <typeInit.(type)>;\""] + newline;
  [self writeFile:tmpdir arg1:@"test.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[[tmpdir stringByAppendingString:@"/"] stringByAppendingString:@"test.stg"]] autorelease];
  ST * st = [group getInstanceOf:@"var"];
  [st add:@"type" arg1:@"UserRecord"];
  [st add:@"name" arg1:@"x"];
  NSString * expecting = @"UserRecord x = null;";
  NSString * result = [st render];
  [self assertEquals:expecting arg1:result];
}

- (void) testDictNullKeyGetsDefaultValue {
  NSString * templates = [[@"typeInit ::= [\"int\":\"0\", default:\"null\"] " stringByAppendingString:newline] stringByAppendingString:@"var(type,name) ::= \"<type> <name> = <typeInit.(type)>;\""] + newline;
  [self writeFile:tmpdir arg1:@"test.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[[tmpdir stringByAppendingString:@"/"] stringByAppendingString:@"test.stg"]] autorelease];
  ST * st = [group getInstanceOf:@"var"];
  [st add:@"name" arg1:@"x"];
  NSString * expecting = @" x = null;";
  NSString * result = [st render];
  [self assertEquals:expecting arg1:result];
}

- (void) testDictEmptyDefaultValue {
  NSString * templates = [[@"typeInit ::= [\"int\":\"0\", default:] " stringByAppendingString:newline] stringByAppendingString:@"var(type,name) ::= \"<type> <name> = <typeInit.(type)>;\""] + newline;
  [self writeFile:tmpdir arg1:@"test.stg" arg2:templates];
  ErrorBuffer * errors = [[[ErrorBuffer alloc] init] autorelease];
  STGroupFile * group = [[[STGroupFile alloc] init:[[tmpdir stringByAppendingString:@"/"] stringByAppendingString:@"test.stg"]] autorelease];
  [group setListener:errors];
  [group load];
  NSString * expected = @"[test.stg 1:33: missing value for key at ']']";
  NSString * result = [errors.errors description];
  [self assertEquals:expected arg1:result];
}

- (void) testDictDefaultValueIsKey {
  NSString * templates = [[@"typeInit ::= [\"int\":\"0\", default:key] " stringByAppendingString:newline] stringByAppendingString:@"var(type,name) ::= \"<type> <name> = <typeInit.(type)>;\""] + newline;
  [self writeFile:tmpdir arg1:@"test.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[[tmpdir stringByAppendingString:@"/"] stringByAppendingString:@"test.stg"]] autorelease];
  ST * st = [group getInstanceOf:@"var"];
  [st add:@"type" arg1:@"UserRecord"];
  [st add:@"name" arg1:@"x"];
  NSString * expecting = @"UserRecord x = UserRecord;";
  NSString * result = [st render];
  [self assertEquals:expecting arg1:result];
}


/**
 * Test that a map can have only the default entry.
 */
- (void) testDictDefaultStringAsKey {
  NSString * templates = [[@"typeInit ::= [\"default\":\"foo\"] " stringByAppendingString:newline] stringByAppendingString:@"var(type,name) ::= \"<type> <name> = <typeInit.(type)>;\""] + newline;
  [self writeFile:tmpdir arg1:@"test.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[[tmpdir stringByAppendingString:@"/"] stringByAppendingString:@"test.stg"]] autorelease];
  ST * st = [group getInstanceOf:@"var"];
  [st add:@"type" arg1:@"default"];
  [st add:@"name" arg1:@"x"];
  NSString * expecting = @"default x = foo;";
  NSString * result = [st render];
  [self assertEquals:expecting arg1:result];
}


/**
 * Test that a map can return a <b>string</b> with the word: default.
 */
- (void) testDictDefaultIsDefaultString {
  NSString * templates = [[@"map ::= [default: \"default\"] " stringByAppendingString:newline] stringByAppendingString:@"t() ::= << <map.(\"1\")> >>"] + newline;
  [self writeFile:tmpdir arg1:@"test.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[[tmpdir stringByAppendingString:@"/"] stringByAppendingString:@"test.stg"]] autorelease];
  ST * st = [group getInstanceOf:@"t"];
  NSString * expecting = @" default ";
  NSString * result = [st render];
  [self assertEquals:expecting arg1:result];
}

- (void) testDictViaEnclosingTemplates {
  NSString * templates = [[[@"typeInit ::= [\"int\":\"0\", \"float\":\"0.0\"] " stringByAppendingString:newline] stringByAppendingString:@"intermediate(type,name) ::= \"<var(type,name)>\""] + newline stringByAppendingString:@"var(type,name) ::= \"<type> <name> = <typeInit.(type)>;\""] + newline;
  [self writeFile:tmpdir arg1:@"test.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[[tmpdir stringByAppendingString:@"/"] stringByAppendingString:@"test.stg"]] autorelease];
  ST * st = [group getInstanceOf:@"intermediate"];
  [st add:@"type" arg1:@"int"];
  [st add:@"name" arg1:@"x"];
  NSString * expecting = @"int x = 0;";
  NSString * result = [st render];
  [self assertEquals:expecting arg1:result];
}

- (void) testDictViaEnclosingTemplates2 {
  NSString * templates = [[[@"typeInit ::= [\"int\":\"0\", \"float\":\"0.0\"] " stringByAppendingString:newline] stringByAppendingString:@"intermediate(stuff) ::= \"<stuff>\""] + newline stringByAppendingString:@"var(type,name) ::= \"<type> <name> = <typeInit.(type)>;\""] + newline;
  [self writeFile:tmpdir arg1:@"test.stg" arg2:templates];
  STGroup * group = [[[STGroupFile alloc] init:[[tmpdir stringByAppendingString:@"/"] stringByAppendingString:@"test.stg"]] autorelease];
  ST * interm = [group getInstanceOf:@"intermediate"];
  ST * var = [group getInstanceOf:@"var"];
  [var add:@"type" arg1:@"int"];
  [var add:@"name" arg1:@"x"];
  [interm add:@"stuff" arg1:var];
  NSString * expecting = @"int x = 0;";
  NSString * result = [interm render];
  [self assertEquals:expecting arg1:result];
}

- (void) TestAccessDictionaryFromAnonymousTemplate {
  NSString * dir = tmpdir;
  NSString * g = [[[[@"a() ::= <<[<[\"foo\",\"a\"]:{x|<if(values.(x))><x><endif>}>]>>\n" stringByAppendingString:@"values ::= [\n"] stringByAppendingString:@"    \"a\":false,\n"] stringByAppendingString:@"    default:true\n"] stringByAppendingString:@"]\n"];
  [self writeFile:dir arg1:@"g.stg" arg2:g];
  STGroup * group = [[[STGroupFile alloc] init:[[tmpdir stringByAppendingString:@"/"] stringByAppendingString:@"g.stg"]] autorelease];
  ST * st = [group getInstanceOf:@"a"];
  NSString * expected = @"[foo]";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

- (void) TestAccessDictionaryFromAnonymousTemplateInRegion {
  NSString * dir = tmpdir;
  NSString * g = [[[[[[[@"a() ::= <<[<@r()>]>>\n" stringByAppendingString:@"@a.r() ::= <<\n"] stringByAppendingString:@"<[\"foo\",\"a\"]:{x|<if(values.(x))><x><endif>}>\n"] stringByAppendingString:@">>\n"] stringByAppendingString:@"values ::= [\n"] stringByAppendingString:@"    \"a\":false,\n"] stringByAppendingString:@"    default:true\n"] stringByAppendingString:@"]\n"];
  [self writeFile:dir arg1:@"g.stg" arg2:g];
  STGroup * group = [[[STGroupFile alloc] init:[[tmpdir stringByAppendingString:@"/"] stringByAppendingString:@"g.stg"]] autorelease];
  ST * st = [group getInstanceOf:@"a"];
  NSString * expected = @"[foo]";
  NSString * result = [st render];
  [self assertEquals:expected arg1:result];
}

@end
