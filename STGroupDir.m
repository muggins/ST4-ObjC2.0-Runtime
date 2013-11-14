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
#import <ANTLR/ANTLR.h>
#import "STErrorListener.h"
#import "STGroupDir.h"
#import "STException.h"
#import "GroupLexer.h"
#import "GroupParser.h"
#import "ErrorManager.h"

/** A directory or directory tree full of templates and/or group files.
 *  We load files on-demand. Dir search path: current working dir then
 *  CLASSPATH (as a resource).  Do not look for templates outside of this dir
 *  subtree (except via imports).
 */
@implementation STGroupDir

@synthesize groupDirName;
@synthesize root;

+ (id) newSTGroupDir:(NSString *)aDirName
{
    return [[STGroupDir alloc] init:aDirName encoding:NSASCIIStringEncoding delimiterStartChar:'<' delimiterStopChar:'>'];
}

+ (id) newSTGroupDir:(NSString *)aDirName encoding:(NSStringEncoding)theEncoding
{
    return [[STGroupDir alloc] init:aDirName encoding:theEncoding delimiterStartChar:'<' delimiterStopChar:'>'];
}

+ (id) newSTGroupDir:(NSString *)aDirName delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar
{
    return [[STGroupDir alloc] init:aDirName encoding:NSASCIIStringEncoding delimiterStartChar:aDelimiterStartChar delimiterStopChar:aDelimiterStopChar];
}

+ (id) newSTGroupDir:(NSString *)aDirName encoding:(NSStringEncoding)theEncoding delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar
{
    return [[STGroupDir alloc] init:aDirName encoding:theEncoding delimiterStartChar:aDelimiterStartChar delimiterStopChar:aDelimiterStopChar];
}

+ (id) newSTGroupDirWithURL:(NSURL *)theRoot encoding:(NSStringEncoding)theEncoding delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar
{
    return [[STGroupDir alloc] initWithURL:theRoot encoding:theEncoding delimiterStartChar:aDelimiterStartChar delimiterStopChar:aDelimiterStopChar];
}

- (id) init:(NSString *)aDirName encoding:(NSStringEncoding)theEncoding delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar
{
    BOOL fExists, isDir;
    self=[super init:aDelimiterStartChar delimiterStopChar:aDelimiterStopChar];
    if ( self != nil ) {
        groupDirName = aDirName;
        encoding = theEncoding;
        NSFileManager *fm;
        fm = [NSFileManager defaultManager];
        if ( [aDirName characterAtIndex:0] == '~' ) {
            aDirName = [NSString stringWithFormat:@"%@", [aDirName stringByExpandingTildeInPath]];
        }
        fExists = [fm fileExistsAtPath:aDirName isDirectory:&isDir];
        if ( fExists && isDir ) {
            root = [NSURL fileURLWithPath:aDirName];
            if ( STGroup.verbose )
                NSLog( @"%@", [NSString stringWithFormat:@"[%@ %@] found at %@\n", [self className], aDirName, [root path]]);
        }
        else {
#ifdef DONTUSEYET
            [NSThread currentThread];
            ClassLoader *cl = [[NSThread currentThread] contextClassLoader];
            root = [cl getResource:aDirName];
            if (root == nil) {
                cl = [[self class] classLoader];
                root = [cl getResource:aDirName];
            }
#endif
            if ( fExists ) {
                if ( [aDirName hasSuffix:@".stg"] ) {
                    //groupDirName = [aDirName lastPathComponent];
                    root = [NSURL fileURLWithPath:[Misc getParent:aDirName]];
                }
                else {
                    root = [NSURL fileURLWithPath:aDirName];
                }
                if ( STGroup.verbose )
                    NSLog(@"[STGroupDir %@] found via CLASSPATH at %@", aDirName, [root path]);
            }
            if (root == nil) 
                    @throw [IllegalArgumentException newException:[NSString stringWithFormat:@"No such directory: %@", aDirName]];
        }
    }
    return self;
}

- (id) initWithURL:(NSURL *)theRoot encoding:(NSStringEncoding)theEncoding delimiterStartChar:(unichar)aDelimiterStartChar delimiterStopChar:(unichar)aDelimiterStopChar
{
    self=[super init:aDelimiterStartChar delimiterStopChar:aDelimiterStopChar];
    if ( self != nil ) {
        root = theRoot;
        encoding = theEncoding;
    }
    return self;
}

- (void) dealloc {
#ifdef DEBUG_DEALLOC
    NSLog( @"called dealloc in STGroupDir" );
#endif
    groupDirName = nil;
    root = nil;
    // [super dealloc];
}

- (void) importTemplatesWithFileName:(CommonToken *)fileNameToken
{
    NSString *msg = [NSString stringWithFormat:@"import illegal in group files embedded in STGroupDirs; \nimport %@ in STGroupDir %@", fileNameToken.text, [self getName]];
    @throw [UnsupportedOperationException newException:(NSString *) msg];
}

/**
 * Load a template from dir or group file.  Group file is given
 * precedence over dir with same name.
 */
- (CompiledST *) load:(NSString *)aName
{
    if ( STGroup.verbose ) NSLog(@"[STGroupDir load:%@]\n", aName);
    NSString *parent = [Misc getParent:aName];
    NSString *prefix = [Misc getPrefix:aName];
    if ( STGroup.verbose )
        NSLog( @"parent = \"%@\"\nprefix = \"%@\"\nroot = \"%@\"\n", parent, prefix, root );
    //    if ( [parent length] == 0 )
    //        no need to check for a group file as name has no parent
    //        return [self loadTemplateFile:@"/" fileName:[NSString stringWithFormat:@"%@.st", aName]];
    //    }
    NSURL *groupFileURL = nil;
    @try {
        groupFileURL = [[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@%@%@", [root path], parent, STGroup.GROUP_FILE_EXTENSION]] URLByStandardizingPath];
        if ( STGroup.verbose ) NSLog( @"groupFileURL = %@\n", [groupFileURL path] );
    }
    @catch (MalformedURLException *e) {
        [errMgr internalError:nil msg:[NSString stringWithFormat:@"bad URL: %@%@%@", [root path], parent, STGroup.GROUP_FILE_EXTENSION] e:e];
        return nil;
    }
    @try {
        if ( ![Misc urlExists:groupFileURL] ) {
            IOException *ioe = [IOException newException:@"not a fileReferenceURL"];
            @throw ioe;
        }
    }
    @catch (IOException *ioe) {
        NSString *unqualifiedName = [Misc getFileName:aName];
        return [self loadTemplateFile:prefix fileName:[NSString stringWithFormat:@"%@%@", unqualifiedName, STGroup.TEMPLATE_FILE_EXTENSION]];
    }
    [self loadGroupFile:prefix fileName:[NSString stringWithFormat:@"%@%@%@", [root path], parent, STGroup.GROUP_FILE_EXTENSION]];
    return [self rawGetTemplate:aName];
}


/**
 * Load full path name .st file relative to root by prefix
 */
- (CompiledST *) loadTemplateFile:(NSString *)prefix fileName:(NSString *)unqualifiedFileName
{
    if ( STGroup.verbose )
        NSLog(@"[STGroupDir loadTemplateFile:%@] in groupdir from %@ prefix=%@\n", unqualifiedFileName, root, prefix);
    NSURL *f = nil;
    @try {
        f = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@%@%@", [root path], prefix, unqualifiedFileName]];
        if (![f isFileURL]) {
            @throw [MalformedURLException newException:@"Not a File URL"];
        }
    }
    @catch (MalformedURLException *me) {
        [errMgr runTimeError:nil scope:nil error:INVALID_TEMPLATE_NAME e:me arg:[f path]];
        return nil;
    }
    
    ANTLRInputStream *ais;
    @try {
        if ( [Misc urlExists:f] == NO ) {
            @throw [IOException newException:@"Error opening file"];
        }
        NSInputStream *is = [NSInputStream inputStreamWithURL:f];
        ais = [ANTLRInputStream newANTLRInputStream:is encoding:encoding];
        ais.name = unqualifiedFileName;
    }
    @catch (IOException *ioe) {
        if ( STGroup.verbose ) NSLog( @"%@/%@ doesn't exist\n", root, unqualifiedFileName);
        return nil;
    }
    return [self loadTemplateFile:prefix fileName:unqualifiedFileName stream:ais];
}

- (NSString *) getName
{
    return groupDirName;
}

- (NSString *) getFileName
{
    return [groupDirName lastPathComponent];
}

- (NSURL *) getRootDirURL
{
    return root;
}

@end
