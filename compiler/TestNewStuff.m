#import "TestNewStuff.h"

@implementation TestNewStuff

@end

int main(int argc, char **args)
{
    Compiler *c = [Compiler newCompiler];
    char *buffer;
    NSMutableData *nsBuff;
    FileInputStream *f = [[FileInputStream alloc] init:args[0]];
    [f read:buffer];
    NSString *template = [[NSString alloc] initWithCharacters:buffer length:1000];
    AMutableArray *a = [AMutableArray arrayWithCapacity:16];
    [a addObject:[[FormalArgument alloc] init:@"x"]];
    NSString *n = [Misc getFileNameNoSuffix:[Misc getFileName:args[0]]];
    [c compile:args[0] name:n args:a template:template templateToken:nil];
}
