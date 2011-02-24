// $ANTLR 3.3.1-SNAPSHOT Feb 04, 2011 12:40:37 /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g 2011-02-04 20:21:49

package org.stringtemplate.v4.compiler;
import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import org.stringtemplate.v4.misc.*;
import org.stringtemplate.v4.*;
import java.io.File;


import org.antlr.runtime.*;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;

public class GroupParser extends Parser {
    public static final String[] tokenNames = new String[] {
        "<invalid>", "<EOR>", "<DOWN>", "<UP>", "STRING", "ID", "BIGSTRING", "ANONYMOUS_TEMPLATE", "COMMENT", "LINE_COMMENT", "WS", "'import'", "'.'", "'@'", "'('", "')'", "'::='", "','", "'='", "'['", "']'", "'default'", "':'"
    };
    public static final int EOF=-1;
    public static final int T__11=11;
    public static final int T__12=12;
    public static final int T__13=13;
    public static final int T__14=14;
    public static final int T__15=15;
    public static final int T__16=16;
    public static final int T__17=17;
    public static final int T__18=18;
    public static final int T__19=19;
    public static final int T__20=20;
    public static final int T__21=21;
    public static final int T__22=22;
    public static final int STRING=4;
    public static final int ID=5;
    public static final int BIGSTRING=6;
    public static final int ANONYMOUS_TEMPLATE=7;
    public static final int COMMENT=8;
    public static final int LINE_COMMENT=9;
    public static final int WS=10;

    // delegates
    // delegators


        public GroupParser(TokenStream input) {
            this(input, new RecognizerSharedState());
        }
        public GroupParser(TokenStream input, RecognizerSharedState state) {
            super(input, state);
             
        }
        

    public String[] getTokenNames() { return GroupParser.tokenNames; }
    public String getGrammarFileName() { return "/Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g"; }


    public STGroup group;

    public void displayRecognitionError(String[] tokenNames,
                                        RecognitionException e)
    {
        String msg = getErrorMessage(e, tokenNames);
        group.errMgr.groupSyntaxError(ErrorType.SYNTAX_ERROR, getSourceName(), e, msg);
    }
    public String getSourceName() {
        String fullFileName = super.getSourceName();
        File f = new File(fullFileName); // strip to simple name
        return f.getName();
    }
    public void error(String msg) {
        NoViableAltException e = new NoViableAltException("", 0, 0, input);
        group.errMgr.groupSyntaxError(ErrorType.SYNTAX_ERROR, getSourceName(), e, msg);
        recover(input, null);
    }



    // $ANTLR start "group"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:92:1: group[STGroup group, String prefix] : ( 'import' STRING | 'import' ID ( '.' ID )* )* ( def[prefix] )+ ;
    public final void group(STGroup group, String prefix) throws RecognitionException {
        Token STRING1=null;


        GroupLexer lexer = (GroupLexer)input.getTokenSource();
        this.group = lexer.group = group;

        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:97:2: ( ( 'import' STRING | 'import' ID ( '.' ID )* )* ( def[prefix] )+ )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:97:4: ( 'import' STRING | 'import' ID ( '.' ID )* )* ( def[prefix] )+
            {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:97:4: ( 'import' STRING | 'import' ID ( '.' ID )* )*
            loop2:
            do {
                int alt2=3;
                int LA2_0 = input.LA(1);

                if ( (LA2_0==11) ) {
                    int LA2_2 = input.LA(2);

                    if ( (LA2_2==STRING) ) {
                        alt2=1;
                    }
                    else if ( (LA2_2==ID) ) {
                        alt2=2;
                    }


                }


                switch (alt2) {
            	case 1 :
            	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:97:6: 'import' STRING
            	    {
            	    match(input,11,FOLLOW_11_in_group51); 
            	    STRING1=(Token)match(input,STRING,FOLLOW_STRING_in_group53); 
            	    group.importTemplates(STRING1);

            	    }
            	    break;
            	case 2 :
            	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:98:5: 'import' ID ( '.' ID )*
            	    {
            	    match(input,11,FOLLOW_11_in_group61); 

            	    			MismatchedTokenException e = new MismatchedTokenException(STRING, input);
            	    			reportError(e);
            	    			
            	    match(input,ID,FOLLOW_ID_in_group72); 
            	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:103:7: ( '.' ID )*
            	    loop1:
            	    do {
            	        int alt1=2;
            	        int LA1_0 = input.LA(1);

            	        if ( (LA1_0==12) ) {
            	            alt1=1;
            	        }


            	        switch (alt1) {
            	    	case 1 :
            	    	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:103:8: '.' ID
            	    	    {
            	    	    match(input,12,FOLLOW_12_in_group75); 
            	    	    match(input,ID,FOLLOW_ID_in_group77); 

            	    	    }
            	    	    break;

            	    	default :
            	    	    break loop1;
            	        }
            	    } while (true);


            	    }
            	    break;

            	default :
            	    break loop2;
                }
            } while (true);

            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:105:9: ( def[prefix] )+
            int cnt3=0;
            loop3:
            do {
                int alt3=2;
                int LA3_0 = input.LA(1);

                if ( (LA3_0==ID||LA3_0==13) ) {
                    alt3=1;
                }


                switch (alt3) {
            	case 1 :
            	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:105:9: def[prefix]
            	    {
            	    pushFollow(FOLLOW_def_in_group95);
            	    def(prefix);

            	    state._fsp--;


            	    }
            	    break;

            	default :
            	    if ( cnt3 >= 1 ) break loop3;
                        EarlyExitException eee =
                            new EarlyExitException(3, input);
                        throw eee;
                }
                cnt3++;
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
    // $ANTLR end "group"


    // $ANTLR start "groupName"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:108:1: groupName returns [String name] : a= ID ( '.' a= ID )* ;
    public final String groupName() throws RecognitionException {
        String name = null;

        Token a=null;

        StringBuilder buf = new StringBuilder();
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:110:2: (a= ID ( '.' a= ID )* )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:110:4: a= ID ( '.' a= ID )*
            {
            a=(Token)match(input,ID,FOLLOW_ID_in_groupName126); 
            buf.append((a!=null?a.getText():null));
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:110:32: ( '.' a= ID )*
            loop4:
            do {
                int alt4=2;
                int LA4_0 = input.LA(1);

                if ( (LA4_0==12) ) {
                    alt4=1;
                }


                switch (alt4) {
            	case 1 :
            	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:110:33: '.' a= ID
            	    {
            	    match(input,12,FOLLOW_12_in_groupName131); 
            	    a=(Token)match(input,ID,FOLLOW_ID_in_groupName135); 
            	    buf.append((a!=null?a.getText():null));

            	    }
            	    break;

            	default :
            	    break loop4;
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
        return name;
    }
    // $ANTLR end "groupName"


    // $ANTLR start "def"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:113:1: def[String prefix] : ( templateDef[prefix] | dictDef );
    public final void def(String prefix) throws RecognitionException {
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:117:20: ( templateDef[prefix] | dictDef )
            int alt5=2;
            int LA5_0 = input.LA(1);

            if ( (LA5_0==13) ) {
                alt5=1;
            }
            else if ( (LA5_0==ID) ) {
                int LA5_2 = input.LA(2);

                if ( (LA5_2==14) ) {
                    alt5=1;
                }
                else if ( (LA5_2==16) ) {
                    int LA5_3 = input.LA(3);

                    if ( (LA5_3==ID) ) {
                        alt5=1;
                    }
                    else if ( (LA5_3==19) ) {
                        alt5=2;
                    }
                    else {
                        NoViableAltException nvae =
                            new NoViableAltException("", 5, 3, input);

                        throw nvae;
                    }
                }
                else {
                    NoViableAltException nvae =
                        new NoViableAltException("", 5, 2, input);

                    throw nvae;
                }
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 5, 0, input);

                throw nvae;
            }
            switch (alt5) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:117:22: templateDef[prefix]
                    {
                    pushFollow(FOLLOW_templateDef_in_def152);
                    templateDef(prefix);

                    state._fsp--;


                    }
                    break;
                case 2 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:117:44: dictDef
                    {
                    pushFollow(FOLLOW_dictDef_in_def157);
                    dictDef();

                    state._fsp--;


                    }
                    break;

            }
        }
        catch (RecognitionException re) {

            		// pretend we already saw an error here
            		state.lastErrorIndex = input.index();
            		error("garbled template definition starting at '"+input.LT(1).getText()+"'");
            	
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "def"


    // $ANTLR start "templateDef"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:124:1: templateDef[String prefix] : ( ( '@' enclosing= ID '.' name= ID '(' ')' | name= ID '(' formalArgs ')' ) '::=' ( STRING | BIGSTRING | ) | alias= ID '::=' target= ID );
    public final void templateDef(String prefix) throws RecognitionException {
        Token enclosing=null;
        Token name=null;
        Token alias=null;
        Token target=null;
        Token STRING2=null;
        Token BIGSTRING3=null;
        List<FormalArgument> formalArgs4 = null;



            String template=null;
            int n=0; // num char to strip from left, right of template def

        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:129:2: ( ( '@' enclosing= ID '.' name= ID '(' ')' | name= ID '(' formalArgs ')' ) '::=' ( STRING | BIGSTRING | ) | alias= ID '::=' target= ID )
            int alt8=2;
            int LA8_0 = input.LA(1);

            if ( (LA8_0==13) ) {
                alt8=1;
            }
            else if ( (LA8_0==ID) ) {
                int LA8_2 = input.LA(2);

                if ( (LA8_2==14) ) {
                    alt8=1;
                }
                else if ( (LA8_2==16) ) {
                    alt8=2;
                }
                else {
                    NoViableAltException nvae =
                        new NoViableAltException("", 8, 2, input);

                    throw nvae;
                }
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 8, 0, input);

                throw nvae;
            }
            switch (alt8) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:129:4: ( '@' enclosing= ID '.' name= ID '(' ')' | name= ID '(' formalArgs ')' ) '::=' ( STRING | BIGSTRING | )
                    {
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:129:4: ( '@' enclosing= ID '.' name= ID '(' ')' | name= ID '(' formalArgs ')' )
                    int alt6=2;
                    int LA6_0 = input.LA(1);

                    if ( (LA6_0==13) ) {
                        alt6=1;
                    }
                    else if ( (LA6_0==ID) ) {
                        alt6=2;
                    }
                    else {
                        NoViableAltException nvae =
                            new NoViableAltException("", 6, 0, input);

                        throw nvae;
                    }
                    switch (alt6) {
                        case 1 :
                            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:129:6: '@' enclosing= ID '.' name= ID '(' ')'
                            {
                            match(input,13,FOLLOW_13_in_templateDef181); 
                            enclosing=(Token)match(input,ID,FOLLOW_ID_in_templateDef185); 
                            match(input,12,FOLLOW_12_in_templateDef187); 
                            name=(Token)match(input,ID,FOLLOW_ID_in_templateDef191); 
                            match(input,14,FOLLOW_14_in_templateDef193); 
                            match(input,15,FOLLOW_15_in_templateDef195); 

                            }
                            break;
                        case 2 :
                            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:130:5: name= ID '(' formalArgs ')'
                            {
                            name=(Token)match(input,ID,FOLLOW_ID_in_templateDef203); 
                            match(input,14,FOLLOW_14_in_templateDef205); 
                            pushFollow(FOLLOW_formalArgs_in_templateDef207);
                            formalArgs4=formalArgs();

                            state._fsp--;

                            match(input,15,FOLLOW_15_in_templateDef209); 

                            }
                            break;

                    }

                    match(input,16,FOLLOW_16_in_templateDef220); 
                    Token templateToken = input.LT(1);
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:134:6: ( STRING | BIGSTRING | )
                    int alt7=3;
                    switch ( input.LA(1) ) {
                    case STRING:
                        {
                        alt7=1;
                        }
                        break;
                    case BIGSTRING:
                        {
                        alt7=2;
                        }
                        break;
                    case EOF:
                    case ID:
                    case 13:
                        {
                        alt7=3;
                        }
                        break;
                    default:
                        NoViableAltException nvae =
                            new NoViableAltException("", 7, 0, input);

                        throw nvae;
                    }

                    switch (alt7) {
                        case 1 :
                            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:134:8: STRING
                            {
                            STRING2=(Token)match(input,STRING,FOLLOW_STRING_in_templateDef236); 
                            template=(STRING2!=null?STRING2.getText():null); n=1;

                            }
                            break;
                        case 2 :
                            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:135:8: BIGSTRING
                            {
                            BIGSTRING3=(Token)match(input,BIGSTRING,FOLLOW_BIGSTRING_in_templateDef251); 
                            template=(BIGSTRING3!=null?BIGSTRING3.getText():null); n=2;

                            }
                            break;
                        case 3 :
                            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:136:8: 
                            {

                            	    	template = "";
                            	    	String msg = "missing template at '"+input.LT(1).getText()+"'";
                                        NoViableAltException e = new NoViableAltException("", 0, 0, input);
                                	    group.errMgr.groupSyntaxError(ErrorType.SYNTAX_ERROR, getSourceName(), e, msg);
                                	    

                            }
                            break;

                    }


                            template = Misc.strip(template, n);
                            String templateName = (name!=null?name.getText():null);
                            if ( prefix.length()>0 ) templateName = prefix+"/"+(name!=null?name.getText():null);
                    	    group.defineTemplateOrRegion(templateName, (enclosing!=null?enclosing.getText():null), templateToken,
                    	    							 template, name, formalArgs4);
                    	    

                    }
                    break;
                case 2 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:150:6: alias= ID '::=' target= ID
                    {
                    alias=(Token)match(input,ID,FOLLOW_ID_in_templateDef286); 
                    match(input,16,FOLLOW_16_in_templateDef288); 
                    target=(Token)match(input,ID,FOLLOW_ID_in_templateDef292); 
                    group.defineTemplateAlias(alias, target);

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
    // $ANTLR end "templateDef"


    // $ANTLR start "formalArgs"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:153:1: formalArgs returns [List<FormalArgument> args] : ( formalArg[$args] ( ',' formalArg[$args] )* ( ',' formalArgWithDefaultValue[$args] )* | formalArgWithDefaultValue[$args] ( ',' formalArgWithDefaultValue[$args] )* | );
    public final List<FormalArgument> formalArgs() throws RecognitionException {
        List<FormalArgument> args = null;

        args = new ArrayList<FormalArgument>();
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:155:5: ( formalArg[$args] ( ',' formalArg[$args] )* ( ',' formalArgWithDefaultValue[$args] )* | formalArgWithDefaultValue[$args] ( ',' formalArgWithDefaultValue[$args] )* | )
            int alt12=3;
            int LA12_0 = input.LA(1);

            if ( (LA12_0==ID) ) {
                int LA12_1 = input.LA(2);

                if ( (LA12_1==15||LA12_1==17) ) {
                    alt12=1;
                }
                else if ( (LA12_1==18) ) {
                    alt12=2;
                }
                else {
                    NoViableAltException nvae =
                        new NoViableAltException("", 12, 1, input);

                    throw nvae;
                }
            }
            else if ( (LA12_0==15) ) {
                alt12=3;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 12, 0, input);

                throw nvae;
            }
            switch (alt12) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:155:7: formalArg[$args] ( ',' formalArg[$args] )* ( ',' formalArgWithDefaultValue[$args] )*
                    {
                    pushFollow(FOLLOW_formalArg_in_formalArgs317);
                    formalArg(args);

                    state._fsp--;

                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:156:6: ( ',' formalArg[$args] )*
                    loop9:
                    do {
                        int alt9=2;
                        int LA9_0 = input.LA(1);

                        if ( (LA9_0==17) ) {
                            int LA9_1 = input.LA(2);

                            if ( (LA9_1==ID) ) {
                                int LA9_3 = input.LA(3);

                                if ( (LA9_3==15||LA9_3==17) ) {
                                    alt9=1;
                                }


                            }


                        }


                        switch (alt9) {
                    	case 1 :
                    	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:156:8: ',' formalArg[$args]
                    	    {
                    	    match(input,17,FOLLOW_17_in_formalArgs327); 
                    	    pushFollow(FOLLOW_formalArg_in_formalArgs329);
                    	    formalArg(args);

                    	    state._fsp--;


                    	    }
                    	    break;

                    	default :
                    	    break loop9;
                        }
                    } while (true);

                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:157:6: ( ',' formalArgWithDefaultValue[$args] )*
                    loop10:
                    do {
                        int alt10=2;
                        int LA10_0 = input.LA(1);

                        if ( (LA10_0==17) ) {
                            alt10=1;
                        }


                        switch (alt10) {
                    	case 1 :
                    	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:157:8: ',' formalArgWithDefaultValue[$args]
                    	    {
                    	    match(input,17,FOLLOW_17_in_formalArgs342); 
                    	    pushFollow(FOLLOW_formalArgWithDefaultValue_in_formalArgs344);
                    	    formalArgWithDefaultValue(args);

                    	    state._fsp--;


                    	    }
                    	    break;

                    	default :
                    	    break loop10;
                        }
                    } while (true);


                    }
                    break;
                case 2 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:158:7: formalArgWithDefaultValue[$args] ( ',' formalArgWithDefaultValue[$args] )*
                    {
                    pushFollow(FOLLOW_formalArgWithDefaultValue_in_formalArgs356);
                    formalArgWithDefaultValue(args);

                    state._fsp--;

                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:158:40: ( ',' formalArgWithDefaultValue[$args] )*
                    loop11:
                    do {
                        int alt11=2;
                        int LA11_0 = input.LA(1);

                        if ( (LA11_0==17) ) {
                            alt11=1;
                        }


                        switch (alt11) {
                    	case 1 :
                    	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:158:42: ',' formalArgWithDefaultValue[$args]
                    	    {
                    	    match(input,17,FOLLOW_17_in_formalArgs361); 
                    	    pushFollow(FOLLOW_formalArgWithDefaultValue_in_formalArgs363);
                    	    formalArgWithDefaultValue(args);

                    	    state._fsp--;


                    	    }
                    	    break;

                    	default :
                    	    break loop11;
                        }
                    } while (true);


                    }
                    break;
                case 3 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:160:2: 
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
        return args;
    }
    // $ANTLR end "formalArgs"


    // $ANTLR start "formalArg"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:162:1: formalArg[List<FormalArgument> args] : ID ;
    public final void formalArg(List<FormalArgument> args) throws RecognitionException {
        Token ID5=null;

        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:163:2: ( ID )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:163:4: ID
            {
            ID5=(Token)match(input,ID,FOLLOW_ID_in_formalArg385); 
            args.add(new FormalArgument((ID5!=null?ID5.getText():null)));

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
    // $ANTLR end "formalArg"


    // $ANTLR start "formalArgWithDefaultValue"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:167:1: formalArgWithDefaultValue[List<FormalArgument> args] : ID ( '=' a= STRING | '=' a= ANONYMOUS_TEMPLATE ) ;
    public final void formalArgWithDefaultValue(List<FormalArgument> args) throws RecognitionException {
        Token a=null;
        Token ID6=null;

        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:168:2: ( ID ( '=' a= STRING | '=' a= ANONYMOUS_TEMPLATE ) )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:168:4: ID ( '=' a= STRING | '=' a= ANONYMOUS_TEMPLATE )
            {
            ID6=(Token)match(input,ID,FOLLOW_ID_in_formalArgWithDefaultValue404); 
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:169:3: ( '=' a= STRING | '=' a= ANONYMOUS_TEMPLATE )
            int alt13=2;
            int LA13_0 = input.LA(1);

            if ( (LA13_0==18) ) {
                int LA13_1 = input.LA(2);

                if ( (LA13_1==STRING) ) {
                    alt13=1;
                }
                else if ( (LA13_1==ANONYMOUS_TEMPLATE) ) {
                    alt13=2;
                }
                else {
                    NoViableAltException nvae =
                        new NoViableAltException("", 13, 1, input);

                    throw nvae;
                }
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 13, 0, input);

                throw nvae;
            }
            switch (alt13) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:169:5: '=' a= STRING
                    {
                    match(input,18,FOLLOW_18_in_formalArgWithDefaultValue410); 
                    a=(Token)match(input,STRING,FOLLOW_STRING_in_formalArgWithDefaultValue414); 

                    }
                    break;
                case 2 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:170:5: '=' a= ANONYMOUS_TEMPLATE
                    {
                    match(input,18,FOLLOW_18_in_formalArgWithDefaultValue420); 
                    a=(Token)match(input,ANONYMOUS_TEMPLATE,FOLLOW_ANONYMOUS_TEMPLATE_in_formalArgWithDefaultValue424); 

                    }
                    break;

            }

            args.add(new FormalArgument((ID6!=null?ID6.getText():null), a));

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
    // $ANTLR end "formalArgWithDefaultValue"


    // $ANTLR start "dictDef"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:184:1: dictDef : ID '::=' dict ;
    public final void dictDef() throws RecognitionException {
        Token ID7=null;
        Map<String,Object> dict8 = null;


        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:185:2: ( ID '::=' dict )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:185:4: ID '::=' dict
            {
            ID7=(Token)match(input,ID,FOLLOW_ID_in_dictDef449); 
            match(input,16,FOLLOW_16_in_dictDef451); 
            pushFollow(FOLLOW_dict_in_dictDef453);
            dict8=dict();

            state._fsp--;


                    if ( group.rawGetDictionary((ID7!=null?ID7.getText():null))!=null ) {
            			group.errMgr.compileTimeError(ErrorType.MAP_REDEFINITION, null, ID7);
                    }
                    else if ( group.rawGetTemplate((ID7!=null?ID7.getText():null))!=null ) {
            			group.errMgr.compileTimeError(ErrorType.TEMPLATE_REDEFINITION_AS_MAP, null, ID7);
                    }
                    else {
                        group.defineDictionary((ID7!=null?ID7.getText():null), dict8);
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
    // $ANTLR end "dictDef"


    // $ANTLR start "dict"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:199:1: dict returns [Map<String,Object> mapping] : '[' dictPairs[mapping] ']' ;
    public final Map<String,Object> dict() throws RecognitionException {
        Map<String,Object> mapping = null;

        mapping=new HashMap<String,Object>();
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:201:2: ( '[' dictPairs[mapping] ']' )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:201:6: '[' dictPairs[mapping] ']'
            {
            match(input,19,FOLLOW_19_in_dict485); 
            pushFollow(FOLLOW_dictPairs_in_dict487);
            dictPairs(mapping);

            state._fsp--;

            match(input,20,FOLLOW_20_in_dict490); 

            }

        }
        catch (RecognitionException re) {
            reportError(re);
            recover(input,re);
        }
        finally {
        }
        return mapping;
    }
    // $ANTLR end "dict"


    // $ANTLR start "dictPairs"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:204:1: dictPairs[Map<String,Object> mapping] : ( keyValuePair[mapping] ( ',' keyValuePair[mapping] )* ( ',' defaultValuePair[mapping] )? | defaultValuePair[mapping] );
    public final void dictPairs(Map<String,Object> mapping) throws RecognitionException {
        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:205:5: ( keyValuePair[mapping] ( ',' keyValuePair[mapping] )* ( ',' defaultValuePair[mapping] )? | defaultValuePair[mapping] )
            int alt16=2;
            int LA16_0 = input.LA(1);

            if ( (LA16_0==STRING) ) {
                alt16=1;
            }
            else if ( (LA16_0==21) ) {
                alt16=2;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 16, 0, input);

                throw nvae;
            }
            switch (alt16) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:205:7: keyValuePair[mapping] ( ',' keyValuePair[mapping] )* ( ',' defaultValuePair[mapping] )?
                    {
                    pushFollow(FOLLOW_keyValuePair_in_dictPairs505);
                    keyValuePair(mapping);

                    state._fsp--;

                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:206:6: ( ',' keyValuePair[mapping] )*
                    loop14:
                    do {
                        int alt14=2;
                        int LA14_0 = input.LA(1);

                        if ( (LA14_0==17) ) {
                            int LA14_1 = input.LA(2);

                            if ( (LA14_1==STRING) ) {
                                alt14=1;
                            }


                        }


                        switch (alt14) {
                    	case 1 :
                    	    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:206:7: ',' keyValuePair[mapping]
                    	    {
                    	    match(input,17,FOLLOW_17_in_dictPairs514); 
                    	    pushFollow(FOLLOW_keyValuePair_in_dictPairs516);
                    	    keyValuePair(mapping);

                    	    state._fsp--;


                    	    }
                    	    break;

                    	default :
                    	    break loop14;
                        }
                    } while (true);

                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:206:35: ( ',' defaultValuePair[mapping] )?
                    int alt15=2;
                    int LA15_0 = input.LA(1);

                    if ( (LA15_0==17) ) {
                        alt15=1;
                    }
                    switch (alt15) {
                        case 1 :
                            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:206:36: ',' defaultValuePair[mapping]
                            {
                            match(input,17,FOLLOW_17_in_dictPairs522); 
                            pushFollow(FOLLOW_defaultValuePair_in_dictPairs524);
                            defaultValuePair(mapping);

                            state._fsp--;


                            }
                            break;

                    }


                    }
                    break;
                case 2 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:207:7: defaultValuePair[mapping]
                    {
                    pushFollow(FOLLOW_defaultValuePair_in_dictPairs535);
                    defaultValuePair(mapping);

                    state._fsp--;


                    }
                    break;

            }
        }
        catch (RecognitionException re) {

            		error("missing dictionary entry at '"+input.LT(1).getText()+"'");
            	
        }
        finally {
        }
        return ;
    }
    // $ANTLR end "dictPairs"


    // $ANTLR start "defaultValuePair"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:213:1: defaultValuePair[Map<String,Object> mapping] : 'default' ':' keyValue ;
    public final void defaultValuePair(Map<String,Object> mapping) throws RecognitionException {
        Object keyValue9 = null;


        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:214:2: ( 'default' ':' keyValue )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:214:4: 'default' ':' keyValue
            {
            match(input,21,FOLLOW_21_in_defaultValuePair558); 
            match(input,22,FOLLOW_22_in_defaultValuePair560); 
            pushFollow(FOLLOW_keyValue_in_defaultValuePair562);
            keyValue9=keyValue();

            state._fsp--;

            mapping.put(STGroup.DEFAULT_KEY, keyValue9);

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
    // $ANTLR end "defaultValuePair"


    // $ANTLR start "keyValuePair"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:217:1: keyValuePair[Map<String,Object> mapping] : STRING ':' keyValue ;
    public final void keyValuePair(Map<String,Object> mapping) throws RecognitionException {
        Token STRING10=null;
        Object keyValue11 = null;


        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:218:2: ( STRING ':' keyValue )
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:218:4: STRING ':' keyValue
            {
            STRING10=(Token)match(input,STRING,FOLLOW_STRING_in_keyValuePair576); 
            match(input,22,FOLLOW_22_in_keyValuePair578); 
            pushFollow(FOLLOW_keyValue_in_keyValuePair580);
            keyValue11=keyValue();

            state._fsp--;

            mapping.put(Misc.replaceEscapes(Misc.strip((STRING10!=null?STRING10.getText():null), 1)), keyValue11);

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
    // $ANTLR end "keyValuePair"


    // $ANTLR start "keyValue"
    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:221:1: keyValue returns [Object value] : ( BIGSTRING | ANONYMOUS_TEMPLATE | STRING | {...}? => ID );
    public final Object keyValue() throws RecognitionException {
        Object value = null;

        Token BIGSTRING12=null;
        Token ANONYMOUS_TEMPLATE13=null;
        Token STRING14=null;

        try {
            // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:222:2: ( BIGSTRING | ANONYMOUS_TEMPLATE | STRING | {...}? => ID )
            int alt17=4;
            int LA17_0 = input.LA(1);

            if ( (LA17_0==BIGSTRING) ) {
                alt17=1;
            }
            else if ( (LA17_0==ANONYMOUS_TEMPLATE) ) {
                alt17=2;
            }
            else if ( (LA17_0==STRING) ) {
                alt17=3;
            }
            else if ( (LA17_0==ID) && ((input.LT(1).getText().equals("key")))) {
                alt17=4;
            }
            else {
                NoViableAltException nvae =
                    new NoViableAltException("", 17, 0, input);

                throw nvae;
            }
            switch (alt17) {
                case 1 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:222:4: BIGSTRING
                    {
                    BIGSTRING12=(Token)match(input,BIGSTRING,FOLLOW_BIGSTRING_in_keyValue597); 
                    value = group.createSingleton(BIGSTRING12);

                    }
                    break;
                case 2 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:223:4: ANONYMOUS_TEMPLATE
                    {
                    ANONYMOUS_TEMPLATE13=(Token)match(input,ANONYMOUS_TEMPLATE,FOLLOW_ANONYMOUS_TEMPLATE_in_keyValue606); 
                    value = group.createSingleton(ANONYMOUS_TEMPLATE13);

                    }
                    break;
                case 3 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:224:4: STRING
                    {
                    STRING14=(Token)match(input,STRING,FOLLOW_STRING_in_keyValue613); 
                    value = Misc.replaceEscapes(Misc.strip((STRING14!=null?STRING14.getText():null), 1));

                    }
                    break;
                case 4 :
                    // /Users/acondit/source/antlr3/acondit_localhost/code/ST4/objc/main/compiler/Group.g:225:4: {...}? => ID
                    {
                    if ( !((input.LT(1).getText().equals("key"))) ) {
                        throw new FailedPredicateException(input, "keyValue", "input.LT(1).getText().equals(\"key\")");
                    }
                    match(input,ID,FOLLOW_ID_in_keyValue626); 
                    value = STGroup.DICT_KEY;

                    }
                    break;

            }
        }
        catch (RecognitionException re) {

            		error("missing value for key at '"+input.LT(1).getText()+"'");
            	
        }
        finally {
        }
        return value;
    }
    // $ANTLR end "keyValue"

    // Delegated rules


 

    public static final BitSet FOLLOW_11_in_group51 = new BitSet(new long[]{0x0000000000000010L});
    public static final BitSet FOLLOW_STRING_in_group53 = new BitSet(new long[]{0x0000000000002820L});
    public static final BitSet FOLLOW_11_in_group61 = new BitSet(new long[]{0x0000000000000020L});
    public static final BitSet FOLLOW_ID_in_group72 = new BitSet(new long[]{0x0000000000003820L});
    public static final BitSet FOLLOW_12_in_group75 = new BitSet(new long[]{0x0000000000000020L});
    public static final BitSet FOLLOW_ID_in_group77 = new BitSet(new long[]{0x0000000000003820L});
    public static final BitSet FOLLOW_def_in_group95 = new BitSet(new long[]{0x0000000000002022L});
    public static final BitSet FOLLOW_ID_in_groupName126 = new BitSet(new long[]{0x0000000000001002L});
    public static final BitSet FOLLOW_12_in_groupName131 = new BitSet(new long[]{0x0000000000000020L});
    public static final BitSet FOLLOW_ID_in_groupName135 = new BitSet(new long[]{0x0000000000001002L});
    public static final BitSet FOLLOW_templateDef_in_def152 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_dictDef_in_def157 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_13_in_templateDef181 = new BitSet(new long[]{0x0000000000000020L});
    public static final BitSet FOLLOW_ID_in_templateDef185 = new BitSet(new long[]{0x0000000000001000L});
    public static final BitSet FOLLOW_12_in_templateDef187 = new BitSet(new long[]{0x0000000000000020L});
    public static final BitSet FOLLOW_ID_in_templateDef191 = new BitSet(new long[]{0x0000000000004000L});
    public static final BitSet FOLLOW_14_in_templateDef193 = new BitSet(new long[]{0x0000000000008000L});
    public static final BitSet FOLLOW_15_in_templateDef195 = new BitSet(new long[]{0x0000000000010000L});
    public static final BitSet FOLLOW_ID_in_templateDef203 = new BitSet(new long[]{0x0000000000004000L});
    public static final BitSet FOLLOW_14_in_templateDef205 = new BitSet(new long[]{0x0000000000008020L});
    public static final BitSet FOLLOW_formalArgs_in_templateDef207 = new BitSet(new long[]{0x0000000000008000L});
    public static final BitSet FOLLOW_15_in_templateDef209 = new BitSet(new long[]{0x0000000000010000L});
    public static final BitSet FOLLOW_16_in_templateDef220 = new BitSet(new long[]{0x0000000000000052L});
    public static final BitSet FOLLOW_STRING_in_templateDef236 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_BIGSTRING_in_templateDef251 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ID_in_templateDef286 = new BitSet(new long[]{0x0000000000010000L});
    public static final BitSet FOLLOW_16_in_templateDef288 = new BitSet(new long[]{0x0000000000000020L});
    public static final BitSet FOLLOW_ID_in_templateDef292 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_formalArg_in_formalArgs317 = new BitSet(new long[]{0x0000000000020002L});
    public static final BitSet FOLLOW_17_in_formalArgs327 = new BitSet(new long[]{0x0000000000000020L});
    public static final BitSet FOLLOW_formalArg_in_formalArgs329 = new BitSet(new long[]{0x0000000000020002L});
    public static final BitSet FOLLOW_17_in_formalArgs342 = new BitSet(new long[]{0x0000000000000020L});
    public static final BitSet FOLLOW_formalArgWithDefaultValue_in_formalArgs344 = new BitSet(new long[]{0x0000000000020002L});
    public static final BitSet FOLLOW_formalArgWithDefaultValue_in_formalArgs356 = new BitSet(new long[]{0x0000000000020002L});
    public static final BitSet FOLLOW_17_in_formalArgs361 = new BitSet(new long[]{0x0000000000000020L});
    public static final BitSet FOLLOW_formalArgWithDefaultValue_in_formalArgs363 = new BitSet(new long[]{0x0000000000020002L});
    public static final BitSet FOLLOW_ID_in_formalArg385 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ID_in_formalArgWithDefaultValue404 = new BitSet(new long[]{0x0000000000040000L});
    public static final BitSet FOLLOW_18_in_formalArgWithDefaultValue410 = new BitSet(new long[]{0x0000000000000010L});
    public static final BitSet FOLLOW_STRING_in_formalArgWithDefaultValue414 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_18_in_formalArgWithDefaultValue420 = new BitSet(new long[]{0x0000000000000080L});
    public static final BitSet FOLLOW_ANONYMOUS_TEMPLATE_in_formalArgWithDefaultValue424 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ID_in_dictDef449 = new BitSet(new long[]{0x0000000000010000L});
    public static final BitSet FOLLOW_16_in_dictDef451 = new BitSet(new long[]{0x0000000000080000L});
    public static final BitSet FOLLOW_dict_in_dictDef453 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_19_in_dict485 = new BitSet(new long[]{0x0000000000200010L});
    public static final BitSet FOLLOW_dictPairs_in_dict487 = new BitSet(new long[]{0x0000000000100000L});
    public static final BitSet FOLLOW_20_in_dict490 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_keyValuePair_in_dictPairs505 = new BitSet(new long[]{0x0000000000020002L});
    public static final BitSet FOLLOW_17_in_dictPairs514 = new BitSet(new long[]{0x0000000000000010L});
    public static final BitSet FOLLOW_keyValuePair_in_dictPairs516 = new BitSet(new long[]{0x0000000000020002L});
    public static final BitSet FOLLOW_17_in_dictPairs522 = new BitSet(new long[]{0x0000000000200010L});
    public static final BitSet FOLLOW_defaultValuePair_in_dictPairs524 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_defaultValuePair_in_dictPairs535 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_21_in_defaultValuePair558 = new BitSet(new long[]{0x0000000000400000L});
    public static final BitSet FOLLOW_22_in_defaultValuePair560 = new BitSet(new long[]{0x00000000000000F0L});
    public static final BitSet FOLLOW_keyValue_in_defaultValuePair562 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_STRING_in_keyValuePair576 = new BitSet(new long[]{0x0000000000400000L});
    public static final BitSet FOLLOW_22_in_keyValuePair578 = new BitSet(new long[]{0x00000000000000F0L});
    public static final BitSet FOLLOW_keyValue_in_keyValuePair580 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_BIGSTRING_in_keyValue597 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ANONYMOUS_TEMPLATE_in_keyValue606 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_STRING_in_keyValue613 = new BitSet(new long[]{0x0000000000000002L});
    public static final BitSet FOLLOW_ID_in_keyValue626 = new BitSet(new long[]{0x0000000000000002L});

}