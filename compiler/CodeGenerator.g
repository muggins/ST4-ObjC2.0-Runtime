/*
 [The "BSD license"]
 Copyright (c) 2009 Terence Parr
 All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:
 1. Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.
 2. Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.
 3. The name of the author may not be used to endorse or promote products
    derived from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

tree grammar CodeGenerator;

options {
	tokenVocab=STParser;
	ASTLabelType=ANTLRCommonTree;
	language=ObjC;
}

@header {
#import "Compiler.h"
#import "CompiledST.h"
#import "CompilationState.h"
#import "ErrorManager.h"
//#import "ErrorType.h"
#import "Bytecode.h"
//#import "STLexer.h"
//#import "Misc.h"
//#import "GroupLexer.h"
//#import "FormalArgument.h"
}

@memVars {
	NSString *outermostTemplateName;	// name of overall template
	CompiledST *outermostImpl;
	ANTLRCommonToken *templateToken;			// overall template token
	NSString *template;  				// overall template text
	ErrorManager *errMgr;
}

@properties {
	@property(retain, getter=getOutermostTemplateName, setter=setOutermostTemplateName:) NSString *outermostTemplateName; // name of overall template
	@property(retain, getter=getOutermostImpl, setter=setOutermostImpl:) CompiledST *outermostImpl;
	@property(retain, getter=getTemplateToken, setter=setTemplateToken:) ANTLRCommonToken *templateToken;// overall template token
	@property(retain, getter=getTemplate, setter=setTemplate:) NSString *template; // overall template text
	@property(retain, getter=getErrMgr, setter=setErrMgr:) ErrorManager *errMgr;
}

@methodsDecl {
+ (id) newCodeGenerator:(id<ANTLRTreeNodeStream>)input
                 errMgr:(ErrorManager *)anErrMgr
                   name:(NSString *)aName
               template:(NSString *)aTemplate
                  token:(ANTLRCommonToken *)aTemplateToken;

- (id) init:(id<ANTLRTreeNodeStream>)input
                     errMgr:(ErrorManager *)anErrMgr
                   name:(NSString *)aName
               template:(NSString *)aTemplate
                  token:(ANTLRCommonToken *)aTemplateToken;

// convience funcs to hide offensive sending of emit messages to
// CompilationState temp data object.

- (void) emit:(short)anOpcode;
- (void) emit:(ANTLRCommonTree *)opAST opcode:(short)anOpcode;
- (void) emit1:(ANTLRCommonTree *)opAST opcode:(short)anOpcode arg:(NSInteger)arg;
- (void) emit1:(ANTLRCommonTree *)opAST opcode:(short)anOpcode s:(NSString *)arg;
- (void) emit2:(ANTLRCommonTree *)opAST opcode:(short)anOpcode arg:(NSInteger)anArg arg2:(NSInteger)anArg2;
- (void) emit2:(ANTLRCommonTree *)opAST opcode:(short)anOpcode s:(NSString *)s arg2:(NSInteger)anArg;
- (void) insert:(NSInteger)addr opcode:(short)anOpcode s:(NSString *)s;
- (void) setOption:(ANTLRCommonTree *)anID;
- (void) write:(NSInteger)addr value:(short)value;
- (NSInteger) address;
- (void) func:(ANTLRCommonTree *)aTree;
- (void) refAttr:(ANTLRCommonTree *)aTree;
- (NSInteger) defineString:(NSString *)s;
}

@synthesize {
	@synthesize outermostTemplateName; // name of overall template
	@synthesize outermostImpl;
	@synthesize templateToken;// overall template token
	@synthesize template; // overall template text
	@synthesize errMgr;
}

@methods {
	+ (id) newCodeGenerator:(id<ANTLRTreeNodeStream>)anInput
	                 errMgr:(ErrorManager *)anErrMgr
	                   name:(NSString *)aName
	               template:(NSString *)aTemplate
	                  token:(ANTLRCommonToken *)aTemplateToken
	{
	    return [[CodeGenerator alloc] init:anInput
		                            errMgr:anErrMgr
	                                  name:aName
	                              template:aTemplate
	                                 token:aTemplateToken];
	}
	
	- (id) init:(id<ANTLRTreeNodeStream>)anInput
		                 errMgr:(ErrorManager *)anErrMgr
	                   name:(NSString *)aName
	               template:(NSString *)aTemplate
	                  token:(ANTLRCommonToken *)aTemplateToken
	{
		if (self = [super initWithStream:anInput State:[ANTLRRecognizerSharedState newANTLRRecognizerSharedState]]) {
            /* ruleAttributeScopeInit */
            template_scope = [template_Scope newtemplate_Scope];
            template_stack = [ANTLRSymbolStack newANTLRSymbolStackWithLen:30];
			errMgr = anErrMgr;
			outermostTemplateName = aName;
			template = aTemplate;
			templateToken = aTemplateToken;
		}
		return self;
	}

	// convience funcs to hide offensive sending of emit messages to
	// CompilationState temp data object.
	
	- (void) emit:(short)anOpcode
	{
		[$template::state emit:anOpcode];
    }
    
    - (void) emit:(ANTLRCommonTree *)opAST opcode:(short)anOpcode
    {
		[$template::state emit:opAST opcode:anOpcode];
	}
	
	- (void) emit1:(ANTLRCommonTree *)opAST opcode:(short)anOpcode arg:(NSInteger)arg
	{
		[$template::state emit1:opAST opcode:anOpcode arg:arg];
	}
	
	- (void) emit1:(ANTLRCommonTree *)opAST opcode:(short)anOpcode s:(NSString *)arg
	{
		[$template::state emit1:opAST opcode:anOpcode s:arg];
	}
	
	- (void) emit2:(ANTLRCommonTree *)opAST opcode:(short)anOpcode arg:(NSInteger)anArg arg2:(NSInteger)anArg2
	{
		[$template::state emit2:opAST opcode:anOpcode arg:anArg arg2:anArg2];
	}
	
	- (void) emit2:(ANTLRCommonTree *)opAST opcode:(short)anOpcode s:(NSString *)s arg2:(NSInteger)anArg
	{
		[$template::state emit2:opAST opcode:anOpcode s:s arg2:anArg];
	}
	
	- (void) insert:(NSInteger)addr opcode:(short)anOpcode s:(NSString *)s
	{
		[$template::state insert:addr opcode:anOpcode s:s];
	}
	
	- (void) setOption:(ANTLRCommonTree *)anID
	{
		[$template::state setOption:anID];
	}
	
	- (void) write:(NSInteger)addr value:(short)value
	{
		[$template::state write:addr value:value];
	}
	
	- (NSInteger) address { return $template::state.ip; }
	- (void) func:(ANTLRCommonTree *)aTree { [$template::state func:templateToken tree:aTree]; }
	- (void) refAttr:(ANTLRCommonTree *)aTree { [$template::state refAttr:templateToken tree:aTree]; }
	- (NSInteger) defineString:(NSString *)s { return [$template::state defineString:s]; }
}

templateAndEOF : template[nil ,nil] EOF; // hush warning; ignore

template[NSString *name, NSMutableArray *args] returns [CompiledST *impl]
scope {
    CompilationState *state; // automatically get a new state pointer per invocation
}
@init {
 	$template::state = [CompilationState newCompilationState:errMgr name:name stream:[input getTokenStream]];
	$impl = $template::state.impl;
 	if ( [$template count] == 1 ) outermostImpl = $impl;
	[$impl defineFormalArgs:$args]; // make sure args are defined prior to compilation
	if ( name != nil && [name hasPrefix:Compiler.SUBTEMPLATE_PREFIX] ) {
	    [$impl addArg:[FormalArgument newFormalArgument:@"i"]];
	    [$impl addArg:[FormalArgument newFormalArgument:@"i0"]];
    }
	$impl.template = template; // always forget the entire template; char indexes are relative to it
}
	:	chunk
		{ // finish off the CompiledST result
        if ( $template::state.stringtable != nil ) $impl.strings = [$template::state.stringtable toArray];
        $impl.codeSize = $template::state.ip;
		}
	;

chunk
	:	element*
	;
	
element
	:	^(INDENT {[$template::state indent:$INDENT.text];} element {[$template::state emit:Bytecode.INSTR_DEDENT];})
	|	ifstat
	|	exprElement
	|	TEXT
		{
		if ( [$TEXT.text length]>0 ) {
			[self emit1:$TEXT opcode:Bytecode.INSTR_LOAD_STR s:$TEXT.text];
			[self emit:$TEXT opcode:Bytecode.INSTR_WRITE];
		}
		}
	|	region
		{
		[self emit2:$region.start opcode:Bytecode.INSTR_NEW s:$region.name arg2:0];
		[self emit:$region.start opcode:Bytecode.INSTR_WRITE];
		}
	|	NEWLINE {[self emit:Bytecode.INSTR_NEWLINE];}
	;

exprElement
@init { short op = Bytecode.INSTR_WRITE; }
	:	^( EXPR expr (exprOptions {op=Bytecode.INSTR_WRITE_OPT;})? )
		{[self emit:$EXPR opcode:op];}
	;

region returns [NSString *name]
	:	^(	REGION ID
			{$name = [STGroup getMangledRegionName:outermostTemplateName name:$ID.text];}
			template[$name,nil]
			{
			CompiledST *sub = $template.impl;
	        sub.isRegion = true;
	        sub.regionDefType = /* ST.RegionType. */ EMBEDDED;
			//sub.dump();
			[outermostImpl addImplicitlyDefinedTemplate:sub];
			}
		 )
	;

subtemplate returns [NSString *name, NSInteger nargs]
@init {
    $name = [Compiler getNewSubtemplateName];
	NSMutableArray *args = [NSMutableArray arrayWithCapacity:16];
}
	:	^(	SUBTEMPLATE
			(^(ARGS (ID {[args addObject:[FormalArgument newFormalArgument:$ID.text]];})+))*
			{$nargs = [args count];}
			template[$name,args]
			{
			CompiledST *sub = $template.impl;
			sub.isAnonSubtemplate = true;
			if ( STGroup.debug ) {
				sub.ast = $SUBTEMPLATE;
				[sub.ast setUnknownTokenBoundaries];
				sub.tokens = [input getTokenStream];
			}
			//sub.dump();
			[outermostImpl addImplicitlyDefinedTemplate:sub];
			}
		 )
	;

ifstat
@init {
    /** Tracks address of branch operand (in code block).  It's how
     *  we backpatch forward references when generating code for IFs.
     */
    NSInteger prevBranchOperand = -1;
    /** Branch instruction operands that are forward refs to end of IF.
     *  We need to update them once we see the endif.
     */
    ANTLRIntArray *endRefs = [ANTLRIntArray newArrayWithLen:16];
}
	:	^(	i='if' conditional
			{
	        prevBranchOperand = [self address]+1;
	        [self emit1:$i opcode:Bytecode.INSTR_BRF arg:-1]; // write placeholder as branch target
			}
			chunk
			(	^(eif='elseif'
				{
				[endRefs addInteger:[self address]+1];
				[self emit1:$eif opcode:Bytecode.INSTR_BR arg:-1]; // br end
				// update previous branch instruction
				[self write:prevBranchOperand value:(short)[self address]];
				prevBranchOperand = -1;
				}
				ec=conditional
				{
		       	prevBranchOperand = [self address]+1;
		       	// write placeholder as branch target
		       	[self emit1:$ec.start opcode:Bytecode.INSTR_BRF arg:-1];
				}
				chunk
				)
			)*
			(	^(	el='else'
					{
					[endRefs addInteger:[self address]+1];
					[self emit1:$el opcode:Bytecode.INSTR_BR arg:-1]; // br end
					// update previous branch instruction
					[self write:prevBranchOperand value:(short)[self address]];
					prevBranchOperand = -1;
					}
					chunk
				 )
			)?
		 )
		{
		if ( prevBranchOperand>=0 ) {
			[self write:prevBranchOperand value:(short)[self address]];
		}
        for (int opnd = 0; opnd < [endRefs count]; opnd++) {
            [self write:opnd value:(short)[self address]];
        }
		}
	;
// STARTHERE
conditional
	:	^('||' conditional conditional)		{[self emit:Bytecode.INSTR_OR];}
	|	^('&&' conditional conditional)		{[self emit:Bytecode.INSTR_AND];}
	|	^('!' conditional)					{[self emit:Bytecode.INSTR_NOT];}
	|	expr // not all expr are valid, but reuse code gen (parser restricts syntax)
	;

exprOptions : {[self emit:Bytecode.INSTR_OPTIONS];} ^(OPTIONS option*) ;

option : ^('=' ID expr) {[self setOption:$ID];} ;

expr
@init {NSInteger nt = 0, ne = 0;}
	:	^(ZIP ^(ELEMENTS (expr {ne++;})+) mapTemplateRef[ne])
		{[self emit1:$ZIP opcode:Bytecode.INSTR_ZIP_MAP arg:ne];}
	|	^(MAP expr (mapTemplateRef[1] {nt++;})+)
		{
		if ( nt>1 )
            [self emit1:$MAP opcode:Bytecode.INSTR_ROT_MAP arg:nt];
		else
            [self emit:$MAP opcode:Bytecode.INSTR_MAP];
		}
	|	prop
	|	includeExpr
	;

prop:	^(PROP expr ID)						{[self emit1:$PROP opcode:Bytecode.INSTR_LOAD_PROP s:$ID.text];}
	|	^(PROP_IND expr expr)				{[self emit:$PROP_IND opcode:Bytecode.INSTR_LOAD_PROP_IND];}
	;
	
mapTemplateRef[NSInteger num_exprs]
	:	^(	INCLUDE ID
			{for (NSInteger i=1; i<=$num_exprs; i++) [self emit:$INCLUDE opcode:Bytecode.INSTR_NULL];}
			args
		 )
		{
		if ( $args.namedArgs )
			[self emit1:$INCLUDE opcode:Bytecode.INSTR_NEW_BOX_ARGS s:$ID.text];
		else
			[self emit2:$INCLUDE opcode:Bytecode.INSTR_NEW s:$ID.text arg2:($args.n+$num_exprs)];
		}
	|	subtemplate
		{
		if ( $subtemplate.nargs != $num_exprs ) {
            [errMgr compileTimeError:ANON_ARGUMENT_MISMATCH
                       templateToken:templateToken
                                   t:$subtemplate.start.token
                                 arg:$subtemplate.nargs
                                arg2:$num_exprs];
		}
		for (NSInteger i=1; i<=$num_exprs; i++) [self emit:$subtemplate.start opcode:Bytecode.INSTR_NULL];
        [self emit2:$subtemplate.start opcode:Bytecode.INSTR_NEW s:$subtemplate.name arg2:$num_exprs];
		}

	|	^(	INCLUDE_IND expr
			{
			[self emit:$INCLUDE_IND opcode:Bytecode.INSTR_TOSTR];
			for (NSInteger i=1; i<=$num_exprs; i++) [self emit:$INCLUDE_IND opcode:Bytecode.INSTR_NULL];
			}
			args
			{[self emit1:$INCLUDE_IND opcode:Bytecode.INSTR_NEW_IND arg:($args.n+$num_exprs)];}
		 )
	;

includeExpr
	:	^(EXEC_FUNC ID expr?)		{[self func:$ID];}
	|	^(INCLUDE ID args)
		{
		if ( $args.namedArgs ) [self emit1:$INCLUDE opcode:Bytecode.INSTR_NEW_BOX_ARGS s:$ID.text];
		else [self emit2:$INCLUDE opcode:Bytecode.INSTR_NEW s:$ID.text arg2:$args.n];
		}
	|	^(INCLUDE_SUPER ID args)
		{
		if ( $args.namedArgs ) [self emit1:$INCLUDE_SUPER opcode:Bytecode.INSTR_SUPER_NEW_BOX_ARGS s:$ID.text];
		else [self emit2:$INCLUDE_SUPER opcode:Bytecode.INSTR_SUPER_NEW s:$ID.text arg2:$args.n];
		}
	|	^(INCLUDE_REGION ID)		{
									CompiledST *impl =
										[Compiler defineBlankRegion:outermostImpl name:$ID.text];
									//impl.dump();
									[self emit2:$INCLUDE_REGION opcode:Bytecode.INSTR_NEW s:impl.name arg2:0];
									}
	|	^(INCLUDE_SUPER_REGION ID)	{
									CompiledST *impl =
										[Compiler defineBlankRegion:outermostImpl name:$ID.text];
									//impl.dump();
									[self emit2:$INCLUDE_SUPER_REGION opcode:Bytecode.INSTR_SUPER_NEW s:impl.name arg2:0];
									}
	|	primary
	;

primary
	:	ID				{[self refAttr:$ID];}
	|	STRING			{[self emit1:$STRING opcode:Bytecode.INSTR_LOAD_STR s:[Misc strip:$STRING.text n:1]];}	
	|	subtemplate		// push a subtemplate but ignore args since we can't pass any to it here
		                {[self emit2:$start opcode:Bytecode.INSTR_NEW s:$subtemplate.name arg2:0];}
	|	list
	|	^(	INCLUDE_IND	
			expr 		{[self emit:$INCLUDE_IND opcode:Bytecode.INSTR_TOSTR];}
			args		{[self emit1:$INCLUDE_IND opcode:Bytecode.INSTR_NEW_IND arg:$args.n];}
		 )
	|	^(TO_STR expr)	{[self emit:$TO_STR opcode:Bytecode.INSTR_TOSTR];}
	;

arg : expr ;

args returns [NSInteger n=0, BOOL namedArgs=false]
	:	( arg {$n++;} )+
	|	{[self emit:$args.start opcode:Bytecode.INSTR_ARGS]; $namedArgs=true;}
		(	^(eq='=' ID expr)
			{$n++; [self emit1:$eq opcode:Bytecode.INSTR_STORE_ARG s:[self defineString:$ID.text]];}
		)+
	|
 	;

list:	{[self emit:Bytecode.INSTR_LIST];}
		^(LIST (listElement {[self emit:$listElement.start opcode:Bytecode.INSTR_ADD];})* ) 
	;

listElement : expr | A_NULL {[self emit:$A_NULL opcode:Bytecode.INSTR_NULL];} ;
