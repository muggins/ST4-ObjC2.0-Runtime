#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLR.h>
#import "ErrorManager.h"

@implementation ErrorManager_Anon1

+ (id) newErrorManager_Anon1
{
    return [[ErrorManager_Anon1 alloc] init];
}

- (id) init
{
    if (self = [super init] ) {
    }
    return self;
}

- (void) compileTimeError:(STMessage *)aMsg
{
    //[System.err println:aMsg];
    NSLog(@"%@", [ErrorType ErrorNum:aMsg.error]);
}

- (void) runTimeError:(STMessage *)aMsg
{
    if (aMsg.error != NO_SUCH_PROPERTY) {
        //[System.err println:aMsg];
        NSLog(@"%@", [ErrorType ErrorNum:aMsg.error]);
    }
}

- (void) IOError:(STMessage *)aMsg
{
    //[System.err println:aMsg];
    NSLog(@"%@", [ErrorType ErrorNum:aMsg.error]);
}

- (void) internalError:(STMessage *)aMsg
{
    //[System.err println:msg];
    NSLog(@"%@", [ErrorType ErrorNum:aMsg.error]);
}

- (void) error:(NSString *)s
{
    //[System.err println:msg];
    [self error:s e:nil];
}

- (void) error:(NSString *)s e:(NSException *)e
{
    //[System.err println:aMsg];
    NSLog(@"%@", s);
    if (e != nil) {
#pragma mark error -- fix this
#ifdef DONTUSEYET
        [e printStackTrace:System.err];
#endif
    }
}

@end


@implementation ErrorManager
static STErrorListener *DEFAULT_ERROR_LISTENER;

+ (void) initialize
{
    DEFAULT_ERROR_LISTENER = [ErrorManager_Anon1 newErrorManager_Anon1];
}

+ (STErrorListener *) DEFAULT_ERROR_LISTENER
{
    return DEFAULT_ERROR_LISTENER;
}

+ (id) newErrorManager
{
    return [[ErrorManager alloc] init];
}

+ (id) newErrorManagerWithListerner:(STErrorListener *)aListener
{
    return [[ErrorManager alloc] initWithListener:aListener];
}

- (id) init
{
    if (self = [super init]) {
        listener = DEFAULT_ERROR_LISTENER;
    }
    return self;
}

- (id) initWithListener:(STErrorListener *)aListener
{
    if (self = [super init]) {
        listener = aListener;
    }
    return self;
}

- (void) compileTimeError:(ErrorTypeEnum)anError templateToken:(ANTLRCommonToken *)aTemplateToken t:(ANTLRCommonToken *)t
{
    NSString *srcName = [[t getInput] getSourceName];
    if (srcName != nil)
        srcName = [Misc getFileName:srcName];
    [listener compileTimeError:[[STCompiletimeMessage alloc] init:anError srcName:srcName templateToken:aTemplateToken t:t cause:nil arg:[t getText]]];
}

- (void) compileTimeError:(ErrorTypeEnum)anError templateToken:(ANTLRCommonToken *)aTemplateToken t:(ANTLRCommonToken *)t arg:(id)arg
{
    NSString * srcName = [[t getInput] getSourceName];
    srcName = [Misc getFileName:srcName];
    [listener compileTimeError:[[STCompiletimeMessage alloc] init:anError srcName:srcName templateToken:aTemplateToken t:t cause:nil arg:arg]];
}

- (void) compileTimeError:(ErrorTypeEnum)anError templateToken:(ANTLRCommonToken *)aTemplateToken t:(ANTLRCommonToken *)t arg:(id)arg arg2:(id)arg2
{
    NSString * srcName = [[t getInput] getSourceName];
    if (srcName != nil)
        srcName = [Misc getFileName:srcName];
    [listener compileTimeError:[[STCompiletimeMessage alloc] init:anError srcName:srcName templateToken:aTemplateToken t:t cause:nil arg:arg arg2:arg2]];
}

- (void) lexerError:(NSString *)srcName msg:(NSString *)aMsg templateToken:(ANTLRCommonToken *)aTemplateToken e:(ANTLRRecognitionException *)e
{
    [listener compileTimeError:[[STLexerMessage alloc] init:srcName msg:aMsg templateToken:aTemplateToken cause:e]];
}

- (void) groupSyntaxError:(ErrorTypeEnum)anError srcName:(NSString *)srcName e:(ANTLRRecognitionException *)e msg:(NSString *)aMsg
{
    [listener compileTimeError:[[STGroupCompiletimeMessage alloc] init:anError srcName:srcName t:e.token cause:e arg:aMsg]];
}

- (void) groupLexerError:(ErrorTypeEnum)anError srcName:(NSString *)srcName e:(ANTLRRecognitionException *)e msg:(NSString *)aMsg
{
    [listener compileTimeError:[[STGroupCompiletimeMessage alloc] init:anError srcName:srcName t:e.token cause:e arg:aMsg]];
}

- (void) runTimeError:(ST *)aWho ip:(NSInteger)ip error:(ErrorTypeEnum)anError
{
    [listener runTimeError:[[STRuntimeMessage alloc] init:anError ip:ip who:aWho]];
}

- (void) runTimeError:(ST *)aWho ip:(NSInteger)ip error:(ErrorTypeEnum)anError arg:(id)arg
{
    [listener runTimeError:[[STRuntimeMessage alloc] init:anError ip:ip who:aWho arg:arg]];
}

- (void) runTimeError:(ST *)aWho ip:(NSInteger)ip error:(ErrorTypeEnum)anError e:(NSException *)e arg:(id)arg
{
    [listener runTimeError:[[STRuntimeMessage alloc] init:anError ip:ip who:aWho cause:e arg:arg]];
}

- (void) runTimeError:(ST *)aWho ip:(NSInteger)ip error:(ErrorTypeEnum)anError arg:(id)arg arg2:(id)arg2
{
    [listener runTimeError:[[STRuntimeMessage alloc] init:anError ip:ip who:aWho cause:nil arg:arg arg2:arg2]];
}

- (void) runTimeError:(ST *)aWho ip:(NSInteger)ip error:(ErrorTypeEnum)anError arg:(id)arg arg2:(id)arg2 arg3:(id)arg3
{
    [listener runTimeError:[[STRuntimeMessage alloc] init:anError ip:ip who:aWho cause:nil arg:arg arg2:arg2 arg3:arg3]];
}

- (void) IOError:(ST *)aWho error:(ErrorTypeEnum)anError e:(NSException *)e
{
    [listener IOError:[[STMessage alloc] init:anError who:aWho cause:e]];
}

- (void) IOError:(ST *)aWho error:(ErrorTypeEnum)anError e:(NSException *)e arg:(id)arg
{
    [listener IOError:[[STMessage alloc] init:anError who:aWho cause:e arg:arg]];
}

- (void) internalError:(ST *)aWho msg:(NSString *)aMsg e:(NSException *)e
{
    [listener internalError:[[STMessage alloc] init:INTERNAL_ERROR who:aWho cause:e arg:aMsg]];
}

- (void) dealloc
{
    [listener release];
    [super dealloc];
}

@end
