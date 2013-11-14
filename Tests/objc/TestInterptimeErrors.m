#import "TestInterptimeErrors.h"
#import "STGroup.h"

@implementation UserHiddenName

- (id) initWithName:(NSString *)aName {
    if ( (self=[super init]) != nil ) {
        name = aName;
    }
    return self;
}

- (NSString *) getName {
    return name;
}

- (void) dealloc
{
    name = nil;
    // [super dealloc];
}

@end

@implementation UserHiddenNameField

- (id) initWithName:(NSString *)aName {
    if ( (self=[super init]) != nil ) {
        name = aName;
    }
    return self;
}

- (void) dealloc
{
    name = nil;
    // [super dealloc];
}

@end

@implementation TestInterptimeErrors

- (void) test01MissingEmbeddedTemplate
{
    ErrorBuffer *errors = [ErrorBuffer newErrorBuffer];
    NSString *templates = @"t() ::= \"<foo()>\"\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    [group setListener:errors];
    ST *st = [group getInstanceOf:@"t"];
    [st render];
    NSString *expected = @"context [/t] 1:1 no such template: /foo\n";
    NSString *result = [errors description];
    [self assertEquals:expected result:result];
}

- (void) test02MissingSuperTemplate
{
    ErrorBuffer *errors = [ErrorBuffer newErrorBuffer];
    NSString *templates = @"t() ::= \"<super.t()>\"\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    [group setListener:errors];
    NSString *templates2 = @"u() ::= \"blech\"\n";
    [self writeFile:tmpdir fileName:@"t2.stg" content:templates2];
    STGroup *group2 = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t2.stg", tmpdir]];
    [group importTemplates:group2];
    ST *st = [group getInstanceOf:@"t"];
    [st render];
    NSString *expected = @"context [/t] 1:1 no such template: super.t\n";
    NSString *result = [errors description];
    [self assertEquals:expected result:result];
}

- (void) test03NoPropertyNotError
{
    ErrorBuffer *errors = [ErrorBuffer newErrorBuffer];
    NSString *templates = @"t(u) ::= \"<u.x>\"\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    [group setListener:errors];
    ST *st = [group getInstanceOf:@"t"];
    [st add:@"u" value:[User newUser:32 name:@"parrt"]];
    [st render];
    NSString *expected = @"";
    NSString *result = [errors description];
    [self assertEquals:expected result:result];
}

- (void) test04HiddenPropertyNotError
{
    ErrorBuffer *errors = [ErrorBuffer newErrorBuffer];
    NSString *templates = @"t(u) ::= \"<u.name>\"\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    [group setListener:errors];
    ST *st = [group getInstanceOf:@"t"];
    [st add:@"u" value:[[UserHiddenName alloc] initWithName:@"parrt"]];
    [st render];
    NSString *expected = @"";
    NSString *result = [errors description];
    [self assertEquals:expected result:result];
}

- (void) test05HiddenFieldNotError
{
    ErrorBuffer *errors = [ErrorBuffer newErrorBuffer];
    NSString *templates = @"t(u) ::= \"<u.name>\"\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    [group setListener:errors];
    ST *st = [group getInstanceOf:@"t"];
    [st add:@"u" value:[[UserHiddenNameField alloc] initWithName:@"parrt"]];
    [st render];
    NSString *expected = @"";
    NSString *result = [errors description];
    [self assertEquals:expected result:result];
}

- (void) test06SoleArg
{
    ErrorBuffer *errors = [ErrorBuffer newErrorBuffer];
    NSString *templates = @"t() ::= \"<u({9})>\"\nu(x,y) ::= \"<x>\"\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    [group setListener:errors];
    ST *st = [group getInstanceOf:@"t"];
    [st render];
    NSString *expected = @"context [/t] 1:1 passed 1 arg(s) to template /u with 2 declared arg(s)\n";
    NSString *result = [errors description];
    [self assertEquals:expected result:result];
}

- (void) test07SoleArgUsingApplySyntax
{
    ErrorBuffer *errors = [ErrorBuffer newErrorBuffer];
    NSString *templates = @"t() ::= \"<{9}:u()>\"\nu(x,y) ::= \"<x>\"\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    [group setListener:errors];
    ST *st = [group getInstanceOf:@"t"];
    NSString *expected = @"9";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    expected = @"context [/t] 1:5 passed 1 arg(s) to template /u with 2 declared arg(s)\n";
    result = [errors description];
    [self assertEquals:expected result:result];
}

- (void) test08UndefinedAttr
{
    ErrorBuffer *errors = [ErrorBuffer newErrorBuffer];
    NSString *templates = @"t() ::= \"<u()>\"\nu() ::= \"<x>\"\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    [group setListener:errors];
    //    STGroup.debug = YES;
    [STGroup setDebug];
    ST *st = [group getInstanceOf:@"t"];
    [st render];
    NSString *expected = @"context [/t /u] 1:1 attribute x isn't defined\n";
    NSString *result = [errors description];
    [self assertEquals:expected result:result];
}

- (void) test09ParallelAttributeIterationWithMissingArgs
{
    ErrorBuffer *errors = [ErrorBuffer newErrorBuffer];
    STGroup *group = [STGroup newSTGroup];
    [group setListener:errors];
    ST *st = [ST newST:group template:@"<names,phones,salaries:{n,p | <n>@<p>}; separator=\", \">"];
    [st add:@"names" value:@"Ter"];
    [st add:@"names" value:@"Tom"];
    [st add:@"phones" value:@"1"];
    [st add:@"phones" value:@"2"];
    [st add:@"salaries" value:@"big"];
    NSString *result = [st render];
    NSString *expected = @"Ter@1, Tom@2";
    [self assertEquals:expected result:result];
    expected = @"1:23: anonymous template has 2 arg(s) but mapped across 3 value(s)\ncontext [anonymous] 1:23 passed 3 arg(s) to template /_sub1 with 2 declared arg(s)\ncontext [anonymous] 1:1 iterating through 3 values in zip map but template has 2 declared arguments\n";
    result = [errors description];
    [self assertEquals:expected result:result];
}

- (void) test10StringTypeMismatch
{
    ErrorBuffer *errors = [ErrorBuffer newErrorBuffer];
    STGroup *group = [STGroup newSTGroup];
    [group setListener:errors];
    ST *st = [ST newST:group template:@"<trim(s)>"];
    [st add:@"s" value:[ACNumber numberWithInteger:34]];
    [st render];
    NSString *expected = @"context [anonymous] 1:1 function trim expects a string not ACNumber\n";
    NSString *result = [errors description];
    [self assertEquals:expected result:result];
}

- (void) test11StringTypeMismatch2
{
    ErrorBuffer *errors = [ErrorBuffer newErrorBuffer];
    STGroup *group = [STGroup newSTGroup];
    [group setListener:errors];
    ST *st = [ST newST:group template:@"<strlen(s)>"];
    [st add:@"s" value:[ACNumber numberWithInteger:34]];
    [st render];
    NSString *expected = @"context [anonymous] 1:1 function strlen expects a string not ACNumber\n";
    NSString *result = [errors description];
    [self assertEquals:expected result:result];
}

@end
