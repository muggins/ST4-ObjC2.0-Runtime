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
#import "STErrorListener.h"
#import "STToken.h"
#import "ModelAdaptor.h"
#import "AMutableArray.h"

@class ErrorManager;
@class STErrorListener;
@class AttributeRenderer;
@class ST;
@class CompiledST;

@interface STGroup_Anon1 : NSObject {
    NSMutableDictionary *dict;
}

+ (id) newSTGroup_Anon1;

- (id) init;
- (id) getDict;
- (id) objectForKey:(id)aKey;
- (void) setObject:(id)anObject forKey:(id)aKey;
- (NSInteger) count;

@property (retain) NSMutableDictionary *dict;
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
@interface STGroup : NSObject {
    
    
    /**
     * Load files using what encoding?
     */
    NSStringEncoding encoding;
    
    /**
     * Every group can import templates/dictionaries from other groups.
     * The list must be synchronized (see importTemplates).
     */
    AMutableArray *imports;
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
    
	/** Cache exact attribute type to renderer object */
	NSMutableDictionary *typeToRendererCache;
    /**
     * The errMgr for entire group; all compilations and executions.
     * This gets copied to parsers, walkers, and interpreters.
     */
    ErrorManager *errMgr;
}

+ (CompiledST *) NOT_FOUND_ST;
+ (NSString *) DEFAULT_KEY;
+ (NSString *) DICT_KEY;
+ (STGroup *) defaultGroup;
+ (ErrorManager *) DEFAULT_ERR_MGR;
+ (BOOL) debug;
+ (void) setDebug;
+ (BOOL) verbose;

+ (NSString *) getMangledRegionName:(NSString *)enclosingTemplateName name:(NSString *)name;
+ (NSString *) getUnMangledTemplateName:(NSString *)mangledName;

+ (id) newSTGroup;
+ (id) newSTGroup:(unichar)startChar delimiterStopChar:(unichar)stopChar;
- (id) init;
- (id) init:(unichar)delimiterStartChar delimiterStopChar:(unichar)delimiterStopChar;
- (ST *) getInstanceOf:(NSString *)name;
- (ST *) getEmbeddedInstanceOf:(ST *)enclosingInstance ip:(NSInteger)ip name:(NSString *)name;
- (ST *) createSingleton:(STToken *)templateToken;
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

- (CompiledST *) defineTemplate:(NSString *)aName argsS:(NSString *)argsS template:(NSString *)template;
- (CompiledST *) defineTemplate:(NSString *)name argsS:(NSString *)argsS template:(NSString *)template templateToken:(STToken *)templateToken;
- (CompiledST *) defineTemplate:(NSString *)templateName nameT:(STToken *)nameT args:(AMutableArray *)args template:(NSString *)template templateToken:(STToken *)templateToken;
- (CompiledST *) defineTemplateAlias:(STToken *)aliasT targetT:(STToken *)targetT;
- (CompiledST *) defineRegion:(NSString *)enclosingTemplateName regionT:(STToken *)regionT template:(NSString *)template templateToken:(STToken *)templateToken;
- (void) defineTemplateOrRegion:(NSString *)templateName regionSurroundingTemplateName:(NSString *)regionSurroundingTemplateName templateToken:(STToken *)templateToken template:(NSString *)template nameToken:(STToken *)nameToken args:(AMutableArray *)args;
- (void) rawDefineTemplate:(NSString *)name code:(CompiledST *)code defT:(STToken *)defT;
- (void) undefineTemplate:(NSString *)name;
- (CompiledST *) compile:(NSString *)srcName name:(NSString *)name args:(AMutableArray *)args template:(NSString *)template templateToken:(STToken *)templateToken;
- (void) defineDictionary:(NSString *)name mapping:(NSMutableDictionary *)mapping;
- (void) importTemplates:(STGroup *)g;
- (void) importTemplatesWithFileName:(STToken *)fileNameToken;
- (void) loadGroupFile:(NSString *)prefix fileName:(NSString *)fileName;
- (CompiledST *) loadTemplateFile:(NSString *)prefix fileName:(NSString *)fileName stream:(id<ANTLRCharStream>)templateStream;
- (CompiledST *) loadAbsoluteTemplateFile:(NSString *) fileName;
- (void) registerModelAdaptor:(id)attributeType adaptor:(id<ModelAdaptor>)adaptor;
- (void) invalidateModelAdaptorCache:(id)attributeType;
- (id<ModelAdaptor>) getModelAdaptor:(id)attributeType;
- (void) registerRenderer:(id)attributeType r:(AttributeRenderer *)r;
- (AttributeRenderer *) getAttributeRenderer:(id)attributeType;
- (ST *) createStringTemplate;
- (ST *) createStringTemplate:(ST *)proto;
- (NSString *)getRootDir;
- (NSString *) description;
- (NSString *) toString;
- (NSString *) show;

// getters and setters

- (NSString *) getFileName;
- (NSString *) getName;
- (id<STErrorListener>) getListener;
- (void) setListener:(id<STErrorListener>)aListener;

@property (assign) NSStringEncoding encoding; 
@property (retain) AMutableArray *imports;
@property (assign) unichar delimiterStartChar;
@property (assign) unichar delimiterStopChar;
@property (retain) NSMutableDictionary *templates;
@property (retain) NSMutableDictionary *dictionaries;
@property (retain) NSMutableDictionary *renderers;
@property (retain) NSMutableDictionary *adaptors;
@property (retain) ErrorManager *errMgr;
@property (retain) NSMutableDictionary *typeToAdaptorCache;
@property (retain) NSMutableDictionary *typeToRendererCache;

@end
