#import "TestGroupSyntax.h"

@implementation TestGroupSyntax

- (void) test01SimpleGroup
{
    NSString *templates = @"t() ::= <<foo>>\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    NSString *expected = @"t() ::= <<\nfoo\n>>\n";
    NSString *result = [group show];
    [self assertEquals:expected result:result];
}

- (void) test02MultiTemplates
{
    NSString *templates = @"ta(x) ::= \"[<x>]\"\nduh() ::= <<hi there>>\nwow() ::= <<last>>\\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    NSString *expected = @"ta(x) ::= <<\n[<x>]\n>>\nduh() ::= <<\nhi there\n>>\nwow() ::= <<\nlast\n>>\n";
    NSString *result = [group show];
    [self assertEquals:expected result:result];
}

- (void) test03SingleTemplateWithArgs
{
    NSString *templates = @"t(a,b) ::= \"[<a>]\"\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    NSString *expected = @"t(a,b) ::= <<\n[<a>]\n>>\n";
    NSString *result = [group show];
    [self assertEquals:expected result:result];
}

- (void) test04DefaultValues
{
    NSString *templates = @"t(a={def1},b=\"def2\") ::= \"[<a>]\"\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    NSString *expected = @"t(a={def1},b=\"def2\") ::= <<\n[<a>]\n>>\n";
    NSString *result = [group show];
    [self assertEquals:expected result:result];
}

- (void) test05DefaultValueTemplateWithArg
{
    NSString *templates = @"t(a={x | 2*<x>}) ::= \"[<a>]\"\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    NSString *expected = @"t(a={x | 2*<x>}) ::= <<\n[<a>]\n>>\n";
    NSString *result = [group show];
    [self assertEquals:expected result:result];
}

- (void) test06NestedTemplateInGroupFile
{
    NSString *templates = @"t(a) ::= \"<a:{x | <x:{y | <y>}>}>\"\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    NSString *expected = @"t(a) ::= <<\n<a:{x | <x:{y | <y>}>}>\n>>\n";
    NSString *result = [group show];
    [self assertEquals:expected result:result];
}

- (void) test07NestedDefaultValueTemplate
{
    NSString *templates = @"t(a={x | <x:{y|<y>}>}) ::= \"ick\"\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    [group load];
    NSString *expected = @"t(a={x | <x:{y|<y>}>}) ::= <<\nick\n>>\n";
    NSString *result = [group show];
    [self assertEquals:expected result:result];
}

- (void) test08NestedDefaultValueTemplateWithEscapes
{
    NSString *templates = @"t(a={x | \\< <x:{y|<y>\\}}>}) ::= \"[<a>]\"\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    NSString *expected = @"t(a={x | \\< <x:{y|<y>\\}}>}) ::= <<\n[<a>]\n>>\n";
    NSString *result = [group show];
    [self assertEquals:expected result:result];
}

- (void) test09MessedUpTemplateDoesntCauseRuntimeError
{
    NSString *templates = @"main(p) ::= <<\n<f(x=\"abc\")>\n>>\n\nf() ::= <<\n<x>\n>>\n";
    [self writeFile:tmpdir fileName:@"t.stg" content:templates];
    STGroupFile *group = nil;
    ErrorBuffer *errors = [ErrorBuffer newErrorBuffer];
    group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/t.stg", tmpdir]];
    [group setListener:errors];
    ST *st = [group getInstanceOf:@"main"];
    [st render];
    NSString *expected = @"[context [/main] 1:1 passed 1 arg(s) to template /f with 0 declared arg(s), context [/main] 1:1 attribute x isn't defined, context [/main /f] 1:1 attribute x isn't defined]";
    NSString *result = [errors.errors description];
    [self assertEquals:expected result:result];
}
    
@end
