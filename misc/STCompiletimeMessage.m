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
#import "STErrorListener.h"
#import "STCompiletimeMessage.h"
#import "GroupLexer.h"
#import "AMutableArray.h"

@class STToken;


@implementation STCompiletimeMessage

+ (id) newMessage:(ErrorTypeEnum)anError srcName:(NSString *)aSrcName templateToken:(STToken *)aTemplateToken t:(STToken *)t
{
    return [[[STCompiletimeMessage alloc] init:anError srcName:aSrcName templateToken:aTemplateToken t:t] retain];
}

+ (id) newMessage:(ErrorTypeEnum)anError srcName:(NSString *)aSrcName templateToken:(STToken *)aTemplateToken t:(STToken *)t cause:(NSException *)aCause
{
    return [[[STCompiletimeMessage alloc] init:anError srcName:aSrcName templateToken:aTemplateToken t:t cause:aCause] retain];
}
            
+ (id) newMessage:(ErrorTypeEnum)anError srcName:(NSString *)aSrcName templateToken:(STToken *)aTemplateToken t:(STToken *)t cause:(NSException *)aCause arg:(id)anArg
{
    return [[[STCompiletimeMessage alloc] init:anError srcName:aSrcName templateToken:aTemplateToken t:t cause:aCause arg:anArg] retain];
}

+ (id) newMessage:(ErrorTypeEnum)anError srcName:(NSString *)aSrcName templateToken:(STToken *)aTemplateToken t:(STToken *)t cause:(NSException *)aCause arg:(id)anArg arg2:(id)anArg2
{
    return [[[STCompiletimeMessage alloc] init:anError srcName:aSrcName templateToken:aTemplateToken t:t cause:aCause arg:anArg arg2:anArg2] retain];
}

- (id) init:(ErrorTypeEnum)anError srcName:(NSString *)aSrcName templateToken:(STToken *)aTemplateToken t:(STToken *)t
{
    if ( (self=[super init:anError who:nil cause:nil]) != nil ) {
        templateToken = aTemplateToken;
        token = t;
        srcName = aSrcName;
    }
    return self;
}

- (id) init:(ErrorTypeEnum)anError srcName:(NSString *)aSrcName templateToken:(STToken *)aTemplateToken t:(STToken *)t cause:(NSException *)aCause
{
    self=[super init:anError who:nil cause:aCause];
    if ( self != nil ) {
        templateToken = aTemplateToken;
        token = t;
        srcName = aSrcName;
    }
    return self;
}

- (id) init:(ErrorTypeEnum)anError srcName:(NSString *)aSrcName templateToken:(STToken *)aTemplateToken t:(STToken *)t cause:(NSException *)aCause arg:(id)anArg
{
    self=[super init:anError who:nil cause:aCause arg:anArg];
    if ( self != nil ) {
        templateToken = aTemplateToken;
        token = t;
        srcName = aSrcName;
    }
    return self;
}

- (id) init:(ErrorTypeEnum)anError srcName:(NSString *)aSrcName templateToken:(STToken *)aTemplateToken t:(STToken *)t cause:(NSException *)aCause arg:(id)anArg arg2:(id)anArg2
{
    self=[super init:anError who:nil cause:aCause arg:anArg arg2:anArg2];
    if ( self != nil ) {
        templateToken = aTemplateToken;
        token = t;
        srcName = aSrcName;
    }
    return self;
}

- (NSString *) description
{
    NSInteger line = 0;
    NSInteger charPos = -1;
    if (token != nil) {
        line = [token getLine];
        charPos = [token getCharPositionInLine];
        if (templateToken != nil) {
            NSInteger templateDelimiterSize = 1;
            if ([templateToken getType] == BIGSTRING) {
                templateDelimiterSize = 2;
            }
            line += [templateToken getLine] - 1;
            charPos += [templateToken getCharPositionInLine] + templateDelimiterSize;
        }
    }
    NSString *filepos = [NSString stringWithFormat:@"%d:%d", line, charPos];
    NSString *fmtMsg = [ErrorType ErrorNum:error];
    NSString *result = [NSString stringWithFormat:fmtMsg, arg, arg2];
    if (srcName != nil) {
        return [NSString stringWithFormat:@"%@ %@: %@", srcName, filepos, result];
    }
    return [NSString stringWithFormat:@"%@: %@", filepos, result ];
}

- (NSString *) toString
{
    return [self description];
}

- (void) dealloc {
    [templateToken release];
    [token release];
    [srcName release];
    [super dealloc];
}

@synthesize templateToken;
@synthesize token;
@synthesize srcName;
@end
