/*
 * [The "BSD license"]
 *  Copyright (c) 2011 Terence Parr and Alan Condit
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions
 *  are met:
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  3. The name of the author may not be used to endorse or promote products
 *     derived from this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 *  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 *  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 *  NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLR.h>
#import "Writer.h"
#import "ST.h"

@class ST;
@class CompiledST;
@class STGroup;
@class ErrorManager;
@class AttributeList;


@interface Interpreter_Anon1 : NSObject {
    NSMutableDictionary *dict;
}

+ (id) newInterpreter_Anon1;
- (id) init;
- (BOOL) containsObject:(NSString *)text;
- (id) objectForKey:(NSString *)key;
- (void) setObject:(id)obj forKey:(id)key;
- (NSInteger) count;
- (NSEnumerator *) keyEnumerator;
- (NSArray *) objectEnumerator;

@property (retain) NSMutableDictionary *dict;

@end

@interface Interpreter_Anon2 : AMutableArray {
}

+ (id) newArrayWithST:(ST *)anST;
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

@property (assign) OptionEnum Option;

+ (OptionEnum) ANCHOR;
+ (OptionEnum) FORMAT;
+ (OptionEnum) _NULL;
+ (OptionEnum) SEPARATOR;
+ (OptionEnum) WRAP;

+ (id) newInterpreter_Anon3;
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
    id operands[100];
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
    AMutableArray *events;
    AMutableArray *executeTrace;
    //Map<ST, List<InterpEvent>> debugInfo;
    NSMutableDictionary *debugInfo;
}

+ (NSInteger) DEFAULT_OPERAND_STACK_SIZE;
+ (NSDictionary *) predefinedAnonSubtemplateAttributes;
+ (Interpreter_Anon3 *) Option;

- (id) initWithGroup:(STGroup *)group;
- (id) init:(STGroup *)group locale:(NSLocale *)locale;
- (id) init:(STGroup *)group errMgr:(ErrorManager *)errMgr;
- (id) init:(STGroup *)group locale:(NSLocale *)locale errMgr:(ErrorManager *)errMgr;
#ifdef USE_FREQ_COUNT
- (void) dumpOpcodeFreq;
#endif

- (NSInteger) exec:(Writer *)anSTWriter who:(ST *)aWho;
- (NSInteger) _exec:(Writer *)anSTWriter who:(ST *)aWho;
- (void) load_str:(ST *)who ip:(NSInteger)ip;
- (void) super_new:(ST *)aWho name:(NSString *)name nargs:(NSInteger)nargs;
- (void) super_new:(ST *)aWho name:(NSString *)name attrs:(NSMutableDictionary *)attrs;
- (void) storeArgs:(ST *)aWho attrs:(NSMutableDictionary *)attrs st:(ST *)st;
- (void) storeArgs:(ST *)aWho nargs:(NSInteger)nargs st:(ST *)st;
- (void) indent:(id<STWriter>)wr1 who:(ST *)aWho index:(NSInteger)strIndex;
- (NSInteger) writeObjectNoOptions:(Writer *)wr1 who:(ST *)aWho obj:(id)obj;
- (NSInteger) writeObjectWithOptions:(Writer *)anSTWriter who:(ST *)aWho obj:(id)obj options:(NSArray *)options;
- (NSInteger) writeObject:(Writer *)anSTWriter who:(ST *)who obj:(id)obj options:(NSArray *)options;
- (NSInteger) writeIterator:(Writer *)anSTWriter who:(ST *)aWho obj:(id)obj options:(NSArray *)options;
- (NSInteger) writePOJO:(Writer *)anSTWriter obj:(id)obj options:(NSArray *)options;
- (NSInteger) getExprStartChar:(ST *)aWho;
- (NSInteger) getExprStopChar:(ST *)aWho;
- (void) map:(ST *)aWho attr:(id)attr st:(ST *)st;
- (void) rot_map:(ST *)aWho attr:(id)attr prototypes:(AMutableArray *)prototypes;
- (AMutableArray *) rot_map_iterator:(ST *)aWho iter:(id)attr proto:(AMutableArray *)prototypes;
- (AttributeList *) zip_map:(ST *)aWho exprs:(AMutableArray *)exprs prototype:(ST *)prototype;
- (void) setFirstArgument:(ST *)aWho st:(ST *)st attr:(id)attr;
- (void) addToList:(AMutableArray *)list obj:(id)obj;
- (id) first:(id)v;
- (id) last:(id)v;
- (id) rest:(id)v;
- (id) trunc:(id)v;
- (id) strip:(id)v;
- (id) reverse:(id)v;
- (NSInteger) length:(id)v;
- (NSString *) description:(id<STWriter>)aWriter who:(ST *)aWho value:(id)value;
- (NSString *) toString:(id<STWriter>)aWriter who:(ST *)aWho value:(id)value;
+ (id) convertAnythingIteratableToIterator:(id)obj;
+ (ArrayIterator *) convertAnythingToIterator:(id)obj;
- (BOOL) testAttributeTrue:(id)a;
- (id) getObjectProperty:(id<STWriter>)anSTWriter who:(ST *)aWho obj:(id)obj property:(id)property;
- (void) setDefaultArguments:(id<STWriter>)wr1 who:(ST *)invokedST;
- (void) trace:(ST *)aWho ip:(NSInteger)ip;
- (void) printForTrace:(NSMutableString *)tr obj:(id)obj;
- (AMutableArray *) getEvents:(ST *)st;
+ (NSInteger) getShort:(char *)memory index:(NSInteger)index;

//@property (retain, getter=getOperands, setter=setOperands:) AMutableArray *operands;
@property (assign) NSInteger sp;
@property (assign) NSInteger current_ip;
@property (assign) NSInteger nwline;
@property (retain) STGroup *group;
@property (retain) NSLocale *locale;
@property (retain) ErrorManager *errMgr;
@property (retain) AMutableArray *events;
@property (retain) AMutableArray *executeTrace;
@property (retain) NSMutableDictionary *debugInfo;

@end
