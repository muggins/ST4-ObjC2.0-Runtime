#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLR.h>
#import "STWriter.h"
#import "ST.h"
@class STGroup;
@class ErrorManager;
@class AttributeList;


@interface Interpreter_Anon1 : ANTLRHashMap {
}

+ (id) newInterpreter_Anon1;
- (id) init;
@end

@interface Interpreter_Anon2 : NSMutableArray {
}

+ (id) newInterpreter_Anon2WithST:(ST *)anST;
- (id) initWithST:(ST *)anST;
@end

typedef enum {
    ANCHOR,
    FORMAT,
    _NULL,
    SEPARATOR,
    WRAP
} OptionEnum;

@interface Interpreter_Anon3 : NSObject {
    OptionEnum Option;
}

@property (assign, getter=getOption, setter=setOption:) OptionEnum Option;

+ (OptionEnum) ANCHOR;
+ (OptionEnum) FORMAT;
+ (OptionEnum) _NULL;
+ (OptionEnum) SEPARATOR;
+ (OptionEnum) WRAP;

- (id) init;
- (OptionEnum) ANCHOR;
- (OptionEnum) FORMAT;
- (OptionEnum) _NULL;
- (OptionEnum) SEPARATOR;
- (OptionEnum) WRAP;
- (OptionEnum) containsObject:(NSString *)text;
- (NSInteger) count;
@end

OptionEnum OptionValueOf(NSString *text);
NSString *OptionDescription(OptionEnum value);

/**
 * This class knows how to execute template bytecodes relative to a
 * particular STGroup. To execute the byte codes, we need an output stream
 * and a reference to an ST an instance. That instance's impl field points at
 * a CompiledST, which contains all of the byte codes and other information
 * relevant to execution.
 * 
 * This interpreter is a stack-based bytecode interpreter.  All operands
 * go onto an operand stack.
 * 
 * If the group that we're executing relative to has debug set, we track
 * interpreter events. For now, I am only tracking instance creation events.
 * These are used by STViz to pair up output chunks with the template
 * expressions that generate them.
 * 
 * We create a new interpreter for each ST.render(), DebugST.inspect, or
 * DebugST.getEvents() invocation.
 */

/**
 * Dump bytecode instructions as we execute them?
 */
extern BOOL trace;

@interface Interpreter : NSObject {
    
    /**
     * Operand stack, grows upwards
     */
    NSMutableArray *operands;
    NSInteger sp;
    NSInteger current_ip;
    NSInteger nwline;
    
    /**
     * Exec st with respect to this group. Once set in ST.toString(),
     * it should be fixed. ST has group also.
     */
    STGroup *group;
    
    /**
     * For renderers, we have to pass in the locale
     */
    NSLocale *locale;
    ErrorManager *errMgr;
    
    /**
     * Track everything happening in interp if debug across all templates
     */
    NSMutableArray *events;
    NSMutableArray *executeTrace;
    //Map<ST, List<InterpEvent>> debugInfo;
    NSMutableDictionary *debugInfo;
}

@property (retain, getter=getOperands, setter=setOperands:) NSMutableArray *operands;
@property (assign, getter=getSp, setter=setSp:) NSInteger sp;
@property (assign, getter=getCurrent_ip, setter=setCurrent_ip:) NSInteger current_ip;
@property (assign, getter=getNwline, setter=setNwline:) NSInteger nwline;
@property (retain, getter=getGroup, setter=setGroup:) STGroup *group;
@property (retain, getter=getLocale, setter=setLocale:) NSLocale *locale;
@property (retain, getter=getErrMgr, setter=setErrMgr:) ErrorManager *errMgr;
@property (retain, getter=getEvents, setter=setEvents:) NSMutableArray *events;
@property (retain, getter=getExecuteTrace, setter=setExecuteTrace:) NSMutableArray *executeTrace;
@property (retain, getter=getDebugInfo, setter=setDebugInfo:) NSMutableDictionary *debugInfo;

+ (NSInteger) DEFAULT_OPERAND_STACK_SIZE;
+ (Interpreter_Anon3 *) Option;
+ (Interpreter_Anon3 *)predefinedAnonSubtemplateAttributes;

- (id) initWithGroup:(STGroup *)group;
- (id) init:(STGroup *)group locale:(NSLocale *)locale;
- (id) init:(STGroup *)group errMgr:(ErrorManager *)errMgr;
- (id) init:(STGroup *)group locale:(NSLocale *)locale errMgr:(ErrorManager *)errMgr;
- (NSInteger) exec:(id<STWriter>)anSTWriter who:(ST *)aWho;
- (NSInteger) _exec:(id<STWriter>)anSTWriter who:(ST *)aWho;
- (void) super_new:(ST *)aWho name:(NSString *)name nargs:(NSInteger)nargs;
- (void) super_new:(ST *)aWho name:(NSString *)name attrs:(NSMutableDictionary *)attrs;
- (void) storeArgs:(ST *)aWho attrs:(NSMutableDictionary *)attrs st:(ST *)st;
- (void) storeArgs:(ST *)aWho nargs:(NSInteger)nargs st:(ST *)st;
- (NSInteger) writeObjectNoOptions:(id<STWriter>)anSTWriter who:(ST *)aWho obj:(id)obj;
- (NSInteger) writeObjectWithOptions:(id<STWriter>)anSTWriter who:(ST *)aWho obj:(id)obj options:(NSArray *)options;
- (NSInteger) writeObject:(id<STWriter>)anSTWriter who:(ST *)who obj:(id)obj options:(NSArray *)options;
- (NSInteger) writeIterator:(id<STWriter>)anSTWriter who:(ST *)aWho obj:(id)obj options:(NSArray *)options;
- (NSInteger) writePOJO:(id<STWriter>)anSTWriter obj:(id)obj options:(NSArray *)options;
- (void) map:(ST *)aWho attr:(id)attr st:(ST *)st;
- (void) rot_map:(ST *)aWho attr:(id)attr prototypes:(NSMutableArray *)prototypes;
- (AttributeList *) zip_map:(ST *)aWho exprs:(NSMutableArray *)exprs prototype:(ST *)prototype;
- (void) setFirstArgument:(ST *)aWho st:(ST *)st attr:(id)attr;
- (void) addToList:(NSMutableArray *)list obj:(id)obj;
- (id) first:(id)v;
- (id) last:(id)v;
- (id) rest:(id)v;
- (id) trunc:(id)v;
- (id) strip:(id)v;
- (id) reverse:(id)v;
- (NSInteger) length:(id)v;
- (NSString *) description:(ST *)aWho value:(id)value;
+ (id) convertAnythingIteratableToIterator:(id)obj;
+ (NSEnumerator *) convertAnythingToIterator:(id)obj;
- (BOOL) testAttributeTrue:(id)a;
- (id) getObjectProperty:(ST *)aWho obj:(id)obj property:(id)property;
- (void) setDefaultArguments:(ST *)invokedST;
- (void) trace:(ST *)aWho ip:(NSInteger)ip;
- (void) printForTrace:(NSMutableString *)tr obj:(id)obj;
- (NSMutableArray *) getEvents:(ST *)st;
+ (NSInteger) getShort:(char *)memory index:(NSInteger)index;
@end
