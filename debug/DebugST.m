#import "DebugST.h"
#import "STWriter.h"
#import "InterpEvent.h"
#import "AddAttributeEvent.h"
#import "CompiledST.h"
#import "MultiMap.h"

@implementation State

- (id) init {
    if (self = [super init]) {
        interpEvents = [NSMutableArray arrayWithCapacity:16];
    }
    return self;
}

- (void) dealloc {
    [interpEvents release];
    [super dealloc];
}

@end

@implementation DebugST

@synthesize newSTEvent;
@synthesize addAttrEvents;
@synthesize events;

+ (id) newDebugSTWithProto:(ST *)proto
{
    return [[DebugST alloc] initWithProto:proto];
}

- (id) init
{
    if (self = [super init]) {
        newSTEvent = [[ConstructionEvent alloc] init];
        addAttrEvents = [[MultiMap alloc] init];
    }
    return self;
}

- (id) initWithProto:(ST *)proto
{
    if (self = [super initWithProto:proto]) {
        newSTEvent = [[ConstructionEvent alloc] init];
        addAttrEvents = [[MultiMap alloc] init];
    }
    return self;
}

- (void) add:(NSString *)name value:(id)value
{
    if (STGroup.debug) {
        [addAttrEvents map:name value:[[AddAttributeEvent alloc] init:name value:value]];
    }
    [super add:name value:value];
}

- (NSMutableArray *) inspect
{
    return [self inspectLocale:[NSLocale currentLocale]];
}

- (NSMutableArray *) inspect:(NSInteger)lineWidth
{
    return [self inspect:impl.nativeGroup.errMgr locale:[NSLocale currentLocale] lineWidth:lineWidth];
}

- (NSMutableArray *) inspectLocale:(NSLocale *)locale
{
    return [self inspect:impl.nativeGroup.errMgr locale:locale lineWidth:[ST NO_WRAP]];
}

- (NSMutableArray *) inspect:(ErrorManager *)anErrMgr locale:(NSLocale *)locale lineWidth:(NSInteger)lineWidth
{
    ErrorBuffer *errors = [[ErrorBuffer alloc] init];
    [impl.nativeGroup setListener:errors];
    StringWriter *wr = [[StringWriter alloc] init];
    id<STWriter> writer = [AutoIndentWriter newWriter:wr];
    [writer setLineWidth:lineWidth];
    Interpreter *interp = [[Interpreter alloc] init:groupThatCreatedThisInstance locale:locale];
    [interp exec:writer who:self];
//    [[STViz alloc] init:errMgr root:self output:[wr description] interp:interp trace:[interp executionTrace] errors:errors.errors];
    return [interp events];
}

- (NSMutableArray *) events
{
    return [self getEvents:[NSLocale currentLocale]];
}

- (NSMutableArray *) getEvents:(NSInteger)lineWidth
{
    return [self getEvents:[NSLocale currentLocale] lineWidth:lineWidth];
}

- (NSMutableArray *) getEventsLocale:(NSLocale *)locale {
    return [self getEventsLocale:locale lineWidth:[ST NO_WRAP]];
}

- (NSMutableArray *) getEventsLocale:(NSLocale *)locale lineWidth:(NSInteger)lineWidth
{
    StringWriter * wr1 = [[StringWriter alloc] init];
    id<STWriter> aWriter = [AutoIndentWriter newWriter:wr1];
    [aWriter setLineWidth:lineWidth];
    Interpreter * interp = [[Interpreter alloc] init:groupThatCreatedThisInstance locale:locale];
    [interp exec:aWriter who:self];
    return [interp events];
}

- (void) dealloc
{
    [newSTEvent release];
    [addAttrEvents release];
    [super dealloc];
}

@end
