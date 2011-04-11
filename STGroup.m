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
#import "ST.h"
#import "STGroup.h"
#import "Bytecode.h"
#import "BytecodeDisassembler.h"
#import "CompilationState.h"
#import "CompiledST.h"
#import "Compiler.h"
#import "FormalArgument.h"
#import "STException.h"
#import "StringTable.h"
#import "Compiler.h"
#import "DebugST.h"
#import "ArrayIterator.h"
#import "Coordinate.h"
#import "ErrorBuffer.h"
#import "ErrorManager.h"
#import "ErrorType.h"
#import "Interval.h"
#import "MapModelAdaptor.h"
#import "Misc.h"
#import "MultiMap.h"
#import "ObjectModelAdaptor.h"
#import "STCompiletimeMessage.h"
#import "STDump.h"
#import "STGroupCompiletimeMessage.h"
#import "STLexerMessage.h"
#import "STMessage.h"
#import "STModelAdaptor.h"
#import "STRuntimeMessage.h"
#import "ModelAdaptor.h"
#import "GroupLexer.h"
#import "GroupParser.h"
#import "AMutableArray.h"

@implementation STGroup_Anon1

@synthesize dict;

+ (id) newSTGroup_Anon1
{
    return [[[STGroup_Anon1 alloc] init] retain];
}

- (id) init
{
    self=[super init];
    if ( self != nil ) {
        dict = [NSMutableDictionary dictionaryWithCapacity:16];
        [dict setObject:[[ObjectModelAdaptor alloc] init] forKey:[NSObject className]];
        [dict setObject:[[STModelAdaptor alloc] init] forKey:[ST className]];
        [dict setObject:[[MapModelAdaptor alloc] init] forKey:[NSMutableDictionary className]];
    }
    return self;
}

- (id) getDict
{
    return dict;
}

- (id) objectForKey:(id)aKey
{
    return [dict objectForKey:aKey];
}

- (void) setObject:(id)anObject forKey:(id)aKey
{
    [dict setObject:anObject forKey:aKey];
}

- (NSInteger) count
{
    return [dict count];
}

@end

/** A directory or directory tree of .st template files and/or group files.
 *  Individual template files contain formal template definitions. In a sense,
 *  it's like a single group file broken into multiple files, one for each template.
 *  ST v3 had just the pure template inside, not the template name and header.
 *  Name inside must match filename (minus suffix).
 */
@implementation STGroup

/**
 * Used to indicate that the template doesn't exist.
 * Prevents duplicate group file loads and unnecessary file checks.
 */
static STGroup      *defaultGroup = nil;
static CompiledST   *NOT_FOUND_ST = nil;
static ErrorManager *DEFAULT_ERR_MGR = nil;
/**
 * When we use key as a value in a dictionary, this is how we signify.
 */
static NSString *const DEFAULT_KEY = @"default";
static NSString *const DICT_KEY = @"key";
static BOOL debug = NO;
static BOOL verbose = YES;
static BOOL trackCreationEvents = NO;

@synthesize encoding; 
@synthesize imports;
@synthesize delimiterStartChar;
@synthesize delimiterStopChar;
@synthesize templates;
@synthesize dictionaries;
@synthesize renderers;
@synthesize adaptors;
@synthesize errMgr;
@synthesize typeToAdaptorCache;
@synthesize typeToRendererCache;

+ (void) initialize
{
    defaultGroup = [STGroup newSTGroup];
}

+ (CompiledST *) NOT_FOUND_ST
{
    if (NOT_FOUND_ST == nil)
        NOT_FOUND_ST = [CompiledST newCompiledST];
    return NOT_FOUND_ST;
}

+ (NSString *) DEFAULT_KEY
{
    return DEFAULT_KEY;
}

+ (NSString *) DICT_KEY
{
    return DICT_KEY;
}

+ (id) defaultGroup
{
    if (defaultGroup == nil)
        defaultGroup = [STGroup newSTGroup];
    return defaultGroup;
}

+ (ErrorManager *) DEFAULT_ERR_MGR
{
    if (DEFAULT_ERR_MGR == nil)
        DEFAULT_ERR_MGR = [ErrorManager newErrorManager];
    return DEFAULT_ERR_MGR;
}

+ (BOOL)trackCreationEvents
{
    return trackCreationEvents;
}

+ (BOOL) debug
{
    return debug;
}

+ (void) setDebug
{
    debug = YES;
}

+ (BOOL) verbose
{
    return verbose;
}

+ (void) setVerbose
{
    verbose = YES;
}

+ (id) newSTGroup
{
    return [[[STGroup alloc] init] retain];
}

+ (id) newSTGroup:(unichar)startChar delimiterStopChar:(unichar)stopChar
{
    return [[[STGroup alloc] init:(unichar)startChar delimiterStopChar:(unichar)stopChar] retain];
}

- (id) init
{
    self=[super init];
    if ( self != nil ) {
        encoding = NSUTF8StringEncoding;
        delimiterStartChar = '<';
        delimiterStopChar = '>';
        templates = [NSMutableDictionary dictionaryWithCapacity:16];
        dictionaries = [NSMutableDictionary dictionaryWithCapacity:16];
        adaptors = [NSMutableDictionary dictionaryWithDictionary:[[STGroup_Anon1 newSTGroup_Anon1] getDict]];
        typeToAdaptorCache = [NSMutableDictionary dictionaryWithCapacity:16];
        errMgr = STGroup.DEFAULT_ERR_MGR;
    }
    return self;
}

- (id) init:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar
{
    self=[super init];
    if ( self != nil ) {
        encoding = NSUTF8StringEncoding;
        delimiterStartChar = aDelimiterStartChar;
        delimiterStopChar = aDelimiterStopChar;
        templates = [NSMutableDictionary dictionaryWithCapacity:16];
        dictionaries = [NSMutableDictionary dictionaryWithCapacity:20];
        adaptors = [NSMutableDictionary dictionaryWithDictionary:[[STGroup_Anon1 newSTGroup_Anon1] getDict]];
        typeToAdaptorCache = [NSMutableDictionary dictionaryWithCapacity:16];
        errMgr = STGroup.DEFAULT_ERR_MGR;
    }
    return self;
}


/**
 * The primary means of getting an instance of a template from this
 * group. Names must be absolute, fully-qualified names like a/b
 */
- (ST *) getInstanceOf:(NSString *)aName
{
	if ( verbose ) NSLog(@"getInstanceOf(%@) in group %@", aName, [self getName]);
    if ( aName == nil )
        return nil;
    CompiledST *c = [self lookupTemplate:aName];
    if ( c != nil ) {
        ST *instanceST = [self createStringTemplate];
        instanceST.groupThatCreatedThisInstance = self;
        instanceST.impl = c;
        if ( instanceST.impl.formalArguments != nil ) {
            instanceST.locals = [AMutableArray arrayWithCapacity:[instanceST.impl.formalArguments count]];
            for (int i = 0; i < [instanceST.impl.formalArguments count]; i++ ) {
                [instanceST.locals addObject:ST.EMPTY_ATTR];
            }
        }
        return instanceST;
    }
    return nil;
}

- (ST *) getEmbeddedInstanceOf:(Interpreter *)interp
                           who:(ST *)enclosingInstance
                            ip:(NSInteger)ip
                          name:(NSString *)aName
{
	if ( verbose ) NSLog( @"getEmbeddedInstanceOf(%@)", aName);
    ST *st = [self getInstanceOf:aName];
    if ( st == nil ) {
        [errMgr runTimeError:interp who:enclosingInstance
                          ip:ip
                       error:NO_SUCH_TEMPLATE
                         arg:aName];
        st = [self createStringTemplate];
        st.impl = [CompiledST newCompiledST];
        return st;
    }
	// this is only called internally. whack any debug ST create events
	if ( trackCreationEvents ) {
		st.debugState.newSTEvent = nil; // toss it out
	}
    return st;
}


/**
 * Create singleton template for use with dictionary values
 */
- (ST *) createSingleton:(STToken *)templateToken
{
    NSString *template;
    if ([templateToken getType] == GroupParser.TBIGSTRING) {
        template = [Misc strip:[templateToken getText] n:2];
    }
    else {
        template = [Misc strip:[templateToken getText] n:1];
    }
    ST *st = [self createStringTemplateInternally];
    st.groupThatCreatedThisInstance = self;
    st.impl = [self compile:[self getFileName] name:nil args:nil template:template templateToken:templateToken];
    st.impl.hasFormalArgs = NO;
    st.impl.name = ST.UNKNOWN_NAME;
    [st.impl defineImplicitlyDefinedTemplates:self];
    return st;
}


/**
 * Is this template defined in this group or from this group below?
 * Names must be absolute, fully-qualified names like /a/b
 */
- (BOOL) isDefined:(NSString *)aName
{
    return [self lookupTemplate:aName] != nil;
}


/**
 * Look up a fully-qualified name
 */
- (CompiledST *) lookupTemplate:(NSString *)aName
{
    CompiledST *code = [self rawGetTemplate:aName];
    if (code == STGroup.NOT_FOUND_ST) {
		if ( verbose ) NSLog(@"%@ not found", aName);
        return nil;
    }
    if (code == nil)
        code = [self load:aName];
    if (code == nil)
        code = [self lookupImportedTemplate:aName];
    if (code == nil) {
		if ( verbose ) NSLog(@"%@ not found", aName);
        [templates setObject:NOT_FOUND_ST forKey:aName];
    }
	if ( verbose && code != nil ) NSLog(@"found %@ in %@", aName, code.name);
    return code;
}

/**
 * "unload" all templates and dictionaries but leave renderers, adaptors,
 * and import relationships.  This essentially forces next getInstanceOf
 * to reload templates.
 */
- (void) unload
{
    [templates removeAllObjects];
    [dictionaries removeAllObjects];
}


/**
 * Load st from disk if dir or load whole group file if .stg file (then
 * return just one template). name is fully-qualified.
 */
- (CompiledST *) load:(NSString *)name
{
    return nil;
}


/**
 * Force a load if it makes sense for the group
 */
- (void) load
{
}

- (CompiledST *) lookupImportedTemplate:(NSString *)aName
{
    if ( imports == nil )
        return nil;
    
    for (STGroup *g in imports) {
        CompiledST *code = [g lookupTemplate:aName];
        if ( code != nil ) {
	        if ( verbose ) NSLog(@"found %@ in %@", aName, [self getName]);
            return code;
        }
    }
	if ( verbose ) NSLog(@"%@ not found in imports", aName);
    return nil;
}

- (CompiledST *) rawGetTemplate:(NSString *)aName
{
    CompiledST *c = [templates objectForKey:aName];
    return c;
}

- (NSMutableDictionary *) rawGetDictionary:(NSString *)aName
{
    return [dictionaries objectForKey:aName];
}

- (BOOL) isDictionary:(NSString *)aName
{
    return ([dictionaries objectForKey:aName] != nil);
}

// for testing
- (CompiledST *) defineTemplate:(NSString *)aTemplateName template:(NSString *)aTemplate
{
    @try {
        CompiledST *impl = [self defineTemplate:aTemplateName
                                          nameT:[STToken newToken:ID Text:aTemplateName]
                                           args:nil
                                       template:aTemplate
                                  templateToken:nil];
        return impl;
    }
    @catch (STException *se) {
        // we have reported the error; the exception just blasts us
        // out of parsing this template
    }
    return nil;
}

- (CompiledST *) defineTemplate:(NSString *)aName argsS:(NSString *)argsS template:(NSString *)template
{
    return [self defineTemplate:aName argsS:argsS template:template templateToken:nil];
}

// for testing
- (CompiledST *) defineTemplate:(NSString *)aName argsS:(NSString *)argsS template:(NSString *)template templateToken:templateToken
{
    NSArray *args = [argsS componentsSeparatedByString:@","];
    AMutableArray *a = [AMutableArray arrayWithCapacity:5];
    for (NSString *arg in args) {
        [a addObject:[FormalArgument newFormalArgument:arg]];
    }
    return [self defineTemplate:aName
                          nameT:[STToken newToken:ID Text:aName]
                           args:a
                       template:template
                  templateToken:nil];
}

- (CompiledST *) defineTemplate:(NSString *)templateName
                          nameT:(STToken *)nameT
                           args:(AMutableArray *)args
                       template:(NSString *)template
                  templateToken:(STToken *)templateToken
{
    AMutableArray *hold_args;
    hold_args = args;
    if (templateName == nil || [templateName length] == 0) {
        @throw [ANTLRIllegalArgumentException newException:@"empty template name"];
    }
    NSInteger i;
    for (i = ([templateName length]-1); i >= 0; i-- ) {
        if ( [templateName characterAtIndex:i] == '.' ) break;
    }
    if (i >= 0) {
        @throw [ANTLRIllegalArgumentException newException:@"cannot have '.' in template names"];
    }
    template = [Misc trimOneStartingNewline:template];
    template = [Misc trimOneTrailingNewline:template];
    CompiledST *code = [self compile:[self getFileName] name:templateName args:args template:template templateToken:templateToken];
    code.name = templateName;
    [self rawDefineTemplate:templateName code:code defT:nameT];
    [code defineArgDefaultValueTemplates:self];
    [code defineImplicitlyDefinedTemplates:self];
    return code;
}


/**
 * Make name and alias for target.  Replace any previous def of name
 */
- (CompiledST *) defineTemplateAlias:(STToken *)aliasT targetT:(STToken *)targetT
{
    NSString *alias = [aliasT getText];
    NSString *target = [targetT getText];
    CompiledST *targetCode = [self rawGetTemplate:target];
    if ( targetCode == nil ) {
        [errMgr compileTimeError:ALIAS_TARGET_UNDEFINED templateToken:nil t:aliasT arg:alias arg2:target];
        return nil;
    }
    [templates setObject:targetCode forKey:alias];
    return targetCode;
}

- (CompiledST *) defineRegion:(NSString *)enclosingTemplateName regionT:(STToken *)regionT template:(NSString *)template templateToken:(STToken *)templateToken
{
    NSString *aName = [regionT getText];
    template = [Misc trimOneStartingNewline:template];
    template = [Misc trimOneTrailingNewline:template];
    CompiledST *code = [self compile:[self getFileName] name:enclosingTemplateName args:nil template:template templateToken:regionT];
    NSString *mangled = [STGroup getMangledRegionName:enclosingTemplateName name:aName];
    if ([self lookupTemplate:mangled] == nil) {
        [errMgr compileTimeError:NO_SUCH_REGION templateToken:templateToken t:regionT arg:enclosingTemplateName arg2:aName];
        return [CompiledST newCompiledST];
    }
    code.name = mangled;
    code.isRegion = YES;
    code.regionDefType = /* ST.RegionType. */EXPLICIT;
    code.templateDefStartToken = regionT;
    [self rawDefineTemplate:mangled code:code defT:regionT];
    [code defineArgDefaultValueTemplates:self];
    [code defineImplicitlyDefinedTemplates:self];
    return code;
}

- (void) defineTemplateOrRegion:(NSString *)templateName
  regionSurroundingTemplateName:(NSString *)regionSurroundingTemplateName
                  templateToken:(STToken *)templateToken
                       template:(NSString *)template
                      nameToken:(STToken *)nameToken
                           args:(AMutableArray *)args
{
    @try {
        if (regionSurroundingTemplateName != nil) {
            [self defineRegion:regionSurroundingTemplateName regionT:nameToken template:template templateToken:templateToken];
        }
        else {
            [self defineTemplate:templateName nameT:nameToken args:args template:template templateToken:templateToken];
        }
    }
    @catch (STException *e) {
        // after getting syntax error in a template, we emit msg
        // and throw exception to blast all the way out here.
    }
}

- (void) rawDefineTemplate:(NSString *)aName code:(CompiledST *)code defT:(STToken *)defT
{
    CompiledST *prev = [self rawGetTemplate:aName];
    if ( prev != nil ) {
        if ( !prev.isRegion ) {
            [errMgr compileTimeError:TEMPLATE_REDEFINITION templateToken:nil t:defT];
            return;
        }
        if ( prev.isRegion ) {
            if ( code.regionDefType == IMPLICIT && prev.regionDefType == EMBEDDED ) {
                [errMgr compileTimeError:EMBEDDED_REGION_REDEFINITION templateToken:nil t:defT arg:[STGroup getUnMangledTemplateName:aName]];
                return;
            }
            else if ( code.regionDefType == IMPLICIT || prev.regionDefType == EXPLICIT ) {
                [errMgr compileTimeError:REGION_REDEFINITION templateToken:nil t:defT arg:[STGroup getUnMangledTemplateName:aName]];
                return;
            }
        }
    }
        code.nativeGroup = self;
        code.templateDefStartToken = defT;
        [templates setObject:code forKey:aName];
}
    
    - (void) undefineTemplate:(NSString *)aName
    {
        [templates removeObjectForKey:aName];
    }
    
/**
 * Compile a template
 */
- (CompiledST *) compile:(NSString *)srcName
                    name:(NSString *)aName
                    args:(AMutableArray *)args
                template:(NSString *)aTemplate
           templateToken:(STToken *)aTemplateToken
{
	// if ( verbose ) NSLog(@"STGroup.compile: %@", enclosingTemplateName);
    Compiler *c = [Compiler newCompiler:self];
    CompiledST *code = [c compile:srcName name:aName args:args template:aTemplate templateToken:aTemplateToken];
    return code;
}


/**
 * The "foo" of t() ::= "<@foo()>" is mangled to "region#t#foo"
 */
+ (NSString *) getMangledRegionName:(NSString *)anEnclosingTemplateName name:(NSString *)aName
{
    NSString *tmp = [NSString stringWithFormat:@"region__%@__%@", anEnclosingTemplateName, aName];
    return tmp;
}


/**
 * Return "t.foo" from "region__t__foo"
 */
+ (NSString *) getUnMangledTemplateName:(NSString *)mangledName
{
    NSInteger len = [@"region__" length];
    NSRange r1 = [mangledName rangeOfString:@"__" options:NSBackwardsSearch];
    NSRange r2 = NSMakeRange(len, r1.location-len);
    NSString *t = [mangledName substringWithRange:r2];
    NSString *r = [mangledName substringWithRange:NSMakeRange(r1.location+2, [mangledName length]-(r1.location+2))];
    NSString *tmp = [NSString stringWithFormat:@"%@.%@", t, r];
    return tmp;
}


/**
 * Define a map for this group; not thread safe...do not keep adding
 * these while you reference them.
 */
- (void) defineDictionary:(NSString *)aName mapping:(NSMutableDictionary *)mapping
{
    [dictionaries setObject:mapping forKey:aName];
}


/*
 * Import template files, directories, and group files.
 *  Priority is given to templates defined in the current group;
 *  this, in effect, provides inheritance. Polymorphism is in effect so
 *  that if an inherited template references template t() then we
 *  search for t() in the subgroup first.
 *
 *  If you specify an absolute file name or directory name, the
 *  import statement uses that directly. If it is not an absolute path,
 *  we look that entity up in the directory holding the group that
 *  initiates the import. If file or directory is not in that directory,
 *  then we load using the classpath.
 *
 *  Templates are loaded on-demand from import dirs.  Imported groups are
 *  loaded on-demand when searching for a template.
 *
 *  The listener of this group is passed to the import group so errors
 *  found while loading imported element are sent to listener of this group.
 */
- (void) importTemplates:(STGroup *)g
{
    if (g == nil)
        return;
    if (imports == nil)
        imports = [AMutableArray arrayWithArray:[AMutableArray arrayWithCapacity:5]];
    [imports addObject:g];
}


/**
 * Load group dir or file (if .stg suffix) and then import templates. Don't hold
 * an independent ref to the "supergroup".
 * 
 * Override this if you want to look for groups elsewhere (database maybe?)
 * 
 * importTemplates("org.foo.proj.G.stg") will try to find file org/foo/proj/G.stg
 * relative to current dir or in CLASSPATH. The name is not relative to this group.
 * Can use "/a/b/c/myfile.stg" also or "/a/b/c/mydir".
 * 
 * Pass token so you can give good error if you want.
 */
- (void) importTemplatesWithFileName:(STToken *)fileNameToken
{
    NSError *error;
    NSString *aFileName = [fileNameToken getText];
    if (aFileName == nil || [aFileName isEqualToString:@"<missing STRING>"])
        return;
    aFileName = [Misc strip:aFileName n:1];
    
    //System.out.println("import "+fileName);
    BOOL isGroupFile = [aFileName hasSuffix:@".stg"];
    BOOL isTemplateFile = [aFileName hasSuffix:@".st"];
    BOOL isGroupDir = !(isGroupFile || isTemplateFile);
    
    STGroup *g = nil;
    
    if ( [aFileName isAbsolutePath] ) {
        if ( isTemplateFile ) {
            g = [STGroup newSTGroup];
            [g setListener:[self getListener]];
            [g loadAbsoluteTemplateFile:aFileName];
        }
        else if ( isGroupFile ) {
            g = [STGroupFile newSTGroupFile:aFileName delimiterStartChar:delimiterStartChar delimiterStopChar:delimiterStopChar];
            [g setListener:[self getListener]];
        }
        else if ( isGroupDir ) {
            g = [STGroupDir newSTGroupDir:aFileName delimiterStartChar:delimiterStartChar delimiterStopChar:delimiterStopChar];
            [g setListener:[self getListener]];
        }
        [self importTemplates:g];
        return;
    }
    // it's a relative name; search path is working dir, g.stg's dir, CLASSPATH
    //NSURL *thisRoot = [self getRootDirURL];
    NSString *thisRoot = @"~/";
    NSString *fileUnderRoot = nil;
    //System.out.println("thisRoot="+thisRoot);
    fileUnderRoot = [thisRoot stringByAppendingPathComponent:aFileName];
    fileUnderRoot = [fileUnderRoot stringByStandardizingPath];
    if ( isTemplateFile ) {
        g = [STGroup newSTGroup];
        [g setListener:[self getListener]];
        ANTLRInputStream *fs = nil;
        @try {
            NSURL *url = [NSURL fileURLWithPath:fileUnderRoot];
            NSFileHandle *fh = [NSFileHandle fileHandleForReadingFromURL:url error:&error];
            url = [ANTLRInputStream newANTLRInputStream:fh];
            fs.name = aFileName;
            CompiledST *code = [g loadTemplateFile:@"" fileName:aFileName stream:fs];
            if ( code==nil ) g = nil;
        }
        @catch (MalformedURLException *mfe) {
            [errMgr internalError:nil msg:[NSString stringWithFormat:@"can't build URL for %@", fileUnderRoot] e:mfe];
        }
        @catch (IOException *ioe) {
            // not found
            g = nil;
        }
    }
    else if ( isGroupFile ) {
        @try {
            //System.out.println("look for fileUnderRoot: "+fileUnderRoot);
            g = [STGroupFile newSTGroupFile:fileUnderRoot encoding:encoding delimiterStartChar:delimiterStartChar delimiterStopChar:delimiterStopChar];
            [g setListener:[self getListener]];
        }
        @catch (ANTLRIllegalArgumentException *iae) { // not relative to this group
                                               //System.out.println("look in path: "+fileName);
                                               // try in CLASSPATH
            @try {
                g = [STGroupFile newSTGroupFile:aFileName delimiterStartChar:delimiterStartChar delimiterStopChar:delimiterStopChar];
                [g setListener:[self getListener]];
            }
            @catch (ANTLRIllegalArgumentException *iae2) {
                g = nil;
            }
        }
    }
    else if ( isGroupDir ) {
        @try {
            g = [STGroupDir newSTGroupDir:fileUnderRoot encoding:encoding delimiterStartChar:delimiterStartChar delimiterStopChar:delimiterStopChar];
            [g setListener:[self getListener]];
        }
        @catch (ANTLRIllegalArgumentException *iae) { // not relative to this group
                                               // try in CLASSPATH
            @try {
                g = [STGroupDir newSTGroupDir:aFileName delimiterStartChar:delimiterStartChar delimiterStopChar:delimiterStopChar];
                [g setListener:[self getListener]];
            }
            @catch (ANTLRIllegalArgumentException *iae2) {
                g = nil;
            }
        }
    }
    
    if ( g == nil ) {
        [errMgr compileTimeError:CANT_IMPORT templateToken:nil t:fileNameToken arg:aFileName];
    }
    else {
        [self importTemplates:g];
    }
}


/**
 * Load a group file with full path fileName; it's relative to root by prefix.
 */
- (void) loadGroupFile:(NSString *)prefix fileName:(NSString *)aFileName
{
    GroupParser *aParser = nil;
    NSError *error;
    
    @try {
        NSString *fn = [aFileName stringByStandardizingPath];
        NSURL *f = [NSURL fileURLWithPath:fn];
        //NSFileHandle *fh = [NSFileHandle fileHandleForReadingAtPath:fn];
        NSFileHandle *fh = [NSFileHandle fileHandleForReadingFromURL:f error:&error];
        ANTLRInputStream *fs = [ANTLRInputStream newANTLRInputStream:fh];
        fs.name = aFileName;
        GroupLexer *lexer = [GroupLexer newGroupLexerWithCharStream:fs];
        ANTLRCommonTokenStream *tokens = [ANTLRCommonTokenStream newANTLRCommonTokenStreamWithTokenSource:lexer];
        aParser = [GroupParser newGroupParser:tokens];
        [aParser group:self arg1:prefix];
    }
    @catch (ANTLRRuntimeException *e) {
        [e stackTrace:e];
        [errMgr IOError:nil error:CANT_LOAD_GROUP_FILE e:e arg:aFileName];
    }
}

/** Load template file into this group using absolute filename */
- (CompiledST *) loadAbsoluteTemplateFile:(NSString *) aFileName
{
    ANTLRFileStream *fs;
    @try {
        fs = [NSInputStream inputStreamWithFileAtPath:aFileName];
        fs.name = aFileName;
    }
    @catch (IOException *ioe) {
        // doesn't exist
        //errMgr.IOError(null, ErrorType.NO_SUCH_TEMPLATE, ioe, fileName);
        return nil;
    }
    return [self loadTemplateFile:@"" fileName:aFileName stream:fs];
}

/** Load template stream into this group */
- (CompiledST *) loadTemplateFile:(NSString *)prefix fileName:(NSString *)fileName stream:(id<ANTLRCharStream>)templateStream
{
    GroupLexer *lexer = [GroupLexer newGroupLexerWithCharStream:templateStream];
    ANTLRCommonTokenStream *tokens = [ANTLRCommonTokenStream newANTLRCommonTokenStreamWithTokenSource:lexer];
    GroupParser *parser = [GroupParser newGroupParser:tokens];
    parser.group = self;
    lexer.group = self;
    @try {
        [parser templateDef:prefix];
    }
    @catch (ANTLRRecognitionException *re) {
        [errMgr groupSyntaxError:SYNTAX_ERROR srcName:fileName e:re msg:re.getMessage];
    }
    NSString *templateName = [Misc getFileNameNoSuffix:fileName];
    if ( prefix != nil && [prefix length] > 0 )
        templateName = [NSString stringWithFormat:@"%@/%@", prefix, templateName];
    return [self rawGetTemplate:templateName];
}

/**
 * Add an adaptor for a kind of object so ST knows how to pull properties
 * from them. Add adaptors in increasing order of specificity.  ST adds Object,
 * Map, and ST model adaptors for you first. Adaptors you add have
 * priority over default adaptors.
 * 
 * If an adaptor for type T already exists, it is replaced by the adaptor arg.
 * 
 * This must invalidate cache entries, so set your adaptors up before
 * render()ing your templates for efficiency.
 */
- (void) registerModelAdaptor:(id)attributeType adaptor:(id<ModelAdaptor>)adaptor
{
    //class_getName(Class cls)
    if ( attributeType == nil ) {
        @throw [ANTLRIllegalArgumentException newException:
                [NSString stringWithFormat:@"can't register ModelAdaptor for primitive type %@",
                 [attributeType className]]];
    }
    [adaptors setObject:adaptor forKey:[attributeType className]];
    [self invalidateModelAdaptorCache:attributeType];
}


/**
 * remove at least all types in cache that are subclasses or implement attributeType
 */
- (void) invalidateModelAdaptorCache:(id)attributeType
{
    [typeToAdaptorCache removeAllObjects]; // be safe, not clever; whack all values
}

- (id<ModelAdaptor>) getModelAdaptor:(id)attributeType
{
    id<ModelAdaptor> a = [typeToAdaptorCache objectForKey:[attributeType className]];
    if (a != nil)
        return a;
    
    for (NSString *t in [adaptors allKeys]) {
        id cls = objc_getClass([t UTF8String]);
        if ([[attributeType class] isSubclassOfClass:cls]) {
            a = [adaptors objectForKey:t];
        }
    }
    [typeToAdaptorCache setObject:a forKey:[attributeType className]];
    return a;
}


/**
 * Register a renderer for all objects of a particular "kind" for all
 * templates evaluated relative to this group.  Use r to render if
 * object in question is instanceof(attributeType).
 */
- (void) registerRenderer:(id)attributeType r:(AttributeRenderer *)r
{
    /*
     if ( attributeType.isPrimitive() ) {
     @throw [ANTLRIllegalArgumentException newException:
     [NSString stringWithFormat:@"can't register ModelAdaptor for primitive type %@",
     [attributeType getSimpleName]];
     }
     [typeToAdaptorCache removeAllObjects]; // be safe, not clever; whack all values
     */
    if (renderers == nil) {
        renderers = [AMutableArray arrayWithCapacity:5];
    }
    [renderers setObject:r forKey:[attributeType attributeValueClassName]];
}

- (AttributeRenderer *) getAttributeRenderer:(id)attributeType
{
    if (renderers == nil)
        return nil;
    
    AttributeRenderer *r;
    /*
     if ( renderers==null ) return null;
     AttributeRenderer r = nil;
     if ( typeToRendererCache != nil ) {
     r = [typeToRendererCache objectAtIndex:attributeType];
     if ( r != nil ) return r;
     }
     // Else look up, finding first first
     for ( Class t in [renderers allKeys] ) {
     // t works for attributeType if attributeType subclasses t or implements
     if ( t.isAssignableFrom(attributeType) ) return renderers.get(t);
     }
     */
    for (NSString *t in [renderers allKeys]) {
        id cls = objc_getClass([t UTF8String]);
        r = [renderers objectForKey:t];
        if ([cls isSubclassOfClass:[attributeType class]])
            return [renderers objectForKey:t];
    }
    
    return nil;
}


/**
 * StringTemplate object factory; each group can have its own.
 */
- (ST *) createStringTemplate
{
    return [ST newST];
}

- (ST *) createStringTemplateInternally
{
    ST *st = [self createStringTemplate];
	if ( trackCreationEvents && st.debugState!=nil ) {
		st.debugState.newSTEvent = nil; // toss it out
    }
    return st;
}

- (ST *) createStringTemplateInternally:(ST *)proto
{
    ST *st = [ST newSTWithProto:proto];
	if ( trackCreationEvents && st.debugState!=nil ) {
		st.debugState.newSTEvent = nil; // toss it out
    }
    return st;
}


- (NSString *)getName
{
    return @"<no name>";
}

- (NSString *)getFileName
{
    return nil;
}

/** Return root dir if this is group dir; return dir containing group file
 *  if this is group file.  This is derived from original incoming
 *  dir or filename.  If it was absolute, this should come back
 *  as full absolute path.  If it was org/foo/templates then this should
 *  be org/foo/templates.  org/foo/templates/main.stg ->
 *  org/foo/templates.
 */
- (NSURL *)getRootDirURL
{
    return nil;
}

- (NSURL *)getURL:(NSString *)fileName
{
	NSURL *url = nil;
    //[NSURL 
/*
    Class cl = Thread.currentThread().getContextClassLoader();
	url = cl.getResource(fileName);
	if ( url==nil ) {
		cl = [[self class] getClassLoader];
		url = [cl getResource:fileName];
	}
 */
	return url;
}

- (NSString *) description
{
    return [self getName];
}

- (NSString *) toString
{
    return [self description];
}

- (NSString *) show
{
    NSMutableString *buf = [NSMutableString stringWithCapacity:16];
    if (imports != nil)
        [buf appendFormat:@" : %@", imports];
    
    for (NSString *aName in [templates allKeys]) {
        CompiledST *c = [self rawGetTemplate:aName];
        if (c.isAnonSubtemplate || c == NOT_FOUND_ST)
            continue;
        aName = [aName lastPathComponent];
        [buf appendString:aName];
        [buf appendString:@"("];
        if (c.formalArguments != nil)
            [buf appendString:[Misc join:(ArrayIterator *)[c.formalArguments objectEnumerator] separator:@","]];
        [buf appendString:@")"];
        [buf appendString:@" ::= <<\n"];
        [buf appendFormat:@"%@%@>>%@", c.template, Misc.newline, Misc.newline];
    }
    return buf;
}

- (void) dealloc
{
    [imports release];
    [templates release];
    [dictionaries release];
    [renderers release];
    [adaptors release];
    [typeToAdaptorCache release];
    [errMgr release];
    [super dealloc];
}

- (id<STErrorListener>)getListener
{
    return errMgr.listener;
}

- (void) setListener:(id<STErrorListener>)listener
{
    errMgr = [ErrorManager newErrorManagerWithListener:listener];
}

@end
