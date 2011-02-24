#import <ANTLR/ANTLR.h>
#import "STWriter.h"
#import "STGroup.h"
#import "STErrorListener.h"

/**
 * <@r()>, <@r>...<@end>, and @t.r() ::= "..." defined manually by coder
 */

typedef enum {
    IMPLICIT,
    EMBEDDED,
    EXPLICIT
} RegionTypeEnum;

// RegionTypeEnum RegionTypeValueOf(NSString *text);
// (NSString *) RegionTypeDescription(RegionTypeEnum value);

@class CompiledST;
@class STNoSuchPropertyException;
@class STErrorListener;

/**
 * Just an alias for ArrayList, but this way I can track whether a
 * list is something ST created or it's an incoming list.
 */

@interface AttributeList : NSMutableArray {
}

+ (id) arrayWithCapacity:(NSInteger)size;

- (id) init;
- (id) initWithCapacity:(NSInteger)size;
@end

/**
 * An instance of the StringTemplate. It consists primarily of
 * a reference to its implementation (shared among all instances)
 * and a hash table of attributes.  Because of dynamic scoping,
 * we also need a reference to any enclosing instance. For example,
 * in a deeply nested template for an HTML page body, we could still reference
 * the title attribute defined in the outermost page template.
 * 
 * To use templates, you create one (usually via STGroup) and then inject
 * attributes using add(). To render its attacks, use render().
 */

/**
 * Cache exception since this could happen a lot if people use "missing"
 * to mean boolean false.
 */
extern STNoSuchPropertyException *cachedNoSuchPropException;

@interface ST : NSObject {
    
    RegionTypeEnum RegionType;
    
    /**
     * The implementation for this template among all instances of same tmpelate .
     */
    CompiledST *impl;
    
    /**
     * Safe to simultaneously write via add, which is synchronized.  Reading
     * during exec is, however, NOT synchronized.  So, not thread safe to
     * add attributes while it is being evaluated.  Initialized to EMPTY_ATTR
     * to distinguish null from empty.
     */
    NSMutableArray *locals;
    
    NSMutableDictionary *attributes;
    /**
     * Enclosing instance if I'm embedded within another template.
     * IF-subtemplates are considered embedded as well. We look up
     * dynamically scoped attributes with this ptr.
     */
    ST *enclosingInstance;
    
    /**
     * Created as instance of which group? We need this to init interpreter
     * via render.  So, we create st and then it needs to know which
     * group created it for sake of polymorphism:
     * 
     * st = skin1.getInstanceOf("searchbox");
     * result = st.render(); // knows skin1 created it
     * 
     * Say we have a group, g1, with template t and import t and u templates from
     * another group, g2.  g1.getInstanceOf("u") finds u in g2 but remembers
     * that g1 created it.  If u includes t, it should create g1.t not g2.t.
     * 
     * g1 = {t(), u()}
     * |
     * v
     * g2 = {t()}
     */
    STGroup *groupThatCreatedThisInstance;
}

@property (assign, getter=getRegionType, setter=setRegionType:) RegionTypeEnum RegionType;
@property(retain, getter=getImpl, setter=setImpl:) CompiledST *impl;
@property(retain, getter=getLocals, setter=setLocals:) NSMutableArray *locals;
@property(retain, getter=getAttributes, setter=setAttributes:) NSMutableDictionary *attributes;
@property(retain, getter=getEnclosingInstance, setter=setEnclosingInstance:) ST *enclosingInstance;
@property(retain, getter=getGroupThatCreatedThisInstance, setter=setGroupThatCreatedThisInstance:) STGroup *groupThatCreatedThisInstance;

+ (void) initialize;
+ (NSInteger) NO_WRAP;
+ (NSString *)UNKNOWN_NAME;
+ (AttributeList *) EMPTY_ATTR;
//+ (AttributeList *) attributeList;
+ (AttributeList *) convertToAttributeList:(id)curvalue;

+ (NSString *) format:(NSString *)template attributes:(id)attributes;
+ (NSString *) format:(NSInteger)lineWidth template:(NSString *)template attributes:(id)attributes;

+ (id) newST;
+ (id) newSTWithTemplate:(NSString *)template;
+ (id) newST:(NSString *)template delimiterStartChar:(unichar)delimiterStartChar delimiterStopChar:(unichar)delimiterStopChar;
+ (id) newST:(STGroup *)group template:(NSString *)template;
+ (id) newSTWithProto:(ST *)proto;
- (id) init;
- (id) initWithTemplate:(NSString *)template;
- (id) init:(NSString *)template delimiterStartChar:(unichar)delimiterStartChar delimiterStopChar:(unichar)delimiterStopChar;
- (id) init:(STGroup *)group template:(NSString *)template;
- (id) initWithProto:(ST *)proto;
- (void) add:(NSString *)name value:(id)value;
- (void) remove:(NSString *)name;
- (void) rawSetAttribute:(NSString *)name value:(id)value;
- (id) getAttribute:(NSString *)name;
- (NSMutableDictionary *) getAttributes;
- (NSString *) getEnclosingInstanceStackString;
- (NSMutableArray *) getEnclosingInstanceStack:(BOOL)topdown;
- (NSString *) getName;
- (NSInteger) write:(id<STWriter>)wr1;
- (NSInteger) write:(id<STWriter>)wr1 locale:(NSLocale *)locale;
- (NSInteger) write:(id<STWriter>)wr1 listener:(STErrorListener *)listener;
- (NSInteger) write:(id<STWriter>)wr1 locale:(NSLocale *)locale listener:(STErrorListener *)listener;
- (NSString *) render;
- (NSString *) renderWithLineWidth:(NSInteger)lineWidth;
- (NSString *) render:(NSLocale *)locale;
- (NSString *) render:(NSLocale *)locale lineWidth:(NSInteger)lineWidth;
- (NSString *) description;
- (BOOL) getIsAnonSubtemplate;
// getters and setters
//- (NSMutableDictionary *) getAttributes;
//- (void) setAttributes:(NSMutableDictionary *)aDictionary;
//- (NSString *)getEnclosingInstanceStackString;
//- (void)setEnclosingInstanceStackString:(NSString *)aString;
//- (BOOL) getAnonSubtemplate;
//- (void) setAnonSubtemplate:(BOOL)aSubtemplate;

#ifdef DONTUSENOMO
// getters and setters
- (CompiledST *) getImpl;
- (void) setImpl:(CompiledST *)anImpl;
- (NSArray *) getLocals;
- (void) setLocals:(NSMutableArray *)locals;
//@property(retain, getter=getAttributes, setter=setAttributes:) NSMutableDictionary *attributes;
- (ST *) getEnclosingInstance;
- (void) setEnclosingInstance:(ST *)enclosingInstance;
- (STGroup *) getGroupThatCreatedThisInstance;
- (void) setGroupThatCreatedThisInstance:(STGroup *)groupThatCreatedThisInstance;

- (NSInteger) getNO_WRAP;
- (void) setNO_WRAP:(NSInteger)linewidth;
- (NSString *) getUNKNOW_NAME;
- (void) setUNKNOWN_NAME:(NSString *)aName;
- (NSString *) getEMPTY_ATTR;
- (void) setEMPTY_ATTR:(NSString *)aName;
#endif

@end
