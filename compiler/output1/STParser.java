// $ANTLR 3.3.1-SNAPSHOT Feb 01, 2011 19:19:01 /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g 2011-02-03 08:07:03

package org.stringtemplate.v4.compiler;
import org.stringtemplate.v4.misc.ErrorManager;
import org.stringtemplate.v4.misc.ErrorType;


import org.antlr.runtime.*;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;


import org.antlr.runtime.tree.*;

/** Build an AST from a single StringTemplate template */
public class STParser extends Parser {
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


        public STParser(TokenStream input) {
            this(input, new RecognizerSharedState());
        }
        public STParser(TokenStream input, RecognizerSharedState state) {
            super(input, state);
             
        }
        
    protected TreeAdaptor adaptor = new CommonTreeAdaptor();

    public void setTreeAdaptor(TreeAdaptor adaptor) {
        this.adaptor = adaptor;
    }
    public TreeAdaptor getTreeAdaptor() {
        return adaptor;
    }

    public String[] getTokenNames() { return STParser.tokenNames; }
    public String getGrammarFileName() { return "/Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g"; }


    ErrorManager errMgr;
    Token templateToken;
    public STParser(TokenStream input, ErrorManager errMgr, Token templateToken) {
    	this(input);
    	this.errMgr = errMgr;
    	this.templateToken = templateToken;
    }
    protected Object recoverFromMismatchedToken(IntStream input, int ttype, BitSet follow)
    	throws RecognitionException
    {
    	throw new MismatchedTokenException(ttype, input);
    }


    public static class templateAndEOF_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "templateAndEOF"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:70:1: templateAndEOF : template EOF -> ( template )? ;
    public final STParser.templateAndEOF_return templateAndEOF() throws RecognitionException {
        STParser.templateAndEOF_return retval = new STParser.templateAndEOF_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        CommonToken EOF2=null;
        STParser.template_return template1 = null;


        CommonTree EOF2_tree=null;
        RewriteRuleTokenStream stream_EOF=new RewriteRuleTokenStream(adaptor,"token EOF");
        RewriteRuleSubtreeStream stream_template=new RewriteRuleSubtreeStream(adaptor,"rule template");
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:70:16: ( template EOF -> ( template )? )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:70:18: template EOF
            {
            pushFollow(FOLLOW_template_in_templateAndEOF130);
            template1=template();

            state._fsp--;

            stream_template.add(template1.getTree());
            EOF2=(CommonToken)match(input,EOF,FOLLOW_EOF_in_templateAndEOF132);  
            stream_EOF.add(EOF2);



            // AST REWRITE
            // elements: template
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 70:31: -> ( template )?
            {
                // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:70:34: ( template )?
                if ( stream_template.hasNext() ) {
                    adaptor.addChild(root_0, stream_template.nextTree());

                }
                stream_template.reset();

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "templateAndEOF"

    public static class template_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "template"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:72:1: template : ( element )* ;
    public final STParser.template_return template() throws RecognitionException {
        STParser.template_return retval = new STParser.template_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        STParser.element_return element3 = null;



        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:72:10: ( ( element )* )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:72:12: ( element )*
            {
            root_0 = (CommonTree)adaptor.nil();

            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:72:12: ( element )*
            loop1:
            do {
                int alt1=2;
                switch ( input.LA(1) ) {
                case LDELIM:
                    {
                    int LA1_2 = input.LA(2);

                    if ( (LA1_2==IF||LA1_2==SUPER||LA1_2==LPAREN||LA1_2==LBRACK||LA1_2==LCURLY||(LA1_2>=ID && LA1_2<=STRING)||LA1_2==AT) ) {
                        alt1=1;
                    }


                    }
                    break;
                case INDENT:
                    {
                    int LA1_3 = input.LA(2);

                    if ( (LA1_3==LDELIM) ) {
                        int LA1_5 = input.LA(3);

                        if ( (LA1_5==IF||LA1_5==SUPER||LA1_5==LPAREN||LA1_5==LBRACK||LA1_5==LCURLY||(LA1_5>=ID && LA1_5<=STRING)||LA1_5==AT) ) {
                            alt1=1;
                        }


                    }
                    else if ( (LA1_3==TEXT||(LA1_3>=INDENT && LA1_3<=NEWLINE)) ) {
                        alt1=1;
                    }


                    }
                    break;
                case TEXT:
                case NEWLINE:
                    {
                    alt1=1;
                    }
                    break;

                }

                switch (alt1) {
            	case 1 :
            	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:72:12: element
            	    {
            	    pushFollow(FOLLOW_element_in_template146);
            	    element3=element();

            	    state._fsp--;

            	    adaptor.addChild(root_0, element3.getTree());

            	    }
            	    break;

            	default :
            	    break loop1;
                }
            } while (true);


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "template"

    public static class element_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "element"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:74:1: element : ( INDENT element -> ^( INDENT element ) | ifstat | exprTag | text | region | NEWLINE );
    public final STParser.element_return element() throws RecognitionException {
        STParser.element_return retval = new STParser.element_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        CommonToken INDENT4=null;
        CommonToken NEWLINE10=null;
        STParser.element_return element5 = null;

        STParser.ifstat_return ifstat6 = null;

        STParser.exprTag_return exprTag7 = null;

        STParser.text_return text8 = null;

        STParser.region_return region9 = null;


        CommonTree INDENT4_tree=null;
        CommonTree NEWLINE10_tree=null;
        RewriteRuleTokenStream stream_INDENT=new RewriteRuleTokenStream(adaptor,"token INDENT");
        RewriteRuleSubtreeStream stream_element=new RewriteRuleSubtreeStream(adaptor,"rule element");
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:75:2: ( INDENT element -> ^( INDENT element ) | ifstat | exprTag | text | region | NEWLINE )
            int alt2=6;
            alt2 = dfa2.predict(input);
            switch (alt2) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:75:4: INDENT element
                    {
                    INDENT4=(CommonToken)match(input,INDENT,FOLLOW_INDENT_in_element157);  
                    stream_INDENT.add(INDENT4);

                    pushFollow(FOLLOW_element_in_element159);
                    element5=element();

                    state._fsp--;

                    stream_element.add(element5.getTree());


                    // AST REWRITE
                    // elements: INDENT, element
                    // token labels: 
                    // rule labels: retval
                    // token list labels: 
                    // rule list labels: 
                    // wildcard labels: 
                    retval.tree = root_0;
                    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

                    root_0 = (CommonTree)adaptor.nil();
                    // 75:19: -> ^( INDENT element )
                    {
                        // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:75:22: ^( INDENT element )
                        {
                        CommonTree root_1 = (CommonTree)adaptor.nil();
                        root_1 = (CommonTree)adaptor.becomeRoot(stream_INDENT.nextNode(), root_1);

                        adaptor.addChild(root_1, stream_element.nextTree());

                        adaptor.addChild(root_0, root_1);
                        }

                    }

                    retval.tree = root_0;
                    }
                    break;
                case 2 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:76:4: ifstat
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_ifstat_in_element172);
                    ifstat6=ifstat();

                    state._fsp--;

                    adaptor.addChild(root_0, ifstat6.getTree());

                    }
                    break;
                case 3 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:77:4: exprTag
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_exprTag_in_element177);
                    exprTag7=exprTag();

                    state._fsp--;

                    adaptor.addChild(root_0, exprTag7.getTree());

                    }
                    break;
                case 4 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:78:4: text
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_text_in_element182);
                    text8=text();

                    state._fsp--;

                    adaptor.addChild(root_0, text8.getTree());

                    }
                    break;
                case 5 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:79:4: region
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_region_in_element187);
                    region9=region();

                    state._fsp--;

                    adaptor.addChild(root_0, region9.getTree());

                    }
                    break;
                case 6 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:80:4: NEWLINE
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    NEWLINE10=(CommonToken)match(input,NEWLINE,FOLLOW_NEWLINE_in_element192); 
                    NEWLINE10_tree = (CommonTree)adaptor.create(NEWLINE10);
                    adaptor.addChild(root_0, NEWLINE10_tree);


                    }
                    break;

            }
            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "element"

    public static class text_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "text"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:83:1: text : TEXT ;
    public final STParser.text_return text() throws RecognitionException {
        STParser.text_return retval = new STParser.text_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        CommonToken TEXT11=null;

        CommonTree TEXT11_tree=null;

        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:83:6: ( TEXT )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:83:8: TEXT
            {
            root_0 = (CommonTree)adaptor.nil();

            TEXT11=(CommonToken)match(input,TEXT,FOLLOW_TEXT_in_text202); 
            TEXT11_tree = (CommonTree)adaptor.create(TEXT11);
            adaptor.addChild(root_0, TEXT11_tree);


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "text"

    public static class exprTag_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "exprTag"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:85:1: exprTag : LDELIM expr ( ';' exprOptions )? RDELIM -> ^( EXPR[$LDELIM,\"EXPR\"] expr ( exprOptions )? ) ;
    public final STParser.exprTag_return exprTag() throws RecognitionException {
        STParser.exprTag_return retval = new STParser.exprTag_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        CommonToken LDELIM12=null;
        CommonToken char_literal14=null;
        CommonToken RDELIM16=null;
        STParser.expr_return expr13 = null;

        STParser.exprOptions_return exprOptions15 = null;


        CommonTree LDELIM12_tree=null;
        CommonTree char_literal14_tree=null;
        CommonTree RDELIM16_tree=null;
        RewriteRuleTokenStream stream_RDELIM=new RewriteRuleTokenStream(adaptor,"token RDELIM");
        RewriteRuleTokenStream stream_LDELIM=new RewriteRuleTokenStream(adaptor,"token LDELIM");
        RewriteRuleTokenStream stream_SEMI=new RewriteRuleTokenStream(adaptor,"token SEMI");
        RewriteRuleSubtreeStream stream_exprOptions=new RewriteRuleSubtreeStream(adaptor,"rule exprOptions");
        RewriteRuleSubtreeStream stream_expr=new RewriteRuleSubtreeStream(adaptor,"rule expr");
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:86:2: ( LDELIM expr ( ';' exprOptions )? RDELIM -> ^( EXPR[$LDELIM,\"EXPR\"] expr ( exprOptions )? ) )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:86:4: LDELIM expr ( ';' exprOptions )? RDELIM
            {
            LDELIM12=(CommonToken)match(input,LDELIM,FOLLOW_LDELIM_in_exprTag212);  
            stream_LDELIM.add(LDELIM12);

            pushFollow(FOLLOW_expr_in_exprTag214);
            expr13=expr();

            state._fsp--;

            stream_expr.add(expr13.getTree());
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:86:16: ( ';' exprOptions )?
            int alt3=2;
            int LA3_0 = input.LA(1);

            if ( (LA3_0==SEMI) ) {
                alt3=1;
            }
            switch (alt3) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:86:18: ';' exprOptions
                    {
                    char_literal14=(CommonToken)match(input,SEMI,FOLLOW_SEMI_in_exprTag218);  
                    stream_SEMI.add(char_literal14);

                    pushFollow(FOLLOW_exprOptions_in_exprTag220);
                    exprOptions15=exprOptions();

                    state._fsp--;

                    stream_exprOptions.add(exprOptions15.getTree());

                    }
                    break;

            }

            RDELIM16=(CommonToken)match(input,RDELIM,FOLLOW_RDELIM_in_exprTag225);  
            stream_RDELIM.add(RDELIM16);



            // AST REWRITE
            // elements: expr, exprOptions
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 87:3: -> ^( EXPR[$LDELIM,\"EXPR\"] expr ( exprOptions )? )
            {
                // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:87:6: ^( EXPR[$LDELIM,\"EXPR\"] expr ( exprOptions )? )
                {
                CommonTree root_1 = (CommonTree)adaptor.nil();
                root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(EXPR, LDELIM12, "EXPR"), root_1);

                adaptor.addChild(root_1, stream_expr.nextTree());
                // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:87:34: ( exprOptions )?
                if ( stream_exprOptions.hasNext() ) {
                    adaptor.addChild(root_1, stream_exprOptions.nextTree());

                }
                stream_exprOptions.reset();

                adaptor.addChild(root_0, root_1);
                }

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "exprTag"

    public static class region_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "region"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:90:1: region : LDELIM '@' ID RDELIM template LDELIM '@end' RDELIM -> ^( REGION ID template ) ;
    public final STParser.region_return region() throws RecognitionException {
        STParser.region_return retval = new STParser.region_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        CommonToken LDELIM17=null;
        CommonToken char_literal18=null;
        CommonToken ID19=null;
        CommonToken RDELIM20=null;
        CommonToken LDELIM22=null;
        CommonToken string_literal23=null;
        CommonToken RDELIM24=null;
        STParser.template_return template21 = null;


        CommonTree LDELIM17_tree=null;
        CommonTree char_literal18_tree=null;
        CommonTree ID19_tree=null;
        CommonTree RDELIM20_tree=null;
        CommonTree LDELIM22_tree=null;
        CommonTree string_literal23_tree=null;
        CommonTree RDELIM24_tree=null;
        RewriteRuleTokenStream stream_AT=new RewriteRuleTokenStream(adaptor,"token AT");
        RewriteRuleTokenStream stream_RDELIM=new RewriteRuleTokenStream(adaptor,"token RDELIM");
        RewriteRuleTokenStream stream_ID=new RewriteRuleTokenStream(adaptor,"token ID");
        RewriteRuleTokenStream stream_END=new RewriteRuleTokenStream(adaptor,"token END");
        RewriteRuleTokenStream stream_LDELIM=new RewriteRuleTokenStream(adaptor,"token LDELIM");
        RewriteRuleSubtreeStream stream_template=new RewriteRuleSubtreeStream(adaptor,"rule template");
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:90:8: ( LDELIM '@' ID RDELIM template LDELIM '@end' RDELIM -> ^( REGION ID template ) )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:90:10: LDELIM '@' ID RDELIM template LDELIM '@end' RDELIM
            {
            LDELIM17=(CommonToken)match(input,LDELIM,FOLLOW_LDELIM_in_region249);  
            stream_LDELIM.add(LDELIM17);

            char_literal18=(CommonToken)match(input,AT,FOLLOW_AT_in_region251);  
            stream_AT.add(char_literal18);

            ID19=(CommonToken)match(input,ID,FOLLOW_ID_in_region253);  
            stream_ID.add(ID19);

            RDELIM20=(CommonToken)match(input,RDELIM,FOLLOW_RDELIM_in_region255);  
            stream_RDELIM.add(RDELIM20);

            pushFollow(FOLLOW_template_in_region257);
            template21=template();

            state._fsp--;

            stream_template.add(template21.getTree());
            LDELIM22=(CommonToken)match(input,LDELIM,FOLLOW_LDELIM_in_region259);  
            stream_LDELIM.add(LDELIM22);

            string_literal23=(CommonToken)match(input,END,FOLLOW_END_in_region261);  
            stream_END.add(string_literal23);

            RDELIM24=(CommonToken)match(input,RDELIM,FOLLOW_RDELIM_in_region263);  
            stream_RDELIM.add(RDELIM24);



            // AST REWRITE
            // elements: ID, template
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 90:61: -> ^( REGION ID template )
            {
                // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:90:64: ^( REGION ID template )
                {
                CommonTree root_1 = (CommonTree)adaptor.nil();
                root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(REGION, "REGION"), root_1);

                adaptor.addChild(root_1, stream_ID.nextNode());
                adaptor.addChild(root_1, stream_template.nextTree());

                adaptor.addChild(root_0, root_1);
                }

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "region"

    public static class subtemplate_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "subtemplate"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:92:1: subtemplate : lc= '{' (ids+= ID ( ',' ids+= ID )* '|' )? template ( INDENT )? '}' -> ^( SUBTEMPLATE[$lc,\"SUBTEMPLATE\"] ( ^( ARGS $ids) )* template ) ;
    public final STParser.subtemplate_return subtemplate() throws RecognitionException {
        STParser.subtemplate_return retval = new STParser.subtemplate_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        CommonToken lc=null;
        CommonToken char_literal25=null;
        CommonToken char_literal26=null;
        CommonToken INDENT28=null;
        CommonToken char_literal29=null;
        CommonToken ids=null;
        List list_ids=null;
        STParser.template_return template27 = null;


        CommonTree lc_tree=null;
        CommonTree char_literal25_tree=null;
        CommonTree char_literal26_tree=null;
        CommonTree INDENT28_tree=null;
        CommonTree char_literal29_tree=null;
        CommonTree ids_tree=null;
        RewriteRuleTokenStream stream_LCURLY=new RewriteRuleTokenStream(adaptor,"token LCURLY");
        RewriteRuleTokenStream stream_PIPE=new RewriteRuleTokenStream(adaptor,"token PIPE");
        RewriteRuleTokenStream stream_ID=new RewriteRuleTokenStream(adaptor,"token ID");
        RewriteRuleTokenStream stream_COMMA=new RewriteRuleTokenStream(adaptor,"token COMMA");
        RewriteRuleTokenStream stream_INDENT=new RewriteRuleTokenStream(adaptor,"token INDENT");
        RewriteRuleTokenStream stream_RCURLY=new RewriteRuleTokenStream(adaptor,"token RCURLY");
        RewriteRuleSubtreeStream stream_template=new RewriteRuleSubtreeStream(adaptor,"rule template");
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:93:2: (lc= '{' (ids+= ID ( ',' ids+= ID )* '|' )? template ( INDENT )? '}' -> ^( SUBTEMPLATE[$lc,\"SUBTEMPLATE\"] ( ^( ARGS $ids) )* template ) )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:93:4: lc= '{' (ids+= ID ( ',' ids+= ID )* '|' )? template ( INDENT )? '}'
            {
            lc=(CommonToken)match(input,LCURLY,FOLLOW_LCURLY_in_subtemplate285);  
            stream_LCURLY.add(lc);

            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:93:11: (ids+= ID ( ',' ids+= ID )* '|' )?
            int alt5=2;
            int LA5_0 = input.LA(1);

            if ( (LA5_0==ID) ) {
                alt5=1;
            }
            switch (alt5) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:93:12: ids+= ID ( ',' ids+= ID )* '|'
                    {
                    ids=(CommonToken)match(input,ID,FOLLOW_ID_in_subtemplate291);  
                    stream_ID.add(ids);

                    if (list_ids==null) list_ids=new ArrayList();
                    list_ids.add(ids);

                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:93:21: ( ',' ids+= ID )*
                    loop4:
                    do {
                        int alt4=2;
                        int LA4_0 = input.LA(1);

                        if ( (LA4_0==COMMA) ) {
                            alt4=1;
                        }


                        switch (alt4) {
                    	case 1 :
                    	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:93:23: ',' ids+= ID
                    	    {
                    	    char_literal25=(CommonToken)match(input,COMMA,FOLLOW_COMMA_in_subtemplate295);  
                    	    stream_COMMA.add(char_literal25);

                    	    ids=(CommonToken)match(input,ID,FOLLOW_ID_in_subtemplate300);  
                    	    stream_ID.add(ids);

                    	    if (list_ids==null) list_ids=new ArrayList();
                    	    list_ids.add(ids);


                    	    }
                    	    break;

                    	default :
                    	    break loop4;
                        }
                    } while (true);

                    char_literal26=(CommonToken)match(input,PIPE,FOLLOW_PIPE_in_subtemplate305);  
                    stream_PIPE.add(char_literal26);


                    }
                    break;

            }

            pushFollow(FOLLOW_template_in_subtemplate310);
            template27=template();

            state._fsp--;

            stream_template.add(template27.getTree());
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:93:55: ( INDENT )?
            int alt6=2;
            int LA6_0 = input.LA(1);

            if ( (LA6_0==INDENT) ) {
                alt6=1;
            }
            switch (alt6) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:93:55: INDENT
                    {
                    INDENT28=(CommonToken)match(input,INDENT,FOLLOW_INDENT_in_subtemplate312);  
                    stream_INDENT.add(INDENT28);


                    }
                    break;

            }

            char_literal29=(CommonToken)match(input,RCURLY,FOLLOW_RCURLY_in_subtemplate315);  
            stream_RCURLY.add(char_literal29);



            // AST REWRITE
            // elements: template, ids
            // token labels: 
            // rule labels: retval
            // token list labels: ids
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleTokenStream stream_ids=new RewriteRuleTokenStream(adaptor,"token ids", list_ids);
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 95:3: -> ^( SUBTEMPLATE[$lc,\"SUBTEMPLATE\"] ( ^( ARGS $ids) )* template )
            {
                // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:95:6: ^( SUBTEMPLATE[$lc,\"SUBTEMPLATE\"] ( ^( ARGS $ids) )* template )
                {
                CommonTree root_1 = (CommonTree)adaptor.nil();
                root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(SUBTEMPLATE, lc, "SUBTEMPLATE"), root_1);

                // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:95:39: ( ^( ARGS $ids) )*
                while ( stream_ids.hasNext() ) {
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:95:39: ^( ARGS $ids)
                    {
                    CommonTree root_2 = (CommonTree)adaptor.nil();
                    root_2 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(ARGS, "ARGS"), root_2);

                    adaptor.addChild(root_2, stream_ids.nextNode());

                    adaptor.addChild(root_1, root_2);
                    }

                }
                stream_ids.reset();
                adaptor.addChild(root_1, stream_template.nextTree());

                adaptor.addChild(root_0, root_1);
                }

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "subtemplate"

    public static class ifstat_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "ifstat"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:98:1: ifstat : LDELIM 'if' '(' c1= conditional ')' RDELIM t1= template ( ( INDENT )? LDELIM 'elseif' '(' c2+= conditional ')' RDELIM t2+= template )* ( ( INDENT )? LDELIM 'else' RDELIM t3= template )? ( INDENT )? endif= LDELIM 'endif' RDELIM ({...}? => NEWLINE )? -> ^( 'if' $c1 ( $t1)? ( ^( 'elseif' $c2 $t2) )* ( ^( 'else' ( $t3)? ) )? ) ;
    public final STParser.ifstat_return ifstat() throws RecognitionException {
        STParser.ifstat_return retval = new STParser.ifstat_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        CommonToken endif=null;
        CommonToken LDELIM30=null;
        CommonToken string_literal31=null;
        CommonToken char_literal32=null;
        CommonToken char_literal33=null;
        CommonToken RDELIM34=null;
        CommonToken INDENT35=null;
        CommonToken LDELIM36=null;
        CommonToken string_literal37=null;
        CommonToken char_literal38=null;
        CommonToken char_literal39=null;
        CommonToken RDELIM40=null;
        CommonToken INDENT41=null;
        CommonToken LDELIM42=null;
        CommonToken string_literal43=null;
        CommonToken RDELIM44=null;
        CommonToken INDENT45=null;
        CommonToken string_literal46=null;
        CommonToken RDELIM47=null;
        CommonToken NEWLINE48=null;
        List list_c2=null;
        List list_t2=null;
        STParser.conditional_return c1 = null;

        STParser.template_return t1 = null;

        STParser.template_return t3 = null;

        RuleReturnScope c2 = null;
        RuleReturnScope t2 = null;
        CommonTree endif_tree=null;
        CommonTree LDELIM30_tree=null;
        CommonTree string_literal31_tree=null;
        CommonTree char_literal32_tree=null;
        CommonTree char_literal33_tree=null;
        CommonTree RDELIM34_tree=null;
        CommonTree INDENT35_tree=null;
        CommonTree LDELIM36_tree=null;
        CommonTree string_literal37_tree=null;
        CommonTree char_literal38_tree=null;
        CommonTree char_literal39_tree=null;
        CommonTree RDELIM40_tree=null;
        CommonTree INDENT41_tree=null;
        CommonTree LDELIM42_tree=null;
        CommonTree string_literal43_tree=null;
        CommonTree RDELIM44_tree=null;
        CommonTree INDENT45_tree=null;
        CommonTree string_literal46_tree=null;
        CommonTree RDELIM47_tree=null;
        CommonTree NEWLINE48_tree=null;
        RewriteRuleTokenStream stream_ENDIF=new RewriteRuleTokenStream(adaptor,"token ENDIF");
        RewriteRuleTokenStream stream_RDELIM=new RewriteRuleTokenStream(adaptor,"token RDELIM");
        RewriteRuleTokenStream stream_RPAREN=new RewriteRuleTokenStream(adaptor,"token RPAREN");
        RewriteRuleTokenStream stream_NEWLINE=new RewriteRuleTokenStream(adaptor,"token NEWLINE");
        RewriteRuleTokenStream stream_LDELIM=new RewriteRuleTokenStream(adaptor,"token LDELIM");
        RewriteRuleTokenStream stream_INDENT=new RewriteRuleTokenStream(adaptor,"token INDENT");
        RewriteRuleTokenStream stream_LPAREN=new RewriteRuleTokenStream(adaptor,"token LPAREN");
        RewriteRuleTokenStream stream_IF=new RewriteRuleTokenStream(adaptor,"token IF");
        RewriteRuleTokenStream stream_ELSE=new RewriteRuleTokenStream(adaptor,"token ELSE");
        RewriteRuleTokenStream stream_ELSEIF=new RewriteRuleTokenStream(adaptor,"token ELSEIF");
        RewriteRuleSubtreeStream stream_template=new RewriteRuleSubtreeStream(adaptor,"rule template");
        RewriteRuleSubtreeStream stream_conditional=new RewriteRuleSubtreeStream(adaptor,"rule conditional");
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:99:2: ( LDELIM 'if' '(' c1= conditional ')' RDELIM t1= template ( ( INDENT )? LDELIM 'elseif' '(' c2+= conditional ')' RDELIM t2+= template )* ( ( INDENT )? LDELIM 'else' RDELIM t3= template )? ( INDENT )? endif= LDELIM 'endif' RDELIM ({...}? => NEWLINE )? -> ^( 'if' $c1 ( $t1)? ( ^( 'elseif' $c2 $t2) )* ( ^( 'else' ( $t3)? ) )? ) )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:99:4: LDELIM 'if' '(' c1= conditional ')' RDELIM t1= template ( ( INDENT )? LDELIM 'elseif' '(' c2+= conditional ')' RDELIM t2+= template )* ( ( INDENT )? LDELIM 'else' RDELIM t3= template )? ( INDENT )? endif= LDELIM 'endif' RDELIM ({...}? => NEWLINE )?
            {
            LDELIM30=(CommonToken)match(input,LDELIM,FOLLOW_LDELIM_in_ifstat349);  
            stream_LDELIM.add(LDELIM30);

            string_literal31=(CommonToken)match(input,IF,FOLLOW_IF_in_ifstat351);  
            stream_IF.add(string_literal31);

            char_literal32=(CommonToken)match(input,LPAREN,FOLLOW_LPAREN_in_ifstat353);  
            stream_LPAREN.add(char_literal32);

            pushFollow(FOLLOW_conditional_in_ifstat357);
            c1=conditional();

            state._fsp--;

            stream_conditional.add(c1.getTree());
            char_literal33=(CommonToken)match(input,RPAREN,FOLLOW_RPAREN_in_ifstat359);  
            stream_RPAREN.add(char_literal33);

            RDELIM34=(CommonToken)match(input,RDELIM,FOLLOW_RDELIM_in_ifstat361);  
            stream_RDELIM.add(RDELIM34);

            pushFollow(FOLLOW_template_in_ifstat368);
            t1=template();

            state._fsp--;

            stream_template.add(t1.getTree());
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:101:4: ( ( INDENT )? LDELIM 'elseif' '(' c2+= conditional ')' RDELIM t2+= template )*
            loop8:
            do {
                int alt8=2;
                int LA8_0 = input.LA(1);

                if ( (LA8_0==INDENT) ) {
                    int LA8_1 = input.LA(2);

                    if ( (LA8_1==LDELIM) ) {
                        int LA8_2 = input.LA(3);

                        if ( (LA8_2==ELSEIF) ) {
                            alt8=1;
                        }


                    }


                }
                else if ( (LA8_0==LDELIM) ) {
                    int LA8_2 = input.LA(2);

                    if ( (LA8_2==ELSEIF) ) {
                        alt8=1;
                    }


                }


                switch (alt8) {
            	case 1 :
            	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:101:6: ( INDENT )? LDELIM 'elseif' '(' c2+= conditional ')' RDELIM t2+= template
            	    {
            	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:101:6: ( INDENT )?
            	    int alt7=2;
            	    int LA7_0 = input.LA(1);

            	    if ( (LA7_0==INDENT) ) {
            	        alt7=1;
            	    }
            	    switch (alt7) {
            	        case 1 :
            	            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:101:6: INDENT
            	            {
            	            INDENT35=(CommonToken)match(input,INDENT,FOLLOW_INDENT_in_ifstat375);  
            	            stream_INDENT.add(INDENT35);


            	            }
            	            break;

            	    }

            	    LDELIM36=(CommonToken)match(input,LDELIM,FOLLOW_LDELIM_in_ifstat378);  
            	    stream_LDELIM.add(LDELIM36);

            	    string_literal37=(CommonToken)match(input,ELSEIF,FOLLOW_ELSEIF_in_ifstat380);  
            	    stream_ELSEIF.add(string_literal37);

            	    char_literal38=(CommonToken)match(input,LPAREN,FOLLOW_LPAREN_in_ifstat382);  
            	    stream_LPAREN.add(char_literal38);

            	    pushFollow(FOLLOW_conditional_in_ifstat386);
            	    c2=conditional();

            	    state._fsp--;

            	    stream_conditional.add(c2.getTree());
            	    if (list_c2==null) list_c2=new ArrayList();
            	    list_c2.add(c2.getTree());

            	    char_literal39=(CommonToken)match(input,RPAREN,FOLLOW_RPAREN_in_ifstat388);  
            	    stream_RPAREN.add(char_literal39);

            	    RDELIM40=(CommonToken)match(input,RDELIM,FOLLOW_RDELIM_in_ifstat390);  
            	    stream_RDELIM.add(RDELIM40);

            	    pushFollow(FOLLOW_template_in_ifstat394);
            	    t2=template();

            	    state._fsp--;

            	    stream_template.add(t2.getTree());
            	    if (list_t2==null) list_t2=new ArrayList();
            	    list_t2.add(t2.getTree());


            	    }
            	    break;

            	default :
            	    break loop8;
                }
            } while (true);

            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:102:4: ( ( INDENT )? LDELIM 'else' RDELIM t3= template )?
            int alt10=2;
            int LA10_0 = input.LA(1);

            if ( (LA10_0==INDENT) ) {
                int LA10_1 = input.LA(2);

                if ( (LA10_1==LDELIM) ) {
                    int LA10_2 = input.LA(3);

                    if ( (LA10_2==ELSE) ) {
                        alt10=1;
                    }
                }
            }
            else if ( (LA10_0==LDELIM) ) {
                int LA10_2 = input.LA(2);

                if ( (LA10_2==ELSE) ) {
                    alt10=1;
                }
            }
            switch (alt10) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:102:6: ( INDENT )? LDELIM 'else' RDELIM t3= template
                    {
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:102:6: ( INDENT )?
                    int alt9=2;
                    int LA9_0 = input.LA(1);

                    if ( (LA9_0==INDENT) ) {
                        alt9=1;
                    }
                    switch (alt9) {
                        case 1 :
                            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:102:6: INDENT
                            {
                            INDENT41=(CommonToken)match(input,INDENT,FOLLOW_INDENT_in_ifstat404);  
                            stream_INDENT.add(INDENT41);


                            }
                            break;

                    }

                    LDELIM42=(CommonToken)match(input,LDELIM,FOLLOW_LDELIM_in_ifstat407);  
                    stream_LDELIM.add(LDELIM42);

                    string_literal43=(CommonToken)match(input,ELSE,FOLLOW_ELSE_in_ifstat409);  
                    stream_ELSE.add(string_literal43);

                    RDELIM44=(CommonToken)match(input,RDELIM,FOLLOW_RDELIM_in_ifstat411);  
                    stream_RDELIM.add(RDELIM44);

                    pushFollow(FOLLOW_template_in_ifstat415);
                    t3=template();

                    state._fsp--;

                    stream_template.add(t3.getTree());

                    }
                    break;

            }

            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:103:4: ( INDENT )?
            int alt11=2;
            int LA11_0 = input.LA(1);

            if ( (LA11_0==INDENT) ) {
                alt11=1;
            }
            switch (alt11) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:103:4: INDENT
                    {
                    INDENT45=(CommonToken)match(input,INDENT,FOLLOW_INDENT_in_ifstat423);  
                    stream_INDENT.add(INDENT45);


                    }
                    break;

            }

            endif=(CommonToken)match(input,LDELIM,FOLLOW_LDELIM_in_ifstat429);  
            stream_LDELIM.add(endif);

            string_literal46=(CommonToken)match(input,ENDIF,FOLLOW_ENDIF_in_ifstat431);  
            stream_ENDIF.add(string_literal46);

            RDELIM47=(CommonToken)match(input,RDELIM,FOLLOW_RDELIM_in_ifstat435);  
            stream_RDELIM.add(RDELIM47);

            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:106:3: ({...}? => NEWLINE )?
            int alt12=2;
            int LA12_0 = input.LA(1);

            if ( (LA12_0==NEWLINE) ) {
                int LA12_1 = input.LA(2);

                if ( ((((CommonToken)retval.start).getLine()!=input.LT(1).getLine())) ) {
                    alt12=1;
                }
            }
            switch (alt12) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:106:4: {...}? => NEWLINE
                    {
                    if ( !((((CommonToken)retval.start).getLine()!=input.LT(1).getLine())) ) {
                        throw new FailedPredicateException(input, "ifstat", "$ifstat.start.getLine()!=input.LT(1).getLine()");
                    }
                    NEWLINE48=(CommonToken)match(input,NEWLINE,FOLLOW_NEWLINE_in_ifstat446);  
                    stream_NEWLINE.add(NEWLINE48);


                    }
                    break;

            }



            // AST REWRITE
            // elements: t1, c1, c2, t3, IF, ELSEIF, ELSE, t2
            // token labels: 
            // rule labels: t3, retval, t1, c1
            // token list labels: 
            // rule list labels: t2, c2
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_t3=new RewriteRuleSubtreeStream(adaptor,"rule t3",t3!=null?t3.tree:null);
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);
            RewriteRuleSubtreeStream stream_t1=new RewriteRuleSubtreeStream(adaptor,"rule t1",t1!=null?t1.tree:null);
            RewriteRuleSubtreeStream stream_c1=new RewriteRuleSubtreeStream(adaptor,"rule c1",c1!=null?c1.tree:null);
            RewriteRuleSubtreeStream stream_t2=new RewriteRuleSubtreeStream(adaptor,"token t2",list_t2);
            RewriteRuleSubtreeStream stream_c2=new RewriteRuleSubtreeStream(adaptor,"token c2",list_c2);
            root_0 = (CommonTree)adaptor.nil();
            // 107:3: -> ^( 'if' $c1 ( $t1)? ( ^( 'elseif' $c2 $t2) )* ( ^( 'else' ( $t3)? ) )? )
            {
                // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:107:6: ^( 'if' $c1 ( $t1)? ( ^( 'elseif' $c2 $t2) )* ( ^( 'else' ( $t3)? ) )? )
                {
                CommonTree root_1 = (CommonTree)adaptor.nil();
                root_1 = (CommonTree)adaptor.becomeRoot(stream_IF.nextNode(), root_1);

                adaptor.addChild(root_1, stream_c1.nextTree());
                // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:107:17: ( $t1)?
                if ( stream_t1.hasNext() ) {
                    adaptor.addChild(root_1, stream_t1.nextTree());

                }
                stream_t1.reset();
                // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:107:22: ( ^( 'elseif' $c2 $t2) )*
                while ( stream_c2.hasNext()||stream_ELSEIF.hasNext()||stream_t2.hasNext() ) {
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:107:22: ^( 'elseif' $c2 $t2)
                    {
                    CommonTree root_2 = (CommonTree)adaptor.nil();
                    root_2 = (CommonTree)adaptor.becomeRoot(stream_ELSEIF.nextNode(), root_2);

                    adaptor.addChild(root_2, stream_c2.nextTree());
                    adaptor.addChild(root_2, stream_t2.nextTree());

                    adaptor.addChild(root_1, root_2);
                    }

                }
                stream_c2.reset();
                stream_ELSEIF.reset();
                stream_t2.reset();
                // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:107:43: ( ^( 'else' ( $t3)? ) )?
                if ( stream_t3.hasNext()||stream_ELSE.hasNext() ) {
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:107:43: ^( 'else' ( $t3)? )
                    {
                    CommonTree root_2 = (CommonTree)adaptor.nil();
                    root_2 = (CommonTree)adaptor.becomeRoot(stream_ELSE.nextNode(), root_2);

                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:107:52: ( $t3)?
                    if ( stream_t3.hasNext() ) {
                        adaptor.addChild(root_2, stream_t3.nextTree());

                    }
                    stream_t3.reset();

                    adaptor.addChild(root_1, root_2);
                    }

                }
                stream_t3.reset();
                stream_ELSE.reset();

                adaptor.addChild(root_0, root_1);
                }

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "ifstat"

    public static class conditional_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "conditional"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:110:1: conditional : andConditional ( '||' andConditional )* ;
    public final STParser.conditional_return conditional() throws RecognitionException {
        STParser.conditional_return retval = new STParser.conditional_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        CommonToken string_literal50=null;
        STParser.andConditional_return andConditional49 = null;

        STParser.andConditional_return andConditional51 = null;


        CommonTree string_literal50_tree=null;

        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:110:13: ( andConditional ( '||' andConditional )* )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:110:15: andConditional ( '||' andConditional )*
            {
            root_0 = (CommonTree)adaptor.nil();

            pushFollow(FOLLOW_andConditional_in_conditional493);
            andConditional49=andConditional();

            state._fsp--;

            adaptor.addChild(root_0, andConditional49.getTree());
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:110:30: ( '||' andConditional )*
            loop13:
            do {
                int alt13=2;
                int LA13_0 = input.LA(1);

                if ( (LA13_0==OR) ) {
                    alt13=1;
                }


                switch (alt13) {
            	case 1 :
            	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:110:32: '||' andConditional
            	    {
            	    string_literal50=(CommonToken)match(input,OR,FOLLOW_OR_in_conditional497); 
            	    string_literal50_tree = (CommonTree)adaptor.create(string_literal50);
            	    root_0 = (CommonTree)adaptor.becomeRoot(string_literal50_tree, root_0);

            	    pushFollow(FOLLOW_andConditional_in_conditional500);
            	    andConditional51=andConditional();

            	    state._fsp--;

            	    adaptor.addChild(root_0, andConditional51.getTree());

            	    }
            	    break;

            	default :
            	    break loop13;
                }
            } while (true);


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "conditional"

    public static class andConditional_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "andConditional"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:112:1: andConditional : notConditional ( '&&' notConditional )* ;
    public final STParser.andConditional_return andConditional() throws RecognitionException {
        STParser.andConditional_return retval = new STParser.andConditional_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        CommonToken string_literal53=null;
        STParser.notConditional_return notConditional52 = null;

        STParser.notConditional_return notConditional54 = null;


        CommonTree string_literal53_tree=null;

        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:112:16: ( notConditional ( '&&' notConditional )* )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:112:18: notConditional ( '&&' notConditional )*
            {
            root_0 = (CommonTree)adaptor.nil();

            pushFollow(FOLLOW_notConditional_in_andConditional512);
            notConditional52=notConditional();

            state._fsp--;

            adaptor.addChild(root_0, notConditional52.getTree());
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:112:33: ( '&&' notConditional )*
            loop14:
            do {
                int alt14=2;
                int LA14_0 = input.LA(1);

                if ( (LA14_0==AND) ) {
                    alt14=1;
                }


                switch (alt14) {
            	case 1 :
            	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:112:35: '&&' notConditional
            	    {
            	    string_literal53=(CommonToken)match(input,AND,FOLLOW_AND_in_andConditional516); 
            	    string_literal53_tree = (CommonTree)adaptor.create(string_literal53);
            	    root_0 = (CommonTree)adaptor.becomeRoot(string_literal53_tree, root_0);

            	    pushFollow(FOLLOW_notConditional_in_andConditional519);
            	    notConditional54=notConditional();

            	    state._fsp--;

            	    adaptor.addChild(root_0, notConditional54.getTree());

            	    }
            	    break;

            	default :
            	    break loop14;
                }
            } while (true);


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "andConditional"

    public static class notConditional_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "notConditional"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:114:1: notConditional : ( '!' notConditionalExpr | '!' '(' conditional ')' | memberExpr ) ;
    public final STParser.notConditional_return notConditional() throws RecognitionException {
        STParser.notConditional_return retval = new STParser.notConditional_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        CommonToken char_literal55=null;
        CommonToken char_literal57=null;
        CommonToken char_literal58=null;
        CommonToken char_literal60=null;
        STParser.notConditionalExpr_return notConditionalExpr56 = null;

        STParser.conditional_return conditional59 = null;

        STParser.memberExpr_return memberExpr61 = null;


        CommonTree char_literal55_tree=null;
        CommonTree char_literal57_tree=null;
        CommonTree char_literal58_tree=null;
        CommonTree char_literal60_tree=null;

        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:114:16: ( ( '!' notConditionalExpr | '!' '(' conditional ')' | memberExpr ) )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:114:18: ( '!' notConditionalExpr | '!' '(' conditional ')' | memberExpr )
            {
            root_0 = (CommonTree)adaptor.nil();

            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:114:18: ( '!' notConditionalExpr | '!' '(' conditional ')' | memberExpr )
            int alt15=3;
            int LA15_0 = input.LA(1);

            if ( (LA15_0==BANG) ) {
                int LA15_1 = input.LA(2);

                if ( (LA15_1==LPAREN) ) {
                    alt15=2;
                }
                else if ( (LA15_1==ID) ) {
                    alt15=1;
                }
                else {
                    NoViableAltException nvae =
                        new NoViableAltException("", 15, 1, input);

                    throw nvae;
                }
            }
            else if ( (LA15_0==SUPER||LA15_0==LPAREN||LA15_0==LBRACK||LA15_0==LCURLY||(LA15_0>=ID && LA15_0<=STRING)||LA15_0==AT) ) {
                alt15=3;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 15, 0, input);

                throw nvae;
            }
            switch (alt15) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:114:20: '!' notConditionalExpr
                    {
                    char_literal55=(CommonToken)match(input,BANG,FOLLOW_BANG_in_notConditional533); 
                    char_literal55_tree = (CommonTree)adaptor.create(char_literal55);
                    root_0 = (CommonTree)adaptor.becomeRoot(char_literal55_tree, root_0);

                    pushFollow(FOLLOW_notConditionalExpr_in_notConditional536);
                    notConditionalExpr56=notConditionalExpr();

                    state._fsp--;

                    adaptor.addChild(root_0, notConditionalExpr56.getTree());

                    }
                    break;
                case 2 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:114:46: '!' '(' conditional ')'
                    {
                    char_literal57=(CommonToken)match(input,BANG,FOLLOW_BANG_in_notConditional540); 
                    char_literal57_tree = (CommonTree)adaptor.create(char_literal57);
                    root_0 = (CommonTree)adaptor.becomeRoot(char_literal57_tree, root_0);

                    char_literal58=(CommonToken)match(input,LPAREN,FOLLOW_LPAREN_in_notConditional543); 
                    pushFollow(FOLLOW_conditional_in_notConditional546);
                    conditional59=conditional();

                    state._fsp--;

                    adaptor.addChild(root_0, conditional59.getTree());
                    char_literal60=(CommonToken)match(input,RPAREN,FOLLOW_RPAREN_in_notConditional548); 

                    }
                    break;
                case 3 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:114:75: memberExpr
                    {
                    pushFollow(FOLLOW_memberExpr_in_notConditional553);
                    memberExpr61=memberExpr();

                    state._fsp--;

                    adaptor.addChild(root_0, memberExpr61.getTree());

                    }
                    break;

            }


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "notConditional"

    public static class notConditionalExpr_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "notConditionalExpr"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:116:1: notConditionalExpr : ( ID -> ID ) (p= '.' prop= ID -> ^( PROP[$p,\"PROP\"] $notConditionalExpr $prop) | p= '.' '(' mapExpr ')' -> ^( PROP_IND[$p,\"PROP_IND\"] $notConditionalExpr mapExpr ) )* ;
    public final STParser.notConditionalExpr_return notConditionalExpr() throws RecognitionException {
        STParser.notConditionalExpr_return retval = new STParser.notConditionalExpr_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        CommonToken p=null;
        CommonToken prop=null;
        CommonToken ID62=null;
        CommonToken char_literal63=null;
        CommonToken char_literal65=null;
        STParser.mapExpr_return mapExpr64 = null;


        CommonTree p_tree=null;
        CommonTree prop_tree=null;
        CommonTree ID62_tree=null;
        CommonTree char_literal63_tree=null;
        CommonTree char_literal65_tree=null;
        RewriteRuleTokenStream stream_RPAREN=new RewriteRuleTokenStream(adaptor,"token RPAREN");
        RewriteRuleTokenStream stream_DOT=new RewriteRuleTokenStream(adaptor,"token DOT");
        RewriteRuleTokenStream stream_ID=new RewriteRuleTokenStream(adaptor,"token ID");
        RewriteRuleTokenStream stream_LPAREN=new RewriteRuleTokenStream(adaptor,"token LPAREN");
        RewriteRuleSubtreeStream stream_mapExpr=new RewriteRuleSubtreeStream(adaptor,"rule mapExpr");
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:117:2: ( ( ID -> ID ) (p= '.' prop= ID -> ^( PROP[$p,\"PROP\"] $notConditionalExpr $prop) | p= '.' '(' mapExpr ')' -> ^( PROP_IND[$p,\"PROP_IND\"] $notConditionalExpr mapExpr ) )* )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:117:4: ( ID -> ID ) (p= '.' prop= ID -> ^( PROP[$p,\"PROP\"] $notConditionalExpr $prop) | p= '.' '(' mapExpr ')' -> ^( PROP_IND[$p,\"PROP_IND\"] $notConditionalExpr mapExpr ) )*
            {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:117:4: ( ID -> ID )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:117:5: ID
            {
            ID62=(CommonToken)match(input,ID,FOLLOW_ID_in_notConditionalExpr565);  
            stream_ID.add(ID62);



            // AST REWRITE
            // elements: ID
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 117:7: -> ID
            {
                adaptor.addChild(root_0, stream_ID.nextNode());

            }

            retval.tree = root_0;
            }

            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:118:3: (p= '.' prop= ID -> ^( PROP[$p,\"PROP\"] $notConditionalExpr $prop) | p= '.' '(' mapExpr ')' -> ^( PROP_IND[$p,\"PROP_IND\"] $notConditionalExpr mapExpr ) )*
            loop16:
            do {
                int alt16=3;
                int LA16_0 = input.LA(1);

                if ( (LA16_0==DOT) ) {
                    int LA16_2 = input.LA(2);

                    if ( (LA16_2==ID) ) {
                        alt16=1;
                    }
                    else if ( (LA16_2==LPAREN) ) {
                        alt16=2;
                    }


                }


                switch (alt16) {
            	case 1 :
            	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:118:5: p= '.' prop= ID
            	    {
            	    p=(CommonToken)match(input,DOT,FOLLOW_DOT_in_notConditionalExpr576);  
            	    stream_DOT.add(p);

            	    prop=(CommonToken)match(input,ID,FOLLOW_ID_in_notConditionalExpr580);  
            	    stream_ID.add(prop);



            	    // AST REWRITE
            	    // elements: prop, notConditionalExpr
            	    // token labels: prop
            	    // rule labels: retval
            	    // token list labels: 
            	    // rule list labels: 
            	    // wildcard labels: 
            	    retval.tree = root_0;
            	    RewriteRuleTokenStream stream_prop=new RewriteRuleTokenStream(adaptor,"token prop",prop);
            	    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            	    root_0 = (CommonTree)adaptor.nil();
            	    // 118:24: -> ^( PROP[$p,\"PROP\"] $notConditionalExpr $prop)
            	    {
            	        // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:118:27: ^( PROP[$p,\"PROP\"] $notConditionalExpr $prop)
            	        {
            	        CommonTree root_1 = (CommonTree)adaptor.nil();
            	        root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(PROP, p, "PROP"), root_1);

            	        adaptor.addChild(root_1, stream_retval.nextTree());
            	        adaptor.addChild(root_1, stream_prop.nextNode());

            	        adaptor.addChild(root_0, root_1);
            	        }

            	    }

            	    retval.tree = root_0;
            	    }
            	    break;
            	case 2 :
            	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:119:5: p= '.' '(' mapExpr ')'
            	    {
            	    p=(CommonToken)match(input,DOT,FOLLOW_DOT_in_notConditionalExpr606);  
            	    stream_DOT.add(p);

            	    char_literal63=(CommonToken)match(input,LPAREN,FOLLOW_LPAREN_in_notConditionalExpr608);  
            	    stream_LPAREN.add(char_literal63);

            	    pushFollow(FOLLOW_mapExpr_in_notConditionalExpr610);
            	    mapExpr64=mapExpr();

            	    state._fsp--;

            	    stream_mapExpr.add(mapExpr64.getTree());
            	    char_literal65=(CommonToken)match(input,RPAREN,FOLLOW_RPAREN_in_notConditionalExpr612);  
            	    stream_RPAREN.add(char_literal65);



            	    // AST REWRITE
            	    // elements: mapExpr, notConditionalExpr
            	    // token labels: 
            	    // rule labels: retval
            	    // token list labels: 
            	    // rule list labels: 
            	    // wildcard labels: 
            	    retval.tree = root_0;
            	    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            	    root_0 = (CommonTree)adaptor.nil();
            	    // 119:30: -> ^( PROP_IND[$p,\"PROP_IND\"] $notConditionalExpr mapExpr )
            	    {
            	        // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:119:33: ^( PROP_IND[$p,\"PROP_IND\"] $notConditionalExpr mapExpr )
            	        {
            	        CommonTree root_1 = (CommonTree)adaptor.nil();
            	        root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(PROP_IND, p, "PROP_IND"), root_1);

            	        adaptor.addChild(root_1, stream_retval.nextTree());
            	        adaptor.addChild(root_1, stream_mapExpr.nextTree());

            	        adaptor.addChild(root_0, root_1);
            	        }

            	    }

            	    retval.tree = root_0;
            	    }
            	    break;

            	default :
            	    break loop16;
                }
            } while (true);


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "notConditionalExpr"

    public static class exprOptions_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "exprOptions"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:123:1: exprOptions : option ( ',' option )* -> ^( OPTIONS ( option )* ) ;
    public final STParser.exprOptions_return exprOptions() throws RecognitionException {
        STParser.exprOptions_return retval = new STParser.exprOptions_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        CommonToken char_literal67=null;
        STParser.option_return option66 = null;

        STParser.option_return option68 = null;


        CommonTree char_literal67_tree=null;
        RewriteRuleTokenStream stream_COMMA=new RewriteRuleTokenStream(adaptor,"token COMMA");
        RewriteRuleSubtreeStream stream_option=new RewriteRuleSubtreeStream(adaptor,"rule option");
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:123:13: ( option ( ',' option )* -> ^( OPTIONS ( option )* ) )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:123:15: option ( ',' option )*
            {
            pushFollow(FOLLOW_option_in_exprOptions642);
            option66=option();

            state._fsp--;

            stream_option.add(option66.getTree());
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:123:22: ( ',' option )*
            loop17:
            do {
                int alt17=2;
                int LA17_0 = input.LA(1);

                if ( (LA17_0==COMMA) ) {
                    alt17=1;
                }


                switch (alt17) {
            	case 1 :
            	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:123:24: ',' option
            	    {
            	    char_literal67=(CommonToken)match(input,COMMA,FOLLOW_COMMA_in_exprOptions646);  
            	    stream_COMMA.add(char_literal67);

            	    pushFollow(FOLLOW_option_in_exprOptions648);
            	    option68=option();

            	    state._fsp--;

            	    stream_option.add(option68.getTree());

            	    }
            	    break;

            	default :
            	    break loop17;
                }
            } while (true);



            // AST REWRITE
            // elements: option
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 123:38: -> ^( OPTIONS ( option )* )
            {
                // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:123:41: ^( OPTIONS ( option )* )
                {
                CommonTree root_1 = (CommonTree)adaptor.nil();
                root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(OPTIONS, "OPTIONS"), root_1);

                // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:123:51: ( option )*
                while ( stream_option.hasNext() ) {
                    adaptor.addChild(root_1, stream_option.nextTree());

                }
                stream_option.reset();

                adaptor.addChild(root_0, root_1);
                }

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "exprOptions"

    public static class option_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "option"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:125:1: option : ID ( '=' exprNoComma -> {validOption}? ^( '=' ID exprNoComma ) -> | -> {validOption&&defVal!=null}? ^( EQUALS[\"=\"] ID STRING[$ID,'\"'+defVal+'\"'] ) ->) ;
    public final STParser.option_return option() throws RecognitionException {
        STParser.option_return retval = new STParser.option_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        CommonToken ID69=null;
        CommonToken char_literal70=null;
        STParser.exprNoComma_return exprNoComma71 = null;


        CommonTree ID69_tree=null;
        CommonTree char_literal70_tree=null;
        RewriteRuleTokenStream stream_EQUALS=new RewriteRuleTokenStream(adaptor,"token EQUALS");
        RewriteRuleTokenStream stream_ID=new RewriteRuleTokenStream(adaptor,"token ID");
        RewriteRuleSubtreeStream stream_exprNoComma=new RewriteRuleSubtreeStream(adaptor,"rule exprNoComma");

        	String id = input.LT(1).getText();
        	String defVal = Compiler.defaultOptionValues.get(id);
        	boolean validOption = Compiler.supportedOptions.get(id)!=null;

        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:131:2: ( ID ( '=' exprNoComma -> {validOption}? ^( '=' ID exprNoComma ) -> | -> {validOption&&defVal!=null}? ^( EQUALS[\"=\"] ID STRING[$ID,'\"'+defVal+'\"'] ) ->) )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:131:4: ID ( '=' exprNoComma -> {validOption}? ^( '=' ID exprNoComma ) -> | -> {validOption&&defVal!=null}? ^( EQUALS[\"=\"] ID STRING[$ID,'\"'+defVal+'\"'] ) ->)
            {
            ID69=(CommonToken)match(input,ID,FOLLOW_ID_in_option675);  
            stream_ID.add(ID69);


            		if ( !validOption ) {
                        errMgr.compileTimeError(ErrorType.NO_SUCH_OPTION, templateToken, ID69, (ID69!=null?ID69.getText():null));
            		}
            		
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:137:3: ( '=' exprNoComma -> {validOption}? ^( '=' ID exprNoComma ) -> | -> {validOption&&defVal!=null}? ^( EQUALS[\"=\"] ID STRING[$ID,'\"'+defVal+'\"'] ) ->)
            int alt18=2;
            int LA18_0 = input.LA(1);

            if ( (LA18_0==EQUALS) ) {
                alt18=1;
            }
            else if ( (LA18_0==COMMA||LA18_0==RDELIM) ) {
                alt18=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 18, 0, input);

                throw nvae;
            }
            switch (alt18) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:137:5: '=' exprNoComma
                    {
                    char_literal70=(CommonToken)match(input,EQUALS,FOLLOW_EQUALS_in_option685);  
                    stream_EQUALS.add(char_literal70);

                    pushFollow(FOLLOW_exprNoComma_in_option687);
                    exprNoComma71=exprNoComma();

                    state._fsp--;

                    stream_exprNoComma.add(exprNoComma71.getTree());


                    // AST REWRITE
                    // elements: exprNoComma, ID, EQUALS
                    // token labels: 
                    // rule labels: retval
                    // token list labels: 
                    // rule list labels: 
                    // wildcard labels: 
                    retval.tree = root_0;
                    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

                    root_0 = (CommonTree)adaptor.nil();
                    // 137:26: -> {validOption}? ^( '=' ID exprNoComma )
                    if (validOption) {
                        // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:137:44: ^( '=' ID exprNoComma )
                        {
                        CommonTree root_1 = (CommonTree)adaptor.nil();
                        root_1 = (CommonTree)adaptor.becomeRoot(stream_EQUALS.nextNode(), root_1);

                        adaptor.addChild(root_1, stream_ID.nextNode());
                        adaptor.addChild(root_1, stream_exprNoComma.nextTree());

                        adaptor.addChild(root_0, root_1);
                        }

                    }
                    else // 138:13: ->
                    {
                        root_0 = null;
                    }

                    retval.tree = root_0;
                    }
                    break;
                case 2 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:139:5: 
                    {

                    			if ( defVal==null ) {
                    				errMgr.compileTimeError(ErrorType.NO_DEFAULT_VALUE, templateToken, ID69);
                    			}
                    			


                    // AST REWRITE
                    // elements: ID
                    // token labels: 
                    // rule labels: retval
                    // token list labels: 
                    // rule list labels: 
                    // wildcard labels: 
                    retval.tree = root_0;
                    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

                    root_0 = (CommonTree)adaptor.nil();
                    // 144:13: -> {validOption&&defVal!=null}? ^( EQUALS[\"=\"] ID STRING[$ID,'\"'+defVal+'\"'] )
                    if (validOption&&defVal!=null) {
                        // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:145:16: ^( EQUALS[\"=\"] ID STRING[$ID,'\"'+defVal+'\"'] )
                        {
                        CommonTree root_1 = (CommonTree)adaptor.nil();
                        root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(EQUALS, "="), root_1);

                        adaptor.addChild(root_1, stream_ID.nextNode());
                        adaptor.addChild(root_1, (CommonTree)adaptor.create(STRING, ID69, '"'+defVal+'"'));

                        adaptor.addChild(root_0, root_1);
                        }

                    }
                    else // 146:13: ->
                    {
                        root_0 = null;
                    }

                    retval.tree = root_0;
                    }
                    break;

            }


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "option"

    public static class exprNoComma_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "exprNoComma"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:150:1: exprNoComma : memberExpr ( ':' mapTemplateRef -> ^( MAP memberExpr mapTemplateRef ) | -> memberExpr ) ;
    public final STParser.exprNoComma_return exprNoComma() throws RecognitionException {
        STParser.exprNoComma_return retval = new STParser.exprNoComma_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        CommonToken char_literal73=null;
        STParser.memberExpr_return memberExpr72 = null;

        STParser.mapTemplateRef_return mapTemplateRef74 = null;


        CommonTree char_literal73_tree=null;
        RewriteRuleTokenStream stream_COLON=new RewriteRuleTokenStream(adaptor,"token COLON");
        RewriteRuleSubtreeStream stream_memberExpr=new RewriteRuleSubtreeStream(adaptor,"rule memberExpr");
        RewriteRuleSubtreeStream stream_mapTemplateRef=new RewriteRuleSubtreeStream(adaptor,"rule mapTemplateRef");
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:151:2: ( memberExpr ( ':' mapTemplateRef -> ^( MAP memberExpr mapTemplateRef ) | -> memberExpr ) )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:151:4: memberExpr ( ':' mapTemplateRef -> ^( MAP memberExpr mapTemplateRef ) | -> memberExpr )
            {
            pushFollow(FOLLOW_memberExpr_in_exprNoComma794);
            memberExpr72=memberExpr();

            state._fsp--;

            stream_memberExpr.add(memberExpr72.getTree());
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:152:3: ( ':' mapTemplateRef -> ^( MAP memberExpr mapTemplateRef ) | -> memberExpr )
            int alt19=2;
            int LA19_0 = input.LA(1);

            if ( (LA19_0==COLON) ) {
                alt19=1;
            }
            else if ( (LA19_0==RPAREN||(LA19_0>=RBRACK && LA19_0<=COMMA)||LA19_0==RDELIM) ) {
                alt19=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 19, 0, input);

                throw nvae;
            }
            switch (alt19) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:152:5: ':' mapTemplateRef
                    {
                    char_literal73=(CommonToken)match(input,COLON,FOLLOW_COLON_in_exprNoComma800);  
                    stream_COLON.add(char_literal73);

                    pushFollow(FOLLOW_mapTemplateRef_in_exprNoComma802);
                    mapTemplateRef74=mapTemplateRef();

                    state._fsp--;

                    stream_mapTemplateRef.add(mapTemplateRef74.getTree());


                    // AST REWRITE
                    // elements: memberExpr, mapTemplateRef
                    // token labels: 
                    // rule labels: retval
                    // token list labels: 
                    // rule list labels: 
                    // wildcard labels: 
                    retval.tree = root_0;
                    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

                    root_0 = (CommonTree)adaptor.nil();
                    // 152:28: -> ^( MAP memberExpr mapTemplateRef )
                    {
                        // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:152:31: ^( MAP memberExpr mapTemplateRef )
                        {
                        CommonTree root_1 = (CommonTree)adaptor.nil();
                        root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(MAP, "MAP"), root_1);

                        adaptor.addChild(root_1, stream_memberExpr.nextTree());
                        adaptor.addChild(root_1, stream_mapTemplateRef.nextTree());

                        adaptor.addChild(root_0, root_1);
                        }

                    }

                    retval.tree = root_0;
                    }
                    break;
                case 2 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:153:14: 
                    {

                    // AST REWRITE
                    // elements: memberExpr
                    // token labels: 
                    // rule labels: retval
                    // token list labels: 
                    // rule list labels: 
                    // wildcard labels: 
                    retval.tree = root_0;
                    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

                    root_0 = (CommonTree)adaptor.nil();
                    // 153:14: -> memberExpr
                    {
                        adaptor.addChild(root_0, stream_memberExpr.nextTree());

                    }

                    retval.tree = root_0;
                    }
                    break;

            }


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "exprNoComma"

    public static class expr_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "expr"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:157:1: expr : mapExpr ;
    public final STParser.expr_return expr() throws RecognitionException {
        STParser.expr_return retval = new STParser.expr_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        STParser.mapExpr_return mapExpr75 = null;



        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:157:6: ( mapExpr )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:157:8: mapExpr
            {
            root_0 = (CommonTree)adaptor.nil();

            pushFollow(FOLLOW_mapExpr_in_expr847);
            mapExpr75=mapExpr();

            state._fsp--;

            adaptor.addChild(root_0, mapExpr75.getTree());

            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "expr"

    public static class mapExpr_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "mapExpr"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:161:1: mapExpr : memberExpr ( (c= ',' memberExpr )+ col= ':' mapTemplateRef -> ^( ZIP[$col] ^( ELEMENTS ( memberExpr )+ ) mapTemplateRef ) | -> memberExpr ) (col= ':' x+= mapTemplateRef ({...}? => ',' x+= mapTemplateRef )* -> ^( MAP[$col] $mapExpr ( $x)+ ) )* ;
    public final STParser.mapExpr_return mapExpr() throws RecognitionException {
        STParser.mapExpr_return retval = new STParser.mapExpr_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        CommonToken c=null;
        CommonToken col=null;
        CommonToken char_literal79=null;
        List list_x=null;
        STParser.memberExpr_return memberExpr76 = null;

        STParser.memberExpr_return memberExpr77 = null;

        STParser.mapTemplateRef_return mapTemplateRef78 = null;

        RuleReturnScope x = null;
        CommonTree c_tree=null;
        CommonTree col_tree=null;
        CommonTree char_literal79_tree=null;
        RewriteRuleTokenStream stream_COLON=new RewriteRuleTokenStream(adaptor,"token COLON");
        RewriteRuleTokenStream stream_COMMA=new RewriteRuleTokenStream(adaptor,"token COMMA");
        RewriteRuleSubtreeStream stream_memberExpr=new RewriteRuleSubtreeStream(adaptor,"rule memberExpr");
        RewriteRuleSubtreeStream stream_mapTemplateRef=new RewriteRuleSubtreeStream(adaptor,"rule mapTemplateRef");
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:162:2: ( memberExpr ( (c= ',' memberExpr )+ col= ':' mapTemplateRef -> ^( ZIP[$col] ^( ELEMENTS ( memberExpr )+ ) mapTemplateRef ) | -> memberExpr ) (col= ':' x+= mapTemplateRef ({...}? => ',' x+= mapTemplateRef )* -> ^( MAP[$col] $mapExpr ( $x)+ ) )* )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:162:4: memberExpr ( (c= ',' memberExpr )+ col= ':' mapTemplateRef -> ^( ZIP[$col] ^( ELEMENTS ( memberExpr )+ ) mapTemplateRef ) | -> memberExpr ) (col= ':' x+= mapTemplateRef ({...}? => ',' x+= mapTemplateRef )* -> ^( MAP[$col] $mapExpr ( $x)+ ) )*
            {
            pushFollow(FOLLOW_memberExpr_in_mapExpr859);
            memberExpr76=memberExpr();

            state._fsp--;

            stream_memberExpr.add(memberExpr76.getTree());
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:163:3: ( (c= ',' memberExpr )+ col= ':' mapTemplateRef -> ^( ZIP[$col] ^( ELEMENTS ( memberExpr )+ ) mapTemplateRef ) | -> memberExpr )
            int alt21=2;
            int LA21_0 = input.LA(1);

            if ( (LA21_0==COMMA) ) {
                alt21=1;
            }
            else if ( (LA21_0==SEMI||LA21_0==COLON||LA21_0==RPAREN||LA21_0==RDELIM) ) {
                alt21=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 21, 0, input);

                throw nvae;
            }
            switch (alt21) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:163:5: (c= ',' memberExpr )+ col= ':' mapTemplateRef
                    {
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:163:5: (c= ',' memberExpr )+
                    int cnt20=0;
                    loop20:
                    do {
                        int alt20=2;
                        int LA20_0 = input.LA(1);

                        if ( (LA20_0==COMMA) ) {
                            alt20=1;
                        }


                        switch (alt20) {
                    	case 1 :
                    	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:163:6: c= ',' memberExpr
                    	    {
                    	    c=(CommonToken)match(input,COMMA,FOLLOW_COMMA_in_mapExpr868);  
                    	    stream_COMMA.add(c);

                    	    pushFollow(FOLLOW_memberExpr_in_mapExpr870);
                    	    memberExpr77=memberExpr();

                    	    state._fsp--;

                    	    stream_memberExpr.add(memberExpr77.getTree());

                    	    }
                    	    break;

                    	default :
                    	    if ( cnt20 >= 1 ) break loop20;
                                EarlyExitException eee =
                                    new EarlyExitException(20, input);
                                throw eee;
                        }
                        cnt20++;
                    } while (true);

                    col=(CommonToken)match(input,COLON,FOLLOW_COLON_in_mapExpr876);  
                    stream_COLON.add(col);

                    pushFollow(FOLLOW_mapTemplateRef_in_mapExpr878);
                    mapTemplateRef78=mapTemplateRef();

                    state._fsp--;

                    stream_mapTemplateRef.add(mapTemplateRef78.getTree());


                    // AST REWRITE
                    // elements: memberExpr, mapTemplateRef
                    // token labels: 
                    // rule labels: retval
                    // token list labels: 
                    // rule list labels: 
                    // wildcard labels: 
                    retval.tree = root_0;
                    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

                    root_0 = (CommonTree)adaptor.nil();
                    // 164:13: -> ^( ZIP[$col] ^( ELEMENTS ( memberExpr )+ ) mapTemplateRef )
                    {
                        // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:164:16: ^( ZIP[$col] ^( ELEMENTS ( memberExpr )+ ) mapTemplateRef )
                        {
                        CommonTree root_1 = (CommonTree)adaptor.nil();
                        root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(ZIP, col), root_1);

                        // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:164:28: ^( ELEMENTS ( memberExpr )+ )
                        {
                        CommonTree root_2 = (CommonTree)adaptor.nil();
                        root_2 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(ELEMENTS, "ELEMENTS"), root_2);

                        if ( !(stream_memberExpr.hasNext()) ) {
                            throw new RewriteEarlyExitException();
                        }
                        while ( stream_memberExpr.hasNext() ) {
                            adaptor.addChild(root_2, stream_memberExpr.nextTree());

                        }
                        stream_memberExpr.reset();

                        adaptor.addChild(root_1, root_2);
                        }
                        adaptor.addChild(root_1, stream_mapTemplateRef.nextTree());

                        adaptor.addChild(root_0, root_1);
                        }

                    }

                    retval.tree = root_0;
                    }
                    break;
                case 2 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:165:14: 
                    {

                    // AST REWRITE
                    // elements: memberExpr
                    // token labels: 
                    // rule labels: retval
                    // token list labels: 
                    // rule list labels: 
                    // wildcard labels: 
                    retval.tree = root_0;
                    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

                    root_0 = (CommonTree)adaptor.nil();
                    // 165:14: -> memberExpr
                    {
                        adaptor.addChild(root_0, stream_memberExpr.nextTree());

                    }

                    retval.tree = root_0;
                    }
                    break;

            }

            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:167:3: (col= ':' x+= mapTemplateRef ({...}? => ',' x+= mapTemplateRef )* -> ^( MAP[$col] $mapExpr ( $x)+ ) )*
            loop23:
            do {
                int alt23=2;
                int LA23_0 = input.LA(1);

                if ( (LA23_0==COLON) ) {
                    alt23=1;
                }


                switch (alt23) {
            	case 1 :
            	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:167:5: col= ':' x+= mapTemplateRef ({...}? => ',' x+= mapTemplateRef )*
            	    {
            	    if (list_x!=null) list_x.clear();
            	    col=(CommonToken)match(input,COLON,FOLLOW_COLON_in_mapExpr941);  
            	    stream_COLON.add(col);

            	    pushFollow(FOLLOW_mapTemplateRef_in_mapExpr945);
            	    x=mapTemplateRef();

            	    state._fsp--;

            	    stream_mapTemplateRef.add(x.getTree());
            	    if (list_x==null) list_x=new ArrayList();
            	    list_x.add(x.getTree());

            	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:168:30: ({...}? => ',' x+= mapTemplateRef )*
            	    loop22:
            	    do {
            	        int alt22=2;
            	        int LA22_0 = input.LA(1);

            	        if ( (LA22_0==COMMA) && ((c==null))) {
            	            alt22=1;
            	        }


            	        switch (alt22) {
            	    	case 1 :
            	    	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:168:31: {...}? => ',' x+= mapTemplateRef
            	    	    {
            	    	    if ( !((c==null)) ) {
            	    	        throw new FailedPredicateException(input, "mapExpr", "$c==null");
            	    	    }
            	    	    char_literal79=(CommonToken)match(input,COMMA,FOLLOW_COMMA_in_mapExpr951);  
            	    	    stream_COMMA.add(char_literal79);

            	    	    pushFollow(FOLLOW_mapTemplateRef_in_mapExpr955);
            	    	    x=mapTemplateRef();

            	    	    state._fsp--;

            	    	    stream_mapTemplateRef.add(x.getTree());
            	    	    if (list_x==null) list_x=new ArrayList();
            	    	    list_x.add(x.getTree());


            	    	    }
            	    	    break;

            	    	default :
            	    	    break loop22;
            	        }
            	    } while (true);



            	    // AST REWRITE
            	    // elements: mapExpr, x
            	    // token labels: 
            	    // rule labels: retval
            	    // token list labels: 
            	    // rule list labels: x
            	    // wildcard labels: 
            	    retval.tree = root_0;
            	    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);
            	    RewriteRuleSubtreeStream stream_x=new RewriteRuleSubtreeStream(adaptor,"token x",list_x);
            	    root_0 = (CommonTree)adaptor.nil();
            	    // 169:13: -> ^( MAP[$col] $mapExpr ( $x)+ )
            	    {
            	        // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:169:16: ^( MAP[$col] $mapExpr ( $x)+ )
            	        {
            	        CommonTree root_1 = (CommonTree)adaptor.nil();
            	        root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(MAP, col), root_1);

            	        adaptor.addChild(root_1, stream_retval.nextTree());
            	        if ( !(stream_x.hasNext()) ) {
            	            throw new RewriteEarlyExitException();
            	        }
            	        while ( stream_x.hasNext() ) {
            	            adaptor.addChild(root_1, stream_x.nextTree());

            	        }
            	        stream_x.reset();

            	        adaptor.addChild(root_0, root_1);
            	        }

            	    }

            	    retval.tree = root_0;
            	    }
            	    break;

            	default :
            	    break loop23;
                }
            } while (true);


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "mapExpr"

    public static class mapTemplateRef_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "mapTemplateRef"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:173:1: mapTemplateRef : ( ID '(' args ')' -> ^( INCLUDE ID ( args )? ) | subtemplate | lp= '(' mapExpr rp= ')' '(' ( argExprList )? ')' -> ^( INCLUDE_IND mapExpr ( argExprList )? ) );
    public final STParser.mapTemplateRef_return mapTemplateRef() throws RecognitionException {
        STParser.mapTemplateRef_return retval = new STParser.mapTemplateRef_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        CommonToken lp=null;
        CommonToken rp=null;
        CommonToken ID80=null;
        CommonToken char_literal81=null;
        CommonToken char_literal83=null;
        CommonToken char_literal86=null;
        CommonToken char_literal88=null;
        STParser.args_return args82 = null;

        STParser.subtemplate_return subtemplate84 = null;

        STParser.mapExpr_return mapExpr85 = null;

        STParser.argExprList_return argExprList87 = null;


        CommonTree lp_tree=null;
        CommonTree rp_tree=null;
        CommonTree ID80_tree=null;
        CommonTree char_literal81_tree=null;
        CommonTree char_literal83_tree=null;
        CommonTree char_literal86_tree=null;
        CommonTree char_literal88_tree=null;
        RewriteRuleTokenStream stream_RPAREN=new RewriteRuleTokenStream(adaptor,"token RPAREN");
        RewriteRuleTokenStream stream_ID=new RewriteRuleTokenStream(adaptor,"token ID");
        RewriteRuleTokenStream stream_LPAREN=new RewriteRuleTokenStream(adaptor,"token LPAREN");
        RewriteRuleSubtreeStream stream_argExprList=new RewriteRuleSubtreeStream(adaptor,"rule argExprList");
        RewriteRuleSubtreeStream stream_args=new RewriteRuleSubtreeStream(adaptor,"rule args");
        RewriteRuleSubtreeStream stream_mapExpr=new RewriteRuleSubtreeStream(adaptor,"rule mapExpr");
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:179:2: ( ID '(' args ')' -> ^( INCLUDE ID ( args )? ) | subtemplate | lp= '(' mapExpr rp= ')' '(' ( argExprList )? ')' -> ^( INCLUDE_IND mapExpr ( argExprList )? ) )
            int alt25=3;
            switch ( input.LA(1) ) {
            case ID:
                {
                alt25=1;
                }
                break;
            case LCURLY:
                {
                alt25=2;
                }
                break;
            case LPAREN:
                {
                alt25=3;
                }
                break;
            default:
                NoViableAltException nvae =
                    new NoViableAltException("", 25, 0, input);

                throw nvae;
            }

            switch (alt25) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:179:4: ID '(' args ')'
                    {
                    ID80=(CommonToken)match(input,ID,FOLLOW_ID_in_mapTemplateRef1002);  
                    stream_ID.add(ID80);

                    char_literal81=(CommonToken)match(input,LPAREN,FOLLOW_LPAREN_in_mapTemplateRef1004);  
                    stream_LPAREN.add(char_literal81);

                    pushFollow(FOLLOW_args_in_mapTemplateRef1006);
                    args82=args();

                    state._fsp--;

                    stream_args.add(args82.getTree());
                    char_literal83=(CommonToken)match(input,RPAREN,FOLLOW_RPAREN_in_mapTemplateRef1008);  
                    stream_RPAREN.add(char_literal83);



                    // AST REWRITE
                    // elements: ID, args
                    // token labels: 
                    // rule labels: retval
                    // token list labels: 
                    // rule list labels: 
                    // wildcard labels: 
                    retval.tree = root_0;
                    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

                    root_0 = (CommonTree)adaptor.nil();
                    // 179:26: -> ^( INCLUDE ID ( args )? )
                    {
                        // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:179:29: ^( INCLUDE ID ( args )? )
                        {
                        CommonTree root_1 = (CommonTree)adaptor.nil();
                        root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(INCLUDE, "INCLUDE"), root_1);

                        adaptor.addChild(root_1, stream_ID.nextNode());
                        // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:179:42: ( args )?
                        if ( stream_args.hasNext() ) {
                            adaptor.addChild(root_1, stream_args.nextTree());

                        }
                        stream_args.reset();

                        adaptor.addChild(root_0, root_1);
                        }

                    }

                    retval.tree = root_0;
                    }
                    break;
                case 2 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:180:4: subtemplate
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_subtemplate_in_mapTemplateRef1030);
                    subtemplate84=subtemplate();

                    state._fsp--;

                    adaptor.addChild(root_0, subtemplate84.getTree());

                    }
                    break;
                case 3 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:181:4: lp= '(' mapExpr rp= ')' '(' ( argExprList )? ')'
                    {
                    lp=(CommonToken)match(input,LPAREN,FOLLOW_LPAREN_in_mapTemplateRef1037);  
                    stream_LPAREN.add(lp);

                    pushFollow(FOLLOW_mapExpr_in_mapTemplateRef1039);
                    mapExpr85=mapExpr();

                    state._fsp--;

                    stream_mapExpr.add(mapExpr85.getTree());
                    rp=(CommonToken)match(input,RPAREN,FOLLOW_RPAREN_in_mapTemplateRef1043);  
                    stream_RPAREN.add(rp);

                    char_literal86=(CommonToken)match(input,LPAREN,FOLLOW_LPAREN_in_mapTemplateRef1045);  
                    stream_LPAREN.add(char_literal86);

                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:181:30: ( argExprList )?
                    int alt24=2;
                    int LA24_0 = input.LA(1);

                    if ( (LA24_0==SUPER||LA24_0==LPAREN||LA24_0==LBRACK||LA24_0==LCURLY||(LA24_0>=ID && LA24_0<=STRING)||LA24_0==AT) ) {
                        alt24=1;
                    }
                    switch (alt24) {
                        case 1 :
                            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:181:30: argExprList
                            {
                            pushFollow(FOLLOW_argExprList_in_mapTemplateRef1047);
                            argExprList87=argExprList();

                            state._fsp--;

                            stream_argExprList.add(argExprList87.getTree());

                            }
                            break;

                    }

                    char_literal88=(CommonToken)match(input,RPAREN,FOLLOW_RPAREN_in_mapTemplateRef1050);  
                    stream_RPAREN.add(char_literal88);



                    // AST REWRITE
                    // elements: argExprList, mapExpr
                    // token labels: 
                    // rule labels: retval
                    // token list labels: 
                    // rule list labels: 
                    // wildcard labels: 
                    retval.tree = root_0;
                    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

                    root_0 = (CommonTree)adaptor.nil();
                    // 181:46: -> ^( INCLUDE_IND mapExpr ( argExprList )? )
                    {
                        // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:181:49: ^( INCLUDE_IND mapExpr ( argExprList )? )
                        {
                        CommonTree root_1 = (CommonTree)adaptor.nil();
                        root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(INCLUDE_IND, "INCLUDE_IND"), root_1);

                        adaptor.addChild(root_1, stream_mapExpr.nextTree());
                        // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:181:71: ( argExprList )?
                        if ( stream_argExprList.hasNext() ) {
                            adaptor.addChild(root_1, stream_argExprList.nextTree());

                        }
                        stream_argExprList.reset();

                        adaptor.addChild(root_0, root_1);
                        }

                    }

                    retval.tree = root_0;
                    }
                    break;

            }
            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "mapTemplateRef"

    public static class memberExpr_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "memberExpr"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:184:1: memberExpr : ( includeExpr -> includeExpr ) (p= '.' ID -> ^( PROP[$p,\"PROP\"] $memberExpr ID ) | p= '.' '(' mapExpr ')' -> ^( PROP_IND[$p,\"PROP_IND\"] $memberExpr mapExpr ) )* ;
    public final STParser.memberExpr_return memberExpr() throws RecognitionException {
        STParser.memberExpr_return retval = new STParser.memberExpr_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        CommonToken p=null;
        CommonToken ID90=null;
        CommonToken char_literal91=null;
        CommonToken char_literal93=null;
        STParser.includeExpr_return includeExpr89 = null;

        STParser.mapExpr_return mapExpr92 = null;


        CommonTree p_tree=null;
        CommonTree ID90_tree=null;
        CommonTree char_literal91_tree=null;
        CommonTree char_literal93_tree=null;
        RewriteRuleTokenStream stream_RPAREN=new RewriteRuleTokenStream(adaptor,"token RPAREN");
        RewriteRuleTokenStream stream_DOT=new RewriteRuleTokenStream(adaptor,"token DOT");
        RewriteRuleTokenStream stream_ID=new RewriteRuleTokenStream(adaptor,"token ID");
        RewriteRuleTokenStream stream_LPAREN=new RewriteRuleTokenStream(adaptor,"token LPAREN");
        RewriteRuleSubtreeStream stream_includeExpr=new RewriteRuleSubtreeStream(adaptor,"rule includeExpr");
        RewriteRuleSubtreeStream stream_mapExpr=new RewriteRuleSubtreeStream(adaptor,"rule mapExpr");
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:185:2: ( ( includeExpr -> includeExpr ) (p= '.' ID -> ^( PROP[$p,\"PROP\"] $memberExpr ID ) | p= '.' '(' mapExpr ')' -> ^( PROP_IND[$p,\"PROP_IND\"] $memberExpr mapExpr ) )* )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:185:4: ( includeExpr -> includeExpr ) (p= '.' ID -> ^( PROP[$p,\"PROP\"] $memberExpr ID ) | p= '.' '(' mapExpr ')' -> ^( PROP_IND[$p,\"PROP_IND\"] $memberExpr mapExpr ) )*
            {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:185:4: ( includeExpr -> includeExpr )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:185:5: includeExpr
            {
            pushFollow(FOLLOW_includeExpr_in_memberExpr1072);
            includeExpr89=includeExpr();

            state._fsp--;

            stream_includeExpr.add(includeExpr89.getTree());


            // AST REWRITE
            // elements: includeExpr
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 185:16: -> includeExpr
            {
                adaptor.addChild(root_0, stream_includeExpr.nextTree());

            }

            retval.tree = root_0;
            }

            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:186:3: (p= '.' ID -> ^( PROP[$p,\"PROP\"] $memberExpr ID ) | p= '.' '(' mapExpr ')' -> ^( PROP_IND[$p,\"PROP_IND\"] $memberExpr mapExpr ) )*
            loop26:
            do {
                int alt26=3;
                int LA26_0 = input.LA(1);

                if ( (LA26_0==DOT) ) {
                    int LA26_2 = input.LA(2);

                    if ( (LA26_2==ID) ) {
                        alt26=1;
                    }
                    else if ( (LA26_2==LPAREN) ) {
                        alt26=2;
                    }


                }


                switch (alt26) {
            	case 1 :
            	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:186:5: p= '.' ID
            	    {
            	    p=(CommonToken)match(input,DOT,FOLLOW_DOT_in_memberExpr1083);  
            	    stream_DOT.add(p);

            	    ID90=(CommonToken)match(input,ID,FOLLOW_ID_in_memberExpr1085);  
            	    stream_ID.add(ID90);



            	    // AST REWRITE
            	    // elements: ID, memberExpr
            	    // token labels: 
            	    // rule labels: retval
            	    // token list labels: 
            	    // rule list labels: 
            	    // wildcard labels: 
            	    retval.tree = root_0;
            	    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            	    root_0 = (CommonTree)adaptor.nil();
            	    // 186:20: -> ^( PROP[$p,\"PROP\"] $memberExpr ID )
            	    {
            	        // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:186:23: ^( PROP[$p,\"PROP\"] $memberExpr ID )
            	        {
            	        CommonTree root_1 = (CommonTree)adaptor.nil();
            	        root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(PROP, p, "PROP"), root_1);

            	        adaptor.addChild(root_1, stream_retval.nextTree());
            	        adaptor.addChild(root_1, stream_ID.nextNode());

            	        adaptor.addChild(root_0, root_1);
            	        }

            	    }

            	    retval.tree = root_0;
            	    }
            	    break;
            	case 2 :
            	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:187:5: p= '.' '(' mapExpr ')'
            	    {
            	    p=(CommonToken)match(input,DOT,FOLLOW_DOT_in_memberExpr1111);  
            	    stream_DOT.add(p);

            	    char_literal91=(CommonToken)match(input,LPAREN,FOLLOW_LPAREN_in_memberExpr1113);  
            	    stream_LPAREN.add(char_literal91);

            	    pushFollow(FOLLOW_mapExpr_in_memberExpr1115);
            	    mapExpr92=mapExpr();

            	    state._fsp--;

            	    stream_mapExpr.add(mapExpr92.getTree());
            	    char_literal93=(CommonToken)match(input,RPAREN,FOLLOW_RPAREN_in_memberExpr1117);  
            	    stream_RPAREN.add(char_literal93);



            	    // AST REWRITE
            	    // elements: memberExpr, mapExpr
            	    // token labels: 
            	    // rule labels: retval
            	    // token list labels: 
            	    // rule list labels: 
            	    // wildcard labels: 
            	    retval.tree = root_0;
            	    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            	    root_0 = (CommonTree)adaptor.nil();
            	    // 187:30: -> ^( PROP_IND[$p,\"PROP_IND\"] $memberExpr mapExpr )
            	    {
            	        // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:187:33: ^( PROP_IND[$p,\"PROP_IND\"] $memberExpr mapExpr )
            	        {
            	        CommonTree root_1 = (CommonTree)adaptor.nil();
            	        root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(PROP_IND, p, "PROP_IND"), root_1);

            	        adaptor.addChild(root_1, stream_retval.nextTree());
            	        adaptor.addChild(root_1, stream_mapExpr.nextTree());

            	        adaptor.addChild(root_0, root_1);
            	        }

            	    }

            	    retval.tree = root_0;
            	    }
            	    break;

            	default :
            	    break loop26;
                }
            } while (true);


            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "memberExpr"

    public static class includeExpr_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "includeExpr"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:191:1: includeExpr options {k=2; } : ({...}? ID '(' ( expr )? ')' -> ^( EXEC_FUNC ID ( expr )? ) | 'super' '.' ID '(' args ')' -> ^( INCLUDE_SUPER ID ( args )? ) | ID '(' args ')' -> ^( INCLUDE ID ( args )? ) | '@' 'super' '.' ID '(' rp= ')' -> ^( INCLUDE_SUPER_REGION ID ) | '@' ID '(' rp= ')' -> ^( INCLUDE_REGION ID ) | primary );
    public final STParser.includeExpr_return includeExpr() throws RecognitionException {
        STParser.includeExpr_return retval = new STParser.includeExpr_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        CommonToken rp=null;
        CommonToken ID94=null;
        CommonToken char_literal95=null;
        CommonToken char_literal97=null;
        CommonToken string_literal98=null;
        CommonToken char_literal99=null;
        CommonToken ID100=null;
        CommonToken char_literal101=null;
        CommonToken char_literal103=null;
        CommonToken ID104=null;
        CommonToken char_literal105=null;
        CommonToken char_literal107=null;
        CommonToken char_literal108=null;
        CommonToken string_literal109=null;
        CommonToken char_literal110=null;
        CommonToken ID111=null;
        CommonToken char_literal112=null;
        CommonToken char_literal113=null;
        CommonToken ID114=null;
        CommonToken char_literal115=null;
        STParser.expr_return expr96 = null;

        STParser.args_return args102 = null;

        STParser.args_return args106 = null;

        STParser.primary_return primary116 = null;


        CommonTree rp_tree=null;
        CommonTree ID94_tree=null;
        CommonTree char_literal95_tree=null;
        CommonTree char_literal97_tree=null;
        CommonTree string_literal98_tree=null;
        CommonTree char_literal99_tree=null;
        CommonTree ID100_tree=null;
        CommonTree char_literal101_tree=null;
        CommonTree char_literal103_tree=null;
        CommonTree ID104_tree=null;
        CommonTree char_literal105_tree=null;
        CommonTree char_literal107_tree=null;
        CommonTree char_literal108_tree=null;
        CommonTree string_literal109_tree=null;
        CommonTree char_literal110_tree=null;
        CommonTree ID111_tree=null;
        CommonTree char_literal112_tree=null;
        CommonTree char_literal113_tree=null;
        CommonTree ID114_tree=null;
        CommonTree char_literal115_tree=null;
        RewriteRuleTokenStream stream_AT=new RewriteRuleTokenStream(adaptor,"token AT");
        RewriteRuleTokenStream stream_RPAREN=new RewriteRuleTokenStream(adaptor,"token RPAREN");
        RewriteRuleTokenStream stream_SUPER=new RewriteRuleTokenStream(adaptor,"token SUPER");
        RewriteRuleTokenStream stream_DOT=new RewriteRuleTokenStream(adaptor,"token DOT");
        RewriteRuleTokenStream stream_ID=new RewriteRuleTokenStream(adaptor,"token ID");
        RewriteRuleTokenStream stream_LPAREN=new RewriteRuleTokenStream(adaptor,"token LPAREN");
        RewriteRuleSubtreeStream stream_args=new RewriteRuleSubtreeStream(adaptor,"rule args");
        RewriteRuleSubtreeStream stream_expr=new RewriteRuleSubtreeStream(adaptor,"rule expr");
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:193:2: ({...}? ID '(' ( expr )? ')' -> ^( EXEC_FUNC ID ( expr )? ) | 'super' '.' ID '(' args ')' -> ^( INCLUDE_SUPER ID ( args )? ) | ID '(' args ')' -> ^( INCLUDE ID ( args )? ) | '@' 'super' '.' ID '(' rp= ')' -> ^( INCLUDE_SUPER_REGION ID ) | '@' ID '(' rp= ')' -> ^( INCLUDE_REGION ID ) | primary )
            int alt28=6;
            alt28 = dfa28.predict(input);
            switch (alt28) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:193:4: {...}? ID '(' ( expr )? ')'
                    {
                    if ( !((Compiler.funcs.containsKey(input.LT(1).getText()))) ) {
                        throw new FailedPredicateException(input, "includeExpr", "Compiler.funcs.containsKey(input.LT(1).getText())");
                    }
                    ID94=(CommonToken)match(input,ID,FOLLOW_ID_in_includeExpr1161);  
                    stream_ID.add(ID94);

                    char_literal95=(CommonToken)match(input,LPAREN,FOLLOW_LPAREN_in_includeExpr1163);  
                    stream_LPAREN.add(char_literal95);

                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:194:10: ( expr )?
                    int alt27=2;
                    int LA27_0 = input.LA(1);

                    if ( (LA27_0==SUPER||LA27_0==LPAREN||LA27_0==LBRACK||LA27_0==LCURLY||(LA27_0>=ID && LA27_0<=STRING)||LA27_0==AT) ) {
                        alt27=1;
                    }
                    switch (alt27) {
                        case 1 :
                            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:194:10: expr
                            {
                            pushFollow(FOLLOW_expr_in_includeExpr1165);
                            expr96=expr();

                            state._fsp--;

                            stream_expr.add(expr96.getTree());

                            }
                            break;

                    }

                    char_literal97=(CommonToken)match(input,RPAREN,FOLLOW_RPAREN_in_includeExpr1168);  
                    stream_RPAREN.add(char_literal97);



                    // AST REWRITE
                    // elements: ID, expr
                    // token labels: 
                    // rule labels: retval
                    // token list labels: 
                    // rule list labels: 
                    // wildcard labels: 
                    retval.tree = root_0;
                    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

                    root_0 = (CommonTree)adaptor.nil();
                    // 194:25: -> ^( EXEC_FUNC ID ( expr )? )
                    {
                        // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:194:28: ^( EXEC_FUNC ID ( expr )? )
                        {
                        CommonTree root_1 = (CommonTree)adaptor.nil();
                        root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(EXEC_FUNC, "EXEC_FUNC"), root_1);

                        adaptor.addChild(root_1, stream_ID.nextNode());
                        // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:194:43: ( expr )?
                        if ( stream_expr.hasNext() ) {
                            adaptor.addChild(root_1, stream_expr.nextTree());

                        }
                        stream_expr.reset();

                        adaptor.addChild(root_0, root_1);
                        }

                    }

                    retval.tree = root_0;
                    }
                    break;
                case 2 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:195:4: 'super' '.' ID '(' args ')'
                    {
                    string_literal98=(CommonToken)match(input,SUPER,FOLLOW_SUPER_in_includeExpr1189);  
                    stream_SUPER.add(string_literal98);

                    char_literal99=(CommonToken)match(input,DOT,FOLLOW_DOT_in_includeExpr1191);  
                    stream_DOT.add(char_literal99);

                    ID100=(CommonToken)match(input,ID,FOLLOW_ID_in_includeExpr1193);  
                    stream_ID.add(ID100);

                    char_literal101=(CommonToken)match(input,LPAREN,FOLLOW_LPAREN_in_includeExpr1195);  
                    stream_LPAREN.add(char_literal101);

                    pushFollow(FOLLOW_args_in_includeExpr1197);
                    args102=args();

                    state._fsp--;

                    stream_args.add(args102.getTree());
                    char_literal103=(CommonToken)match(input,RPAREN,FOLLOW_RPAREN_in_includeExpr1199);  
                    stream_RPAREN.add(char_literal103);



                    // AST REWRITE
                    // elements: args, ID
                    // token labels: 
                    // rule labels: retval
                    // token list labels: 
                    // rule list labels: 
                    // wildcard labels: 
                    retval.tree = root_0;
                    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

                    root_0 = (CommonTree)adaptor.nil();
                    // 195:35: -> ^( INCLUDE_SUPER ID ( args )? )
                    {
                        // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:195:38: ^( INCLUDE_SUPER ID ( args )? )
                        {
                        CommonTree root_1 = (CommonTree)adaptor.nil();
                        root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(INCLUDE_SUPER, "INCLUDE_SUPER"), root_1);

                        adaptor.addChild(root_1, stream_ID.nextNode());
                        // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:195:57: ( args )?
                        if ( stream_args.hasNext() ) {
                            adaptor.addChild(root_1, stream_args.nextTree());

                        }
                        stream_args.reset();

                        adaptor.addChild(root_0, root_1);
                        }

                    }

                    retval.tree = root_0;
                    }
                    break;
                case 3 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:196:4: ID '(' args ')'
                    {
                    ID104=(CommonToken)match(input,ID,FOLLOW_ID_in_includeExpr1218);  
                    stream_ID.add(ID104);

                    char_literal105=(CommonToken)match(input,LPAREN,FOLLOW_LPAREN_in_includeExpr1220);  
                    stream_LPAREN.add(char_literal105);

                    pushFollow(FOLLOW_args_in_includeExpr1222);
                    args106=args();

                    state._fsp--;

                    stream_args.add(args106.getTree());
                    char_literal107=(CommonToken)match(input,RPAREN,FOLLOW_RPAREN_in_includeExpr1224);  
                    stream_RPAREN.add(char_literal107);



                    // AST REWRITE
                    // elements: ID, args
                    // token labels: 
                    // rule labels: retval
                    // token list labels: 
                    // rule list labels: 
                    // wildcard labels: 
                    retval.tree = root_0;
                    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

                    root_0 = (CommonTree)adaptor.nil();
                    // 196:26: -> ^( INCLUDE ID ( args )? )
                    {
                        // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:196:29: ^( INCLUDE ID ( args )? )
                        {
                        CommonTree root_1 = (CommonTree)adaptor.nil();
                        root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(INCLUDE, "INCLUDE"), root_1);

                        adaptor.addChild(root_1, stream_ID.nextNode());
                        // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:196:42: ( args )?
                        if ( stream_args.hasNext() ) {
                            adaptor.addChild(root_1, stream_args.nextTree());

                        }
                        stream_args.reset();

                        adaptor.addChild(root_0, root_1);
                        }

                    }

                    retval.tree = root_0;
                    }
                    break;
                case 4 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:197:4: '@' 'super' '.' ID '(' rp= ')'
                    {
                    char_literal108=(CommonToken)match(input,AT,FOLLOW_AT_in_includeExpr1246);  
                    stream_AT.add(char_literal108);

                    string_literal109=(CommonToken)match(input,SUPER,FOLLOW_SUPER_in_includeExpr1248);  
                    stream_SUPER.add(string_literal109);

                    char_literal110=(CommonToken)match(input,DOT,FOLLOW_DOT_in_includeExpr1250);  
                    stream_DOT.add(char_literal110);

                    ID111=(CommonToken)match(input,ID,FOLLOW_ID_in_includeExpr1252);  
                    stream_ID.add(ID111);

                    char_literal112=(CommonToken)match(input,LPAREN,FOLLOW_LPAREN_in_includeExpr1254);  
                    stream_LPAREN.add(char_literal112);

                    rp=(CommonToken)match(input,RPAREN,FOLLOW_RPAREN_in_includeExpr1258);  
                    stream_RPAREN.add(rp);



                    // AST REWRITE
                    // elements: ID
                    // token labels: 
                    // rule labels: retval
                    // token list labels: 
                    // rule list labels: 
                    // wildcard labels: 
                    retval.tree = root_0;
                    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

                    root_0 = (CommonTree)adaptor.nil();
                    // 197:36: -> ^( INCLUDE_SUPER_REGION ID )
                    {
                        // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:197:39: ^( INCLUDE_SUPER_REGION ID )
                        {
                        CommonTree root_1 = (CommonTree)adaptor.nil();
                        root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(INCLUDE_SUPER_REGION, "INCLUDE_SUPER_REGION"), root_1);

                        adaptor.addChild(root_1, stream_ID.nextNode());

                        adaptor.addChild(root_0, root_1);
                        }

                    }

                    retval.tree = root_0;
                    }
                    break;
                case 5 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:198:4: '@' ID '(' rp= ')'
                    {
                    char_literal113=(CommonToken)match(input,AT,FOLLOW_AT_in_includeExpr1273);  
                    stream_AT.add(char_literal113);

                    ID114=(CommonToken)match(input,ID,FOLLOW_ID_in_includeExpr1275);  
                    stream_ID.add(ID114);

                    char_literal115=(CommonToken)match(input,LPAREN,FOLLOW_LPAREN_in_includeExpr1277);  
                    stream_LPAREN.add(char_literal115);

                    rp=(CommonToken)match(input,RPAREN,FOLLOW_RPAREN_in_includeExpr1281);  
                    stream_RPAREN.add(rp);



                    // AST REWRITE
                    // elements: ID
                    // token labels: 
                    // rule labels: retval
                    // token list labels: 
                    // rule list labels: 
                    // wildcard labels: 
                    retval.tree = root_0;
                    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

                    root_0 = (CommonTree)adaptor.nil();
                    // 198:27: -> ^( INCLUDE_REGION ID )
                    {
                        // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:198:30: ^( INCLUDE_REGION ID )
                        {
                        CommonTree root_1 = (CommonTree)adaptor.nil();
                        root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(INCLUDE_REGION, "INCLUDE_REGION"), root_1);

                        adaptor.addChild(root_1, stream_ID.nextNode());

                        adaptor.addChild(root_0, root_1);
                        }

                    }

                    retval.tree = root_0;
                    }
                    break;
                case 6 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:199:4: primary
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_primary_in_includeExpr1299);
                    primary116=primary();

                    state._fsp--;

                    adaptor.addChild(root_0, primary116.getTree());

                    }
                    break;

            }
            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "includeExpr"

    public static class primary_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "primary"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:202:1: primary : ( ID | STRING | subtemplate | list | lp= '(' expr ')' ( '(' ( argExprList )? ')' -> ^( INCLUDE_IND[$lp] expr ( argExprList )? ) | -> ^( TO_STR[$lp] expr ) ) );
    public final STParser.primary_return primary() throws RecognitionException {
        STParser.primary_return retval = new STParser.primary_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        CommonToken lp=null;
        CommonToken ID117=null;
        CommonToken STRING118=null;
        CommonToken char_literal122=null;
        CommonToken char_literal123=null;
        CommonToken char_literal125=null;
        STParser.subtemplate_return subtemplate119 = null;

        STParser.list_return list120 = null;

        STParser.expr_return expr121 = null;

        STParser.argExprList_return argExprList124 = null;


        CommonTree lp_tree=null;
        CommonTree ID117_tree=null;
        CommonTree STRING118_tree=null;
        CommonTree char_literal122_tree=null;
        CommonTree char_literal123_tree=null;
        CommonTree char_literal125_tree=null;
        RewriteRuleTokenStream stream_RPAREN=new RewriteRuleTokenStream(adaptor,"token RPAREN");
        RewriteRuleTokenStream stream_LPAREN=new RewriteRuleTokenStream(adaptor,"token LPAREN");
        RewriteRuleSubtreeStream stream_argExprList=new RewriteRuleSubtreeStream(adaptor,"rule argExprList");
        RewriteRuleSubtreeStream stream_expr=new RewriteRuleSubtreeStream(adaptor,"rule expr");
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:203:2: ( ID | STRING | subtemplate | list | lp= '(' expr ')' ( '(' ( argExprList )? ')' -> ^( INCLUDE_IND[$lp] expr ( argExprList )? ) | -> ^( TO_STR[$lp] expr ) ) )
            int alt31=5;
            switch ( input.LA(1) ) {
            case ID:
                {
                alt31=1;
                }
                break;
            case STRING:
                {
                alt31=2;
                }
                break;
            case LCURLY:
                {
                alt31=3;
                }
                break;
            case LBRACK:
                {
                alt31=4;
                }
                break;
            case LPAREN:
                {
                alt31=5;
                }
                break;
            default:
                NoViableAltException nvae =
                    new NoViableAltException("", 31, 0, input);

                throw nvae;
            }

            switch (alt31) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:203:4: ID
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    ID117=(CommonToken)match(input,ID,FOLLOW_ID_in_primary1310); 
                    ID117_tree = (CommonTree)adaptor.create(ID117);
                    adaptor.addChild(root_0, ID117_tree);


                    }
                    break;
                case 2 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:204:4: STRING
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    STRING118=(CommonToken)match(input,STRING,FOLLOW_STRING_in_primary1315); 
                    STRING118_tree = (CommonTree)adaptor.create(STRING118);
                    adaptor.addChild(root_0, STRING118_tree);


                    }
                    break;
                case 3 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:205:4: subtemplate
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_subtemplate_in_primary1320);
                    subtemplate119=subtemplate();

                    state._fsp--;

                    adaptor.addChild(root_0, subtemplate119.getTree());

                    }
                    break;
                case 4 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:206:4: list
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_list_in_primary1325);
                    list120=list();

                    state._fsp--;

                    adaptor.addChild(root_0, list120.getTree());

                    }
                    break;
                case 5 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:207:4: lp= '(' expr ')' ( '(' ( argExprList )? ')' -> ^( INCLUDE_IND[$lp] expr ( argExprList )? ) | -> ^( TO_STR[$lp] expr ) )
                    {
                    lp=(CommonToken)match(input,LPAREN,FOLLOW_LPAREN_in_primary1332);  
                    stream_LPAREN.add(lp);

                    pushFollow(FOLLOW_expr_in_primary1334);
                    expr121=expr();

                    state._fsp--;

                    stream_expr.add(expr121.getTree());
                    char_literal122=(CommonToken)match(input,RPAREN,FOLLOW_RPAREN_in_primary1336);  
                    stream_RPAREN.add(char_literal122);

                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:208:3: ( '(' ( argExprList )? ')' -> ^( INCLUDE_IND[$lp] expr ( argExprList )? ) | -> ^( TO_STR[$lp] expr ) )
                    int alt30=2;
                    int LA30_0 = input.LA(1);

                    if ( (LA30_0==LPAREN) ) {
                        alt30=1;
                    }
                    else if ( (LA30_0==SEMI||LA30_0==COLON||LA30_0==RPAREN||(LA30_0>=RBRACK && LA30_0<=DOT)||LA30_0==RDELIM||(LA30_0>=OR && LA30_0<=AND)) ) {
                        alt30=2;
                    }
                    else {
                        NoViableAltException nvae =
                            new NoViableAltException("", 30, 0, input);

                        throw nvae;
                    }
                    switch (alt30) {
                        case 1 :
                            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:208:5: '(' ( argExprList )? ')'
                            {
                            char_literal123=(CommonToken)match(input,LPAREN,FOLLOW_LPAREN_in_primary1342);  
                            stream_LPAREN.add(char_literal123);

                            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:208:9: ( argExprList )?
                            int alt29=2;
                            int LA29_0 = input.LA(1);

                            if ( (LA29_0==SUPER||LA29_0==LPAREN||LA29_0==LBRACK||LA29_0==LCURLY||(LA29_0>=ID && LA29_0<=STRING)||LA29_0==AT) ) {
                                alt29=1;
                            }
                            switch (alt29) {
                                case 1 :
                                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:208:9: argExprList
                                    {
                                    pushFollow(FOLLOW_argExprList_in_primary1344);
                                    argExprList124=argExprList();

                                    state._fsp--;

                                    stream_argExprList.add(argExprList124.getTree());

                                    }
                                    break;

                            }

                            char_literal125=(CommonToken)match(input,RPAREN,FOLLOW_RPAREN_in_primary1347);  
                            stream_RPAREN.add(char_literal125);



                            // AST REWRITE
                            // elements: expr, argExprList
                            // token labels: 
                            // rule labels: retval
                            // token list labels: 
                            // rule list labels: 
                            // wildcard labels: 
                            retval.tree = root_0;
                            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

                            root_0 = (CommonTree)adaptor.nil();
                            // 208:29: -> ^( INCLUDE_IND[$lp] expr ( argExprList )? )
                            {
                                // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:208:32: ^( INCLUDE_IND[$lp] expr ( argExprList )? )
                                {
                                CommonTree root_1 = (CommonTree)adaptor.nil();
                                root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(INCLUDE_IND, lp), root_1);

                                adaptor.addChild(root_1, stream_expr.nextTree());
                                // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:208:56: ( argExprList )?
                                if ( stream_argExprList.hasNext() ) {
                                    adaptor.addChild(root_1, stream_argExprList.nextTree());

                                }
                                stream_argExprList.reset();

                                adaptor.addChild(root_0, root_1);
                                }

                            }

                            retval.tree = root_0;
                            }
                            break;
                        case 2 :
                            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:209:14: 
                            {

                            // AST REWRITE
                            // elements: expr
                            // token labels: 
                            // rule labels: retval
                            // token list labels: 
                            // rule list labels: 
                            // wildcard labels: 
                            retval.tree = root_0;
                            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

                            root_0 = (CommonTree)adaptor.nil();
                            // 209:14: -> ^( TO_STR[$lp] expr )
                            {
                                // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:209:17: ^( TO_STR[$lp] expr )
                                {
                                CommonTree root_1 = (CommonTree)adaptor.nil();
                                root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(TO_STR, lp), root_1);

                                adaptor.addChild(root_1, stream_expr.nextTree());

                                adaptor.addChild(root_0, root_1);
                                }

                            }

                            retval.tree = root_0;
                            }
                            break;

                    }


                    }
                    break;

            }
            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "primary"

    public static class args_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "args"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:213:1: args : ( argExprList | namedArg ( ',' namedArg )* -> ( namedArg )+ | );
    public final STParser.args_return args() throws RecognitionException {
        STParser.args_return retval = new STParser.args_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        CommonToken char_literal128=null;
        STParser.argExprList_return argExprList126 = null;

        STParser.namedArg_return namedArg127 = null;

        STParser.namedArg_return namedArg129 = null;


        CommonTree char_literal128_tree=null;
        RewriteRuleTokenStream stream_COMMA=new RewriteRuleTokenStream(adaptor,"token COMMA");
        RewriteRuleSubtreeStream stream_namedArg=new RewriteRuleSubtreeStream(adaptor,"rule namedArg");
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:213:5: ( argExprList | namedArg ( ',' namedArg )* -> ( namedArg )+ | )
            int alt33=3;
            switch ( input.LA(1) ) {
            case ID:
                {
                int LA33_1 = input.LA(2);

                if ( ((LA33_1>=COLON && LA33_1<=RPAREN)||(LA33_1>=COMMA && LA33_1<=DOT)) ) {
                    alt33=1;
                }
                else if ( (LA33_1==EQUALS) ) {
                    alt33=2;
                }
                else {
                    NoViableAltException nvae =
                        new NoViableAltException("", 33, 1, input);

                    throw nvae;
                }
                }
                break;
            case SUPER:
            case LPAREN:
            case LBRACK:
            case LCURLY:
            case STRING:
            case AT:
                {
                alt33=1;
                }
                break;
            case RPAREN:
                {
                alt33=3;
                }
                break;
            default:
                NoViableAltException nvae =
                    new NoViableAltException("", 33, 0, input);

                throw nvae;
            }

            switch (alt33) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:213:7: argExprList
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_argExprList_in_args1397);
                    argExprList126=argExprList();

                    state._fsp--;

                    adaptor.addChild(root_0, argExprList126.getTree());

                    }
                    break;
                case 2 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:214:4: namedArg ( ',' namedArg )*
                    {
                    pushFollow(FOLLOW_namedArg_in_args1402);
                    namedArg127=namedArg();

                    state._fsp--;

                    stream_namedArg.add(namedArg127.getTree());
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:214:13: ( ',' namedArg )*
                    loop32:
                    do {
                        int alt32=2;
                        int LA32_0 = input.LA(1);

                        if ( (LA32_0==COMMA) ) {
                            alt32=1;
                        }


                        switch (alt32) {
                    	case 1 :
                    	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:214:15: ',' namedArg
                    	    {
                    	    char_literal128=(CommonToken)match(input,COMMA,FOLLOW_COMMA_in_args1406);  
                    	    stream_COMMA.add(char_literal128);

                    	    pushFollow(FOLLOW_namedArg_in_args1408);
                    	    namedArg129=namedArg();

                    	    state._fsp--;

                    	    stream_namedArg.add(namedArg129.getTree());

                    	    }
                    	    break;

                    	default :
                    	    break loop32;
                        }
                    } while (true);



                    // AST REWRITE
                    // elements: namedArg
                    // token labels: 
                    // rule labels: retval
                    // token list labels: 
                    // rule list labels: 
                    // wildcard labels: 
                    retval.tree = root_0;
                    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

                    root_0 = (CommonTree)adaptor.nil();
                    // 214:31: -> ( namedArg )+
                    {
                        if ( !(stream_namedArg.hasNext()) ) {
                            throw new RewriteEarlyExitException();
                        }
                        while ( stream_namedArg.hasNext() ) {
                            adaptor.addChild(root_0, stream_namedArg.nextTree());

                        }
                        stream_namedArg.reset();

                    }

                    retval.tree = root_0;
                    }
                    break;
                case 3 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:216:2: 
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    }
                    break;

            }
            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "args"

    public static class argExprList_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "argExprList"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:218:1: argExprList : arg ( ',' arg )* -> ( arg )+ ;
    public final STParser.argExprList_return argExprList() throws RecognitionException {
        STParser.argExprList_return retval = new STParser.argExprList_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        CommonToken char_literal131=null;
        STParser.arg_return arg130 = null;

        STParser.arg_return arg132 = null;


        CommonTree char_literal131_tree=null;
        RewriteRuleTokenStream stream_COMMA=new RewriteRuleTokenStream(adaptor,"token COMMA");
        RewriteRuleSubtreeStream stream_arg=new RewriteRuleSubtreeStream(adaptor,"rule arg");
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:218:13: ( arg ( ',' arg )* -> ( arg )+ )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:218:15: arg ( ',' arg )*
            {
            pushFollow(FOLLOW_arg_in_argExprList1429);
            arg130=arg();

            state._fsp--;

            stream_arg.add(arg130.getTree());
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:218:19: ( ',' arg )*
            loop34:
            do {
                int alt34=2;
                int LA34_0 = input.LA(1);

                if ( (LA34_0==COMMA) ) {
                    alt34=1;
                }


                switch (alt34) {
            	case 1 :
            	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:218:21: ',' arg
            	    {
            	    char_literal131=(CommonToken)match(input,COMMA,FOLLOW_COMMA_in_argExprList1433);  
            	    stream_COMMA.add(char_literal131);

            	    pushFollow(FOLLOW_arg_in_argExprList1435);
            	    arg132=arg();

            	    state._fsp--;

            	    stream_arg.add(arg132.getTree());

            	    }
            	    break;

            	default :
            	    break loop34;
                }
            } while (true);



            // AST REWRITE
            // elements: arg
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 218:32: -> ( arg )+
            {
                if ( !(stream_arg.hasNext()) ) {
                    throw new RewriteEarlyExitException();
                }
                while ( stream_arg.hasNext() ) {
                    adaptor.addChild(root_0, stream_arg.nextTree());

                }
                stream_arg.reset();

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "argExprList"

    public static class arg_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "arg"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:220:1: arg : exprNoComma ;
    public final STParser.arg_return arg() throws RecognitionException {
        STParser.arg_return retval = new STParser.arg_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        STParser.exprNoComma_return exprNoComma133 = null;



        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:220:5: ( exprNoComma )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:220:7: exprNoComma
            {
            root_0 = (CommonTree)adaptor.nil();

            pushFollow(FOLLOW_exprNoComma_in_arg1452);
            exprNoComma133=exprNoComma();

            state._fsp--;

            adaptor.addChild(root_0, exprNoComma133.getTree());

            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "arg"

    public static class namedArg_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "namedArg"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:222:1: namedArg : ID '=' arg -> ^( '=' ID arg ) ;
    public final STParser.namedArg_return namedArg() throws RecognitionException {
        STParser.namedArg_return retval = new STParser.namedArg_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        CommonToken ID134=null;
        CommonToken char_literal135=null;
        STParser.arg_return arg136 = null;


        CommonTree ID134_tree=null;
        CommonTree char_literal135_tree=null;
        RewriteRuleTokenStream stream_EQUALS=new RewriteRuleTokenStream(adaptor,"token EQUALS");
        RewriteRuleTokenStream stream_ID=new RewriteRuleTokenStream(adaptor,"token ID");
        RewriteRuleSubtreeStream stream_arg=new RewriteRuleSubtreeStream(adaptor,"rule arg");
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:222:10: ( ID '=' arg -> ^( '=' ID arg ) )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:222:12: ID '=' arg
            {
            ID134=(CommonToken)match(input,ID,FOLLOW_ID_in_namedArg1461);  
            stream_ID.add(ID134);

            char_literal135=(CommonToken)match(input,EQUALS,FOLLOW_EQUALS_in_namedArg1463);  
            stream_EQUALS.add(char_literal135);

            pushFollow(FOLLOW_arg_in_namedArg1465);
            arg136=arg();

            state._fsp--;

            stream_arg.add(arg136.getTree());


            // AST REWRITE
            // elements: EQUALS, arg, ID
            // token labels: 
            // rule labels: retval
            // token list labels: 
            // rule list labels: 
            // wildcard labels: 
            retval.tree = root_0;
            RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

            root_0 = (CommonTree)adaptor.nil();
            // 222:23: -> ^( '=' ID arg )
            {
                // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:222:26: ^( '=' ID arg )
                {
                CommonTree root_1 = (CommonTree)adaptor.nil();
                root_1 = (CommonTree)adaptor.becomeRoot(stream_EQUALS.nextNode(), root_1);

                adaptor.addChild(root_1, stream_ID.nextNode());
                adaptor.addChild(root_1, stream_arg.nextTree());

                adaptor.addChild(root_0, root_1);
                }

            }

            retval.tree = root_0;
            }

            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "namedArg"

    public static class list_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "list"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:224:1: list : ({...}?lb= '[' ']' -> LIST[$lb] | lb= '[' listElement ( ',' listElement )* ']' -> ^( LIST[$lb] ( listElement )* ) );
    public final STParser.list_return list() throws RecognitionException {
        STParser.list_return retval = new STParser.list_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        CommonToken lb=null;
        CommonToken char_literal137=null;
        CommonToken char_literal139=null;
        CommonToken char_literal141=null;
        STParser.listElement_return listElement138 = null;

        STParser.listElement_return listElement140 = null;


        CommonTree lb_tree=null;
        CommonTree char_literal137_tree=null;
        CommonTree char_literal139_tree=null;
        CommonTree char_literal141_tree=null;
        RewriteRuleTokenStream stream_RBRACK=new RewriteRuleTokenStream(adaptor,"token RBRACK");
        RewriteRuleTokenStream stream_LBRACK=new RewriteRuleTokenStream(adaptor,"token LBRACK");
        RewriteRuleTokenStream stream_COMMA=new RewriteRuleTokenStream(adaptor,"token COMMA");
        RewriteRuleSubtreeStream stream_listElement=new RewriteRuleSubtreeStream(adaptor,"rule listElement");
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:224:5: ({...}?lb= '[' ']' -> LIST[$lb] | lb= '[' listElement ( ',' listElement )* ']' -> ^( LIST[$lb] ( listElement )* ) )
            int alt36=2;
            int LA36_0 = input.LA(1);

            if ( (LA36_0==LBRACK) ) {
                int LA36_1 = input.LA(2);

                if ( (LA36_1==RBRACK) ) {
                    int LA36_2 = input.LA(3);

                    if ( ((input.LA(2)==RBRACK)) ) {
                        alt36=1;
                    }
                    else if ( (true) ) {
                        alt36=2;
                    }
                    else {
                        NoViableAltException nvae =
                            new NoViableAltException("", 36, 2, input);

                        throw nvae;
                    }
                }
                else if ( (LA36_1==SUPER||LA36_1==LPAREN||LA36_1==LBRACK||LA36_1==COMMA||LA36_1==LCURLY||(LA36_1>=ID && LA36_1<=STRING)||LA36_1==AT) ) {
                    alt36=2;
                }
                else {
                    NoViableAltException nvae =
                        new NoViableAltException("", 36, 1, input);

                    throw nvae;
                }
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 36, 0, input);

                throw nvae;
            }
            switch (alt36) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:224:7: {...}?lb= '[' ']'
                    {
                    if ( !((input.LA(2)==RBRACK)) ) {
                        throw new FailedPredicateException(input, "list", "input.LA(2)==RBRACK");
                    }
                    lb=(CommonToken)match(input,LBRACK,FOLLOW_LBRACK_in_list1490);  
                    stream_LBRACK.add(lb);

                    char_literal137=(CommonToken)match(input,RBRACK,FOLLOW_RBRACK_in_list1492);  
                    stream_RBRACK.add(char_literal137);



                    // AST REWRITE
                    // elements: 
                    // token labels: 
                    // rule labels: retval
                    // token list labels: 
                    // rule list labels: 
                    // wildcard labels: 
                    retval.tree = root_0;
                    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

                    root_0 = (CommonTree)adaptor.nil();
                    // 225:14: -> LIST[$lb]
                    {
                        adaptor.addChild(root_0, (CommonTree)adaptor.create(LIST, lb));

                    }

                    retval.tree = root_0;
                    }
                    break;
                case 2 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:226:4: lb= '[' listElement ( ',' listElement )* ']'
                    {
                    lb=(CommonToken)match(input,LBRACK,FOLLOW_LBRACK_in_list1504);  
                    stream_LBRACK.add(lb);

                    pushFollow(FOLLOW_listElement_in_list1506);
                    listElement138=listElement();

                    state._fsp--;

                    stream_listElement.add(listElement138.getTree());
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:226:23: ( ',' listElement )*
                    loop35:
                    do {
                        int alt35=2;
                        int LA35_0 = input.LA(1);

                        if ( (LA35_0==COMMA) ) {
                            alt35=1;
                        }


                        switch (alt35) {
                    	case 1 :
                    	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:226:25: ',' listElement
                    	    {
                    	    char_literal139=(CommonToken)match(input,COMMA,FOLLOW_COMMA_in_list1510);  
                    	    stream_COMMA.add(char_literal139);

                    	    pushFollow(FOLLOW_listElement_in_list1512);
                    	    listElement140=listElement();

                    	    state._fsp--;

                    	    stream_listElement.add(listElement140.getTree());

                    	    }
                    	    break;

                    	default :
                    	    break loop35;
                        }
                    } while (true);

                    char_literal141=(CommonToken)match(input,RBRACK,FOLLOW_RBRACK_in_list1517);  
                    stream_RBRACK.add(char_literal141);



                    // AST REWRITE
                    // elements: listElement
                    // token labels: 
                    // rule labels: retval
                    // token list labels: 
                    // rule list labels: 
                    // wildcard labels: 
                    retval.tree = root_0;
                    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

                    root_0 = (CommonTree)adaptor.nil();
                    // 226:48: -> ^( LIST[$lb] ( listElement )* )
                    {
                        // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:226:51: ^( LIST[$lb] ( listElement )* )
                        {
                        CommonTree root_1 = (CommonTree)adaptor.nil();
                        root_1 = (CommonTree)adaptor.becomeRoot((CommonTree)adaptor.create(LIST, lb), root_1);

                        // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:226:63: ( listElement )*
                        while ( stream_listElement.hasNext() ) {
                            adaptor.addChild(root_1, stream_listElement.nextTree());

                        }
                        stream_listElement.reset();

                        adaptor.addChild(root_0, root_1);
                        }

                    }

                    retval.tree = root_0;
                    }
                    break;

            }
            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "list"

    public static class listElement_return extends ParserRuleReturnScope {
        CommonTree tree;
        public Object getTree() { return tree; }
    };

    // $ANTLR start "listElement"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:229:1: listElement : ( exprNoComma | -> NULL );
    public final STParser.listElement_return listElement() throws RecognitionException {
        STParser.listElement_return retval = new STParser.listElement_return();
        retval.start = input.LT(1);

        CommonTree root_0 = null;

        STParser.exprNoComma_return exprNoComma142 = null;



        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:229:13: ( exprNoComma | -> NULL )
            int alt37=2;
            int LA37_0 = input.LA(1);

            if ( (LA37_0==SUPER||LA37_0==LPAREN||LA37_0==LBRACK||LA37_0==LCURLY||(LA37_0>=ID && LA37_0<=STRING)||LA37_0==AT) ) {
                alt37=1;
            }
            else if ( ((LA37_0>=RBRACK && LA37_0<=COMMA)) ) {
                alt37=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 37, 0, input);

                throw nvae;
            }
            switch (alt37) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:229:15: exprNoComma
                    {
                    root_0 = (CommonTree)adaptor.nil();

                    pushFollow(FOLLOW_exprNoComma_in_listElement1537);
                    exprNoComma142=exprNoComma();

                    state._fsp--;

                    adaptor.addChild(root_0, exprNoComma142.getTree());

                    }
                    break;
                case 2 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/STParser.g:229:29: 
                    {

                    // AST REWRITE
                    // elements: 
                    // token labels: 
                    // rule labels: retval
                    // token list labels: 
                    // rule list labels: 
                    // wildcard labels: 
                    retval.tree = root_0;
                    RewriteRuleSubtreeStream stream_retval=new RewriteRuleSubtreeStream(adaptor,"rule retval",retval!=null?retval.tree:null);

                    root_0 = (CommonTree)adaptor.nil();
                    // 229:29: -> NULL
                    {
                        adaptor.addChild(root_0, (CommonTree)adaptor.create(NULL, "NULL"));

                    }

                    retval.tree = root_0;
                    }
                    break;

            }
            retval.stop = input.LT(-1);

            retval.tree = (CommonTree)adaptor.rulePostProcessing(root_0);
            adaptor.setTokenBoundaries(retval.tree, retval.start, retval.stop);

        }

           catch (RecognitionException re) { throw re; }
        finally {
        }
        return retval;
    }
    // $ANTLR end "listElement"

    // Delegated rules


    protected DFA2 dfa2 = new DFA2(this);
    protected DFA28 dfa28 = new DFA28(this);
    static final String DFA2_eotS =
        "\12\uffff";
    static final String DFA2_eofS =
        "\12\uffff";
    static final String DFA2_minS =
        "\1\26\1\uffff\1\4\3\uffff\1\10\1\uffff\1\16\1\uffff";
    static final String DFA2_maxS =
        "\1\40\1\uffff\1\41\3\uffff\1\31\1\uffff\1\30\1\uffff";
    static final String DFA2_acceptS =
        "\1\uffff\1\1\1\uffff\1\4\1\6\1\2\1\uffff\1\3\1\uffff\1\5";
    static final String DFA2_specialS =
        "\12\uffff}>";
    static final String[] DFA2_transitionS = {
            "\1\3\1\2\7\uffff\1\1\1\4",
            "",
            "\1\5\3\uffff\1\7\5\uffff\1\7\1\uffff\1\7\3\uffff\1\7\4\uffff"+
            "\2\7\6\uffff\1\6",
            "",
            "",
            "",
            "\1\7\20\uffff\1\10",
            "",
            "\1\7\11\uffff\1\11",
            ""
    };

    static final short[] DFA2_eot = DFA.unpackEncodedString(DFA2_eotS);
    static final short[] DFA2_eof = DFA.unpackEncodedString(DFA2_eofS);
    static final char[] DFA2_min = DFA.unpackEncodedStringToUnsignedChars(DFA2_minS);
    static final char[] DFA2_max = DFA.unpackEncodedStringToUnsignedChars(DFA2_maxS);
    static final short[] DFA2_accept = DFA.unpackEncodedString(DFA2_acceptS);
    static final short[] DFA2_special = DFA.unpackEncodedString(DFA2_specialS);
    static final short[][] DFA2_transition;

    static {
        int numStates = DFA2_transitionS.length;
        DFA2_transition = new short[numStates][];
        for (int i=0; i<numStates; i++) {
            DFA2_transition[i] = DFA.unpackEncodedString(DFA2_transitionS[i]);
        }
    }

    class DFA2 extends DFA {

        public DFA2(BaseRecognizer recognizer) {
            this.recognizer = recognizer;
            this.decisionNumber = 2;
            this.eot = DFA2_eot;
            this.eof = DFA2_eof;
            this.min = DFA2_min;
            this.max = DFA2_max;
            this.accept = DFA2_accept;
            this.special = DFA2_special;
            this.transition = DFA2_transition;
        }
        public String getDescription() {
            return "74:1: element : ( INDENT element -> ^( INDENT element ) | ifstat | exprTag | text | region | NEWLINE );";
        }
    }
    static final String DFA28_eotS =
        "\26\uffff";
    static final String DFA28_eofS =
        "\26\uffff";
    static final String DFA28_minS =
        "\1\10\1\11\1\uffff\1\10\4\uffff\1\0\15\uffff";
    static final String DFA28_maxS =
        "\1\41\1\36\1\uffff\1\31\4\uffff\1\0\15\uffff";
    static final String DFA28_acceptS =
        "\2\uffff\1\2\1\uffff\1\6\15\uffff\1\4\1\5\1\1\1\3";
    static final String DFA28_specialS =
        "\10\uffff\1\0\15\uffff}>";
    static final String[] DFA28_transitionS = {
            "\1\2\5\uffff\1\4\1\uffff\1\4\3\uffff\1\4\4\uffff\1\1\1\4\6\uffff"+
            "\1\3",
            "\1\4\3\uffff\1\4\1\10\1\4\1\uffff\3\4\4\uffff\1\4\4\uffff\2"+
            "\4",
            "",
            "\1\22\20\uffff\1\23",
            "",
            "",
            "",
            "",
            "\1\uffff",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            ""
    };

    static final short[] DFA28_eot = DFA.unpackEncodedString(DFA28_eotS);
    static final short[] DFA28_eof = DFA.unpackEncodedString(DFA28_eofS);
    static final char[] DFA28_min = DFA.unpackEncodedStringToUnsignedChars(DFA28_minS);
    static final char[] DFA28_max = DFA.unpackEncodedStringToUnsignedChars(DFA28_maxS);
    static final short[] DFA28_accept = DFA.unpackEncodedString(DFA28_acceptS);
    static final short[] DFA28_special = DFA.unpackEncodedString(DFA28_specialS);
    static final short[][] DFA28_transition;

    static {
        int numStates = DFA28_transitionS.length;
        DFA28_transition = new short[numStates][];
        for (int i=0; i<numStates; i++) {
            DFA28_transition[i] = DFA.unpackEncodedString(DFA28_transitionS[i]);
        }
    }

    class DFA28 extends DFA {

        public DFA28(BaseRecognizer recognizer) {
            this.recognizer = recognizer;
            this.decisionNumber = 28;
            this.eot = DFA28_eot;
            this.eof = DFA28_eof;
            this.min = DFA28_min;
            this.max = DFA28_max;
            this.accept = DFA28_accept;
            this.special = DFA28_special;
            this.transition = DFA28_transition;
        }
        public String getDescription() {
            return "191:1: includeExpr options {k=2; } : ({...}? ID '(' ( expr )? ')' -> ^( EXEC_FUNC ID ( expr )? ) | 'super' '.' ID '(' args ')' -> ^( INCLUDE_SUPER ID ( args )? ) | ID '(' args ')' -> ^( INCLUDE ID ( args )? ) | '@' 'super' '.' ID '(' rp= ')' -> ^( INCLUDE_SUPER_REGION ID ) | '@' ID '(' rp= ')' -> ^( INCLUDE_REGION ID ) | primary );";
        }
        public int specialStateTransition(int s, IntStream _input) throws NoViableAltException {
            TokenStream input = (TokenStream)_input;
        	int _s = s;
            switch ( s ) {
                    case 0 : 
                        int LA28_8 = input.LA(1);

                         
                        int index28_8 = input.index();
                        input.rewind();
                        s = -1;
                        if ( ((Compiler.funcs.containsKey(input.LT(1).getText()))) ) {s = 20;}

                        else if ( (true) ) {s = 21;}

                         
                        input.seek(index28_8);
                        if ( s>=0 ) return s;
                        break;
            }
            NoViableAltException nvae =
                new NoViableAltException(getDescription(), 28, _s, input);
            error(nvae);
            throw nvae;
        }
    }
 

    public static final BitSet FOLLOW_template_in_templateAndEOF130 = new BitSet(new long[]{0x0000000000000000L});
    public static final BitSet FOLLOW_EOF_in_templateAndEOF132 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_element_in_template146 = new BitSet(new long[]{0x0000000180C00002L});
    public static final BitSet FOLLOW_INDENT_in_element157 = new BitSet(new long[]{0x0000000180C00000L});
    public static final BitSet FOLLOW_element_in_element159 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ifstat_in_element172 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_exprTag_in_element177 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_text_in_element182 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_region_in_element187 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_NEWLINE_in_element192 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_TEXT_in_text202 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_LDELIM_in_exprTag212 = new BitSet(new long[]{0x0000000206114100L});
    public static final BitSet FOLLOW_expr_in_exprTag214 = new BitSet(new long[]{0x0000000001000200L});
    public static final BitSet FOLLOW_SEMI_in_exprTag218 = new BitSet(new long[]{0x0000000002000000L});
    public static final BitSet FOLLOW_exprOptions_in_exprTag220 = new BitSet(new long[]{0x0000000001000000L});
    public static final BitSet FOLLOW_RDELIM_in_exprTag225 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_LDELIM_in_region249 = new BitSet(new long[]{0x0000000200000000L});
    public static final BitSet FOLLOW_AT_in_region251 = new BitSet(new long[]{0x0000000002000000L});
    public static final BitSet FOLLOW_ID_in_region253 = new BitSet(new long[]{0x0000000001000000L});
    public static final BitSet FOLLOW_RDELIM_in_region255 = new BitSet(new long[]{0x0000000180C00000L});
    public static final BitSet FOLLOW_template_in_region257 = new BitSet(new long[]{0x0000000000800000L});
    public static final BitSet FOLLOW_LDELIM_in_region259 = new BitSet(new long[]{0x0000000400000000L});
    public static final BitSet FOLLOW_END_in_region261 = new BitSet(new long[]{0x0000000001000000L});
    public static final BitSet FOLLOW_RDELIM_in_region263 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_LCURLY_in_subtemplate285 = new BitSet(new long[]{0x0000000182C00000L});
    public static final BitSet FOLLOW_ID_in_subtemplate291 = new BitSet(new long[]{0x0000000010040000L});
    public static final BitSet FOLLOW_COMMA_in_subtemplate295 = new BitSet(new long[]{0x0000000002000000L});
    public static final BitSet FOLLOW_ID_in_subtemplate300 = new BitSet(new long[]{0x0000000010040000L});
    public static final BitSet FOLLOW_PIPE_in_subtemplate305 = new BitSet(new long[]{0x0000000180C00000L});
    public static final BitSet FOLLOW_template_in_subtemplate310 = new BitSet(new long[]{0x0000000080200000L});
    public static final BitSet FOLLOW_INDENT_in_subtemplate312 = new BitSet(new long[]{0x0000000000200000L});
    public static final BitSet FOLLOW_RCURLY_in_subtemplate315 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_LDELIM_in_ifstat349 = new BitSet(new long[]{0x0000000000000010L});
    public static final BitSet FOLLOW_IF_in_ifstat351 = new BitSet(new long[]{0x0000000000004000L});
    public static final BitSet FOLLOW_LPAREN_in_ifstat353 = new BitSet(new long[]{0x0000000206114500L});
    public static final BitSet FOLLOW_conditional_in_ifstat357 = new BitSet(new long[]{0x0000000000008000L});
    public static final BitSet FOLLOW_RPAREN_in_ifstat359 = new BitSet(new long[]{0x0000000001000000L});
    public static final BitSet FOLLOW_RDELIM_in_ifstat361 = new BitSet(new long[]{0x0000000180C00000L});
    public static final BitSet FOLLOW_template_in_ifstat368 = new BitSet(new long[]{0x0000000080800000L});
    public static final BitSet FOLLOW_INDENT_in_ifstat375 = new BitSet(new long[]{0x0000000000800000L});
    public static final BitSet FOLLOW_LDELIM_in_ifstat378 = new BitSet(new long[]{0x0000000000000040L});
    public static final BitSet FOLLOW_ELSEIF_in_ifstat380 = new BitSet(new long[]{0x0000000000004000L});
    public static final BitSet FOLLOW_LPAREN_in_ifstat382 = new BitSet(new long[]{0x0000000206114500L});
    public static final BitSet FOLLOW_conditional_in_ifstat386 = new BitSet(new long[]{0x0000000000008000L});
    public static final BitSet FOLLOW_RPAREN_in_ifstat388 = new BitSet(new long[]{0x0000000001000000L});
    public static final BitSet FOLLOW_RDELIM_in_ifstat390 = new BitSet(new long[]{0x0000000180C00000L});
    public static final BitSet FOLLOW_template_in_ifstat394 = new BitSet(new long[]{0x0000000080800000L});
    public static final BitSet FOLLOW_INDENT_in_ifstat404 = new BitSet(new long[]{0x0000000000800000L});
    public static final BitSet FOLLOW_LDELIM_in_ifstat407 = new BitSet(new long[]{0x0000000000000020L});
    public static final BitSet FOLLOW_ELSE_in_ifstat409 = new BitSet(new long[]{0x0000000001000000L});
    public static final BitSet FOLLOW_RDELIM_in_ifstat411 = new BitSet(new long[]{0x0000000180C00000L});
    public static final BitSet FOLLOW_template_in_ifstat415 = new BitSet(new long[]{0x0000000080800000L});
    public static final BitSet FOLLOW_INDENT_in_ifstat423 = new BitSet(new long[]{0x0000000000800000L});
    public static final BitSet FOLLOW_LDELIM_in_ifstat429 = new BitSet(new long[]{0x0000000000000080L});
    public static final BitSet FOLLOW_ENDIF_in_ifstat431 = new BitSet(new long[]{0x0000000001000000L});
    public static final BitSet FOLLOW_RDELIM_in_ifstat435 = new BitSet(new long[]{0x0000000100000002L});
    public static final BitSet FOLLOW_NEWLINE_in_ifstat446 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_andConditional_in_conditional493 = new BitSet(new long[]{0x0000000020000002L});
    public static final BitSet FOLLOW_OR_in_conditional497 = new BitSet(new long[]{0x0000000206114500L});
    public static final BitSet FOLLOW_andConditional_in_conditional500 = new BitSet(new long[]{0x0000000020000002L});
    public static final BitSet FOLLOW_notConditional_in_andConditional512 = new BitSet(new long[]{0x0000000040000002L});
    public static final BitSet FOLLOW_AND_in_andConditional516 = new BitSet(new long[]{0x0000000206114500L});
    public static final BitSet FOLLOW_notConditional_in_andConditional519 = new BitSet(new long[]{0x0000000040000002L});
    public static final BitSet FOLLOW_BANG_in_notConditional533 = new BitSet(new long[]{0x0000000002000000L});
    public static final BitSet FOLLOW_notConditionalExpr_in_notConditional536 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_BANG_in_notConditional540 = new BitSet(new long[]{0x0000000000004000L});
    public static final BitSet FOLLOW_LPAREN_in_notConditional543 = new BitSet(new long[]{0x0000000206114500L});
    public static final BitSet FOLLOW_conditional_in_notConditional546 = new BitSet(new long[]{0x0000000000008000L});
    public static final BitSet FOLLOW_RPAREN_in_notConditional548 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_memberExpr_in_notConditional553 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ID_in_notConditionalExpr565 = new BitSet(new long[]{0x0000000000080002L});
    public static final BitSet FOLLOW_DOT_in_notConditionalExpr576 = new BitSet(new long[]{0x0000000002000000L});
    public static final BitSet FOLLOW_ID_in_notConditionalExpr580 = new BitSet(new long[]{0x0000000000080002L});
    public static final BitSet FOLLOW_DOT_in_notConditionalExpr606 = new BitSet(new long[]{0x0000000000004000L});
    public static final BitSet FOLLOW_LPAREN_in_notConditionalExpr608 = new BitSet(new long[]{0x0000000206114100L});
    public static final BitSet FOLLOW_mapExpr_in_notConditionalExpr610 = new BitSet(new long[]{0x0000000000008000L});
    public static final BitSet FOLLOW_RPAREN_in_notConditionalExpr612 = new BitSet(new long[]{0x0000000000080002L});
    public static final BitSet FOLLOW_option_in_exprOptions642 = new BitSet(new long[]{0x0000000000040002L});
    public static final BitSet FOLLOW_COMMA_in_exprOptions646 = new BitSet(new long[]{0x0000000002000000L});
    public static final BitSet FOLLOW_option_in_exprOptions648 = new BitSet(new long[]{0x0000000000040002L});
    public static final BitSet FOLLOW_ID_in_option675 = new BitSet(new long[]{0x0000000000001002L});
    public static final BitSet FOLLOW_EQUALS_in_option685 = new BitSet(new long[]{0x0000000206114100L});
    public static final BitSet FOLLOW_exprNoComma_in_option687 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_memberExpr_in_exprNoComma794 = new BitSet(new long[]{0x0000000000002002L});
    public static final BitSet FOLLOW_COLON_in_exprNoComma800 = new BitSet(new long[]{0x0000000002104000L});
    public static final BitSet FOLLOW_mapTemplateRef_in_exprNoComma802 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_mapExpr_in_expr847 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_memberExpr_in_mapExpr859 = new BitSet(new long[]{0x0000000000042002L});
    public static final BitSet FOLLOW_COMMA_in_mapExpr868 = new BitSet(new long[]{0x0000000206114100L});
    public static final BitSet FOLLOW_memberExpr_in_mapExpr870 = new BitSet(new long[]{0x0000000000042000L});
    public static final BitSet FOLLOW_COLON_in_mapExpr876 = new BitSet(new long[]{0x0000000002104000L});
    public static final BitSet FOLLOW_mapTemplateRef_in_mapExpr878 = new BitSet(new long[]{0x0000000000002002L});
    public static final BitSet FOLLOW_COLON_in_mapExpr941 = new BitSet(new long[]{0x0000000002104000L});
    public static final BitSet FOLLOW_mapTemplateRef_in_mapExpr945 = new BitSet(new long[]{0x0000000000042002L});
    public static final BitSet FOLLOW_COMMA_in_mapExpr951 = new BitSet(new long[]{0x0000000002104000L});
    public static final BitSet FOLLOW_mapTemplateRef_in_mapExpr955 = new BitSet(new long[]{0x0000000000042002L});
    public static final BitSet FOLLOW_ID_in_mapTemplateRef1002 = new BitSet(new long[]{0x0000000000004000L});
    public static final BitSet FOLLOW_LPAREN_in_mapTemplateRef1004 = new BitSet(new long[]{0x000000020611C100L});
    public static final BitSet FOLLOW_args_in_mapTemplateRef1006 = new BitSet(new long[]{0x0000000000008000L});
    public static final BitSet FOLLOW_RPAREN_in_mapTemplateRef1008 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_subtemplate_in_mapTemplateRef1030 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_LPAREN_in_mapTemplateRef1037 = new BitSet(new long[]{0x0000000206114100L});
    public static final BitSet FOLLOW_mapExpr_in_mapTemplateRef1039 = new BitSet(new long[]{0x0000000000008000L});
    public static final BitSet FOLLOW_RPAREN_in_mapTemplateRef1043 = new BitSet(new long[]{0x0000000000004000L});
    public static final BitSet FOLLOW_LPAREN_in_mapTemplateRef1045 = new BitSet(new long[]{0x000000020611C100L});
    public static final BitSet FOLLOW_argExprList_in_mapTemplateRef1047 = new BitSet(new long[]{0x0000000000008000L});
    public static final BitSet FOLLOW_RPAREN_in_mapTemplateRef1050 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_includeExpr_in_memberExpr1072 = new BitSet(new long[]{0x0000000000080002L});
    public static final BitSet FOLLOW_DOT_in_memberExpr1083 = new BitSet(new long[]{0x0000000002000000L});
    public static final BitSet FOLLOW_ID_in_memberExpr1085 = new BitSet(new long[]{0x0000000000080002L});
    public static final BitSet FOLLOW_DOT_in_memberExpr1111 = new BitSet(new long[]{0x0000000000004000L});
    public static final BitSet FOLLOW_LPAREN_in_memberExpr1113 = new BitSet(new long[]{0x0000000206114100L});
    public static final BitSet FOLLOW_mapExpr_in_memberExpr1115 = new BitSet(new long[]{0x0000000000008000L});
    public static final BitSet FOLLOW_RPAREN_in_memberExpr1117 = new BitSet(new long[]{0x0000000000080002L});
    public static final BitSet FOLLOW_ID_in_includeExpr1161 = new BitSet(new long[]{0x0000000000004000L});
    public static final BitSet FOLLOW_LPAREN_in_includeExpr1163 = new BitSet(new long[]{0x000000020611C100L});
    public static final BitSet FOLLOW_expr_in_includeExpr1165 = new BitSet(new long[]{0x0000000000008000L});
    public static final BitSet FOLLOW_RPAREN_in_includeExpr1168 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_SUPER_in_includeExpr1189 = new BitSet(new long[]{0x0000000000080000L});
    public static final BitSet FOLLOW_DOT_in_includeExpr1191 = new BitSet(new long[]{0x0000000002000000L});
    public static final BitSet FOLLOW_ID_in_includeExpr1193 = new BitSet(new long[]{0x0000000000004000L});
    public static final BitSet FOLLOW_LPAREN_in_includeExpr1195 = new BitSet(new long[]{0x000000020611C100L});
    public static final BitSet FOLLOW_args_in_includeExpr1197 = new BitSet(new long[]{0x0000000000008000L});
    public static final BitSet FOLLOW_RPAREN_in_includeExpr1199 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ID_in_includeExpr1218 = new BitSet(new long[]{0x0000000000004000L});
    public static final BitSet FOLLOW_LPAREN_in_includeExpr1220 = new BitSet(new long[]{0x000000020611C100L});
    public static final BitSet FOLLOW_args_in_includeExpr1222 = new BitSet(new long[]{0x0000000000008000L});
    public static final BitSet FOLLOW_RPAREN_in_includeExpr1224 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_AT_in_includeExpr1246 = new BitSet(new long[]{0x0000000000000100L});
    public static final BitSet FOLLOW_SUPER_in_includeExpr1248 = new BitSet(new long[]{0x0000000000080000L});
    public static final BitSet FOLLOW_DOT_in_includeExpr1250 = new BitSet(new long[]{0x0000000002000000L});
    public static final BitSet FOLLOW_ID_in_includeExpr1252 = new BitSet(new long[]{0x0000000000004000L});
    public static final BitSet FOLLOW_LPAREN_in_includeExpr1254 = new BitSet(new long[]{0x0000000000008000L});
    public static final BitSet FOLLOW_RPAREN_in_includeExpr1258 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_AT_in_includeExpr1273 = new BitSet(new long[]{0x0000000002000000L});
    public static final BitSet FOLLOW_ID_in_includeExpr1275 = new BitSet(new long[]{0x0000000000004000L});
    public static final BitSet FOLLOW_LPAREN_in_includeExpr1277 = new BitSet(new long[]{0x0000000000008000L});
    public static final BitSet FOLLOW_RPAREN_in_includeExpr1281 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_primary_in_includeExpr1299 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ID_in_primary1310 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_STRING_in_primary1315 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_subtemplate_in_primary1320 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_list_in_primary1325 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_LPAREN_in_primary1332 = new BitSet(new long[]{0x0000000206114100L});
    public static final BitSet FOLLOW_expr_in_primary1334 = new BitSet(new long[]{0x0000000000008000L});
    public static final BitSet FOLLOW_RPAREN_in_primary1336 = new BitSet(new long[]{0x0000000000004002L});
    public static final BitSet FOLLOW_LPAREN_in_primary1342 = new BitSet(new long[]{0x000000020611C100L});
    public static final BitSet FOLLOW_argExprList_in_primary1344 = new BitSet(new long[]{0x0000000000008000L});
    public static final BitSet FOLLOW_RPAREN_in_primary1347 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_argExprList_in_args1397 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_namedArg_in_args1402 = new BitSet(new long[]{0x0000000000040002L});
    public static final BitSet FOLLOW_COMMA_in_args1406 = new BitSet(new long[]{0x0000000002000000L});
    public static final BitSet FOLLOW_namedArg_in_args1408 = new BitSet(new long[]{0x0000000000040002L});
    public static final BitSet FOLLOW_arg_in_argExprList1429 = new BitSet(new long[]{0x0000000000040002L});
    public static final BitSet FOLLOW_COMMA_in_argExprList1433 = new BitSet(new long[]{0x0000000206114100L});
    public static final BitSet FOLLOW_arg_in_argExprList1435 = new BitSet(new long[]{0x0000000000040002L});
    public static final BitSet FOLLOW_exprNoComma_in_arg1452 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ID_in_namedArg1461 = new BitSet(new long[]{0x0000000000001000L});
    public static final BitSet FOLLOW_EQUALS_in_namedArg1463 = new BitSet(new long[]{0x0000000206114100L});
    public static final BitSet FOLLOW_arg_in_namedArg1465 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_LBRACK_in_list1490 = new BitSet(new long[]{0x0000000000020000L});
    public static final BitSet FOLLOW_RBRACK_in_list1492 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_LBRACK_in_list1504 = new BitSet(new long[]{0x0000000206174100L});
    public static final BitSet FOLLOW_listElement_in_list1506 = new BitSet(new long[]{0x0000000000060000L});
    public static final BitSet FOLLOW_COMMA_in_list1510 = new BitSet(new long[]{0x0000000206174100L});
    public static final BitSet FOLLOW_listElement_in_list1512 = new BitSet(new long[]{0x0000000000060000L});
    public static final BitSet FOLLOW_RBRACK_in_list1517 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_exprNoComma_in_listElement1537 = new BitSet(new long[]{0x0000000000000002L});

}