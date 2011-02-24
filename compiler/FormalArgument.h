#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLR.h>

//#import "Token.h"

/**
 * Represents the name of a formal argument defined in a template:
 * 
 * test(a,b) ::= "<a> <n>"
 * 
 * Each template has a set of these formal arguments or uses
 * a placeholder object: UNKNOWN (indicating that no arguments
 * were specified such as when we create a template with "new ST(...)").
 * 
 * Note: originally, I tracked cardinality as well as the name of an
 * attribute.  I'm leaving the code here as I suspect something may come
 * of it later.  Currently, though, cardinality is not used.
 */
@class CompiledST;

@interface FormalArgument : NSObject {
    NSInteger cardinality;
    
    NSString *name;
    NSInteger index;
    /**
     * If they specified name="value", store the template here
     */
    ANTLRCommonToken *defaultValueToken;
    CompiledST *compiledDefaultValue;
}

@property (assign, getter=getCardinality, setter=setCardinality:) NSInteger cardinality;
@property (retain, getter=getName, setter=setName:) NSString *name;
@property (assign, getter=getIndex, setter=setIndex:) NSInteger index;
@property (retain, getter=getDefaultToken, setter=setDefaultToken:) ANTLRCommonToken *defaultValueToken;
@property (retain, getter=getCompiledDefaultValue, setter=setCompiledDefaultValue:) CompiledST *compiledDefaultValue;

+ (void) initialize;
+ (NSInteger) OPTIONAL;
+ (NSInteger) REQUIRED;
+ (NSInteger) ZERO_OR_MORE;
+ (NSInteger) ONE_OR_MORE;
+ (NSString *) suffixes:(NSInteger)idx;
    
+ (id) newFormalArgument:(NSString *)aName;
+ (id) newFormalArgument:(NSString *)aName token:(ANTLRCommonToken *)aToken;

- (id) init:(NSString *)name;
- (id) init:(NSString *)name token:(ANTLRCommonToken *)aDefaultValueToken;
- (NSInteger) hash;
- (BOOL) isEqualTo:(NSString *)obj;
- (NSString *) description;

// getters and setters
- (NSString *)getName;
- (void) setName:(NSString *)aName;
- (NSInteger) getIndex;
- (void) setIndex:(NSInteger) idx;
- (ANTLRCommonToken *)getDefaultValueToken;
- (void) setDefaultValueToken:(ANTLRCommonToken *)aToken;
- (CompiledST *)getCompiledDefaultValue;
- (void) setCompiledDefaultValue:(CompiledST *)aVal;

@end
