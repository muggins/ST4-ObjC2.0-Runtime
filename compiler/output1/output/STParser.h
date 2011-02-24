#import "ErrorManager.h"
#import "ErrorType.h"
#import "NSMutableArray.h"
#import "NSMutableArray.h"
#import "NSMutableArray.h"

@interface templateAndEOF_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface template_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface element_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface text_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface exprTag_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface region_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface subtemplate_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface ifstat_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface conditional_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface andConditional_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface notConditional_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface notConditionalExpr_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface exprOptions_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface option_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface exprNoComma_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface expr_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface mapExpr_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface mapTemplateRef_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface memberExpr_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface includeExpr_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface primary_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface args_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface argExprList_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface arg_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface namedArg_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface list_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface listElement_return : ParserRuleReturnScope {
  CommonTree * tree;
}

@property(nonatomic, retain, readonly) NSObject * tree;
@end

@interface DFA2 : DFA {
}

@property(nonatomic, retain, readonly) NSString * description;
- (id) initWithRecognizer:(BaseRecognizer *)recognizer;
@end

@interface DFA28 : DFA {
}

@property(nonatomic, retain, readonly) NSString * description;
- (id) initWithRecognizer:(BaseRecognizer *)recognizer;
- (int) specialStateTransition:(int)s _input:(IntStream *)_input;
@end

/**
 * Build an AST from a single StringTemplate template
 */

extern NSArray * const tokenNames;
extern int const EOF;
extern int const RBRACK;
extern int const LBRACK;
extern int const ELSE;
extern int const ELLIPSIS;
extern int const LCURLY;
extern int const BANG;
extern int const EQUALS;
extern int const TEXT;
extern int const ID;
extern int const SEMI;
extern int const LPAREN;
extern int const IF;
extern int const ELSEIF;
extern int const COLON;
extern int const RPAREN;
extern int const WS;
extern int const COMMA;
extern int const RCURLY;
extern int const ENDIF;
extern int const RDELIM;
extern int const SUPER;
extern int const DOT;
extern int const LDELIM;
extern int const STRING;
extern int const PIPE;
extern int const OR;
extern int const AND;
extern int const INDENT;
extern int const NEWLINE;
extern int const AT;
extern int const END;
extern int const EXPR;
extern int const OPTIONS;
extern int const PROP;
extern int const PROP_IND;
extern int const INCLUDE;
extern int const INCLUDE_IND;
extern int const EXEC_FUNC;
extern int const INCLUDE_SUPER;
extern int const INCLUDE_SUPER_REGION;
extern int const INCLUDE_REGION;
extern int const TO_STR;
extern int const LIST;
extern int const MAP;
extern int const ZIP;
extern int const SUBTEMPLATE;
extern int const ARGS;
extern int const ELEMENTS;
extern int const REGION;
extern int const NULL;
extern BitSet * const FOLLOW_template_in_templateAndEOF130;
extern BitSet * const FOLLOW_EOF_in_templateAndEOF132;
extern BitSet * const FOLLOW_element_in_template146;
extern BitSet * const FOLLOW_INDENT_in_element157;
extern BitSet * const FOLLOW_element_in_element159;
extern BitSet * const FOLLOW_ifstat_in_element172;
extern BitSet * const FOLLOW_exprTag_in_element177;
extern BitSet * const FOLLOW_text_in_element182;
extern BitSet * const FOLLOW_region_in_element187;
extern BitSet * const FOLLOW_NEWLINE_in_element192;
extern BitSet * const FOLLOW_TEXT_in_text202;
extern BitSet * const FOLLOW_LDELIM_in_exprTag212;
extern BitSet * const FOLLOW_expr_in_exprTag214;
extern BitSet * const FOLLOW_SEMI_in_exprTag218;
extern BitSet * const FOLLOW_exprOptions_in_exprTag220;
extern BitSet * const FOLLOW_RDELIM_in_exprTag225;
extern BitSet * const FOLLOW_LDELIM_in_region249;
extern BitSet * const FOLLOW_AT_in_region251;
extern BitSet * const FOLLOW_ID_in_region253;
extern BitSet * const FOLLOW_RDELIM_in_region255;
extern BitSet * const FOLLOW_template_in_region257;
extern BitSet * const FOLLOW_LDELIM_in_region259;
extern BitSet * const FOLLOW_END_in_region261;
extern BitSet * const FOLLOW_RDELIM_in_region263;
extern BitSet * const FOLLOW_LCURLY_in_subtemplate285;
extern BitSet * const FOLLOW_ID_in_subtemplate291;
extern BitSet * const FOLLOW_COMMA_in_subtemplate295;
extern BitSet * const FOLLOW_ID_in_subtemplate300;
extern BitSet * const FOLLOW_PIPE_in_subtemplate305;
extern BitSet * const FOLLOW_template_in_subtemplate310;
extern BitSet * const FOLLOW_INDENT_in_subtemplate312;
extern BitSet * const FOLLOW_RCURLY_in_subtemplate315;
extern BitSet * const FOLLOW_LDELIM_in_ifstat349;
extern BitSet * const FOLLOW_IF_in_ifstat351;
extern BitSet * const FOLLOW_LPAREN_in_ifstat353;
extern BitSet * const FOLLOW_conditional_in_ifstat357;
extern BitSet * const FOLLOW_RPAREN_in_ifstat359;
extern BitSet * const FOLLOW_RDELIM_in_ifstat361;
extern BitSet * const FOLLOW_template_in_ifstat368;
extern BitSet * const FOLLOW_INDENT_in_ifstat375;
extern BitSet * const FOLLOW_LDELIM_in_ifstat378;
extern BitSet * const FOLLOW_ELSEIF_in_ifstat380;
extern BitSet * const FOLLOW_LPAREN_in_ifstat382;
extern BitSet * const FOLLOW_conditional_in_ifstat386;
extern BitSet * const FOLLOW_RPAREN_in_ifstat388;
extern BitSet * const FOLLOW_RDELIM_in_ifstat390;
extern BitSet * const FOLLOW_template_in_ifstat394;
extern BitSet * const FOLLOW_INDENT_in_ifstat404;
extern BitSet * const FOLLOW_LDELIM_in_ifstat407;
extern BitSet * const FOLLOW_ELSE_in_ifstat409;
extern BitSet * const FOLLOW_RDELIM_in_ifstat411;
extern BitSet * const FOLLOW_template_in_ifstat415;
extern BitSet * const FOLLOW_INDENT_in_ifstat423;
extern BitSet * const FOLLOW_LDELIM_in_ifstat429;
extern BitSet * const FOLLOW_ENDIF_in_ifstat431;
extern BitSet * const FOLLOW_RDELIM_in_ifstat435;
extern BitSet * const FOLLOW_NEWLINE_in_ifstat446;
extern BitSet * const FOLLOW_andConditional_in_conditional493;
extern BitSet * const FOLLOW_OR_in_conditional497;
extern BitSet * const FOLLOW_andConditional_in_conditional500;
extern BitSet * const FOLLOW_notConditional_in_andConditional512;
extern BitSet * const FOLLOW_AND_in_andConditional516;
extern BitSet * const FOLLOW_notConditional_in_andConditional519;
extern BitSet * const FOLLOW_BANG_in_notConditional533;
extern BitSet * const FOLLOW_notConditionalExpr_in_notConditional536;
extern BitSet * const FOLLOW_BANG_in_notConditional540;
extern BitSet * const FOLLOW_LPAREN_in_notConditional543;
extern BitSet * const FOLLOW_conditional_in_notConditional546;
extern BitSet * const FOLLOW_RPAREN_in_notConditional548;
extern BitSet * const FOLLOW_memberExpr_in_notConditional553;
extern BitSet * const FOLLOW_ID_in_notConditionalExpr565;
extern BitSet * const FOLLOW_DOT_in_notConditionalExpr576;
extern BitSet * const FOLLOW_ID_in_notConditionalExpr580;
extern BitSet * const FOLLOW_DOT_in_notConditionalExpr606;
extern BitSet * const FOLLOW_LPAREN_in_notConditionalExpr608;
extern BitSet * const FOLLOW_mapExpr_in_notConditionalExpr610;
extern BitSet * const FOLLOW_RPAREN_in_notConditionalExpr612;
extern BitSet * const FOLLOW_option_in_exprOptions642;
extern BitSet * const FOLLOW_COMMA_in_exprOptions646;
extern BitSet * const FOLLOW_option_in_exprOptions648;
extern BitSet * const FOLLOW_ID_in_option675;
extern BitSet * const FOLLOW_EQUALS_in_option685;
extern BitSet * const FOLLOW_exprNoComma_in_option687;
extern BitSet * const FOLLOW_memberExpr_in_exprNoComma794;
extern BitSet * const FOLLOW_COLON_in_exprNoComma800;
extern BitSet * const FOLLOW_mapTemplateRef_in_exprNoComma802;
extern BitSet * const FOLLOW_mapExpr_in_expr847;
extern BitSet * const FOLLOW_memberExpr_in_mapExpr859;
extern BitSet * const FOLLOW_COMMA_in_mapExpr868;
extern BitSet * const FOLLOW_memberExpr_in_mapExpr870;
extern BitSet * const FOLLOW_COLON_in_mapExpr876;
extern BitSet * const FOLLOW_mapTemplateRef_in_mapExpr878;
extern BitSet * const FOLLOW_COLON_in_mapExpr941;
extern BitSet * const FOLLOW_mapTemplateRef_in_mapExpr945;
extern BitSet * const FOLLOW_COMMA_in_mapExpr951;
extern BitSet * const FOLLOW_mapTemplateRef_in_mapExpr955;
extern BitSet * const FOLLOW_ID_in_mapTemplateRef1002;
extern BitSet * const FOLLOW_LPAREN_in_mapTemplateRef1004;
extern BitSet * const FOLLOW_args_in_mapTemplateRef1006;
extern BitSet * const FOLLOW_RPAREN_in_mapTemplateRef1008;
extern BitSet * const FOLLOW_subtemplate_in_mapTemplateRef1030;
extern BitSet * const FOLLOW_LPAREN_in_mapTemplateRef1037;
extern BitSet * const FOLLOW_mapExpr_in_mapTemplateRef1039;
extern BitSet * const FOLLOW_RPAREN_in_mapTemplateRef1043;
extern BitSet * const FOLLOW_LPAREN_in_mapTemplateRef1045;
extern BitSet * const FOLLOW_argExprList_in_mapTemplateRef1047;
extern BitSet * const FOLLOW_RPAREN_in_mapTemplateRef1050;
extern BitSet * const FOLLOW_includeExpr_in_memberExpr1072;
extern BitSet * const FOLLOW_DOT_in_memberExpr1083;
extern BitSet * const FOLLOW_ID_in_memberExpr1085;
extern BitSet * const FOLLOW_DOT_in_memberExpr1111;
extern BitSet * const FOLLOW_LPAREN_in_memberExpr1113;
extern BitSet * const FOLLOW_mapExpr_in_memberExpr1115;
extern BitSet * const FOLLOW_RPAREN_in_memberExpr1117;
extern BitSet * const FOLLOW_ID_in_includeExpr1161;
extern BitSet * const FOLLOW_LPAREN_in_includeExpr1163;
extern BitSet * const FOLLOW_expr_in_includeExpr1165;
extern BitSet * const FOLLOW_RPAREN_in_includeExpr1168;
extern BitSet * const FOLLOW_SUPER_in_includeExpr1189;
extern BitSet * const FOLLOW_DOT_in_includeExpr1191;
extern BitSet * const FOLLOW_ID_in_includeExpr1193;
extern BitSet * const FOLLOW_LPAREN_in_includeExpr1195;
extern BitSet * const FOLLOW_args_in_includeExpr1197;
extern BitSet * const FOLLOW_RPAREN_in_includeExpr1199;
extern BitSet * const FOLLOW_ID_in_includeExpr1218;
extern BitSet * const FOLLOW_LPAREN_in_includeExpr1220;
extern BitSet * const FOLLOW_args_in_includeExpr1222;
extern BitSet * const FOLLOW_RPAREN_in_includeExpr1224;
extern BitSet * const FOLLOW_AT_in_includeExpr1246;
extern BitSet * const FOLLOW_SUPER_in_includeExpr1248;
extern BitSet * const FOLLOW_DOT_in_includeExpr1250;
extern BitSet * const FOLLOW_ID_in_includeExpr1252;
extern BitSet * const FOLLOW_LPAREN_in_includeExpr1254;
extern BitSet * const FOLLOW_RPAREN_in_includeExpr1258;
extern BitSet * const FOLLOW_AT_in_includeExpr1273;
extern BitSet * const FOLLOW_ID_in_includeExpr1275;
extern BitSet * const FOLLOW_LPAREN_in_includeExpr1277;
extern BitSet * const FOLLOW_RPAREN_in_includeExpr1281;
extern BitSet * const FOLLOW_primary_in_includeExpr1299;
extern BitSet * const FOLLOW_ID_in_primary1310;
extern BitSet * const FOLLOW_STRING_in_primary1315;
extern BitSet * const FOLLOW_subtemplate_in_primary1320;
extern BitSet * const FOLLOW_list_in_primary1325;
extern BitSet * const FOLLOW_LPAREN_in_primary1332;
extern BitSet * const FOLLOW_expr_in_primary1334;
extern BitSet * const FOLLOW_RPAREN_in_primary1336;
extern BitSet * const FOLLOW_LPAREN_in_primary1342;
extern BitSet * const FOLLOW_argExprList_in_primary1344;
extern BitSet * const FOLLOW_RPAREN_in_primary1347;
extern BitSet * const FOLLOW_argExprList_in_args1397;
extern BitSet * const FOLLOW_namedArg_in_args1402;
extern BitSet * const FOLLOW_COMMA_in_args1406;
extern BitSet * const FOLLOW_namedArg_in_args1408;
extern BitSet * const FOLLOW_arg_in_argExprList1429;
extern BitSet * const FOLLOW_COMMA_in_argExprList1433;
extern BitSet * const FOLLOW_arg_in_argExprList1435;
extern BitSet * const FOLLOW_exprNoComma_in_arg1452;
extern BitSet * const FOLLOW_ID_in_namedArg1461;
extern BitSet * const FOLLOW_EQUALS_in_namedArg1463;
extern BitSet * const FOLLOW_arg_in_namedArg1465;
extern BitSet * const FOLLOW_LBRACK_in_list1490;
extern BitSet * const FOLLOW_RBRACK_in_list1492;
extern BitSet * const FOLLOW_LBRACK_in_list1504;
extern BitSet * const FOLLOW_listElement_in_list1506;
extern BitSet * const FOLLOW_COMMA_in_list1510;
extern BitSet * const FOLLOW_listElement_in_list1512;
extern BitSet * const FOLLOW_RBRACK_in_list1517;
extern BitSet * const FOLLOW_exprNoComma_in_listElement1537;

@interface STParser : Parser {
  TreeAdaptor * adaptor;
  ErrorManager * errMgr;
  Token * templateToken;
  DFA2 * dfa2;
  DFA28 * dfa28;
}

@property(nonatomic, retain) TreeAdaptor * treeAdaptor;
@property(nonatomic, retain, readonly) NSArray * tokenNames;
@property(nonatomic, retain, readonly) NSString * grammarFileName;
- (id) initWithInput:(TokenStream *)input;
- (id) init:(TokenStream *)input state:(RecognizerSharedState *)state;
- (void) setTreeAdaptor:(TreeAdaptor *)adaptor;
- (id) init:(TokenStream *)input errMgr:(ErrorManager *)errMgr templateToken:(Token *)templateToken;
- (NSObject *) recoverFromMismatchedToken:(IntStream *)input ttype:(int)ttype follow:(BitSet *)follow;
- (templateAndEOF_return *) templateAndEOF;
- (template_return *) template;
- (element_return *) element;
- (text_return *) text;
- (exprTag_return *) exprTag;
- (region_return *) region;
- (subtemplate_return *) subtemplate;
- (ifstat_return *) ifstat;
- (conditional_return *) conditional;
- (andConditional_return *) andConditional;
- (notConditional_return *) notConditional;
- (notConditionalExpr_return *) notConditionalExpr;
- (exprOptions_return *) exprOptions;
- (option_return *) option;
- (exprNoComma_return *) exprNoComma;
- (expr_return *) expr;
- (mapExpr_return *) mapExpr;
- (mapTemplateRef_return *) mapTemplateRef;
- (memberExpr_return *) memberExpr;
- (includeExpr_return *) includeExpr;
- (primary_return *) primary;
- (args_return *) args;
- (argExprList_return *) argExprList;
- (arg_return *) arg;
- (namedArg_return *) namedArg;
- (list_return *) list;
- (listElement_return *) listElement;
+ (void) initialize;
@end
