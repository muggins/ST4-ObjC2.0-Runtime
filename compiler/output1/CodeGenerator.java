// $ANTLR 3.3.1-SNAPSHOT Feb 01, 2011 19:19:01 /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g 2011-02-03 08:07:25

package org.stringtemplate.v4.compiler;
import org.stringtemplate.v4.misc.*;
import org.stringtemplate.v4.*;


import org.antlr.runtime.*;
import org.antlr.runtime.tree.*;import java.util.Stack;
import java.util.List;
import java.util.ArrayList;

public class CodeGenerator extends TreeParser {
    public static final String[] tokenNames = new String[] {
        "<invalid>", "<EOR>", "<DOWN>", "<UP>", "IF", "ELSE", "ELSEIF", "ENDIF", "SUPER", "SEMI", "BANG", "ELLIPSIS", "EQUALS", "COLON", "LPAREN", "RPAREN", "LBRACK", "RBRACK", "COMMA", "DOT", "LCURLY", "RCURLY", "TEXT", "LDELIM", "RDELIM", "ID", "STRING", "WS", "PIPE", "OR", "AND", "INDENT", "NEWLINE", "AT", "END", "EXPR", "OPTIONS", "PROP", "PROP_IND", "INCLUDE", "INCLUDE_IND", "EXEC_FUNC", "INCLUDE_SUPER", "INCLUDE_SUPER_REGION", "INCLUDE_REGION", "TO_STR", "LIST", "MAP", "ZIP", "SUBTEMPLATE", "ARGS", "ELEMENTS", "REGION", "NULL"
    };
    public static final int EOF=-1;
    public static final int RBRACK=17;
    public static final int LBRACK=16;
    public static final int ELSE=5;
    public static final int ELLIPSIS=11;
    public static final int LCURLY=20;
    public static final int BANG=10;
    public static final int EQUALS=12;
    public static final int TEXT=22;
    public static final int ID=25;
    public static final int SEMI=9;
    public static final int LPAREN=14;
    public static final int IF=4;
    public static final int ELSEIF=6;
    public static final int COLON=13;
    public static final int RPAREN=15;
    public static final int WS=27;
    public static final int COMMA=18;
    public static final int RCURLY=21;
    public static final int ENDIF=7;
    public static final int RDELIM=24;
    public static final int SUPER=8;
    public static final int DOT=19;
    public static final int LDELIM=23;
    public static final int STRING=26;
    public static final int PIPE=28;
    public static final int OR=29;
    public static final int AND=30;
    public static final int INDENT=31;
    public static final int NEWLINE=32;
    public static final int AT=33;
    public static final int END=34;
    public static final int EXPR=35;
    public static final int OPTIONS=36;
    public static final int PROP=37;
    public static final int PROP_IND=38;
    public static final int INCLUDE=39;
    public static final int INCLUDE_IND=40;
    public static final int EXEC_FUNC=41;
    public static final int INCLUDE_SUPER=42;
    public static final int INCLUDE_SUPER_REGION=43;
    public static final int INCLUDE_REGION=44;
    public static final int TO_STR=45;
    public static final int LIST=46;
    public static final int MAP=47;
    public static final int ZIP=48;
    public static final int SUBTEMPLATE=49;
    public static final int ARGS=50;
    public static final int ELEMENTS=51;
    public static final int REGION=52;
    public static final int NULL=53;

    // delegates
    // delegators


        public CodeGenerator(TreeNodeStream input) {
            this(input, new RecognizerSharedState());
        }
        public CodeGenerator(TreeNodeStream input, RecognizerSharedState state) {
            super(input, state);
             
        }
        

    public String[] getTokenNames() { return CodeGenerator.tokenNames; }
    public String getGrammarFileName() { return "/Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g"; }


    	String outermostTemplateName;	// name of overall template
    	CompiledST outermostImpl;
    	Token templateToken;			// overall template token
    	String template;  				// overall template text
    	ErrorManager errMgr;
    	public CodeGenerator(TreeNodeStream input, ErrorManager errMgr, String name, String template, Token templateToken) {
    		this(input, new RecognizerSharedState());
    		this.errMgr = errMgr;
    		this.outermostTemplateName = name;
    		this.template = template;
    		this.templateToken = templateToken;
    	}

    	// convience funcs to hide offensive sending of emit messages to
    	// CompilationState temp data object.
    	
    	public void emit1(CommonTree opAST, short opcode, int arg) {
    		((template_scope)template_stack.peek()).state.emit1(opAST, opcode, arg);
    	}
    	public void emit1(CommonTree opAST, short opcode, String arg) {
    		((template_scope)template_stack.peek()).state.emit1(opAST, opcode, arg);
    	}
    	public void emit2(CommonTree opAST, short opcode, int arg, int arg2) {
    		((template_scope)template_stack.peek()).state.emit2(opAST, opcode, arg, arg2);
    	}
    	public void emit2(CommonTree opAST, short opcode, String s, int arg2) {
    		((template_scope)template_stack.peek()).state.emit2(opAST, opcode, s, arg2);
    	}
    	public void emit(short opcode) {
    		((template_scope)template_stack.peek()).state.emit(opcode);
        }
        public void emit(CommonTree opAST, short opcode) {
    		((template_scope)template_stack.peek()).state.emit(opAST, opcode);
    	}
    	public void insert(int addr, short opcode, String s) {
    		((template_scope)template_stack.peek()).state.insert(addr, opcode, s);
    	}
    	public void setOption(CommonTree id) {
    		((template_scope)template_stack.peek()).state.setOption(id);
    	}
    	public void write(int addr, short value) {
    		((template_scope)template_stack.peek()).state.write(addr,value);
    	}
    	public int address() { return ((template_scope)template_stack.peek()).state.ip; }
    	public void func(CommonTree id) { ((template_scope)template_stack.peek()).state.func(templateToken, id); }
    	public void refAttr(CommonTree id) { ((template_scope)template_stack.peek()).state.refAttr(templateToken, id); }
    	public int defineString(String s) { return ((template_scope)template_stack.peek()).state.defineString(s); }



    // $ANTLR start "templateAndEOF"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:92:1: templateAndEOF : template[null,null] EOF ;
    public final void templateAndEOF() throws RecognitionException {
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:92:16: ( template[null,null] EOF )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:92:18: template[null,null] EOF
            {
            pushFollow(FOLLOW_template_in_templateAndEOF44);
            template(null, null);

            state._fsp--;

            match(input,EOF,FOLLOW_EOF_in_templateAndEOF47); 

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "templateAndEOF"

    protected static class template_scope {
        CompilationState state;
    }
    protected Stack template_stack = new Stack();


    // $ANTLR start "template"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:94:1: template[String name, List<FormalArgument> args] returns [CompiledST impl] : chunk ;
    public final CompiledST template(String name, List<FormalArgument> args) throws RecognitionException {
        template_stack.push(new template_scope());
        CompiledST impl = null;


         	((template_scope)template_stack.peek()).state = new CompilationState(errMgr, name, input.getTokenStream());
        	impl = ((template_scope)template_stack.peek()).state.impl;
         	if ( template_stack.size() == 1 ) outermostImpl = impl;
        	impl.defineFormalArgs(args); // make sure args are defined prior to compilation
        	if ( name!=null && name.startsWith(Compiler.SUBTEMPLATE_PREFIX) ) {
        	    impl.addArg(new FormalArgument("i"));
        	    impl.addArg(new FormalArgument("i0"));
            }
        	impl.template = template; // always forget the entire template; char indexes are relative to it

        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:109:2: ( chunk )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:109:4: chunk
            {
            pushFollow(FOLLOW_chunk_in_template71);
            chunk();

            state._fsp--;

             // finish off the CompiledST result
                    if ( ((template_scope)template_stack.peek()).state.stringtable!=null ) impl.strings = ((template_scope)template_stack.peek()).state.stringtable.toArray();
                    impl.codeSize = ((template_scope)template_stack.peek()).state.ip;
            		

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
            template_stack.pop();
        }
        return impl;
    }
    // $ANTLR end "template"


    // $ANTLR start "chunk"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:116:1: chunk : ( element )* ;
    public final void chunk() throws RecognitionException {
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:117:2: ( ( element )* )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:117:4: ( element )*
            {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:117:4: ( element )*
            loop1:
            do {
                int alt1=2;
                int LA1_0 = input.LA(1);

                if ( (LA1_0==IF||LA1_0==TEXT||(LA1_0>=INDENT && LA1_0<=NEWLINE)||LA1_0==EXPR||LA1_0==REGION) ) {
                    alt1=1;
                }


                switch (alt1) {
            	case 1 :
            	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:117:4: element
            	    {
            	    pushFollow(FOLLOW_element_in_chunk86);
            	    element();

            	    state._fsp--;


            	    }
            	    break;

            	default :
            	    break loop1;
                }
            } while (true);


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "chunk"


    // $ANTLR start "element"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:120:1: element : ( ^( INDENT element ) | ifstat | exprElement | TEXT | region | NEWLINE );
    public final void element() throws RecognitionException {
        CommonTree INDENT1=null;
        CommonTree TEXT2=null;
        CodeGenerator.region_return region3 = null;


        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:121:2: ( ^( INDENT element ) | ifstat | exprElement | TEXT | region | NEWLINE )
            int alt2=6;
            switch ( input.LA(1) ) {
            case INDENT:
                {
                alt2=1;
                }
                break;
            case IF:
                {
                alt2=2;
                }
                break;
            case EXPR:
                {
                alt2=3;
                }
                break;
            case TEXT:
                {
                alt2=4;
                }
                break;
            case REGION:
                {
                alt2=5;
                }
                break;
            case NEWLINE:
                {
                alt2=6;
                }
                break;
            default:
                NoViableAltException nvae =
                    new NoViableAltException("", 2, 0, input);

                throw nvae;
            }

            switch (alt2) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:121:4: ^( INDENT element )
                    {
                    INDENT1=(CommonTree)match(input,INDENT,FOLLOW_INDENT_in_element100); 

                    ((template_scope)template_stack.peek()).state.indent((INDENT1!=null?INDENT1.getText():null));

                    match(input, Token.DOWN, null); 
                    pushFollow(FOLLOW_element_in_element104);
                    element();

                    state._fsp--;

                    ((template_scope)template_stack.peek()).state.emit(Bytecode.INSTR_DEDENT);

                    match(input, Token.UP, null); 

                    }
                    break;
                case 2 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:122:4: ifstat
                    {
                    pushFollow(FOLLOW_ifstat_in_element112);
                    ifstat();

                    state._fsp--;


                    }
                    break;
                case 3 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:123:4: exprElement
                    {
                    pushFollow(FOLLOW_exprElement_in_element117);
                    exprElement();

                    state._fsp--;


                    }
                    break;
                case 4 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:124:4: TEXT
                    {
                    TEXT2=(CommonTree)match(input,TEXT,FOLLOW_TEXT_in_element122); 

                    		if ( (TEXT2!=null?TEXT2.getText():null).length()>0 ) {
                    			emit1(TEXT2,Bytecode.INSTR_LOAD_STR, (TEXT2!=null?TEXT2.getText():null));
                    			emit(TEXT2,Bytecode.INSTR_WRITE);
                    		}
                    		

                    }
                    break;
                case 5 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:131:4: region
                    {
                    pushFollow(FOLLOW_region_in_element131);
                    region3=region();

                    state._fsp--;


                    		emit2((region3!=null?((CommonTree)region3.start):null), Bytecode.INSTR_NEW, (region3!=null?region3.name:null), 0);
                    		emit((region3!=null?((CommonTree)region3.start):null), Bytecode.INSTR_WRITE);
                    		

                    }
                    break;
                case 6 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:136:4: NEWLINE
                    {
                    match(input,NEWLINE,FOLLOW_NEWLINE_in_element140); 
                    emit(Bytecode.INSTR_NEWLINE);

                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "element"


    // $ANTLR start "exprElement"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:139:1: exprElement : ^( EXPR expr ( exprOptions )? ) ;
    public final void exprElement() throws RecognitionException {
        CommonTree EXPR4=null;

         short op = Bytecode.INSTR_WRITE; 
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:141:2: ( ^( EXPR expr ( exprOptions )? ) )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:141:4: ^( EXPR expr ( exprOptions )? )
            {
            EXPR4=(CommonTree)match(input,EXPR,FOLLOW_EXPR_in_exprElement160); 

            match(input, Token.DOWN, null); 
            pushFollow(FOLLOW_expr_in_exprElement162);
            expr();

            state._fsp--;

            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:141:17: ( exprOptions )?
            int alt3=2;
            int LA3_0 = input.LA(1);

            if ( (LA3_0==OPTIONS) ) {
                alt3=1;
            }
            switch (alt3) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:141:18: exprOptions
                    {
                    pushFollow(FOLLOW_exprOptions_in_exprElement165);
                    exprOptions();

                    state._fsp--;

                    op=Bytecode.INSTR_WRITE_OPT;

                    }
                    break;

            }


            match(input, Token.UP, null); 
            emit(EXPR4, op);

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "exprElement"

    public static class region_return extends TreeRuleReturnScope {
        public String name;
    };

    // $ANTLR start "region"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:145:1: region returns [String name] : ^( REGION ID template[$name,null] ) ;
    public final CodeGenerator.region_return region() throws RecognitionException {
        CodeGenerator.region_return retval = new CodeGenerator.region_return();
        retval.start = input.LT(1);

        CommonTree ID5=null;
        CompiledST template6 = null;


        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:146:2: ( ^( REGION ID template[$name,null] ) )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:146:4: ^( REGION ID template[$name,null] )
            {
            match(input,REGION,FOLLOW_REGION_in_region192); 

            match(input, Token.DOWN, null); 
            ID5=(CommonTree)match(input,ID,FOLLOW_ID_in_region194); 
            retval.name = STGroup.getMangledRegionName(outermostTemplateName, (ID5!=null?ID5.getText():null));
            pushFollow(FOLLOW_template_in_region204);
            template6=template(retval.name, null);

            state._fsp--;


            			CompiledST sub = template6;
            	        sub.isRegion = true;
            	        sub.regionDefType = ST.RegionType.EMBEDDED;
            			//sub.dump();
            			outermostImpl.addImplicitlyDefinedTemplate(sub);
            			

            match(input, Token.UP, null); 

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "region"

    public static class subtemplate_return extends TreeRuleReturnScope {
        public String name;
        public int nargs;
    };

    // $ANTLR start "subtemplate"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:159:1: subtemplate returns [String name, int nargs] : ^( SUBTEMPLATE ( ^( ARGS ( ID )+ ) )* template[$name,args] ) ;
    public final CodeGenerator.subtemplate_return subtemplate() throws RecognitionException {
        CodeGenerator.subtemplate_return retval = new CodeGenerator.subtemplate_return();
        retval.start = input.LT(1);

        CommonTree ID7=null;
        CommonTree SUBTEMPLATE9=null;
        CompiledST template8 = null;



            retval.name = Compiler.getNewSubtemplateName();
        	List<FormalArgument> args = new ArrayList<FormalArgument>();

        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:164:2: ( ^( SUBTEMPLATE ( ^( ARGS ( ID )+ ) )* template[$name,args] ) )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:164:4: ^( SUBTEMPLATE ( ^( ARGS ( ID )+ ) )* template[$name,args] )
            {
            SUBTEMPLATE9=(CommonTree)match(input,SUBTEMPLATE,FOLLOW_SUBTEMPLATE_in_subtemplate237); 

            if ( input.LA(1)==Token.DOWN ) {
                match(input, Token.DOWN, null); 
                // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:165:4: ( ^( ARGS ( ID )+ ) )*
                loop5:
                do {
                    int alt5=2;
                    int LA5_0 = input.LA(1);

                    if ( (LA5_0==ARGS) ) {
                        alt5=1;
                    }


                    switch (alt5) {
                	case 1 :
                	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:165:5: ^( ARGS ( ID )+ )
                	    {
                	    match(input,ARGS,FOLLOW_ARGS_in_subtemplate244); 

                	    match(input, Token.DOWN, null); 
                	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:165:12: ( ID )+
                	    int cnt4=0;
                	    loop4:
                	    do {
                	        int alt4=2;
                	        int LA4_0 = input.LA(1);

                	        if ( (LA4_0==ID) ) {
                	            alt4=1;
                	        }


                	        switch (alt4) {
                	    	case 1 :
                	    	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:165:13: ID
                	    	    {
                	    	    ID7=(CommonTree)match(input,ID,FOLLOW_ID_in_subtemplate247); 
                	    	    args.add(new FormalArgument((ID7!=null?ID7.getText():null)));

                	    	    }
                	    	    break;

                	    	default :
                	    	    if ( cnt4 >= 1 ) break loop4;
                	                EarlyExitException eee =
                	                    new EarlyExitException(4, input);
                	                throw eee;
                	        }
                	        cnt4++;
                	    } while (true);


                	    match(input, Token.UP, null); 

                	    }
                	    break;

                	default :
                	    break loop5;
                    }
                } while (true);

                retval.nargs = args.size();
                pushFollow(FOLLOW_template_in_subtemplate264);
                template8=template(retval.name, args);

                state._fsp--;


                			CompiledST sub = template8;
                			sub.isAnonSubtemplate = true;
                			if ( STGroup.debug ) {
                				sub.ast = SUBTEMPLATE9;
                				sub.ast.setUnknownTokenBoundaries();
                				sub.tokens = input.getTokenStream();
                			}
                			//sub.dump();
                			outermostImpl.addImplicitlyDefinedTemplate(sub);
                			

                match(input, Token.UP, null); 
            }

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "subtemplate"


    // $ANTLR start "ifstat"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:182:1: ifstat : ^(i= 'if' conditional chunk ( ^(eif= 'elseif' ec= conditional chunk ) )* ( ^(el= 'else' chunk ) )? ) ;
    public final void ifstat() throws RecognitionException {
        CommonTree i=null;
        CommonTree eif=null;
        CommonTree el=null;
        CodeGenerator.conditional_return ec = null;



            /** Tracks address of branch operand (in code block).  It's how
             *  we backpatch forward references when generating code for IFs.
             */
            int prevBranchOperand = -1;
            /** Branch instruction operands that are forward refs to end of IF.
             *  We need to update them once we see the endif.
             */
            List<Integer> endRefs = new ArrayList<Integer>();

        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:193:2: ( ^(i= 'if' conditional chunk ( ^(eif= 'elseif' ec= conditional chunk ) )* ( ^(el= 'else' chunk ) )? ) )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:193:4: ^(i= 'if' conditional chunk ( ^(eif= 'elseif' ec= conditional chunk ) )* ( ^(el= 'else' chunk ) )? )
            {
            i=(CommonTree)match(input,IF,FOLLOW_IF_in_ifstat295); 

            match(input, Token.DOWN, null); 
            pushFollow(FOLLOW_conditional_in_ifstat297);
            conditional();

            state._fsp--;


            	        prevBranchOperand = address()+1;
            	        emit1(i,Bytecode.INSTR_BRF, -1); // write placeholder as branch target
            			
            pushFollow(FOLLOW_chunk_in_ifstat307);
            chunk();

            state._fsp--;

            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:199:4: ( ^(eif= 'elseif' ec= conditional chunk ) )*
            loop6:
            do {
                int alt6=2;
                int LA6_0 = input.LA(1);

                if ( (LA6_0==ELSEIF) ) {
                    alt6=1;
                }


                switch (alt6) {
            	case 1 :
            	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:199:6: ^(eif= 'elseif' ec= conditional chunk )
            	    {
            	    eif=(CommonTree)match(input,ELSEIF,FOLLOW_ELSEIF_in_ifstat317); 


            	    				endRefs.add(address()+1);
            	    				emit1(eif,Bytecode.INSTR_BR, -1); // br end
            	    				// update previous branch instruction
            	    				write(prevBranchOperand, (short)address());
            	    				prevBranchOperand = -1;
            	    				

            	    match(input, Token.DOWN, null); 
            	    pushFollow(FOLLOW_conditional_in_ifstat331);
            	    ec=conditional();

            	    state._fsp--;


            	    		       	prevBranchOperand = address()+1;
            	    		       	// write placeholder as branch target
            	    		       	emit1((ec!=null?((CommonTree)ec.start):null), Bytecode.INSTR_BRF, -1);
            	    				
            	    pushFollow(FOLLOW_chunk_in_ifstat343);
            	    chunk();

            	    state._fsp--;


            	    match(input, Token.UP, null); 

            	    }
            	    break;

            	default :
            	    break loop6;
                }
            } while (true);

            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:216:4: ( ^(el= 'else' chunk ) )?
            int alt7=2;
            int LA7_0 = input.LA(1);

            if ( (LA7_0==ELSE) ) {
                alt7=1;
            }
            switch (alt7) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:216:6: ^(el= 'else' chunk )
                    {
                    el=(CommonTree)match(input,ELSE,FOLLOW_ELSE_in_ifstat366); 


                    					endRefs.add(address()+1);
                    					emit1(el, Bytecode.INSTR_BR, -1); // br end
                    					// update previous branch instruction
                    					write(prevBranchOperand, (short)address());
                    					prevBranchOperand = -1;
                    					

                    if ( input.LA(1)==Token.DOWN ) {
                        match(input, Token.DOWN, null); 
                        pushFollow(FOLLOW_chunk_in_ifstat380);
                        chunk();

                        state._fsp--;


                        match(input, Token.UP, null); 
                    }

                    }
                    break;

            }


            match(input, Token.UP, null); 

            		if ( prevBranchOperand>=0 ) {
            			write(prevBranchOperand, (short)address());
            		}
                    for (int opnd : endRefs) write(opnd, (short)address());
            		

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "ifstat"

    public static class conditional_return extends TreeRuleReturnScope {
    };

    // $ANTLR start "conditional"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:236:1: conditional : ( ^( '||' conditional conditional ) | ^( '&&' conditional conditional ) | ^( '!' conditional ) | expr );
    public final CodeGenerator.conditional_return conditional() throws RecognitionException {
        CodeGenerator.conditional_return retval = new CodeGenerator.conditional_return();
        retval.start = input.LT(1);

        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:237:2: ( ^( '||' conditional conditional ) | ^( '&&' conditional conditional ) | ^( '!' conditional ) | expr )
            int alt8=4;
            switch ( input.LA(1) ) {
            case OR:
                {
                alt8=1;
                }
                break;
            case AND:
                {
                alt8=2;
                }
                break;
            case BANG:
                {
                alt8=3;
                }
                break;
            case ID:
            case STRING:
            case PROP:
            case PROP_IND:
            case INCLUDE:
            case INCLUDE_IND:
            case EXEC_FUNC:
            case INCLUDE_SUPER:
            case INCLUDE_SUPER_REGION:
            case INCLUDE_REGION:
            case TO_STR:
            case LIST:
            case MAP:
            case ZIP:
            case SUBTEMPLATE:
                {
                alt8=4;
                }
                break;
            default:
                NoViableAltException nvae =
                    new NoViableAltException("", 8, 0, input);

                throw nvae;
            }

            switch (alt8) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:237:4: ^( '||' conditional conditional )
                    {
                    match(input,OR,FOLLOW_OR_in_conditional414); 

                    match(input, Token.DOWN, null); 
                    pushFollow(FOLLOW_conditional_in_conditional416);
                    conditional();

                    state._fsp--;

                    pushFollow(FOLLOW_conditional_in_conditional418);
                    conditional();

                    state._fsp--;


                    match(input, Token.UP, null); 
                    emit(Bytecode.INSTR_OR);

                    }
                    break;
                case 2 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:238:4: ^( '&&' conditional conditional )
                    {
                    match(input,AND,FOLLOW_AND_in_conditional428); 

                    match(input, Token.DOWN, null); 
                    pushFollow(FOLLOW_conditional_in_conditional430);
                    conditional();

                    state._fsp--;

                    pushFollow(FOLLOW_conditional_in_conditional432);
                    conditional();

                    state._fsp--;


                    match(input, Token.UP, null); 
                    emit(Bytecode.INSTR_AND);

                    }
                    break;
                case 3 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:239:4: ^( '!' conditional )
                    {
                    match(input,BANG,FOLLOW_BANG_in_conditional442); 

                    match(input, Token.DOWN, null); 
                    pushFollow(FOLLOW_conditional_in_conditional444);
                    conditional();

                    state._fsp--;


                    match(input, Token.UP, null); 
                    emit(Bytecode.INSTR_NOT);

                    }
                    break;
                case 4 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:240:4: expr
                    {
                    pushFollow(FOLLOW_expr_in_conditional456);
                    expr();

                    state._fsp--;


                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "conditional"


    // $ANTLR start "exprOptions"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:243:1: exprOptions : ^( OPTIONS ( option )* ) ;
    public final void exprOptions() throws RecognitionException {
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:243:13: ( ^( OPTIONS ( option )* ) )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:243:15: ^( OPTIONS ( option )* )
            {
            emit(Bytecode.INSTR_OPTIONS);
            match(input,OPTIONS,FOLLOW_OPTIONS_in_exprOptions470); 

            if ( input.LA(1)==Token.DOWN ) {
                match(input, Token.DOWN, null); 
                // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:243:57: ( option )*
                loop9:
                do {
                    int alt9=2;
                    int LA9_0 = input.LA(1);

                    if ( (LA9_0==EQUALS) ) {
                        alt9=1;
                    }


                    switch (alt9) {
                	case 1 :
                	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:243:57: option
                	    {
                	    pushFollow(FOLLOW_option_in_exprOptions472);
                	    option();

                	    state._fsp--;


                	    }
                	    break;

                	default :
                	    break loop9;
                    }
                } while (true);


                match(input, Token.UP, null); 
            }

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "exprOptions"


    // $ANTLR start "option"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:245:1: option : ^( '=' ID expr ) ;
    public final void option() throws RecognitionException {
        CommonTree ID10=null;

        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:245:8: ( ^( '=' ID expr ) )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:245:10: ^( '=' ID expr )
            {
            match(input,EQUALS,FOLLOW_EQUALS_in_option484); 

            match(input, Token.DOWN, null); 
            ID10=(CommonTree)match(input,ID,FOLLOW_ID_in_option486); 
            pushFollow(FOLLOW_expr_in_option488);
            expr();

            state._fsp--;


            match(input, Token.UP, null); 
            setOption(ID10);

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "option"


    // $ANTLR start "expr"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:247:1: expr : ( ^( ZIP ^( ELEMENTS ( expr )+ ) mapTemplateRef[ne] ) | ^( MAP expr ( mapTemplateRef[1] )+ ) | prop | includeExpr );
    public final void expr() throws RecognitionException {
        CommonTree ZIP11=null;
        CommonTree MAP12=null;

        int nt = 0, ne = 0;
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:249:2: ( ^( ZIP ^( ELEMENTS ( expr )+ ) mapTemplateRef[ne] ) | ^( MAP expr ( mapTemplateRef[1] )+ ) | prop | includeExpr )
            int alt12=4;
            switch ( input.LA(1) ) {
            case ZIP:
                {
                alt12=1;
                }
                break;
            case MAP:
                {
                alt12=2;
                }
                break;
            case PROP:
            case PROP_IND:
                {
                alt12=3;
                }
                break;
            case ID:
            case STRING:
            case INCLUDE:
            case INCLUDE_IND:
            case EXEC_FUNC:
            case INCLUDE_SUPER:
            case INCLUDE_SUPER_REGION:
            case INCLUDE_REGION:
            case TO_STR:
            case LIST:
            case SUBTEMPLATE:
                {
                alt12=4;
                }
                break;
            default:
                NoViableAltException nvae =
                    new NoViableAltException("", 12, 0, input);

                throw nvae;
            }

            switch (alt12) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:249:4: ^( ZIP ^( ELEMENTS ( expr )+ ) mapTemplateRef[ne] )
                    {
                    ZIP11=(CommonTree)match(input,ZIP,FOLLOW_ZIP_in_expr507); 

                    match(input, Token.DOWN, null); 
                    match(input,ELEMENTS,FOLLOW_ELEMENTS_in_expr510); 

                    match(input, Token.DOWN, null); 
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:249:21: ( expr )+
                    int cnt10=0;
                    loop10:
                    do {
                        int alt10=2;
                        int LA10_0 = input.LA(1);

                        if ( ((LA10_0>=ID && LA10_0<=STRING)||(LA10_0>=PROP && LA10_0<=SUBTEMPLATE)) ) {
                            alt10=1;
                        }


                        switch (alt10) {
                    	case 1 :
                    	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:249:22: expr
                    	    {
                    	    pushFollow(FOLLOW_expr_in_expr513);
                    	    expr();

                    	    state._fsp--;

                    	    ne++;

                    	    }
                    	    break;

                    	default :
                    	    if ( cnt10 >= 1 ) break loop10;
                                EarlyExitException eee =
                                    new EarlyExitException(10, input);
                                throw eee;
                        }
                        cnt10++;
                    } while (true);


                    match(input, Token.UP, null); 
                    pushFollow(FOLLOW_mapTemplateRef_in_expr520);
                    mapTemplateRef(ne);

                    state._fsp--;


                    match(input, Token.UP, null); 
                    emit1(ZIP11, Bytecode.INSTR_ZIP_MAP, ne);

                    }
                    break;
                case 2 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:251:4: ^( MAP expr ( mapTemplateRef[1] )+ )
                    {
                    MAP12=(CommonTree)match(input,MAP,FOLLOW_MAP_in_expr532); 

                    match(input, Token.DOWN, null); 
                    pushFollow(FOLLOW_expr_in_expr534);
                    expr();

                    state._fsp--;

                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:251:15: ( mapTemplateRef[1] )+
                    int cnt11=0;
                    loop11:
                    do {
                        int alt11=2;
                        int LA11_0 = input.LA(1);

                        if ( ((LA11_0>=INCLUDE && LA11_0<=INCLUDE_IND)||LA11_0==SUBTEMPLATE) ) {
                            alt11=1;
                        }


                        switch (alt11) {
                    	case 1 :
                    	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:251:16: mapTemplateRef[1]
                    	    {
                    	    pushFollow(FOLLOW_mapTemplateRef_in_expr537);
                    	    mapTemplateRef(1);

                    	    state._fsp--;

                    	    nt++;

                    	    }
                    	    break;

                    	default :
                    	    if ( cnt11 >= 1 ) break loop11;
                                EarlyExitException eee =
                                    new EarlyExitException(11, input);
                                throw eee;
                        }
                        cnt11++;
                    } while (true);


                    match(input, Token.UP, null); 

                    		if ( nt>1 ) emit1(MAP12, nt>1?Bytecode.INSTR_ROT_MAP:Bytecode.INSTR_MAP, nt);
                    		else emit(MAP12, Bytecode.INSTR_MAP);
                    		

                    }
                    break;
                case 3 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:256:4: prop
                    {
                    pushFollow(FOLLOW_prop_in_expr552);
                    prop();

                    state._fsp--;


                    }
                    break;
                case 4 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:257:4: includeExpr
                    {
                    pushFollow(FOLLOW_includeExpr_in_expr557);
                    includeExpr();

                    state._fsp--;


                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "expr"


    // $ANTLR start "prop"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:260:1: prop : ( ^( PROP expr ID ) | ^( PROP_IND expr expr ) );
    public final void prop() throws RecognitionException {
        CommonTree PROP13=null;
        CommonTree ID14=null;
        CommonTree PROP_IND15=null;

        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:260:5: ( ^( PROP expr ID ) | ^( PROP_IND expr expr ) )
            int alt13=2;
            int LA13_0 = input.LA(1);

            if ( (LA13_0==PROP) ) {
                alt13=1;
            }
            else if ( (LA13_0==PROP_IND) ) {
                alt13=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 13, 0, input);

                throw nvae;
            }
            switch (alt13) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:260:7: ^( PROP expr ID )
                    {
                    PROP13=(CommonTree)match(input,PROP,FOLLOW_PROP_in_prop567); 

                    match(input, Token.DOWN, null); 
                    pushFollow(FOLLOW_expr_in_prop569);
                    expr();

                    state._fsp--;

                    ID14=(CommonTree)match(input,ID,FOLLOW_ID_in_prop571); 

                    match(input, Token.UP, null); 
                    emit1(PROP13, Bytecode.INSTR_LOAD_PROP, (ID14!=null?ID14.getText():null));

                    }
                    break;
                case 2 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:261:4: ^( PROP_IND expr expr )
                    {
                    PROP_IND15=(CommonTree)match(input,PROP_IND,FOLLOW_PROP_IND_in_prop585); 

                    match(input, Token.DOWN, null); 
                    pushFollow(FOLLOW_expr_in_prop587);
                    expr();

                    state._fsp--;

                    pushFollow(FOLLOW_expr_in_prop589);
                    expr();

                    state._fsp--;


                    match(input, Token.UP, null); 
                    emit(PROP_IND15, Bytecode.INSTR_LOAD_PROP_IND);

                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "prop"


    // $ANTLR start "mapTemplateRef"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:264:1: mapTemplateRef[int num_exprs] : ( ^( INCLUDE ID args ) | subtemplate | ^( INCLUDE_IND expr args ) );
    public final void mapTemplateRef(int num_exprs) throws RecognitionException {
        CommonTree INCLUDE16=null;
        CommonTree ID18=null;
        CommonTree INCLUDE_IND20=null;
        CodeGenerator.args_return args17 = null;

        CodeGenerator.subtemplate_return subtemplate19 = null;

        CodeGenerator.args_return args21 = null;


        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:265:2: ( ^( INCLUDE ID args ) | subtemplate | ^( INCLUDE_IND expr args ) )
            int alt14=3;
            switch ( input.LA(1) ) {
            case INCLUDE:
                {
                alt14=1;
                }
                break;
            case SUBTEMPLATE:
                {
                alt14=2;
                }
                break;
            case INCLUDE_IND:
                {
                alt14=3;
                }
                break;
            default:
                NoViableAltException nvae =
                    new NoViableAltException("", 14, 0, input);

                throw nvae;
            }

            switch (alt14) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:265:4: ^( INCLUDE ID args )
                    {
                    INCLUDE16=(CommonTree)match(input,INCLUDE,FOLLOW_INCLUDE_in_mapTemplateRef610); 

                    match(input, Token.DOWN, null); 
                    ID18=(CommonTree)match(input,ID,FOLLOW_ID_in_mapTemplateRef612); 
                    for (int i=1; i<=num_exprs; i++) emit(INCLUDE16,Bytecode.INSTR_NULL);
                    pushFollow(FOLLOW_args_in_mapTemplateRef622);
                    args17=args();

                    state._fsp--;


                    match(input, Token.UP, null); 

                    		if ( (args17!=null?args17.namedArgs:false) ) emit1(INCLUDE16, Bytecode.INSTR_NEW_BOX_ARGS, (ID18!=null?ID18.getText():null));
                    		else emit2(INCLUDE16, Bytecode.INSTR_NEW, (ID18!=null?ID18.getText():null), (args17!=null?args17.n:0)+num_exprs);
                    		

                    }
                    break;
                case 2 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:273:4: subtemplate
                    {
                    pushFollow(FOLLOW_subtemplate_in_mapTemplateRef635);
                    subtemplate19=subtemplate();

                    state._fsp--;


                    		if ( (subtemplate19!=null?subtemplate19.nargs:0) != num_exprs ) {
                                errMgr.compileTimeError(ErrorType.ANON_ARGUMENT_MISMATCH,
                                						templateToken, (subtemplate19!=null?((CommonTree)subtemplate19.start):null).token, (subtemplate19!=null?subtemplate19.nargs:0), num_exprs);
                    		}
                    		for (int i=1; i<=num_exprs; i++) emit((subtemplate19!=null?((CommonTree)subtemplate19.start):null),Bytecode.INSTR_NULL);
                            emit2((subtemplate19!=null?((CommonTree)subtemplate19.start):null), Bytecode.INSTR_NEW,
                    	              (subtemplate19!=null?subtemplate19.name:null),
                    	              num_exprs);
                    		

                    }
                    break;
                case 3 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:285:4: ^( INCLUDE_IND expr args )
                    {
                    INCLUDE_IND20=(CommonTree)match(input,INCLUDE_IND,FOLLOW_INCLUDE_IND_in_mapTemplateRef647); 

                    match(input, Token.DOWN, null); 
                    pushFollow(FOLLOW_expr_in_mapTemplateRef649);
                    expr();

                    state._fsp--;


                    			emit(INCLUDE_IND20,Bytecode.INSTR_TOSTR);
                    			for (int i=1; i<=num_exprs; i++) emit(INCLUDE_IND20,Bytecode.INSTR_NULL);
                    			
                    pushFollow(FOLLOW_args_in_mapTemplateRef659);
                    args21=args();

                    state._fsp--;

                    emit1(INCLUDE_IND20, Bytecode.INSTR_NEW_IND, (args21!=null?args21.n:0)+num_exprs);

                    match(input, Token.UP, null); 

                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "mapTemplateRef"


    // $ANTLR start "includeExpr"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:295:1: includeExpr : ( ^( EXEC_FUNC ID ( expr )? ) | ^( INCLUDE ID args ) | ^( INCLUDE_SUPER ID args ) | ^( INCLUDE_REGION ID ) | ^( INCLUDE_SUPER_REGION ID ) | primary );
    public final void includeExpr() throws RecognitionException {
        CommonTree ID22=null;
        CommonTree INCLUDE24=null;
        CommonTree ID25=null;
        CommonTree INCLUDE_SUPER27=null;
        CommonTree ID28=null;
        CommonTree ID29=null;
        CommonTree INCLUDE_REGION30=null;
        CommonTree ID31=null;
        CommonTree INCLUDE_SUPER_REGION32=null;
        CodeGenerator.args_return args23 = null;

        CodeGenerator.args_return args26 = null;


        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:296:2: ( ^( EXEC_FUNC ID ( expr )? ) | ^( INCLUDE ID args ) | ^( INCLUDE_SUPER ID args ) | ^( INCLUDE_REGION ID ) | ^( INCLUDE_SUPER_REGION ID ) | primary )
            int alt16=6;
            switch ( input.LA(1) ) {
            case EXEC_FUNC:
                {
                alt16=1;
                }
                break;
            case INCLUDE:
                {
                alt16=2;
                }
                break;
            case INCLUDE_SUPER:
                {
                alt16=3;
                }
                break;
            case INCLUDE_REGION:
                {
                alt16=4;
                }
                break;
            case INCLUDE_SUPER_REGION:
                {
                alt16=5;
                }
                break;
            case ID:
            case STRING:
            case INCLUDE_IND:
            case TO_STR:
            case LIST:
            case SUBTEMPLATE:
                {
                alt16=6;
                }
                break;
            default:
                NoViableAltException nvae =
                    new NoViableAltException("", 16, 0, input);

                throw nvae;
            }

            switch (alt16) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:296:4: ^( EXEC_FUNC ID ( expr )? )
                    {
                    match(input,EXEC_FUNC,FOLLOW_EXEC_FUNC_in_includeExpr681); 

                    match(input, Token.DOWN, null); 
                    ID22=(CommonTree)match(input,ID,FOLLOW_ID_in_includeExpr683); 
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:296:19: ( expr )?
                    int alt15=2;
                    int LA15_0 = input.LA(1);

                    if ( ((LA15_0>=ID && LA15_0<=STRING)||(LA15_0>=PROP && LA15_0<=SUBTEMPLATE)) ) {
                        alt15=1;
                    }
                    switch (alt15) {
                        case 1 :
                            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:296:19: expr
                            {
                            pushFollow(FOLLOW_expr_in_includeExpr685);
                            expr();

                            state._fsp--;


                            }
                            break;

                    }


                    match(input, Token.UP, null); 
                    func(ID22);

                    }
                    break;
                case 2 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:297:4: ^( INCLUDE ID args )
                    {
                    INCLUDE24=(CommonTree)match(input,INCLUDE,FOLLOW_INCLUDE_in_includeExpr696); 

                    match(input, Token.DOWN, null); 
                    ID25=(CommonTree)match(input,ID,FOLLOW_ID_in_includeExpr698); 
                    pushFollow(FOLLOW_args_in_includeExpr700);
                    args23=args();

                    state._fsp--;


                    match(input, Token.UP, null); 

                    		if ( (args23!=null?args23.namedArgs:false) ) emit1(INCLUDE24, Bytecode.INSTR_NEW_BOX_ARGS, (ID25!=null?ID25.getText():null));
                    		else emit2(INCLUDE24, Bytecode.INSTR_NEW, (ID25!=null?ID25.getText():null), (args23!=null?args23.n:0));
                    		

                    }
                    break;
                case 3 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:302:4: ^( INCLUDE_SUPER ID args )
                    {
                    INCLUDE_SUPER27=(CommonTree)match(input,INCLUDE_SUPER,FOLLOW_INCLUDE_SUPER_in_includeExpr711); 

                    match(input, Token.DOWN, null); 
                    ID28=(CommonTree)match(input,ID,FOLLOW_ID_in_includeExpr713); 
                    pushFollow(FOLLOW_args_in_includeExpr715);
                    args26=args();

                    state._fsp--;


                    match(input, Token.UP, null); 

                    		if ( (args26!=null?args26.namedArgs:false) ) emit1(INCLUDE_SUPER27, Bytecode.INSTR_SUPER_NEW_BOX_ARGS, (ID28!=null?ID28.getText():null));
                    		else emit2(INCLUDE_SUPER27, Bytecode.INSTR_SUPER_NEW, (ID28!=null?ID28.getText():null), (args26!=null?args26.n:0));
                    		

                    }
                    break;
                case 4 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:307:4: ^( INCLUDE_REGION ID )
                    {
                    INCLUDE_REGION30=(CommonTree)match(input,INCLUDE_REGION,FOLLOW_INCLUDE_REGION_in_includeExpr726); 

                    match(input, Token.DOWN, null); 
                    ID29=(CommonTree)match(input,ID,FOLLOW_ID_in_includeExpr728); 

                    match(input, Token.UP, null); 

                    									CompiledST impl =
                    										Compiler.defineBlankRegion(outermostImpl, (ID29!=null?ID29.getText():null));
                    									//impl.dump();
                    									emit2(INCLUDE_REGION30,Bytecode.INSTR_NEW,impl.name,0);
                    									

                    }
                    break;
                case 5 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:313:4: ^( INCLUDE_SUPER_REGION ID )
                    {
                    INCLUDE_SUPER_REGION32=(CommonTree)match(input,INCLUDE_SUPER_REGION,FOLLOW_INCLUDE_SUPER_REGION_in_includeExpr738); 

                    match(input, Token.DOWN, null); 
                    ID31=(CommonTree)match(input,ID,FOLLOW_ID_in_includeExpr740); 

                    match(input, Token.UP, null); 

                    									CompiledST impl =
                    										Compiler.defineBlankRegion(outermostImpl, (ID31!=null?ID31.getText():null));
                    									//impl.dump();
                    									emit2(INCLUDE_SUPER_REGION32,Bytecode.INSTR_SUPER_NEW,impl.name,0);
                    									

                    }
                    break;
                case 6 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:319:4: primary
                    {
                    pushFollow(FOLLOW_primary_in_includeExpr748);
                    primary();

                    state._fsp--;


                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "includeExpr"

    public static class primary_return extends TreeRuleReturnScope {
    };

    // $ANTLR start "primary"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:322:1: primary : ( ID | STRING | subtemplate | list | ^( INCLUDE_IND expr args ) | ^( TO_STR expr ) );
    public final CodeGenerator.primary_return primary() throws RecognitionException {
        CodeGenerator.primary_return retval = new CodeGenerator.primary_return();
        retval.start = input.LT(1);

        CommonTree ID33=null;
        CommonTree STRING34=null;
        CommonTree INCLUDE_IND36=null;
        CommonTree TO_STR38=null;
        CodeGenerator.subtemplate_return subtemplate35 = null;

        CodeGenerator.args_return args37 = null;


        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:323:2: ( ID | STRING | subtemplate | list | ^( INCLUDE_IND expr args ) | ^( TO_STR expr ) )
            int alt17=6;
            switch ( input.LA(1) ) {
            case ID:
                {
                alt17=1;
                }
                break;
            case STRING:
                {
                alt17=2;
                }
                break;
            case SUBTEMPLATE:
                {
                alt17=3;
                }
                break;
            case LIST:
                {
                alt17=4;
                }
                break;
            case INCLUDE_IND:
                {
                alt17=5;
                }
                break;
            case TO_STR:
                {
                alt17=6;
                }
                break;
            default:
                NoViableAltException nvae =
                    new NoViableAltException("", 17, 0, input);

                throw nvae;
            }

            switch (alt17) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:323:4: ID
                    {
                    ID33=(CommonTree)match(input,ID,FOLLOW_ID_in_primary759); 
                    refAttr(ID33);

                    }
                    break;
                case 2 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:324:4: STRING
                    {
                    STRING34=(CommonTree)match(input,STRING,FOLLOW_STRING_in_primary769); 
                    emit1(STRING34,Bytecode.INSTR_LOAD_STR, Misc.strip((STRING34!=null?STRING34.getText():null),1));

                    }
                    break;
                case 3 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:325:4: subtemplate
                    {
                    pushFollow(FOLLOW_subtemplate_in_primary779);
                    subtemplate35=subtemplate();

                    state._fsp--;

                    emit2(((CommonTree)retval.start),Bytecode.INSTR_NEW, (subtemplate35!=null?subtemplate35.name:null), 0);

                    }
                    break;
                case 4 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:327:4: list
                    {
                    pushFollow(FOLLOW_list_in_primary806);
                    list();

                    state._fsp--;


                    }
                    break;
                case 5 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:328:4: ^( INCLUDE_IND expr args )
                    {
                    INCLUDE_IND36=(CommonTree)match(input,INCLUDE_IND,FOLLOW_INCLUDE_IND_in_primary813); 

                    match(input, Token.DOWN, null); 
                    pushFollow(FOLLOW_expr_in_primary819);
                    expr();

                    state._fsp--;

                    emit(INCLUDE_IND36, Bytecode.INSTR_TOSTR);
                    pushFollow(FOLLOW_args_in_primary828);
                    args37=args();

                    state._fsp--;

                    emit1(INCLUDE_IND36, Bytecode.INSTR_NEW_IND, (args37!=null?args37.n:0));

                    match(input, Token.UP, null); 

                    }
                    break;
                case 6 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:332:4: ^( TO_STR expr )
                    {
                    TO_STR38=(CommonTree)match(input,TO_STR,FOLLOW_TO_STR_in_primary842); 

                    match(input, Token.DOWN, null); 
                    pushFollow(FOLLOW_expr_in_primary844);
                    expr();

                    state._fsp--;


                    match(input, Token.UP, null); 
                    emit(TO_STR38, Bytecode.INSTR_TOSTR);

                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "primary"


    // $ANTLR start "arg"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:335:1: arg : expr ;
    public final void arg() throws RecognitionException {
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:335:5: ( expr )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:335:7: expr
            {
            pushFollow(FOLLOW_expr_in_arg857);
            expr();

            state._fsp--;


            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "arg"

    public static class args_return extends TreeRuleReturnScope {
        public int n=0;
        public boolean namedArgs=false;
    };

    // $ANTLR start "args"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:337:1: args returns [int n=0, boolean namedArgs=false] : ( ( arg )+ | ( ^(eq= '=' ID expr ) )+ | );
    public final CodeGenerator.args_return args() throws RecognitionException {
        CodeGenerator.args_return retval = new CodeGenerator.args_return();
        retval.start = input.LT(1);

        CommonTree eq=null;
        CommonTree ID39=null;

        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:338:2: ( ( arg )+ | ( ^(eq= '=' ID expr ) )+ | )
            int alt20=3;
            switch ( input.LA(1) ) {
            case ID:
            case STRING:
            case PROP:
            case PROP_IND:
            case INCLUDE:
            case INCLUDE_IND:
            case EXEC_FUNC:
            case INCLUDE_SUPER:
            case INCLUDE_SUPER_REGION:
            case INCLUDE_REGION:
            case TO_STR:
            case LIST:
            case MAP:
            case ZIP:
            case SUBTEMPLATE:
                {
                alt20=1;
                }
                break;
            case EQUALS:
                {
                alt20=2;
                }
                break;
            case UP:
                {
                alt20=3;
                }
                break;
            default:
                NoViableAltException nvae =
                    new NoViableAltException("", 20, 0, input);

                throw nvae;
            }

            switch (alt20) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:338:4: ( arg )+
                    {
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:338:4: ( arg )+
                    int cnt18=0;
                    loop18:
                    do {
                        int alt18=2;
                        int LA18_0 = input.LA(1);

                        if ( ((LA18_0>=ID && LA18_0<=STRING)||(LA18_0>=PROP && LA18_0<=SUBTEMPLATE)) ) {
                            alt18=1;
                        }


                        switch (alt18) {
                    	case 1 :
                    	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:338:6: arg
                    	    {
                    	    pushFollow(FOLLOW_arg_in_args873);
                    	    arg();

                    	    state._fsp--;

                    	    retval.n++;

                    	    }
                    	    break;

                    	default :
                    	    if ( cnt18 >= 1 ) break loop18;
                                EarlyExitException eee =
                                    new EarlyExitException(18, input);
                                throw eee;
                        }
                        cnt18++;
                    } while (true);


                    }
                    break;
                case 2 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:339:4: ( ^(eq= '=' ID expr ) )+
                    {
                    emit(((CommonTree)retval.start), Bytecode.INSTR_ARGS); retval.namedArgs =true;
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:340:3: ( ^(eq= '=' ID expr ) )+
                    int cnt19=0;
                    loop19:
                    do {
                        int alt19=2;
                        int LA19_0 = input.LA(1);

                        if ( (LA19_0==EQUALS) ) {
                            alt19=1;
                        }


                        switch (alt19) {
                    	case 1 :
                    	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:340:5: ^(eq= '=' ID expr )
                    	    {
                    	    eq=(CommonTree)match(input,EQUALS,FOLLOW_EQUALS_in_args892); 

                    	    match(input, Token.DOWN, null); 
                    	    ID39=(CommonTree)match(input,ID,FOLLOW_ID_in_args894); 
                    	    pushFollow(FOLLOW_expr_in_args896);
                    	    expr();

                    	    state._fsp--;


                    	    match(input, Token.UP, null); 
                    	    retval.n++; emit1(eq, Bytecode.INSTR_STORE_ARG, defineString((ID39!=null?ID39.getText():null)));

                    	    }
                    	    break;

                    	default :
                    	    if ( cnt19 >= 1 ) break loop19;
                                EarlyExitException eee =
                                    new EarlyExitException(19, input);
                                throw eee;
                        }
                        cnt19++;
                    } while (true);


                    }
                    break;
                case 3 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:344:3: 
                    {
                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "args"


    // $ANTLR start "list"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:346:1: list : ^( LIST ( listElement )* ) ;
    public final void list() throws RecognitionException {
        CodeGenerator.listElement_return listElement40 = null;


        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:346:5: ( ^( LIST ( listElement )* ) )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:346:7: ^( LIST ( listElement )* )
            {
            emit(Bytecode.INSTR_LIST);
            match(input,LIST,FOLLOW_LIST_in_list925); 

            if ( input.LA(1)==Token.DOWN ) {
                match(input, Token.DOWN, null); 
                // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:347:10: ( listElement )*
                loop21:
                do {
                    int alt21=2;
                    int LA21_0 = input.LA(1);

                    if ( ((LA21_0>=ID && LA21_0<=STRING)||(LA21_0>=PROP && LA21_0<=SUBTEMPLATE)||LA21_0==NULL) ) {
                        alt21=1;
                    }


                    switch (alt21) {
                	case 1 :
                	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:347:11: listElement
                	    {
                	    pushFollow(FOLLOW_listElement_in_list928);
                	    listElement40=listElement();

                	    state._fsp--;

                	    emit((listElement40!=null?((CommonTree)listElement40.start):null), Bytecode.INSTR_ADD);

                	    }
                	    break;

                	default :
                	    break loop21;
                    }
                } while (true);


                match(input, Token.UP, null); 
            }

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "list"

    public static class listElement_return extends TreeRuleReturnScope {
    };

    // $ANTLR start "listElement"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:350:1: listElement : ( expr | NULL );
    public final CodeGenerator.listElement_return listElement() throws RecognitionException {
        CodeGenerator.listElement_return retval = new CodeGenerator.listElement_return();
        retval.start = input.LT(1);

        CommonTree NULL41=null;

        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:350:13: ( expr | NULL )
            int alt22=2;
            int LA22_0 = input.LA(1);

            if ( ((LA22_0>=ID && LA22_0<=STRING)||(LA22_0>=PROP && LA22_0<=SUBTEMPLATE)) ) {
                alt22=1;
            }
            else if ( (LA22_0==NULL) ) {
                alt22=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 22, 0, input);

                throw nvae;
            }
            switch (alt22) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:350:15: expr
                    {
                    pushFollow(FOLLOW_expr_in_listElement945);
                    expr();

                    state._fsp--;


                    }
                    break;
                case 2 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/CodeGenerator.g:350:22: NULL
                    {
                    NULL41=(CommonTree)match(input,NULL,FOLLOW_NULL_in_listElement949); 
                    emit(NULL41,Bytecode.INSTR_NULL);

                    }
                    break;

            }
        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return retval;
    }
    // $ANTLR end "listElement"

    // Delegated rules


 

    public static final BitSet FOLLOW_template_in_templateAndEOF44 = new BitSet(new long[]{0x0000000000000000L});
    public static final BitSet FOLLOW_EOF_in_templateAndEOF47 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_chunk_in_template71 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_element_in_chunk86 = new BitSet(new long[]{0x0010000980400012L});
    public static final BitSet FOLLOW_INDENT_in_element100 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_element_in_element104 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_ifstat_in_element112 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_exprElement_in_element117 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_TEXT_in_element122 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_region_in_element131 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_NEWLINE_in_element140 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_EXPR_in_exprElement160 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_expr_in_exprElement162 = new BitSet(new long[]{0x0000001000000008L});
    public static final BitSet FOLLOW_exprOptions_in_exprElement165 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_REGION_in_region192 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_ID_in_region194 = new BitSet(new long[]{0x0010000980400010L});
    public static final BitSet FOLLOW_template_in_region204 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_SUBTEMPLATE_in_subtemplate237 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_ARGS_in_subtemplate244 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_ID_in_subtemplate247 = new BitSet(new long[]{0x0000000002000008L});
    public static final BitSet FOLLOW_template_in_subtemplate264 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_IF_in_ifstat295 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_conditional_in_ifstat297 = new BitSet(new long[]{0x0010000980400010L});
    public static final BitSet FOLLOW_chunk_in_ifstat307 = new BitSet(new long[]{0x0000000000000068L});
    public static final BitSet FOLLOW_ELSEIF_in_ifstat317 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_conditional_in_ifstat331 = new BitSet(new long[]{0x0010000980400010L});
    public static final BitSet FOLLOW_chunk_in_ifstat343 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_ELSE_in_ifstat366 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_chunk_in_ifstat380 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_OR_in_conditional414 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_conditional_in_conditional416 = new BitSet(new long[]{0x0003FFE066000400L});
    public static final BitSet FOLLOW_conditional_in_conditional418 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_AND_in_conditional428 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_conditional_in_conditional430 = new BitSet(new long[]{0x0003FFE066000400L});
    public static final BitSet FOLLOW_conditional_in_conditional432 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_BANG_in_conditional442 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_conditional_in_conditional444 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_expr_in_conditional456 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_OPTIONS_in_exprOptions470 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_option_in_exprOptions472 = new BitSet(new long[]{0x0000000000001008L});
    public static final BitSet FOLLOW_EQUALS_in_option484 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_ID_in_option486 = new BitSet(new long[]{0x0003FFE066000400L});
    public static final BitSet FOLLOW_expr_in_option488 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_ZIP_in_expr507 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_ELEMENTS_in_expr510 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_expr_in_expr513 = new BitSet(new long[]{0x0003FFE066000408L});
    public static final BitSet FOLLOW_mapTemplateRef_in_expr520 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_MAP_in_expr532 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_expr_in_expr534 = new BitSet(new long[]{0x0002018000000000L});
    public static final BitSet FOLLOW_mapTemplateRef_in_expr537 = new BitSet(new long[]{0x0002018000000008L});
    public static final BitSet FOLLOW_prop_in_expr552 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_includeExpr_in_expr557 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_PROP_in_prop567 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_expr_in_prop569 = new BitSet(new long[]{0x0000000002000000L});
    public static final BitSet FOLLOW_ID_in_prop571 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_PROP_IND_in_prop585 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_expr_in_prop587 = new BitSet(new long[]{0x0003FFE066000400L});
    public static final BitSet FOLLOW_expr_in_prop589 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_INCLUDE_in_mapTemplateRef610 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_ID_in_mapTemplateRef612 = new BitSet(new long[]{0x0003FFE066001408L});
    public static final BitSet FOLLOW_args_in_mapTemplateRef622 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_subtemplate_in_mapTemplateRef635 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_INCLUDE_IND_in_mapTemplateRef647 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_expr_in_mapTemplateRef649 = new BitSet(new long[]{0x0003FFE066001408L});
    public static final BitSet FOLLOW_args_in_mapTemplateRef659 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_EXEC_FUNC_in_includeExpr681 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_ID_in_includeExpr683 = new BitSet(new long[]{0x0003FFE066000408L});
    public static final BitSet FOLLOW_expr_in_includeExpr685 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_INCLUDE_in_includeExpr696 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_ID_in_includeExpr698 = new BitSet(new long[]{0x0003FFE066001408L});
    public static final BitSet FOLLOW_args_in_includeExpr700 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_INCLUDE_SUPER_in_includeExpr711 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_ID_in_includeExpr713 = new BitSet(new long[]{0x0003FFE066001408L});
    public static final BitSet FOLLOW_args_in_includeExpr715 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_INCLUDE_REGION_in_includeExpr726 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_ID_in_includeExpr728 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_INCLUDE_SUPER_REGION_in_includeExpr738 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_ID_in_includeExpr740 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_primary_in_includeExpr748 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ID_in_primary759 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_STRING_in_primary769 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_subtemplate_in_primary779 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_list_in_primary806 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_INCLUDE_IND_in_primary813 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_expr_in_primary819 = new BitSet(new long[]{0x0003FFE066001408L});
    public static final BitSet FOLLOW_args_in_primary828 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_TO_STR_in_primary842 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_expr_in_primary844 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_expr_in_arg857 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_arg_in_args873 = new BitSet(new long[]{0x0003FFE066000402L});
    public static final BitSet FOLLOW_EQUALS_in_args892 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_ID_in_args894 = new BitSet(new long[]{0x0003FFE066000400L});
    public static final BitSet FOLLOW_expr_in_args896 = new BitSet(new long[]{0x0000000000000008L});
    public static final BitSet FOLLOW_LIST_in_list925 = new BitSet(new long[]{0x0000000000000004L});
    public static final BitSet FOLLOW_listElement_in_list928 = new BitSet(new long[]{0x0023FFE066000408L});
    public static final BitSet FOLLOW_expr_in_listElement945 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_NULL_in_listElement949 = new BitSet(new long[]{0x0000000000000002L});

}