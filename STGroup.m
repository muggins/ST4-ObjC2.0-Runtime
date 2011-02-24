#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLR.h>
#import "ST.h"
#import "STGroup.h"
#import "STLexer.h"
//#import "ANTLRInputStream.h"
//#import "CommonToken.h"
//#import "CommonTokenStream.h"
//#import "Token.h"
#import "Bytecode.h"
#import "BytecodeDisassembler.h"
#import "CompilationState.h"
#import "CompiledST.h"
#import "Compiler.h"
#import "FormalArgument.h"
#import "STException.h"
#import "STLexer.h"
#import "StringTable.h"
#import "TestNewStuff.h"
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
//#import "STNoSuchPropertyException.h"
#import "STRuntimeMessage.h"
//#import "URL.h"
#import "ModelAdaptor.h"


@implementation STGroup_Anon1

+ (id) newSTGroup_Anon1
{
    return [[STGroup_Anon1 alloc] init];
}

- (id) init
{
    if (self = [super initWithCapacity:16]) {
        [self setObject:[[ObjectModelAdaptor alloc] init] forKey:[NSObject className]];
        [self setObject:[[STModelAdaptor alloc] init] forKey:[ST className]];
        [self setObject:[[MapModelAdaptor alloc] init] forKey:[NSMutableDictionary className]];
    }
    return self;
}

@end


BOOL debug = NO;

@implementation STGroup

/**
 * Used to indicate that the template doesn't exist.
 * Prevents duplicate group file loads and unnecessary file checks.
 */
static CompiledST *NOT_FOUND_ST;
/**
 * When we use key as a value in a dictionary, this is how we signify.
 */
static NSString * const DEFAULT_KEY = @"default";
static NSString * const DICT_KEY = @"key";

static STGroup *defaultGroup;
static ErrorManager *DEFAULT_ERR_MGR;

@synthesize encoding; 
@synthesize imports;
@synthesize delimiterStartChar;
@synthesize delimiterStopChar;
@synthesize templates;
@synthesize dictionaries;
@synthesize renderers;
@synthesize adaptors;
@synthesize errMgr;

+ (void) initialize
{
    NOT_FOUND_ST = [[CompiledST alloc] init];
    DEFAULT_ERR_MGR = [[ErrorManager alloc] init];
}

+ (CompiledST *) NOT_FOUND_ST
{
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
    return defaultGroup;
}

+ (ErrorManager *) DEFAULT_ERR_MGR
{
    return DEFAULT_ERR_MGR;
}

+ (BOOL) debug
{
    return debug;
}

+ (id) newSTGroup
{
    return [[STGroup alloc] init];
}

+ (id) newSTGroup:(unichar)startChar delimiterStopChar:(unichar)stopChar
{
    return [[STGroup alloc] init:(unichar)startChar delimiterStopChar:(unichar)stopChar];
}

/**
 * The "foo" of t() ::= "<@foo()>" is mangled to "region#t#foo"
 */
+ (NSString *) getMangledRegionName:(NSString *)anEnclosingTemplateName name:(NSString *)aName
{
    return [NSString stringWithFormat:@"region__%@__%@", anEnclosingTemplateName, aName];
}


/**
 * Return "t.foo" from "region__t__foo"
 */
+ (NSString *) getUnMangledTemplateName:(NSString *)mangledName
{
/*    NSString *t = [mangledName substringWithRange:NSMakeRange([@"region__" length], ([mangledName lastIndexOf:@"__"]-[@"region__" length])+1)];
    NSString *r = [mangledName substringWithRange:NSMakeRange([mangledName lastIndexOf:@"__"]+2,  ([mangledName length]-([mangledName lastIndexOf:@"__"]+2))+1)]; */
    NSString *t = [mangledName substringWithRange:[mangledName rangeOfString:@"region__" options:NSBackwardsSearch]];
    NSString *r = [mangledName substringWithRange:[mangledName rangeOfString:@"__" options:NSBackwardsSearch]];
    return [NSString stringWithFormat:@"%@.%@", t, r];
}


- (id) init
{
    if (self = [super init]) {
        delimiterStartChar = '<';
        delimiterStopChar = '>';
        templates = [NSMutableDictionary dictionaryWithDictionary:[NSMutableDictionary dictionaryWithCapacity:16]];
        dictionaries = [NSMutableDictionary dictionaryWithDictionary:[NSMutableDictionary dictionaryWithCapacity:16]];
        adaptors = [NSMutableDictionary dictionaryWithDictionary:[STGroup_Anon1 newSTGroup_Anon1]];
        typeToAdaptorCache = [NSMutableDictionary dictionaryWithDictionary:[NSMutableDictionary dictionaryWithCapacity:16]];
        errMgr = STGroup.DEFAULT_ERR_MGR;
        defaultGroup = [STGroup newSTGroup];
    }
    return self;
}

- (id) init:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar
{
    if (self = [super init]) {
        delimiterStartChar = aDelimiterStartChar;
        delimiterStopChar = aDelimiterStopChar;
        templates = [NSMutableDictionary dictionaryWithDictionary:[NSMutableDictionary dictionaryWithCapacity:16]];
        dictionaries = [NSMutableDictionary dictionaryWithDictionary:[NSMutableDictionary dictionaryWithCapacity:20]];
        adaptors = [NSMutableDictionary dictionaryWithDictionary:[STGroup_Anon1 newSTGroup_Anon1]];
        typeToAdaptorCache = [NSMutableDictionary dictionaryWithDictionary:[NSMutableDictionary dictionaryWithCapacity:16]];
        errMgr = STGroup.DEFAULT_ERR_MGR;
        defaultGroup = [[STGroup alloc] init];
    }
    return self;
}


/**
 * The primary means of getting an instance of a template from this
 * group. Names must be absolute, fully-qualified names like a/b
 */
- (ST *) getInstanceOf:(NSString *)aName
{
    if (aName == nil)
        return nil;
    CompiledST * c = [self lookupTemplate:aName];
    if (c != nil) {
        ST * instanceST = [self createStringTemplate];
        instanceST.groupThatCreatedThisInstance = self;
        instanceST.impl = c;
        if (instanceST.impl.formalArguments != nil) {
/*            instanceST.locals = new Object[instanceST.impl.formalArguments.size()];
            Arrays.fill(instanceST.locals, ST.EMPTY_ATTR); */
#pragma mark error -- fix this
            instanceST.locals = [NSMutableArray arrayWithCapacity:[instanceST.impl.formalArguments count]];
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:16];
            [dict setObject:instanceST.locals forKey:ST.EMPTY_ATTR];
        }
        return instanceST;
    }
    return nil;
}

- (ST *) getEmbeddedInstanceOf:(ST *)enclosingInstance ip:(NSInteger)ip name:(NSString *)aName
{
    ST * st = [self getInstanceOf:aName];
    if (st == nil) {
        [errMgr runTimeError:enclosingInstance ip:ip error:NO_SUCH_TEMPLATE arg:aName];
        st = [self createStringTemplate];
        st.impl = [[CompiledST alloc] init];
        return st;
    }
    st.enclosingInstance = enclosingInstance;
    return st;
}


/**
 * Create singleton template for use with dictionary values
 */
- (ST *) createSingleton:(STToken *)templateToken
{
    NSString * template;
    if ([templateToken getType] == BIGSTRING) {
        template = [Misc strip:[templateToken getText] n:2];
    }
    else {
        template = [Misc strip:[templateToken getText] n:1];
    }
    ST * st = [self createStringTemplate];
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
    CompiledST * code = [templates objectForKey:aName];
    if (code == NOT_FOUND_ST)
        return nil;
    if (code == nil)
        code = [self load:aName];
    if (code == nil)
        code = [self lookupImportedTemplate:aName];
    if (code == nil) {
        [templates setObject:aName forKey:NOT_FOUND_ST];
    }
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
    if (imports == nil)
        return nil;
    
    for (STGroup * g in imports) {
        CompiledST * code = [g lookupTemplate:aName];
        if (code != nil)
            return code;
    }
    return nil;
}

- (CompiledST *) rawGetTemplate:(NSString *)aName
{
    return [templates objectForKey:aName];
}

- (NSMutableDictionary *) rawGetDictionary:(NSString *)aName
{
    return [dictionaries objectForKey:aName];
}

- (BOOL) isDictionary:(NSString *)aName
{
    return [dictionaries objectForKey:aName] != nil;
}

- (CompiledST *) defineTemplate:(NSString *)aTemplateName template:(NSString *)aTemplate
{
    
    @try {
        CompiledST *impl = [self defineTemplate:aTemplateName nameT:[STToken newToken:ID text:aTemplateName] args:nil template:aTemplate templateToken:nil];
        return impl;
    }
    @catch (STException *se) {
//        [System.err println:@"eh?"];
        NSLog(@"eh?");
    }
    return nil;
}

- (CompiledST *) defineTemplate:(NSString *)aName argsS:(NSString *)argsS template:(NSString *)template
{
    NSArray * args = [argsS componentsSeparatedByString:@","];
    NSMutableArray * a = [NSMutableArray arrayWithCapacity:16];
    
    for (NSString *arg in args) {
        [a addObject:[FormalArgument newFormalArgument:arg]];
    }
    
    return [self defineTemplate:aName
                          nameT:[STToken newToken:ID text:aName]
                           args:a
                       template:template templateToken:nil];
}

- (CompiledST *) defineTemplate:(NSString *)templateName
                          nameT:(ANTLRCommonToken *)nameT
                           args:(NSMutableArray *)args
                       template:(NSString *)template
                  templateToken:(ANTLRCommonToken *)templateToken
{
    if (templateName == nil || [templateName length] == 0) {
        @throw [ANTLRRuntimeException newANTLRIllegalArgumentException:@"empty template name"];
    }
    NSInteger i;
    for (i = ([templateName length]-1); i > 0; i-- ) {
        if ( [templateName characterAtIndex:i] == '.' ) break;
    }
    if (i >= 0) {
        @throw [ANTLRRuntimeException newANTLRIllegalArgumentException:@"cannot have '.' in template names"];
    }
    template = [Misc trimOneStartingNewline:template];
    template = [Misc trimOneTrailingNewline:template];
    CompiledST * code = [self compile:[self getFileName] name:templateName args:args template:template templateToken:templateToken];
    code.name = templateName;
    [self rawDefineTemplate:templateName code:code defT:nameT];
    [code defineArgDefaultValueTemplates:self];
    [code defineImplicitlyDefinedTemplates:self];
    return code;
}


/**
 * Make name and alias for target.  Replace any previous def of name
 */
- (CompiledST *) defineTemplateAlias:(ANTLRCommonToken *)aliasT targetT:(ANTLRCommonToken *)targetT
{
    NSString * alias = [aliasT getText];
    NSString * target = [targetT getText];
    CompiledST * targetCode = [templates objectForKey:target];
    if (targetCode == nil) {
        [errMgr compileTimeError:ALIAS_TARGET_UNDEFINED templateToken:nil t:aliasT arg:alias arg2:target];
        return nil;
    }
    [templates setObject:alias forKey:targetCode];
    return targetCode;
}

- (CompiledST *) defineRegion:(NSString *)enclosingTemplateName regionT:(ANTLRCommonToken *)regionT template:(NSString *)template
{
    NSString *aName = [regionT getText];
    CompiledST *code = [self compile:[self getFileName] name:enclosingTemplateName args:nil template:template templateToken:regionT];
    NSString *mangled = [STGroup getMangledRegionName:enclosingTemplateName name:aName];
    if ([self lookupTemplate:mangled] == nil) {
        [errMgr compileTimeError:NO_SUCH_REGION templateToken:nil t:regionT arg:enclosingTemplateName arg2:aName];
        return [[CompiledST alloc] init];
    }
    code.name = mangled;
    code.isRegion = YES;
    code.regionDefType = /* ST.RegionType. */EXPLICIT;
    [self rawDefineTemplate:mangled code:code defT:regionT];
    return code;
}

- (void) defineTemplateOrRegion:(NSString *)templateName
  regionSurroundingTemplateName:(NSString *)regionSurroundingTemplateName
                  templateToken:(ANTLRCommonToken *)templateToken
                       template:(NSString *)template
                      nameToken:(ANTLRCommonToken *)nameToken
                           args:(NSMutableArray *)args
{
    NSInteger n = 1;
    if ([templateToken getType] == BIGSTRING)
        n = 2;
    
    @try {
        if (regionSurroundingTemplateName != nil) {
            [self defineRegion:regionSurroundingTemplateName regionT:nameToken template:template];
        }
        else {
            [self defineTemplate:templateName nameT:nameToken args:args template:template templateToken:templateToken];
        }
    }
    @catch (STException * e) {
    }
}

- (void) rawDefineTemplate:(NSString *)aName code:(CompiledST *)code defT:(ANTLRCommonToken *)defT
{
    CompiledST * prev = [templates objectForKey:aName];
    if (prev != nil) {
        if (!prev.isRegion) {
            [errMgr compileTimeError:TEMPLATE_REDEFINITION templateToken:nil t:defT];
            return;
        }
        if (prev.isRegion && prev.regionDefType == EMBEDDED) {
            [errMgr compileTimeError:EMBEDDED_REGION_REDEFINITION templateToken:nil t:defT arg:[STGroup getUnMangledTemplateName:aName]];
            return;
        }
        else if (prev.isRegion && prev.regionDefType == EXPLICIT) {
            [errMgr compileTimeError:REGION_REDEFINITION templateToken:nil t:defT arg:[STGroup getUnMangledTemplateName:aName]];
            return;
        }
    }
    [templates setObject:aName forKey:code];
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
                    args:(NSMutableArray *)theArgs
                template:(NSString *)aTemplate
           templateToken:(ANTLRCommonToken *)aTemplateToken
{
    Compiler *c = [Compiler newCompilerWithErrorManager:errMgr delimiterStartChar:delimiterStartChar delimiterStopChar:delimiterStopChar];
    CompiledST *code = [c compile:srcName name:aName args:theArgs template:aTemplate templateToken:aTemplateToken];
    code.nativeGroup = self;
    code.template = aTemplate;
    return code;
}


/**
 * Define a map for this group; not thread safe...do not keep adding
 * these while you reference them.
 */
- (void) defineDictionary:(NSString *)aName mapping:(NSMutableDictionary *)mapping
{
    [dictionaries setObject:mapping forKey:aName];
}


/**
 * Make this group import templates/dictionaries from g.
 */
- (void) importTemplates:(STGroup *)g
{
    if (g == nil)
        return;
    if (imports == nil)
        imports = [NSMutableArray arrayWithArray:[NSMutableArray arrayWithCapacity:16]];
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
    NSString *aFileName = [fileNameToken getText];
    if (aFileName == nil || [aFileName isEqualToString:@"<missing STRING>"])
        return;
    aFileName = [Misc strip:aFileName n:1];
    STGroup *g = nil;
    if ([aFileName hasSuffix:@".stg"]) {
        g = [[STGroupFile alloc] init:aFileName delimiterStartChar:delimiterStartChar delimiterStopChar:delimiterStopChar];
    }
    else {
        g = [[STGroupDir alloc] init:aFileName delimiterStartChar:delimiterStartChar delimiterStopChar:delimiterStopChar];
    }
    [self importTemplates:g];
}


/**
 * Load a group file with full path fileName; it's relative to root by prefix.
 */
- (void) loadGroupFile:(NSString *)prefix fileName:(NSString *)aFileName
{
    GroupParser *aParser = nil;
    NSError *error;
    
    @try {
        NSURL *f = [NSURL fileURLWithPath:aFileName];
        ANTLRInputStream *fs = [ANTLRInputStream newANTLRInputStream:[NSFileHandle fileHandleForReadingFromURL:f error:&error]];
        fs.name = aFileName;
        GroupLexer *lexer = [GroupLexer newGroupLexerWithCharStream:fs];
        ANTLRCommonTokenStream *tokens = [ANTLRCommonTokenStream newANTLRCommonTokenStreamWithTokenSource:lexer];
        aParser = [GroupParser newGroupParser:tokens];
        [aParser group:self arg1:prefix];
    }
    @catch (NSException * e) {
        [errMgr IOError:nil error:CANT_LOAD_GROUP_FILE e:e arg:aFileName];
    }
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
- (void) registerModelAdaptor:(Class *)attributeType adaptor:(id<ModelAdaptor>)adaptor
{
    [adaptors setObject:adaptor forKey:[attributeType className]];
    [self invalidateModelAdaptorCache:attributeType];
}


/**
 * remove at least all types in cache that are subclasses or implement attributeType
 */
- (void) invalidateModelAdaptorCache:(Class *)attributeType
{
    [typeToAdaptorCache removeAllObjects];
}

- (id<ModelAdaptor>) getModelAdaptor:(Class *)attributeType
{
    id<ModelAdaptor> a = [typeToAdaptorCache objectForKey:[attributeType className]];
    if (a != nil)
        return a;
    
    for (Class *t in [adaptors allKeys]) {
        if ([t isSubclassOfClass:[attributeType class]]) {
            a = [adaptors objectForKey:[t className]];
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
- (void) registerRenderer:(Class *)attributeType r:(AttributeRenderer *)r
{
    if (renderers == nil) {
        renderers = [NSMutableArray arrayWithArray:[[ANTLRHashMap alloc] init]];
    }
    [renderers setObject:r forKey:[attributeType className]];
}

- (AttributeRenderer *) getAttributeRenderer:(Class *)attributeType {
    if (renderers == nil)
        return nil;
    
    for (Class *t in [renderers allKeys]) {
        if ([t isSubclassOfClass:[attributeType class]])
            return [renderers objectForKey:[t className]];
    }
    
    return nil;
}


/**
 * StringTemplate object factory; each group can have its own.
 */
- (ST *) createStringTemplate
{
    if (debug) {
        return [[DebugST alloc] init];
    }
    return [[ST alloc] init];
}

- (ST *) createStringTemplate:(ST *)proto
{
    if (debug) {
        return [DebugST newDebugSTWithProto:proto];
    }
    return [ST newSTWithProto:proto];
}

- (NSString *)getName
{
    return @"<no name>";
}

- (NSString *)getFileName
{
    return nil;
}

- (NSString *) toString
{
    return [self description];
}

- (NSString *) description
{
    return [self getName];
}

- (NSString *) show {
    NSMutableString * buf = [NSMutableString stringWithCapacity:16];
    if (imports != nil)
        [buf appendFormat:@" : %@", imports];
    
    for (NSString *aName in [templates allKeys]) {
        CompiledST * c = [templates objectForKey:aName];
        if (c.isAnonSubtemplate || c == NOT_FOUND_ST)
            continue;
        aName = [aName lastPathComponent];
        [buf appendString:aName];
        [buf appendString:@"("];
        if (c.formalArguments != nil)
            [buf appendString:[Misc join:[c.formalArguments objectEnumerator] separator:@","]];
        [buf appendString:@")"];
        [buf appendString:@" ::= <<\n"];
        [buf appendFormat:@"%@%@>>%@", c.template, Misc.newline, Misc.newline];
    }
    
    return [buf description];
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

@end
