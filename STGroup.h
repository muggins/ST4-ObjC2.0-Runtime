#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLR.h>
#import "ModelAdaptor.h"
@class ErrorManager;
@class STErrorListener;
@class AttributeRenderer;
@class ST;
@class CompiledST;

@interface STGroup_Anon1 : NSMutableDictionary {
}
+ (id) newSTGroup_Anon1;
- (id) init;
@end

/**
 * A directory or directory tree of .st template files and/or group files.
 * Individual template files contain formal template definitions. In a sense,
 * it's like a single group file broken into multiple files, one for each template.
 * ST v3 had just the pure template inside, not the template name and header.
 * Name inside must match filename (minus suffix).
 */


/**
 * When we use key as a value in a dictionary, this is how we signify.
 */
extern BOOL debug;

@interface STGroup : NSObject {
    
    
    /**
     * Load files using what encoding?
     */
    NSStringEncoding encoding;
    
    /**
     * Every group can import templates/dictionaries from other groups.
     * The list must be synchronized (see importTemplates).
     */
    NSMutableArray *imports;
    unichar delimiterStartChar;
    unichar delimiterStopChar;
    
    /**
     * Maps template name to StringTemplate object. synchronized.
     */
    NSMutableDictionary *templates;
    
    /**
     * Maps dict names to HashMap objects.  This is the list of dictionaries
     * defined by the user like typeInitMap ::= ["int":"0"]
     */
    NSMutableDictionary *dictionaries;
    
    /**
     * A dictionary that allows people to register a renderer for
     * a particular kind of object for any template evaluated relative to this
     * group.  For example, a date should be formatted differently depending
     * on the locale.  You can set Date.class to an object whose
     * toString(Object) method properly formats a Date attribute
     * according to locale.  Or you can have a different renderer object
     * for each locale.
     * 
     * Order of addition is recorded and matters.  If more than one
     * renderer works for an object, the first registered has priority.
     * 
     * Renderer associated with type t works for object obj if
     * 
     * t.isAssignableFrom(obj.getClass()) // would assignment t = obj work?
     * 
     * So it works if obj is subclass or implements t.
     * 
     * This structure is synchronized.
     */
    NSMutableDictionary *renderers;
    
    /**
     * A dictionary that allows people to register a model adaptor for
     * a particular kind of object (subclass or implementation). Applies
     * for any template evaluated relative to this group.
     * 
     * ST initializes with model adaptors that know how to pull
     * properties out of Objects, Maps, and STs.
     */
    NSMutableDictionary *adaptors;
    
    /**
     * Cache exact attribute type to adaptor object
     */
    NSMutableDictionary *typeToAdaptorCache;
    
    /**
     * The errMgr for entire group; all compilations and executions.
     * This gets copied to parsers, walkers, and interpreters.
     */
    ErrorManager *errMgr;
}

@property (assign, getter=getEncoding, setter=setEncoding:) NSStringEncoding encoding; 
@property (retain, getter=getImports, setter=setImports:) NSMutableArray *imports;
@property (assign, getter=getDelimiterStartChar, setter=setDelimiterStartChar:) unichar delimiterStartChar;
@property (assign, getter=getDelimiterStopChar, setter=setDelimiterStopChar:) unichar delimiterStopChar;
@property (retain, getter=getTemplates, setter=setTemplates:) NSMutableDictionary *templates;
@property (retain, getter=getDictionaries, setter=setDictionaries:) NSMutableDictionary *dictionaries;
@property (retain, getter=getRenderers, setter=setRenderers:) NSMutableDictionary *renderers;
@property (retain, getter=getAdaptors, setter=setAdaptors:) NSMutableDictionary *adaptors;
@property (retain, getter=getErrMgr, setter=setErrMgr:) ErrorManager *errMgr;

+ (CompiledST *) NOT_FOUND_ST;
+ (NSString *) DEFAULT_KEY;
+ (NSString *) DICT_KEY;
+ (STGroup *) defaultGroup;
+ (ErrorManager *) DEFAULT_ERR_MGR;
+ (BOOL) debug;

+ (NSString *) getMangledRegionName:(NSString *)enclosingTemplateName name:(NSString *)name;
+ (NSString *) getUnMangledTemplateName:(NSString *)mangledName;

+ (id) newSTGroup;
+ (id) newSTGroup:(unichar)startChar delimiterStopChar:(unichar)stopChar;
- (id) init;
- (id) init:(unichar)delimiterStartChar delimiterStopChar:(unichar)delimiterStopChar;
- (ST *) getInstanceOf:(NSString *)name;
- (ST *) getEmbeddedInstanceOf:(ST *)enclosingInstance ip:(NSInteger)ip name:(NSString *)name;
- (ST *) createSingleton:(ANTLRCommonToken *)templateToken;
- (BOOL) isDefined:(NSString *)name;
- (CompiledST *) lookupTemplate:(NSString *)name;
- (void) unload;
- (CompiledST *) load:(NSString *)name;
- (void) load;
- (CompiledST *) lookupImportedTemplate:(NSString *)name;
- (CompiledST *) rawGetTemplate:(NSString *)name;
- (NSMutableDictionary *) rawGetDictionary:(NSString *)name;
- (BOOL) isDictionary:(NSString *)name;
- (CompiledST *) defineTemplate:(NSString *)templateName template:(NSString *)template;
- (CompiledST *) defineTemplate:(NSString *)name argsS:(NSString *)argsS template:(NSString *)template;
- (CompiledST *) defineTemplate:(NSString *)templateName nameT:(ANTLRCommonToken *)nameT args:(NSMutableArray *)args template:(NSString *)template templateToken:(ANTLRCommonToken *)templateToken;
- (CompiledST *) defineTemplateAlias:(ANTLRCommonToken *)aliasT targetT:(ANTLRCommonToken *)targetT;
- (CompiledST *) defineRegion:(NSString *)enclosingTemplateName regionT:(ANTLRCommonToken *)regionT template:(NSString *)template;
- (void) defineTemplateOrRegion:(NSString *)templateName regionSurroundingTemplateName:(NSString *)regionSurroundingTemplateName templateToken:(ANTLRCommonToken *)templateToken template:(NSString *)template nameToken:(ANTLRCommonToken *)nameToken args:(NSMutableArray *)args;
- (void) rawDefineTemplate:(NSString *)name code:(CompiledST *)code defT:(ANTLRCommonToken *)defT;
- (void) undefineTemplate:(NSString *)name;
- (CompiledST *) compile:(NSString *)srcName name:(NSString *)name args:(NSMutableArray *)args template:(NSString *)template templateToken:(ANTLRCommonToken *)templateToken;
- (void) defineDictionary:(NSString *)name mapping:(NSMutableDictionary *)mapping;
- (void) importTemplates:(STGroup *)g;
- (void) importTemplatesWithFileName:(ANTLRCommonToken *)fileNameToken;
- (void) loadGroupFile:(NSString *)prefix fileName:(NSString *)fileName;
- (void) registerModelAdaptor:(Class *)attributeType adaptor:(id<ModelAdaptor>)adaptor;
- (void) invalidateModelAdaptorCache:(Class *)attributeType;
- (id<ModelAdaptor>) getModelAdaptor:(Class *)attributeType;
- (void) registerRenderer:(Class *)attributeType r:(AttributeRenderer *)r;
- (AttributeRenderer *) getAttributeRenderer:(Class *)attributeType;
- (ST *) createStringTemplate;
- (ST *) createStringTemplate:(ST *)proto;
- (NSString *) description;
- (NSString *) show;

// getters and setters

- (NSStringEncoding) getEncoding;
- (void) setEncoding:(NSStringEncoding)encoding;
- (NSString *) getName;
//- (void) setName:(NSString *)name;
- (NSString *) getFileName;
//- (STErrorListener *) getListener;
//- (void) setListener:(STErrorListener *)aListener;
- (NSMutableArray *) getImports;
- (void) setImports:(NSMutableArray *)imports;
- (unichar) getDelimiterStartChar;
- (void) setDelimiterStartChar:(unichar)delimiterStartChar;
- (unichar) getDelimiterStopChar;
- (void) setDelimiterStopChar:(unichar)delimiterStopChar;
- (NSMutableDictionary *) getTemplates;
- (void) setTemplates:(NSMutableDictionary *)templates;
- (NSMutableDictionary *) getDictionaries;
- (void) setDictionaries:(NSMutableDictionary *)dictionaries;
- (NSMutableDictionary *) getRenderers;
- (void) setRenderers:(NSMutableDictionary *)renderers;
- (NSMutableDictionary *) getAdaptors;
- (void) setAdaptors:(NSMutableDictionary *)adaptors;
- (ErrorManager *) getErrMgr;
- (void) setErrMgr:(ErrorManager *)errMgr;


@end
