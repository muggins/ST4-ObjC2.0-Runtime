#import "TestScopes.h"

@implementation TestScopes

- (void) test01SeesEnclosingAttr
{
    NSString *templates = @"t(x,y) ::= \"<u()>\"\nu() ::= \"<x><y>\"";
    ErrorBuffer *errors = [ErrorBuffer newErrorBuffer];
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]] autorelease];
    [group setListener:errors];
    ST *st = [group getInstanceOf:@"t"];
    [st add:@"x" value:@"x"];
    [st add:@"y" value:@"y"];
    NSString *expected = @"xy";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    expected = @"";
    result = [errors description];
    [self assertEquals:expected result:result];
}

- (void) test02MissingArg
{
    NSString *templates = @"t() ::= \"<u()>\"\nu(z) ::= \"\"";
    ErrorBuffer *errors = [ErrorBuffer newErrorBuffer];
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]] autorelease];
    [group setListener:errors];
    ST *st = [group getInstanceOf:@"t"];
    NSString *renderResult = [st render];
    NSString *expected = @"context [/t] 1:1 passed 0 arg(s) to template /u with 1 declared arg(s)\n";
    NSString *result = [errors description];
    [self assertEquals:expected result:result];
}

- (void) test03UnknownAttr
{
    NSString *templates = @"t() ::= \"<x>\"\n";
    ErrorBuffer *errors = [ErrorBuffer newErrorBuffer];
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]] autorelease];
    [group setListener:errors];
    ST *st = [group getInstanceOf:@"t"];
    NSString *renderResult = [st render];
    NSString *expected = @"context [/t] 1:1 attribute x isn't defined\n";
    NSString *result = [errors description];
    [self assertEquals:expected result:result];
}

- (void) test04ArgWithSameNameAsEnclosing
{
    NSString *templates = @"t(x,y) ::= \"<u(x)>\"\nu(y) ::= \"<x><y>\"";
    ErrorBuffer *errors = [ErrorBuffer newErrorBuffer];
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]] autorelease];
    [group setListener:errors];
    ST *st = [group getInstanceOf:@"t"];
    [st add:@"x" value:@"x"];
    [st add:@"y" value:@"y"];
    NSString *result = [st render];
    NSString *expected = @"xx";
    [self assertEquals:expected result:result];
    expected = @"";
    result = [errors description];
    [self assertEquals:expected result:result];
    [group setListener:ErrorManager.DEFAULT_ERROR_LISTENER];
}

- (void) test05IndexAttrVisibleLocallyOnly
{
    NSString *templates = @"t(names) ::= \"<names:{n | <u(n)>}>\"\nu(x) ::= \"<i>:<x>\"";
    ErrorBuffer *errors = [ErrorBuffer newErrorBuffer];
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [[STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]] autorelease];
    [group setListener:errors];
    ST *st = [group getInstanceOf:@"t"];
    [st add:@"names" value:@"Ter"];
    NSString *expected = @":Ter";
    NSString *result = [st render];
    [[group getInstanceOf:@"u"].impl dump];
    NSString *expectedError = @"t.stg 2:11: implicitly-defined attribute i not visible\n";
    NSString *resultError = [errors description];
    [self assertEquals:expected result:result];
    [self assertEquals:expectedError result:resultError];
    [group setListener:ErrorManager.DEFAULT_ERROR_LISTENER];
}

@end
