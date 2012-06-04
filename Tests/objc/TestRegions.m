#import "TestRegions.h"

@implementation TestRegions

- (void) test01EmbeddedRegion
{
    NSString *dir = [self getRandomDir];
    NSString *groupFile = @"a() ::= <<\n[<@r>bar<@end>]\n>>\n";
    [self writeFile:dir fileName:@"group.stg" content:groupFile];
    STGroup *group = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/group.stg", dir]] autorelease];
    ST *st = [group getInstanceOf:@"a"];
    NSString *expected = @"[bar]";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test02Region
{
    NSString *dir = [self getRandomDir];
    NSString *groupFile = @"a() ::= <<\n[<@r()>]\n>>\n";
    [self writeFile:dir fileName:@"group.stg" content:groupFile];
    STGroup *group = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/group.stg", dir]] autorelease];
    ST *st = [group getInstanceOf:@"a"];
    NSString *expected = @"[]";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test03DefineRegionInSubgroup
{
    NSString *dir = [self getRandomDir];
    NSString *g1 = @"a() ::= <<[<@r()>]>>\n";
    NSString *g2 = @"@a.r() ::= <<foo>>\n";
    [self writeFile:dir fileName:@"g1.stg" content:g1];
    [self writeFile:dir fileName:@"g2.stg" content:g2];
    STGroup *group1 = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/g1.stg", dir]] autorelease];
    STGroup *group2 = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/g2.stg", dir]] autorelease];
    [group2 importTemplates:group1];
    ST *st = [group2 getInstanceOf:@"a"];
    NSString *expected = @"[foo]";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test04DefineRegionInSubgroupThatRefsSuper
{
    NSString *dir = [self getRandomDir];
    NSString *g1 = @"a() ::= <<[<@r>foo<@end>]>>\n";
    NSString *g2 = @"@a.r() ::= <<(<@super.r()>)>>\n";
    [self writeFile:dir fileName:@"g1.stg" content:g1];
    [self writeFile:dir fileName:@"g2.stg" content:g2];
    STGroup *group1 = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/g1.stg", dir]] autorelease];
    STGroup *group2 = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/g2.stg", dir]] autorelease];
    [group2 importTemplates:group1];
    ST *st = [group2 getInstanceOf:@"a"];
    NSString *expected = @"[(foo)]";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test05DefineRegionInSubgroup2
{
    NSString *dir = [self getRandomDir];
    NSString *g1 = @"a() ::= <<[<@r()>]>>\n";
    [self writeFile:dir fileName:@"g1.stg" content:g1];
    NSString *g2 = @"@a.r() ::= <<foo>>>\n";
    [self writeFile:dir fileName:@"g2.stg" content:g2];
    STGroup *group1 = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/g1.stg", dir]] autorelease];
    STGroup *group2 = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/g2.stg", dir]] autorelease];
    [group1 importTemplates:group2];
    ST *st = [group1 getInstanceOf:@"a"];
    NSString *expected = @"[]";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test06DefineRegionInSameGroup
{
    NSString *dir = [self getRandomDir];
    NSString *g = @"a() ::= <<[<@r()>]>>\n@a.r() ::= <<foo>>\n";
    [self writeFile:dir fileName:@"g.stg" content:g];
    
    STGroup *group = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/g.stg", dir]] autorelease];
    ST *st = [group getInstanceOf:@"a"];
    NSString *expected = @"[foo]";
    [st.impl dump];
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test07AnonymousTemplateInRegion
{
    NSString *dir = [self getRandomDir];
    NSString *g = @"a() ::= <<[<@r()>]>>\n@a.r() ::= <<\n<[\"foo\"]:{x|<x>}>\n>>\n";
    [self writeFile:dir fileName:@"g.stg" content:g];
    STGroup *group = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/g.stg", dir]] autorelease];
    ST *st = [group getInstanceOf:@"a"];
    NSString *expected = @"[foo]";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test08CantDefineEmbeddedRegionAgain
{
    NSString *dir = [self getRandomDir];
    NSString *g = @"a() ::= <<[<@r>foo<@end>]>>\n@a.r() ::= <<bar>>\n";
    [self writeFile:dir fileName:@"g.stg" content:g];
    STGroupFile *group = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/g.stg", dir]] autorelease];
    ErrorBuffer *errors = [ErrorBuffer newErrorBuffer];
    [group setListener:errors];
    [group load];
    NSString *expected = @"g.stg 2:3: region a.r is embedded and thus already implicitly defined\n";
    NSString *result = [errors description];
    [self assertEquals:expected result:result];
}

- (void) test09CantDefineEmbeddedRegionAgainInTemplate
{
    NSString * dir = [self getRandomDir];
    NSString * g = @"a() ::= <<\n[\n<@r>foo<@end>\n<@r()>]\n>>\n";
    [self writeFile:dir fileName:@"g.stg" content:g];
    STGroupFile * group = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/g.stg", dir]] autorelease];
    ErrorBuffer * errors = [[ErrorBuffer newErrorBuffer] autorelease];
    [group setListener:errors];
    [group load];
    NSString * expected = @"g.stg 3:2: redefinition of region a.r\n";
    NSString * result = [errors description];
    [self assertEquals:expected result:result];
}

- (void) test10MissingRegionName
{
    NSString * dir = [self getRandomDir];
    NSString * g = @"@t.() ::= \"\"\n";
    [self writeFile:dir fileName:@"g.stg" content:g];
    STGroupFile * group = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/g.stg", dir]] autorelease];
    ErrorBuffer * errors = [[ErrorBuffer newErrorBuffer] autorelease];
    [group setListener:errors];
    [group load];
    NSString * expected = @"g.stg 1:3: missing ID at '('\n";
    NSString * result = [errors description];
    [self assertEquals:expected result:result];
}

- (void) test11IndentBeforeRegionIsIgnored
{
    NSString *dir = [self getRandomDir];
    NSString *g = @"a() ::= <<[\n  <@r>\n  foo\n  <@end>\n]>>\n";
    [self writeFile:dir fileName:@"g.stg" content:g];
    STGroupFile *group = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/g.stg", dir]] autorelease];
    ST *st = [group getInstanceOf:@"a"];
    NSString *expected = @"[\n  foo\n]";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test12RegionOverrideStripsNewlines
{
    NSString *dir = [self getRandomDir];
    NSString *g = @"a() ::= \"X<@r()>Y\"@a.r() ::= <<\nfoo\n>>\n";
    [self writeFile:dir fileName:@"g.stg" content:g];
    STGroupFile *group = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/g.stg", dir]] autorelease];
    NSString *sub = @"@a.r() ::= \"A<@super.r()>B\"\n";
    [self writeFile:dir fileName:@"sub.stg" content:sub];
    STGroupFile *subGroup = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/sub.stg", dir]] autorelease];
    [subGroup importTemplates:group];
    ST *st = [subGroup getInstanceOf:@"a"];
    NSString *result = [st render];
    NSString *expecting = @"XAfooBY";
    [self assertEquals:expecting result:result];
}

- (void) test13RegionOverrideRefSuperRegion
{
    NSString *dir = [self getRandomDir];
    NSString *g = @"a() ::= \"X<@r()>Y\"@a.r() ::= \"foo\"\n";
    [self writeFile:dir fileName:@"g.stg" content:g];
    STGroupFile *group = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/g.stg", dir]] autorelease];
    NSString *sub = @"@a.r() ::= \"A<@super.r()>B\"\n";
    [self writeFile:dir fileName:@"sub.stg" content:sub];
    STGroupFile *subGroup = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/sub.stg", dir]] autorelease];
    [subGroup importTemplates:group];
    ST *st = [subGroup getInstanceOf:@"a"];
    NSString *result = [st render];
    NSString *expecting = @"XAfooBY";
    [self assertEquals:expecting result:result];
}

- (void) test14RegionOverrideRefSuperRegion3Levels
{
    NSString *dir = [self getRandomDir];
    NSString *g = @"a() ::= \"X<@r()>Y\"@a.r() ::= \"foo\"\n";
    [self writeFile:dir fileName:@"g.stg" content:g];
    STGroupFile *group = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/g.stg", dir]] autorelease];
    NSString *sub = @"@a.r() ::= \"<@super.r()>2\"\n";
    [self writeFile:dir fileName:@"sub.stg" content:sub];
    STGroupFile *subGroup = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/sub.stg", dir]] autorelease];
    [subGroup importTemplates:group];
    NSString *subsub = @"@a.r() ::= \"<@super.r()>3\"\n";
    [self writeFile:dir fileName:@"subsub.stg" content:subsub];
    STGroupFile *subSubGroup = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/subsub.stg", dir]] autorelease];
    [subSubGroup importTemplates:subGroup];
    ST *st = [subSubGroup getInstanceOf:@"a"];
    NSString *result = [st render];
    NSString *expecting = @"Xfoo23Y";
    [self assertEquals:expecting result:result];
}

- (void) test15RegionOverrideRefSuperImplicitRegion
{
    NSString *dir = [self getRandomDir];
    NSString *g = @"a() ::= \"X<@r>foo<@end>Y\"\n";
    [self writeFile:dir fileName:@"g.stg" content:g];
    STGroupFile *group = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/g.stg", dir]] autorelease];
    NSString *sub = @"@a.r() ::= \"A<@super.r()>\"\n";
    [self writeFile:dir fileName:@"sub.stg" content:sub];
    STGroupFile *subGroup = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/sub.stg", dir]] autorelease];
    [subGroup importTemplates:group];
    ST *st = [subGroup getInstanceOf:@"a"];
    NSString *result = [st render];
    NSString *expecting = @"XAfooY";
    [self assertEquals:expecting result:result];
}

- (void) test16UnknownRegionDefError
{
    NSString *dir = [self getRandomDir];
    NSString *g = @"a() ::= <<\nX<@r()>Y>>\n@a.q() ::= \"foo\"\n";
    id<STErrorListener> errors = [ErrorBuffer newErrorBuffer];
    [self writeFile:dir fileName:@"g.stg" content:g];
    STGroupFile *group = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/g.stg", dir]] autorelease];
    [group setListener:errors];
    ST *st = [group getInstanceOf:@"a"];
    [st render];
    NSString *result = [errors description];
    NSString *expecting = @"g.stg 3:3: template a doesn't have a region called q\n";
    [self assertEquals:expecting result:result];
}

- (void) test17SuperRegionRefMissingOk
{
    NSString *dir = [self getRandomDir];
    NSString *g = @"a() ::= \"X<@r()>Y\"@a.r() ::= \"foo\"\n";
    [self writeFile:dir fileName:@"g.stg" content:g];
    STGroupFile *group = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/g.stg", dir]] autorelease];
    NSString *sub = @"@a.r() ::= \"A<@super.q()>B\"\n";
    id<STErrorListener> errors = [ErrorBuffer newErrorBuffer];
    [group setListener:errors];
    [self writeFile:dir fileName:@"sub.stg" content:sub];
    STGroupFile *subGroup = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/sub.stg", dir]] autorelease];
    [subGroup importTemplates:group];
    ST *st = [subGroup getInstanceOf:@"a"];
    NSString *result = [st render];
    NSString *expecting = @"XABY";
    [self assertEquals:expecting result:result];
}

- (void) test18EmbeddedRegionOnOneLine
{
    NSString * dir = [self getRandomDir];
    NSString * groupFile = @"a() ::= <<\n[\n  <@r>bar<@end>\n]\n>>\n";
    [self writeFile:dir fileName:@"group.stg" content:groupFile];
    STGroup * group = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/group.stg", dir]] autorelease];
    ST * st = [group getInstanceOf:@"a"];
    [st.impl dump];
    NSString * expected = @"[\n  bar\n]";
    NSString * result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test19EmbeddedRegionTagsOnSeparateLines
{
    NSString * dir = [self getRandomDir];
    NSString * groupFile = @"a() ::= <<\n[\n  <@r>\n  bar\n  <@end>\n]\n>>\n";
    [self writeFile:dir fileName:@"group.stg" content:groupFile];
    STGroup * group = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/group.stg", dir]] autorelease];
    ST * st = [group getInstanceOf:@"a"];
    NSString * expected = @"[\n  bar\n]";
    NSString * result = [st render];
    [self assertEquals:expected result:result];
}

@end
