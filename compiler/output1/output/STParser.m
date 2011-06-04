/* generated from Java Source and Java2ObjC */

#import "STParser.h"

@implementation templateAndEOF_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation template_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation element_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation text_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation exprTag_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation region_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation subtemplate_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation ifstat_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation conditional_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation andConditional_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation notConditional_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation notConditionalExpr_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation exprOptions_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation option_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation exprNoComma_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation expr_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation mapExpr_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation mapTemplateRef_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation memberExpr_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation includeExpr_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation primary_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation args_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation argExprList_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation arg_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation namedArg_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation list_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation listElement_return

@synthesize tree;

- (void) dealloc {
  if ( tree ) [tree release];
  [super dealloc];
}

@end

@implementation DFA2

@synthesize description;

- (id) initWithRecognizer:(BaseRecognizer *)recognizer {
  if (self = [super init]) {
    recognizer = recognizer;
    decisionNumber = 2;
    eot = DFA2_eot;
    eof = DFA2_eof;
    min = DFA2_min;
    max = DFA2_max;
    accept = DFA2_accept;
    special = DFA2_special;
    transition = DFA2_transition;
  }
  return self;
}

@end

@implementation DFA28

@synthesize description;

- (id) initWithRecognizer:(BaseRecognizer *)recognizer {
  if (self = [super init]) {
    recognizer = recognizer;
    decisionNumber = 28;
    eot = DFA28_eot;
    eof = DFA28_eof;
    min = DFA28_min;
    max = DFA28_max;
    accept = DFA28_accept;
    special = DFA28_special;
    transition = DFA28_transition;
  }
  return self;
}

- (int) specialStateTransition:(int)s _input:(IntStream *)_input {
  TokenStream * input = (TokenStream *)_input;
  int _s = s;

  switch (s) {
  case 0:
    int LA28_8 = [input LA:1];
    int index28_8 = [input index];
    [input rewind];
    s = -1;
    if ((([Compiler.funcs containsKey:[[input LT:1] text]]))) {
      s = 20;
    }
     else if ((YES)) {
      s = 21;
    }
    [input seek:index28_8];
    if (s >= 0)
      return s;
    break;
  }
  NoViableAltException * nvae = [[[NoViableAltException alloc] init:[self description] param1:28 param2:_s param3:input] autorelease];
  [self error:nvae];
  @throw nvae;
}

@end

NSArray * const tokenNames = [NSArray arrayWithObjects:@"<invalid>", @"<EOR>", @"<DOWN>", @"<UP>", @"IF", @"ELSE", @"ELSEIF", @"ENDIF", @"SUPER", @"SEMI", @"BANG", @"ELLIPSIS", @"EQUALS", @"COLON", @"LPAREN", @"RPAREN", @"LBRACK", @"RBRACK", @"COMMA", @"DOT", @"LCURLY", @"RCURLY", @"TEXT", @"LDELIM", @"RDELIM", @"ID", @"STRING", @"WS", @"PIPE", @"OR", @"AND", @"INDENT", @"NEWLINE", @"AT", @"END", @"EXPR", @"OPTIONS", @"PROP", @"PROP_IND", @"INCLUDE", @"INCLUDE_IND", @"EXEC_FUNC", @"INCLUDE_SUPER", @"INCLUDE_SUPER_REGION", @"INCLUDE_REGION", @"TO_STR", @"LIST", @"MAP", @"ZIP", @"SUBTEMPLATE", @"ARGS", @"ELEMENTS", @"REGION", @"NULL", nil];
int const EOF = -1;
int const RBRACK = 17;
int const LBRACK = 16;
int const ELSE = 5;
int const ELLIPSIS = 11;
int const LCURLY = 20;
int const BANG = 10;
int const EQUALS = 12;
int const TEXT = 22;
int const ID = 25;
int const SEMI = 9;
int const LPAREN = 14;
int const IF = 4;
int const ELSEIF = 6;
int const COLON = 13;
int const RPAREN = 15;
int const WS = 27;
int const COMMA = 18;
int const RCURLY = 21;
int const ENDIF = 7;
int const RDELIM = 24;
int const SUPER = 8;
int const DOT = 19;
int const LDELIM = 23;
int const STRING = 26;
int const PIPE = 28;
int const OR = 29;
int const AND = 30;
int const INDENT = 31;
int const NEWLINE = 32;
int const AT = 33;
int const END = 34;
int const EXPR = 35;
int const OPTIONS = 36;
int const PROP = 37;
int const PROP_IND = 38;
int const INCLUDE = 39;
int const INCLUDE_IND = 40;
int const EXEC_FUNC = 41;
int const INCLUDE_SUPER = 42;
int const INCLUDE_SUPER_REGION = 43;
int const INCLUDE_REGION = 44;
int const TO_STR = 45;
int const LIST = 46;
int const MAP = 47;
int const ZIP = 48;
int const SUBTEMPLATE = 49;
int const ARGS = 50;
int const ELEMENTS = 51;
int const REGION = 52;
int const NULL = 53;
NSString * const DFA2_eotS = @"\12?";
NSString * const DFA2_eofS = @"\12?";
NSString * const DFA2_minS = @"\1\26\1?\1\4\3?\1\10\1?\1\16\1?";
NSString * const DFA2_maxS = @"\1\40\1?\1\41\3?\1\31\1?\1\30\1?";
NSString * const DFA2_acceptS = @"\1?\1\1\1?\1\4\1\6\1\2\1?\1\3\1?\1\5";
NSString * const DFA2_specialS = @"\12?}>";
NSArray * const DFA2_transitionS = [NSArray arrayWithObjects:@"\1\3\1\2\7?\1\1\1\4", @"", [@"\1\5\3?\1\7\5?\1\7\1?\1\7\3?\1\7\4?" stringByAppendingString:@"\2\7\6?\1\6"], @"", @"", @"", @"\1\7\20?\1\10", @"", @"\1\7\11?\1\11", @"", nil];
NSArray * const DFA2_eot = [DFA unpackEncodedString:DFA2_eotS];
NSArray * const DFA2_eof = [DFA unpackEncodedString:DFA2_eofS];
NSArray * const DFA2_min = [DFA unpackEncodedStringToUnsignedChars:DFA2_minS];
NSArray * const DFA2_max = [DFA unpackEncodedStringToUnsignedChars:DFA2_maxS];
NSArray * const DFA2_accept = [DFA unpackEncodedString:DFA2_acceptS];
NSArray * const DFA2_special = [DFA unpackEncodedString:DFA2_specialS];
NSArray * const DFA2_transition;
NSString * const DFA28_eotS = @"\26?";
NSString * const DFA28_eofS = @"\26?";
NSString * const DFA28_minS = @"\1\10\1\11\1?\1\10\4?\1\0\15?";
NSString * const DFA28_maxS = @"\1\41\1\36\1?\1\31\4?\1\0\15?";
NSString * const DFA28_acceptS = @"\2?\1\2\1?\1\6\15?\1\4\1\5\1\1\1\3";
NSString * const DFA28_specialS = @"\10?\1\0\15?}>";
NSArray * const DFA28_transitionS = [NSArray arrayWithObjects:[@"\1\2\5?\1\4\1?\1\4\3?\1\4\4?\1\1\1\4\6?" stringByAppendingString:@"\1\3"], [@"\1\4\3?\1\4\1\10\1\4\1?\3\4\4?\1\4\4?\2" stringByAppendingString:@"\4"], @"", @"\1\22\20?\1\23", @"", @"", @"", @"", @"\1?", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil];
NSArray * const DFA28_eot = [DFA unpackEncodedString:DFA28_eotS];
NSArray * const DFA28_eof = [DFA unpackEncodedString:DFA28_eofS];
NSArray * const DFA28_min = [DFA unpackEncodedStringToUnsignedChars:DFA28_minS];
NSArray * const DFA28_max = [DFA unpackEncodedStringToUnsignedChars:DFA28_maxS];
NSArray * const DFA28_accept = [DFA unpackEncodedString:DFA28_acceptS];
NSArray * const DFA28_special = [DFA unpackEncodedString:DFA28_specialS];
NSArray * const DFA28_transition;
BitSet * const FOLLOW_template_in_templateAndEOF130 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000000L, nil]] autorelease];
BitSet * const FOLLOW_EOF_in_templateAndEOF132 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_element_in_template146 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000180C00002L, nil]] autorelease];
BitSet * const FOLLOW_INDENT_in_element157 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000180C00000L, nil]] autorelease];
BitSet * const FOLLOW_element_in_element159 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_ifstat_in_element172 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_exprTag_in_element177 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_text_in_element182 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_region_in_element187 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_NEWLINE_in_element192 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_TEXT_in_text202 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_LDELIM_in_exprTag212 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000206114100L, nil]] autorelease];
BitSet * const FOLLOW_expr_in_exprTag214 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000001000200L, nil]] autorelease];
BitSet * const FOLLOW_SEMI_in_exprTag218 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000002000000L, nil]] autorelease];
BitSet * const FOLLOW_exprOptions_in_exprTag220 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000001000000L, nil]] autorelease];
BitSet * const FOLLOW_RDELIM_in_exprTag225 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_LDELIM_in_region249 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000200000000L, nil]] autorelease];
BitSet * const FOLLOW_AT_in_region251 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000002000000L, nil]] autorelease];
BitSet * const FOLLOW_ID_in_region253 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000001000000L, nil]] autorelease];
BitSet * const FOLLOW_RDELIM_in_region255 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000180C00000L, nil]] autorelease];
BitSet * const FOLLOW_template_in_region257 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000800000L, nil]] autorelease];
BitSet * const FOLLOW_LDELIM_in_region259 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000400000000L, nil]] autorelease];
BitSet * const FOLLOW_END_in_region261 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000001000000L, nil]] autorelease];
BitSet * const FOLLOW_RDELIM_in_region263 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_LCURLY_in_subtemplate285 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000182C00000L, nil]] autorelease];
BitSet * const FOLLOW_ID_in_subtemplate291 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000010040000L, nil]] autorelease];
BitSet * const FOLLOW_COMMA_in_subtemplate295 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000002000000L, nil]] autorelease];
BitSet * const FOLLOW_ID_in_subtemplate300 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000010040000L, nil]] autorelease];
BitSet * const FOLLOW_PIPE_in_subtemplate305 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000180C00000L, nil]] autorelease];
BitSet * const FOLLOW_template_in_subtemplate310 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000080200000L, nil]] autorelease];
BitSet * const FOLLOW_INDENT_in_subtemplate312 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000200000L, nil]] autorelease];
BitSet * const FOLLOW_RCURLY_in_subtemplate315 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_LDELIM_in_ifstat349 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000010L, nil]] autorelease];
BitSet * const FOLLOW_IF_in_ifstat351 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000004000L, nil]] autorelease];
BitSet * const FOLLOW_LPAREN_in_ifstat353 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000206114500L, nil]] autorelease];
BitSet * const FOLLOW_conditional_in_ifstat357 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000008000L, nil]] autorelease];
BitSet * const FOLLOW_RPAREN_in_ifstat359 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000001000000L, nil]] autorelease];
BitSet * const FOLLOW_RDELIM_in_ifstat361 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000180C00000L, nil]] autorelease];
BitSet * const FOLLOW_template_in_ifstat368 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000080800000L, nil]] autorelease];
BitSet * const FOLLOW_INDENT_in_ifstat375 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000800000L, nil]] autorelease];
BitSet * const FOLLOW_LDELIM_in_ifstat378 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000040L, nil]] autorelease];
BitSet * const FOLLOW_ELSEIF_in_ifstat380 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000004000L, nil]] autorelease];
BitSet * const FOLLOW_LPAREN_in_ifstat382 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000206114500L, nil]] autorelease];
BitSet * const FOLLOW_conditional_in_ifstat386 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000008000L, nil]] autorelease];
BitSet * const FOLLOW_RPAREN_in_ifstat388 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000001000000L, nil]] autorelease];
BitSet * const FOLLOW_RDELIM_in_ifstat390 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000180C00000L, nil]] autorelease];
BitSet * const FOLLOW_template_in_ifstat394 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000080800000L, nil]] autorelease];
BitSet * const FOLLOW_INDENT_in_ifstat404 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000800000L, nil]] autorelease];
BitSet * const FOLLOW_LDELIM_in_ifstat407 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000020L, nil]] autorelease];
BitSet * const FOLLOW_ELSE_in_ifstat409 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000001000000L, nil]] autorelease];
BitSet * const FOLLOW_RDELIM_in_ifstat411 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000180C00000L, nil]] autorelease];
BitSet * const FOLLOW_template_in_ifstat415 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000080800000L, nil]] autorelease];
BitSet * const FOLLOW_INDENT_in_ifstat423 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000800000L, nil]] autorelease];
BitSet * const FOLLOW_LDELIM_in_ifstat429 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000080L, nil]] autorelease];
BitSet * const FOLLOW_ENDIF_in_ifstat431 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000001000000L, nil]] autorelease];
BitSet * const FOLLOW_RDELIM_in_ifstat435 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000100000002L, nil]] autorelease];
BitSet * const FOLLOW_NEWLINE_in_ifstat446 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_andConditional_in_conditional493 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000020000002L, nil]] autorelease];
BitSet * const FOLLOW_OR_in_conditional497 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000206114500L, nil]] autorelease];
BitSet * const FOLLOW_andConditional_in_conditional500 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000020000002L, nil]] autorelease];
BitSet * const FOLLOW_notConditional_in_andConditional512 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000040000002L, nil]] autorelease];
BitSet * const FOLLOW_AND_in_andConditional516 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000206114500L, nil]] autorelease];
BitSet * const FOLLOW_notConditional_in_andConditional519 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000040000002L, nil]] autorelease];
BitSet * const FOLLOW_BANG_in_notConditional533 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000002000000L, nil]] autorelease];
BitSet * const FOLLOW_notConditionalExpr_in_notConditional536 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_BANG_in_notConditional540 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000004000L, nil]] autorelease];
BitSet * const FOLLOW_LPAREN_in_notConditional543 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000206114500L, nil]] autorelease];
BitSet * const FOLLOW_conditional_in_notConditional546 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000008000L, nil]] autorelease];
BitSet * const FOLLOW_RPAREN_in_notConditional548 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_memberExpr_in_notConditional553 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_ID_in_notConditionalExpr565 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000080002L, nil]] autorelease];
BitSet * const FOLLOW_DOT_in_notConditionalExpr576 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000002000000L, nil]] autorelease];
BitSet * const FOLLOW_ID_in_notConditionalExpr580 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000080002L, nil]] autorelease];
BitSet * const FOLLOW_DOT_in_notConditionalExpr606 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000004000L, nil]] autorelease];
BitSet * const FOLLOW_LPAREN_in_notConditionalExpr608 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000206114100L, nil]] autorelease];
BitSet * const FOLLOW_mapExpr_in_notConditionalExpr610 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000008000L, nil]] autorelease];
BitSet * const FOLLOW_RPAREN_in_notConditionalExpr612 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000080002L, nil]] autorelease];
BitSet * const FOLLOW_option_in_exprOptions642 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000040002L, nil]] autorelease];
BitSet * const FOLLOW_COMMA_in_exprOptions646 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000002000000L, nil]] autorelease];
BitSet * const FOLLOW_option_in_exprOptions648 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000040002L, nil]] autorelease];
BitSet * const FOLLOW_ID_in_option675 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000001002L, nil]] autorelease];
BitSet * const FOLLOW_EQUALS_in_option685 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000206114100L, nil]] autorelease];
BitSet * const FOLLOW_exprNoComma_in_option687 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_memberExpr_in_exprNoComma794 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000002002L, nil]] autorelease];
BitSet * const FOLLOW_COLON_in_exprNoComma800 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000002104000L, nil]] autorelease];
BitSet * const FOLLOW_mapTemplateRef_in_exprNoComma802 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_mapExpr_in_expr847 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_memberExpr_in_mapExpr859 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000042002L, nil]] autorelease];
BitSet * const FOLLOW_COMMA_in_mapExpr868 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000206114100L, nil]] autorelease];
BitSet * const FOLLOW_memberExpr_in_mapExpr870 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000042000L, nil]] autorelease];
BitSet * const FOLLOW_COLON_in_mapExpr876 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000002104000L, nil]] autorelease];
BitSet * const FOLLOW_mapTemplateRef_in_mapExpr878 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000002002L, nil]] autorelease];
BitSet * const FOLLOW_COLON_in_mapExpr941 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000002104000L, nil]] autorelease];
BitSet * const FOLLOW_mapTemplateRef_in_mapExpr945 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000042002L, nil]] autorelease];
BitSet * const FOLLOW_COMMA_in_mapExpr951 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000002104000L, nil]] autorelease];
BitSet * const FOLLOW_mapTemplateRef_in_mapExpr955 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000042002L, nil]] autorelease];
BitSet * const FOLLOW_ID_in_mapTemplateRef1002 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000004000L, nil]] autorelease];
BitSet * const FOLLOW_LPAREN_in_mapTemplateRef1004 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x000000020611C100L, nil]] autorelease];
BitSet * const FOLLOW_args_in_mapTemplateRef1006 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000008000L, nil]] autorelease];
BitSet * const FOLLOW_RPAREN_in_mapTemplateRef1008 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_subtemplate_in_mapTemplateRef1030 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_LPAREN_in_mapTemplateRef1037 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000206114100L, nil]] autorelease];
BitSet * const FOLLOW_mapExpr_in_mapTemplateRef1039 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000008000L, nil]] autorelease];
BitSet * const FOLLOW_RPAREN_in_mapTemplateRef1043 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000004000L, nil]] autorelease];
BitSet * const FOLLOW_LPAREN_in_mapTemplateRef1045 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x000000020611C100L, nil]] autorelease];
BitSet * const FOLLOW_argExprList_in_mapTemplateRef1047 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000008000L, nil]] autorelease];
BitSet * const FOLLOW_RPAREN_in_mapTemplateRef1050 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_includeExpr_in_memberExpr1072 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000080002L, nil]] autorelease];
BitSet * const FOLLOW_DOT_in_memberExpr1083 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000002000000L, nil]] autorelease];
BitSet * const FOLLOW_ID_in_memberExpr1085 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000080002L, nil]] autorelease];
BitSet * const FOLLOW_DOT_in_memberExpr1111 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000004000L, nil]] autorelease];
BitSet * const FOLLOW_LPAREN_in_memberExpr1113 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000206114100L, nil]] autorelease];
BitSet * const FOLLOW_mapExpr_in_memberExpr1115 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000008000L, nil]] autorelease];
BitSet * const FOLLOW_RPAREN_in_memberExpr1117 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000080002L, nil]] autorelease];
BitSet * const FOLLOW_ID_in_includeExpr1161 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000004000L, nil]] autorelease];
BitSet * const FOLLOW_LPAREN_in_includeExpr1163 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x000000020611C100L, nil]] autorelease];
BitSet * const FOLLOW_expr_in_includeExpr1165 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000008000L, nil]] autorelease];
BitSet * const FOLLOW_RPAREN_in_includeExpr1168 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_SUPER_in_includeExpr1189 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000080000L, nil]] autorelease];
BitSet * const FOLLOW_DOT_in_includeExpr1191 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000002000000L, nil]] autorelease];
BitSet * const FOLLOW_ID_in_includeExpr1193 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000004000L, nil]] autorelease];
BitSet * const FOLLOW_LPAREN_in_includeExpr1195 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x000000020611C100L, nil]] autorelease];
BitSet * const FOLLOW_args_in_includeExpr1197 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000008000L, nil]] autorelease];
BitSet * const FOLLOW_RPAREN_in_includeExpr1199 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_ID_in_includeExpr1218 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000004000L, nil]] autorelease];
BitSet * const FOLLOW_LPAREN_in_includeExpr1220 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x000000020611C100L, nil]] autorelease];
BitSet * const FOLLOW_args_in_includeExpr1222 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000008000L, nil]] autorelease];
BitSet * const FOLLOW_RPAREN_in_includeExpr1224 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_AT_in_includeExpr1246 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000100L, nil]] autorelease];
BitSet * const FOLLOW_SUPER_in_includeExpr1248 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000080000L, nil]] autorelease];
BitSet * const FOLLOW_DOT_in_includeExpr1250 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000002000000L, nil]] autorelease];
BitSet * const FOLLOW_ID_in_includeExpr1252 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000004000L, nil]] autorelease];
BitSet * const FOLLOW_LPAREN_in_includeExpr1254 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000008000L, nil]] autorelease];
BitSet * const FOLLOW_RPAREN_in_includeExpr1258 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_AT_in_includeExpr1273 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000002000000L, nil]] autorelease];
BitSet * const FOLLOW_ID_in_includeExpr1275 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000004000L, nil]] autorelease];
BitSet * const FOLLOW_LPAREN_in_includeExpr1277 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000008000L, nil]] autorelease];
BitSet * const FOLLOW_RPAREN_in_includeExpr1281 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_primary_in_includeExpr1299 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_ID_in_primary1310 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_STRING_in_primary1315 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_subtemplate_in_primary1320 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_list_in_primary1325 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_LPAREN_in_primary1332 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000206114100L, nil]] autorelease];
BitSet * const FOLLOW_expr_in_primary1334 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000008000L, nil]] autorelease];
BitSet * const FOLLOW_RPAREN_in_primary1336 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000004002L, nil]] autorelease];
BitSet * const FOLLOW_LPAREN_in_primary1342 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x000000020611C100L, nil]] autorelease];
BitSet * const FOLLOW_argExprList_in_primary1344 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000008000L, nil]] autorelease];
BitSet * const FOLLOW_RPAREN_in_primary1347 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_argExprList_in_args1397 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_namedArg_in_args1402 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000040002L, nil]] autorelease];
BitSet * const FOLLOW_COMMA_in_args1406 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000002000000L, nil]] autorelease];
BitSet * const FOLLOW_namedArg_in_args1408 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000040002L, nil]] autorelease];
BitSet * const FOLLOW_arg_in_argExprList1429 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000040002L, nil]] autorelease];
BitSet * const FOLLOW_COMMA_in_argExprList1433 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000206114100L, nil]] autorelease];
BitSet * const FOLLOW_arg_in_argExprList1435 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000040002L, nil]] autorelease];
BitSet * const FOLLOW_exprNoComma_in_arg1452 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_ID_in_namedArg1461 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000001000L, nil]] autorelease];
BitSet * const FOLLOW_EQUALS_in_namedArg1463 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000206114100L, nil]] autorelease];
BitSet * const FOLLOW_arg_in_namedArg1465 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_LBRACK_in_list1490 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000020000L, nil]] autorelease];
BitSet * const FOLLOW_RBRACK_in_list1492 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_LBRACK_in_list1504 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000206174100L, nil]] autorelease];
BitSet * const FOLLOW_listElement_in_list1506 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000060000L, nil]] autorelease];
BitSet * const FOLLOW_COMMA_in_list1510 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000206174100L, nil]] autorelease];
BitSet * const FOLLOW_listElement_in_list1512 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000060000L, nil]] autorelease];
BitSet * const FOLLOW_RBRACK_in_list1517 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];
BitSet * const FOLLOW_exprNoComma_in_listElement1537 = [[[BitSet alloc] init:[NSArray arrayWithObjects:0x0000000000000002L, nil]] autorelease];

@implementation STParser

@synthesize treeAdaptor;
@synthesize tokenNames;
@synthesize grammarFileName;

- (id) initWithInput:(TokenStream *)input {
    self = [self init:input state:[[RecognizerSharedState alloc] init] retain];
  if ( self != nil ) {
  }
  return self;
}

- (id) init:(TokenStream *)input state:(RecognizerSharedState *)state {
  if (self = [super init:input param1:state]) {
    adaptor = [[[CommonTreeAdaptor alloc] init] autorelease];
    dfa2 = [[[DFA2 alloc] init:self] autorelease];
    dfa28 = [[[DFA28 alloc] init:self] autorelease];
  }
  return self;
}

- (id) init:(TokenStream *)input errMgr:(ErrorManager *)errMgr templateToken:(Token *)templateToken {
  if (self = [self init:input]) {
    errMgr = errMgr;
    templateToken = templateToken;
  }
  return self;
}

- (NSObject *) recoverFromMismatchedToken:(IntStream *)input ttype:(int)ttype follow:(BitSet *)follow {
  @throw [[[MismatchedTokenException alloc] init:ttype param1:input] autorelease];
}

- (templateAndEOF_return *) templateAndEOF {
  templateAndEOF_return * retval = [[[templateAndEOF_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  CommonToken * EOF2 = nil;
  template_return * template1 = nil;
  CommonTree * EOF2_tree = nil;
  RewriteRuleTokenStream * stream_EOF = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token EOF"] autorelease];
  RewriteRuleSubtreeStream * stream_template = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule template"] autorelease];

  @try {
    {
      [self pushFollow:FOLLOW_template_in_templateAndEOF130];
      template1 = [self template];
      state._fsp--;
      [stream_template add:[template1 tree]];
      EOF2 = (CommonToken *)[self match:input param1:EOF param2:FOLLOW_EOF_in_templateAndEOF132];
      [stream_EOF add:EOF2];
      retval.tree = root_0;
      RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
      root_0 = (CommonTree *)[adaptor nil];
      {
        if ([stream_template hasNext]) {
          [adaptor addChild:root_0 param1:[stream_template nextTree]];
        }
        [stream_template reset];
      }
      retval.tree = root_0;
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

- (template_return *) template {
  template_return * retval = [[[template_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  element_return * element3 = nil;

  @try {
    {
      root_0 = (CommonTree *)[adaptor nil];

      loop1: 
      do {
        int alt1 = 2;

        switch ([input LA:1]) {
        case LDELIM:
          {
            int LA1_2 = [input LA:2];
            if ((LA1_2 == IF || LA1_2 == SUPER || LA1_2 == LPAREN || LA1_2 == LBRACK || LA1_2 == LCURLY || (LA1_2 >= ID && LA1_2 <= STRING) || LA1_2 == AT)) {
              alt1 = 1;
            }
          }
          break;
        case INDENT:
          {
            int LA1_3 = [input LA:2];
            if ((LA1_3 == LDELIM)) {
              int LA1_5 = [input LA:3];
              if ((LA1_5 == IF || LA1_5 == SUPER || LA1_5 == LPAREN || LA1_5 == LBRACK || LA1_5 == LCURLY || (LA1_5 >= ID && LA1_5 <= STRING) || LA1_5 == AT)) {
                alt1 = 1;
              }
            }
             else if ((LA1_3 == TEXT || (LA1_3 >= INDENT && LA1_3 <= NEWLINE))) {
              alt1 = 1;
            }
          }
          break;
        case TEXT:
        case NEWLINE:
          {
            alt1 = 1;
          }
          break;
        }

        switch (alt1) {
        case 1:
          {
            [self pushFollow:FOLLOW_element_in_template146];
            element3 = [self element];
            state._fsp--;
            [adaptor addChild:root_0 param1:[element3 tree]];
          }
          break;
        default:
          break loop1;
        }
      }
       while (YES);
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

- (element_return *) element {
  element_return * retval = [[[element_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  CommonToken * INDENT4 = nil;
  CommonToken * NEWLINE10 = nil;
  element_return * element5 = nil;
  ifstat_return * ifstat6 = nil;
  exprTag_return * exprTag7 = nil;
  text_return * text8 = nil;
  region_return * region9 = nil;
  CommonTree * INDENT4_tree = nil;
  CommonTree * NEWLINE10_tree = nil;
  RewriteRuleTokenStream * stream_INDENT = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token INDENT"] autorelease];
  RewriteRuleSubtreeStream * stream_element = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule element"] autorelease];

  @try {
    int alt2 = 6;
    alt2 = [dfa2 predict:input];

    switch (alt2) {
    case 1:
      {
        INDENT4 = (CommonToken *)[self match:input param1:INDENT param2:FOLLOW_INDENT_in_element157];
        [stream_INDENT add:INDENT4];
        [self pushFollow:FOLLOW_element_in_element159];
        element5 = [self element];
        state._fsp--;
        [stream_element add:[element5 tree]];
        retval.tree = root_0;
        RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
        root_0 = (CommonTree *)[adaptor nil];
        {
          {
            CommonTree * root_1 = (CommonTree *)[adaptor nil];
            root_1 = (CommonTree *)[adaptor becomeRoot:[stream_INDENT nextNode] param1:root_1];
            [adaptor addChild:root_1 param1:[stream_element nextTree]];
            [adaptor addChild:root_0 param1:root_1];
          }
        }
        retval.tree = root_0;
      }
      break;
    case 2:
      {
        root_0 = (CommonTree *)[adaptor nil];
        [self pushFollow:FOLLOW_ifstat_in_element172];
        ifstat6 = [self ifstat];
        state._fsp--;
        [adaptor addChild:root_0 param1:[ifstat6 tree]];
      }
      break;
    case 3:
      {
        root_0 = (CommonTree *)[adaptor nil];
        [self pushFollow:FOLLOW_exprTag_in_element177];
        exprTag7 = [self exprTag];
        state._fsp--;
        [adaptor addChild:root_0 param1:[exprTag7 tree]];
      }
      break;
    case 4:
      {
        root_0 = (CommonTree *)[adaptor nil];
        [self pushFollow:FOLLOW_text_in_element182];
        text8 = [self text];
        state._fsp--;
        [adaptor addChild:root_0 param1:[text8 tree]];
      }
      break;
    case 5:
      {
        root_0 = (CommonTree *)[adaptor nil];
        [self pushFollow:FOLLOW_region_in_element187];
        region9 = [self region];
        state._fsp--;
        [adaptor addChild:root_0 param1:[region9 tree]];
      }
      break;
    case 6:
      {
        root_0 = (CommonTree *)[adaptor nil];
        NEWLINE10 = (CommonToken *)[self match:input param1:NEWLINE param2:FOLLOW_NEWLINE_in_element192];
        NEWLINE10_tree = (CommonTree *)[adaptor create:NEWLINE10];
        [adaptor addChild:root_0 param1:NEWLINE10_tree];
      }
      break;
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

- (text_return *) text {
  text_return * retval = [[[text_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  CommonToken * TEXT11 = nil;
  CommonTree * TEXT11_tree = nil;

  @try {
    {
      root_0 = (CommonTree *)[adaptor nil];
      TEXT11 = (CommonToken *)[self match:input param1:TEXT param2:FOLLOW_TEXT_in_text202];
      TEXT11_tree = (CommonTree *)[adaptor create:TEXT11];
      [adaptor addChild:root_0 param1:TEXT11_tree];
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

- (exprTag_return *) exprTag {
  exprTag_return * retval = [[[exprTag_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  CommonToken * LDELIM12 = nil;
  CommonToken * char_literal14 = nil;
  CommonToken * RDELIM16 = nil;
  expr_return * expr13 = nil;
  exprOptions_return * exprOptions15 = nil;
  CommonTree * LDELIM12_tree = nil;
  CommonTree * char_literal14_tree = nil;
  CommonTree * RDELIM16_tree = nil;
  RewriteRuleTokenStream * stream_RDELIM = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token RDELIM"] autorelease];
  RewriteRuleTokenStream * stream_LDELIM = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token LDELIM"] autorelease];
  RewriteRuleTokenStream * stream_SEMI = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token SEMI"] autorelease];
  RewriteRuleSubtreeStream * stream_exprOptions = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule exprOptions"] autorelease];
  RewriteRuleSubtreeStream * stream_expr = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule expr"] autorelease];

  @try {
    {
      LDELIM12 = (CommonToken *)[self match:input param1:LDELIM param2:FOLLOW_LDELIM_in_exprTag212];
      [stream_LDELIM add:LDELIM12];
      [self pushFollow:FOLLOW_expr_in_exprTag214];
      expr13 = [self expr];
      state._fsp--;
      [stream_expr add:[expr13 tree]];
      int alt3 = 2;
      int LA3_0 = [input LA:1];
      if ((LA3_0 == SEMI)) {
        alt3 = 1;
      }

      switch (alt3) {
      case 1:
        {
          char_literal14 = (CommonToken *)[self match:input param1:SEMI param2:FOLLOW_SEMI_in_exprTag218];
          [stream_SEMI add:char_literal14];
          [self pushFollow:FOLLOW_exprOptions_in_exprTag220];
          exprOptions15 = [self exprOptions];
          state._fsp--;
          [stream_exprOptions add:[exprOptions15 tree]];
        }
        break;
      }
      RDELIM16 = (CommonToken *)[self match:input param1:RDELIM param2:FOLLOW_RDELIM_in_exprTag225];
      [stream_RDELIM add:RDELIM16];
      retval.tree = root_0;
      RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
      root_0 = (CommonTree *)[adaptor nil];
      {
        {
          CommonTree * root_1 = (CommonTree *)[adaptor nil];
          root_1 = (CommonTree *)[adaptor becomeRoot:(CommonTree *)[adaptor create:EXPR param1:LDELIM12 param2:@"EXPR"] param1:root_1];
          [adaptor addChild:root_1 param1:[stream_expr nextTree]];
          if ([stream_exprOptions hasNext]) {
            [adaptor addChild:root_1 param1:[stream_exprOptions nextTree]];
          }
          [stream_exprOptions reset];
          [adaptor addChild:root_0 param1:root_1];
        }
      }
      retval.tree = root_0;
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

- (region_return *) region {
  region_return * retval = [[[region_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  CommonToken * LDELIM17 = nil;
  CommonToken * char_literal18 = nil;
  CommonToken * ID19 = nil;
  CommonToken * RDELIM20 = nil;
  CommonToken * LDELIM22 = nil;
  CommonToken * string_literal23 = nil;
  CommonToken * RDELIM24 = nil;
  template_return * template21 = nil;
  CommonTree * LDELIM17_tree = nil;
  CommonTree * char_literal18_tree = nil;
  CommonTree * ID19_tree = nil;
  CommonTree * RDELIM20_tree = nil;
  CommonTree * LDELIM22_tree = nil;
  CommonTree * string_literal23_tree = nil;
  CommonTree * RDELIM24_tree = nil;
  RewriteRuleTokenStream * stream_AT = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token AT"] autorelease];
  RewriteRuleTokenStream * stream_RDELIM = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token RDELIM"] autorelease];
  RewriteRuleTokenStream * stream_ID = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token ID"] autorelease];
  RewriteRuleTokenStream * stream_END = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token END"] autorelease];
  RewriteRuleTokenStream * stream_LDELIM = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token LDELIM"] autorelease];
  RewriteRuleSubtreeStream * stream_template = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule template"] autorelease];

  @try {
    {
      LDELIM17 = (CommonToken *)[self match:input param1:LDELIM param2:FOLLOW_LDELIM_in_region249];
      [stream_LDELIM add:LDELIM17];
      char_literal18 = (CommonToken *)[self match:input param1:AT param2:FOLLOW_AT_in_region251];
      [stream_AT add:char_literal18];
      ID19 = (CommonToken *)[self match:input param1:ID param2:FOLLOW_ID_in_region253];
      [stream_ID add:ID19];
      RDELIM20 = (CommonToken *)[self match:input param1:RDELIM param2:FOLLOW_RDELIM_in_region255];
      [stream_RDELIM add:RDELIM20];
      [self pushFollow:FOLLOW_template_in_region257];
      template21 = [self template];
      state._fsp--;
      [stream_template add:[template21 tree]];
      LDELIM22 = (CommonToken *)[self match:input param1:LDELIM param2:FOLLOW_LDELIM_in_region259];
      [stream_LDELIM add:LDELIM22];
      string_literal23 = (CommonToken *)[self match:input param1:END param2:FOLLOW_END_in_region261];
      [stream_END add:string_literal23];
      RDELIM24 = (CommonToken *)[self match:input param1:RDELIM param2:FOLLOW_RDELIM_in_region263];
      [stream_RDELIM add:RDELIM24];
      retval.tree = root_0;
      RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
      root_0 = (CommonTree *)[adaptor nil];
      {
        {
          CommonTree * root_1 = (CommonTree *)[adaptor nil];
          root_1 = (CommonTree *)[adaptor becomeRoot:(CommonTree *)[adaptor create:REGION param1:@"REGION"] param1:root_1];
          [adaptor addChild:root_1 param1:[stream_ID nextNode]];
          [adaptor addChild:root_1 param1:[stream_template nextTree]];
          [adaptor addChild:root_0 param1:root_1];
        }
      }
      retval.tree = root_0;
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

- (subtemplate_return *) subtemplate {
  subtemplate_return * retval = [[[subtemplate_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  CommonToken * lc = nil;
  CommonToken * char_literal25 = nil;
  CommonToken * char_literal26 = nil;
  CommonToken * INDENT28 = nil;
  CommonToken * char_literal29 = nil;
  CommonToken * ids = nil;
  NSMutableArray * list_ids = nil;
  template_return * template27 = nil;
  CommonTree * lc_tree = nil;
  CommonTree * char_literal25_tree = nil;
  CommonTree * char_literal26_tree = nil;
  CommonTree * INDENT28_tree = nil;
  CommonTree * char_literal29_tree = nil;
  CommonTree * ids_tree = nil;
  RewriteRuleTokenStream * stream_LCURLY = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token LCURLY"] autorelease];
  RewriteRuleTokenStream * stream_PIPE = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token PIPE"] autorelease];
  RewriteRuleTokenStream * stream_ID = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token ID"] autorelease];
  RewriteRuleTokenStream * stream_COMMA = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token COMMA"] autorelease];
  RewriteRuleTokenStream * stream_INDENT = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token INDENT"] autorelease];
  RewriteRuleTokenStream * stream_RCURLY = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token RCURLY"] autorelease];
  RewriteRuleSubtreeStream * stream_template = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule template"] autorelease];

  @try {
    {
      lc = (CommonToken *)[self match:input param1:LCURLY param2:FOLLOW_LCURLY_in_subtemplate285];
      [stream_LCURLY add:lc];
      int alt5 = 2;
      int LA5_0 = [input LA:1];
      if ((LA5_0 == ID)) {
        alt5 = 1;
      }

      switch (alt5) {
      case 1:
        {
          ids = (CommonToken *)[self match:input param1:ID param2:FOLLOW_ID_in_subtemplate291];
          [stream_ID add:ids];
          if (list_ids == nil)
            list_ids = [[[NSMutableArray alloc] init] autorelease];
          [list_ids addObject:ids];

          loop4: 
          do {
            int alt4 = 2;
            int LA4_0 = [input LA:1];
            if ((LA4_0 == COMMA)) {
              alt4 = 1;
            }

            switch (alt4) {
            case 1:
              {
                char_literal25 = (CommonToken *)[self match:input param1:COMMA param2:FOLLOW_COMMA_in_subtemplate295];
                [stream_COMMA add:char_literal25];
                ids = (CommonToken *)[self match:input param1:ID param2:FOLLOW_ID_in_subtemplate300];
                [stream_ID add:ids];
                if (list_ids == nil)
                  list_ids = [[[NSMutableArray alloc] init] autorelease];
                [list_ids addObject:ids];
              }
              break;
            default:
              break loop4;
            }
          }
           while (YES);
          char_literal26 = (CommonToken *)[self match:input param1:PIPE param2:FOLLOW_PIPE_in_subtemplate305];
          [stream_PIPE add:char_literal26];
        }
        break;
      }
      [self pushFollow:FOLLOW_template_in_subtemplate310];
      template27 = [self template];
      state._fsp--;
      [stream_template add:[template27 tree]];
      int alt6 = 2;
      int LA6_0 = [input LA:1];
      if ((LA6_0 == INDENT)) {
        alt6 = 1;
      }

      switch (alt6) {
      case 1:
        {
          INDENT28 = (CommonToken *)[self match:input param1:INDENT param2:FOLLOW_INDENT_in_subtemplate312];
          [stream_INDENT add:INDENT28];
        }
        break;
      }
      char_literal29 = (CommonToken *)[self match:input param1:RCURLY param2:FOLLOW_RCURLY_in_subtemplate315];
      [stream_RCURLY add:char_literal29];
      retval.tree = root_0;
      RewriteRuleTokenStream * stream_ids = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token ids" param2:list_ids] autorelease];
      RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
      root_0 = (CommonTree *)[adaptor nil];
      {
        {
          CommonTree * root_1 = (CommonTree *)[adaptor nil];
          root_1 = (CommonTree *)[adaptor becomeRoot:(CommonTree *)[adaptor create:SUBTEMPLATE param1:lc param2:@"SUBTEMPLATE"] param1:root_1];

          while ([stream_ids hasNext]) {
            {
              CommonTree * root_2 = (CommonTree *)[adaptor nil];
              root_2 = (CommonTree *)[adaptor becomeRoot:(CommonTree *)[adaptor create:ARGS param1:@"ARGS"] param1:root_2];
              [adaptor addChild:root_2 param1:[stream_ids nextNode]];
              [adaptor addChild:root_1 param1:root_2];
            }
          }

          [stream_ids reset];
          [adaptor addChild:root_1 param1:[stream_template nextTree]];
          [adaptor addChild:root_0 param1:root_1];
        }
      }
      retval.tree = root_0;
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

- (ifstat_return *) ifstat {
  ifstat_return * retval = [[[ifstat_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  CommonToken * endif = nil;
  CommonToken * LDELIM30 = nil;
  CommonToken * string_literal31 = nil;
  CommonToken * char_literal32 = nil;
  CommonToken * char_literal33 = nil;
  CommonToken * RDELIM34 = nil;
  CommonToken * INDENT35 = nil;
  CommonToken * LDELIM36 = nil;
  CommonToken * string_literal37 = nil;
  CommonToken * char_literal38 = nil;
  CommonToken * char_literal39 = nil;
  CommonToken * RDELIM40 = nil;
  CommonToken * INDENT41 = nil;
  CommonToken * LDELIM42 = nil;
  CommonToken * string_literal43 = nil;
  CommonToken * RDELIM44 = nil;
  CommonToken * INDENT45 = nil;
  CommonToken * string_literal46 = nil;
  CommonToken * RDELIM47 = nil;
  CommonToken * NEWLINE48 = nil;
  NSMutableArray * list_c2 = nil;
  NSMutableArray * list_t2 = nil;
  conditional_return * c1 = nil;
  template_return * t1 = nil;
  template_return * t3 = nil;
  RuleReturnScope * c2 = nil;
  RuleReturnScope * t2 = nil;
  CommonTree * endif_tree = nil;
  CommonTree * LDELIM30_tree = nil;
  CommonTree * string_literal31_tree = nil;
  CommonTree * char_literal32_tree = nil;
  CommonTree * char_literal33_tree = nil;
  CommonTree * RDELIM34_tree = nil;
  CommonTree * INDENT35_tree = nil;
  CommonTree * LDELIM36_tree = nil;
  CommonTree * string_literal37_tree = nil;
  CommonTree * char_literal38_tree = nil;
  CommonTree * char_literal39_tree = nil;
  CommonTree * RDELIM40_tree = nil;
  CommonTree * INDENT41_tree = nil;
  CommonTree * LDELIM42_tree = nil;
  CommonTree * string_literal43_tree = nil;
  CommonTree * RDELIM44_tree = nil;
  CommonTree * INDENT45_tree = nil;
  CommonTree * string_literal46_tree = nil;
  CommonTree * RDELIM47_tree = nil;
  CommonTree * NEWLINE48_tree = nil;
  RewriteRuleTokenStream * stream_ENDIF = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token ENDIF"] autorelease];
  RewriteRuleTokenStream * stream_RDELIM = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token RDELIM"] autorelease];
  RewriteRuleTokenStream * stream_RPAREN = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token RPAREN"] autorelease];
  RewriteRuleTokenStream * stream_NEWLINE = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token NEWLINE"] autorelease];
  RewriteRuleTokenStream * stream_LDELIM = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token LDELIM"] autorelease];
  RewriteRuleTokenStream * stream_INDENT = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token INDENT"] autorelease];
  RewriteRuleTokenStream * stream_LPAREN = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token LPAREN"] autorelease];
  RewriteRuleTokenStream * stream_IF = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token IF"] autorelease];
  RewriteRuleTokenStream * stream_ELSE = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token ELSE"] autorelease];
  RewriteRuleTokenStream * stream_ELSEIF = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token ELSEIF"] autorelease];
  RewriteRuleSubtreeStream * stream_template = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule template"] autorelease];
  RewriteRuleSubtreeStream * stream_conditional = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule conditional"] autorelease];

  @try {
    {
      LDELIM30 = (CommonToken *)[self match:input param1:LDELIM param2:FOLLOW_LDELIM_in_ifstat349];
      [stream_LDELIM add:LDELIM30];
      string_literal31 = (CommonToken *)[self match:input param1:IF param2:FOLLOW_IF_in_ifstat351];
      [stream_IF add:string_literal31];
      char_literal32 = (CommonToken *)[self match:input param1:LPAREN param2:FOLLOW_LPAREN_in_ifstat353];
      [stream_LPAREN add:char_literal32];
      [self pushFollow:FOLLOW_conditional_in_ifstat357];
      c1 = [self conditional];
      state._fsp--;
      [stream_conditional add:[c1 tree]];
      char_literal33 = (CommonToken *)[self match:input param1:RPAREN param2:FOLLOW_RPAREN_in_ifstat359];
      [stream_RPAREN add:char_literal33];
      RDELIM34 = (CommonToken *)[self match:input param1:RDELIM param2:FOLLOW_RDELIM_in_ifstat361];
      [stream_RDELIM add:RDELIM34];
      [self pushFollow:FOLLOW_template_in_ifstat368];
      t1 = [self template];
      state._fsp--;
      [stream_template add:[t1 tree]];

      loop8: 
      do {
        int alt8 = 2;
        int LA8_0 = [input LA:1];
        if ((LA8_0 == INDENT)) {
          int LA8_1 = [input LA:2];
          if ((LA8_1 == LDELIM)) {
            int LA8_2 = [input LA:3];
            if ((LA8_2 == ELSEIF)) {
              alt8 = 1;
            }
          }
        }
         else if ((LA8_0 == LDELIM)) {
          int LA8_2 = [input LA:2];
          if ((LA8_2 == ELSEIF)) {
            alt8 = 1;
          }
        }

        switch (alt8) {
        case 1:
          {
            int alt7 = 2;
            int LA7_0 = [input LA:1];
            if ((LA7_0 == INDENT)) {
              alt7 = 1;
            }

            switch (alt7) {
            case 1:
              {
                INDENT35 = (CommonToken *)[self match:input param1:INDENT param2:FOLLOW_INDENT_in_ifstat375];
                [stream_INDENT add:INDENT35];
              }
              break;
            }
            LDELIM36 = (CommonToken *)[self match:input param1:LDELIM param2:FOLLOW_LDELIM_in_ifstat378];
            [stream_LDELIM add:LDELIM36];
            string_literal37 = (CommonToken *)[self match:input param1:ELSEIF param2:FOLLOW_ELSEIF_in_ifstat380];
            [stream_ELSEIF add:string_literal37];
            char_literal38 = (CommonToken *)[self match:input param1:LPAREN param2:FOLLOW_LPAREN_in_ifstat382];
            [stream_LPAREN add:char_literal38];
            [self pushFollow:FOLLOW_conditional_in_ifstat386];
            c2 = [self conditional];
            state._fsp--;
            [stream_conditional add:[c2 tree]];
            if (list_c2 == nil)
              list_c2 = [[[NSMutableArray alloc] init] autorelease];
            [list_c2 addObject:[c2 tree]];
            char_literal39 = (CommonToken *)[self match:input param1:RPAREN param2:FOLLOW_RPAREN_in_ifstat388];
            [stream_RPAREN add:char_literal39];
            RDELIM40 = (CommonToken *)[self match:input param1:RDELIM param2:FOLLOW_RDELIM_in_ifstat390];
            [stream_RDELIM add:RDELIM40];
            [self pushFollow:FOLLOW_template_in_ifstat394];
            t2 = [self template];
            state._fsp--;
            [stream_template add:[t2 tree]];
            if (list_t2 == nil)
              list_t2 = [[[NSMutableArray alloc] init] autorelease];
            [list_t2 addObject:[t2 tree]];
          }
          break;
        default:
          break loop8;
        }
      }
       while (YES);
      int alt10 = 2;
      int LA10_0 = [input LA:1];
      if ((LA10_0 == INDENT)) {
        int LA10_1 = [input LA:2];
        if ((LA10_1 == LDELIM)) {
          int LA10_2 = [input LA:3];
          if ((LA10_2 == ELSE)) {
            alt10 = 1;
          }
        }
      }
       else if ((LA10_0 == LDELIM)) {
        int LA10_2 = [input LA:2];
        if ((LA10_2 == ELSE)) {
          alt10 = 1;
        }
      }

      switch (alt10) {
      case 1:
        {
          int alt9 = 2;
          int LA9_0 = [input LA:1];
          if ((LA9_0 == INDENT)) {
            alt9 = 1;
          }

          switch (alt9) {
          case 1:
            {
              INDENT41 = (CommonToken *)[self match:input param1:INDENT param2:FOLLOW_INDENT_in_ifstat404];
              [stream_INDENT add:INDENT41];
            }
            break;
          }
          LDELIM42 = (CommonToken *)[self match:input param1:LDELIM param2:FOLLOW_LDELIM_in_ifstat407];
          [stream_LDELIM add:LDELIM42];
          string_literal43 = (CommonToken *)[self match:input param1:ELSE param2:FOLLOW_ELSE_in_ifstat409];
          [stream_ELSE add:string_literal43];
          RDELIM44 = (CommonToken *)[self match:input param1:RDELIM param2:FOLLOW_RDELIM_in_ifstat411];
          [stream_RDELIM add:RDELIM44];
          [self pushFollow:FOLLOW_template_in_ifstat415];
          t3 = [self template];
          state._fsp--;
          [stream_template add:[t3 tree]];
        }
        break;
      }
      int alt11 = 2;
      int LA11_0 = [input LA:1];
      if ((LA11_0 == INDENT)) {
        alt11 = 1;
      }

      switch (alt11) {
      case 1:
        {
          INDENT45 = (CommonToken *)[self match:input param1:INDENT param2:FOLLOW_INDENT_in_ifstat423];
          [stream_INDENT add:INDENT45];
        }
        break;
      }
      endif = (CommonToken *)[self match:input param1:LDELIM param2:FOLLOW_LDELIM_in_ifstat429];
      [stream_LDELIM add:endif];
      string_literal46 = (CommonToken *)[self match:input param1:ENDIF param2:FOLLOW_ENDIF_in_ifstat431];
      [stream_ENDIF add:string_literal46];
      RDELIM47 = (CommonToken *)[self match:input param1:RDELIM param2:FOLLOW_RDELIM_in_ifstat435];
      [stream_RDELIM add:RDELIM47];
      int alt12 = 2;
      int LA12_0 = [input LA:1];
      if ((LA12_0 == NEWLINE)) {
        int LA12_1 = [input LA:2];
        if ((([((CommonToken *)retval.start) line] != [[input LT:1] line]))) {
          alt12 = 1;
        }
      }
      switch (alt12) {
      case 1:
        {
          if ( !(retval.start.line] != [input LT:1].line) ) {
            @throw [[[FailedPredicateException alloc] init:input param1:@"ifstat" param2:@"$ifstat.start..line != [input LT:1].line"] autorelease];
          }
          NEWLINE48 = (CommonToken *)[self match:input param1:NEWLINE param2:FOLLOW_NEWLINE_in_ifstat446];
          [stream_NEWLINE add:NEWLINE48];
        }
        break;
      }
      retval.tree = root_0;
      RewriteRuleSubtreeStream * stream_t3 = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule t3" param2:t3 != nil ? t3.tree : nil] autorelease];
      RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
      RewriteRuleSubtreeStream * stream_t1 = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule t1" param2:t1 != nil ? t1.tree : nil] autorelease];
      RewriteRuleSubtreeStream * stream_c1 = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule c1" param2:c1 != nil ? c1.tree : nil] autorelease];
      RewriteRuleSubtreeStream * stream_t2 = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"token t2" param2:list_t2] autorelease];
      RewriteRuleSubtreeStream * stream_c2 = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"token c2" param2:list_c2] autorelease];
      root_0 = (CommonTree *)[adaptor nil];
      {
        {
          CommonTree * root_1 = (CommonTree *)[adaptor nil];
          root_1 = (CommonTree *)[adaptor becomeRoot:[stream_IF nextNode] param1:root_1];
          [adaptor addChild:root_1 param1:[stream_c1 nextTree]];
          if ([stream_t1 hasNext]) {
            [adaptor addChild:root_1 param1:[stream_t1 nextTree]];
          }
          [stream_t1 reset];

          while ([stream_c2 hasNext] || [stream_ELSEIF hasNext] || [stream_t2 hasNext]) {
            {
              CommonTree * root_2 = (CommonTree *)[adaptor nil];
              root_2 = (CommonTree *)[adaptor becomeRoot:[stream_ELSEIF nextNode] param1:root_2];
              [adaptor addChild:root_2 param1:[stream_c2 nextTree]];
              [adaptor addChild:root_2 param1:[stream_t2 nextTree]];
              [adaptor addChild:root_1 param1:root_2];
            }
          }

          [stream_c2 reset];
          [stream_ELSEIF reset];
          [stream_t2 reset];
          if ([stream_t3 hasNext] || [stream_ELSE hasNext]) {
            {
              CommonTree * root_2 = (CommonTree *)[adaptor nil];
              root_2 = (CommonTree *)[adaptor becomeRoot:[stream_ELSE nextNode] param1:root_2];
              if ([stream_t3 hasNext]) {
                [adaptor addChild:root_2 param1:[stream_t3 nextTree]];
              }
              [stream_t3 reset];
              [adaptor addChild:root_1 param1:root_2];
            }
          }
          [stream_t3 reset];
          [stream_ELSE reset];
          [adaptor addChild:root_0 param1:root_1];
        }
      }
      retval.tree = root_0;
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

- (conditional_return *) conditional {
  conditional_return * retval = [[[conditional_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  CommonToken * string_literal50 = nil;
  andConditional_return * andConditional49 = nil;
  andConditional_return * andConditional51 = nil;
  CommonTree * string_literal50_tree = nil;

  @try {
    {
      root_0 = (CommonTree *)[adaptor nil];
      [self pushFollow:FOLLOW_andConditional_in_conditional493];
      andConditional49 = [self andConditional];
      state._fsp--;
      [adaptor addChild:root_0 param1:[andConditional49 tree]];

      loop13: 
      do {
        int alt13 = 2;
        int LA13_0 = [input LA:1];
        if ((LA13_0 == OR)) {
          alt13 = 1;
        }

        switch (alt13) {
        case 1:
          {
            string_literal50 = (CommonToken *)[self match:input param1:OR param2:FOLLOW_OR_in_conditional497];
            string_literal50_tree = (CommonTree *)[adaptor create:string_literal50];
            root_0 = (CommonTree *)[adaptor becomeRoot:string_literal50_tree param1:root_0];
            [self pushFollow:FOLLOW_andConditional_in_conditional500];
            andConditional51 = [self andConditional];
            state._fsp--;
            [adaptor addChild:root_0 param1:[andConditional51 tree]];
          }
          break;
        default:
          break loop13;
        }
      }
       while (YES);
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

- (andConditional_return *) andConditional {
  andConditional_return * retval = [[[andConditional_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  CommonToken * string_literal53 = nil;
  notConditional_return * notConditional52 = nil;
  notConditional_return * notConditional54 = nil;
  CommonTree * string_literal53_tree = nil;

  @try {
    {
      root_0 = (CommonTree *)[adaptor nil];
      [self pushFollow:FOLLOW_notConditional_in_andConditional512];
      notConditional52 = [self notConditional];
      state._fsp--;
      [adaptor addChild:root_0 param1:[notConditional52 tree]];

      loop14: 
      do {
        int alt14 = 2;
        int LA14_0 = [input LA:1];
        if ((LA14_0 == AND)) {
          alt14 = 1;
        }

        switch (alt14) {
        case 1:
          {
            string_literal53 = (CommonToken *)[self match:input param1:AND param2:FOLLOW_AND_in_andConditional516];
            string_literal53_tree = (CommonTree *)[adaptor create:string_literal53];
            root_0 = (CommonTree *)[adaptor becomeRoot:string_literal53_tree param1:root_0];
            [self pushFollow:FOLLOW_notConditional_in_andConditional519];
            notConditional54 = [self notConditional];
            state._fsp--;
            [adaptor addChild:root_0 param1:[notConditional54 tree]];
          }
          break;
        default:
          break loop14;
        }
      }
       while (YES);
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

- (notConditional_return *) notConditional {
  notConditional_return * retval = [[[notConditional_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  CommonToken * char_literal55 = nil;
  CommonToken * char_literal57 = nil;
  CommonToken * char_literal58 = nil;
  CommonToken * char_literal60 = nil;
  notConditionalExpr_return * notConditionalExpr56 = nil;
  conditional_return * conditional59 = nil;
  memberExpr_return * memberExpr61 = nil;
  CommonTree * char_literal55_tree = nil;
  CommonTree * char_literal57_tree = nil;
  CommonTree * char_literal58_tree = nil;
  CommonTree * char_literal60_tree = nil;

  @try {
    {
      root_0 = (CommonTree *)[adaptor nil];
      int alt15 = 3;
      int LA15_0 = [input LA:1];
      if ((LA15_0 == BANG)) {
        int LA15_1 = [input LA:2];
        if ((LA15_1 == LPAREN)) {
          alt15 = 2;
        }
         else if ((LA15_1 == ID)) {
          alt15 = 1;
        }
         else {
          NoViableAltException * nvae = [[[NoViableAltException alloc] init:@"" param1:15 param2:1 param3:input] autorelease];
          @throw nvae;
        }
      }
       else if ((LA15_0 == SUPER || LA15_0 == LPAREN || LA15_0 == LBRACK || LA15_0 == LCURLY || (LA15_0 >= ID && LA15_0 <= STRING) || LA15_0 == AT)) {
        alt15 = 3;
      }
       else {
        NoViableAltException * nvae = [[[NoViableAltException alloc] init:@"" param1:15 param2:0 param3:input] autorelease];
        @throw nvae;
      }

      switch (alt15) {
      case 1:
        {
          char_literal55 = (CommonToken *)[self match:input param1:BANG param2:FOLLOW_BANG_in_notConditional533];
          char_literal55_tree = (CommonTree *)[adaptor create:char_literal55];
          root_0 = (CommonTree *)[adaptor becomeRoot:char_literal55_tree param1:root_0];
          [self pushFollow:FOLLOW_notConditionalExpr_in_notConditional536];
          notConditionalExpr56 = [self notConditionalExpr];
          state._fsp--;
          [adaptor addChild:root_0 param1:[notConditionalExpr56 tree]];
        }
        break;
      case 2:
        {
          char_literal57 = (CommonToken *)[self match:input param1:BANG param2:FOLLOW_BANG_in_notConditional540];
          char_literal57_tree = (CommonTree *)[adaptor create:char_literal57];
          root_0 = (CommonTree *)[adaptor becomeRoot:char_literal57_tree param1:root_0];
          char_literal58 = (CommonToken *)[self match:input param1:LPAREN param2:FOLLOW_LPAREN_in_notConditional543];
          [self pushFollow:FOLLOW_conditional_in_notConditional546];
          conditional59 = [self conditional];
          state._fsp--;
          [adaptor addChild:root_0 param1:[conditional59 tree]];
          char_literal60 = (CommonToken *)[self match:input param1:RPAREN param2:FOLLOW_RPAREN_in_notConditional548];
        }
        break;
      case 3:
        {
          [self pushFollow:FOLLOW_memberExpr_in_notConditional553];
          memberExpr61 = [self memberExpr];
          state._fsp--;
          [adaptor addChild:root_0 param1:[memberExpr61 tree]];
        }
        break;
      }
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

- (notConditionalExpr_return *) notConditionalExpr {
  notConditionalExpr_return * retval = [[[notConditionalExpr_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  CommonToken * p = nil;
  CommonToken * prop = nil;
  CommonToken * ID62 = nil;
  CommonToken * char_literal63 = nil;
  CommonToken * char_literal65 = nil;
  mapExpr_return * mapExpr64 = nil;
  CommonTree * p_tree = nil;
  CommonTree * prop_tree = nil;
  CommonTree * ID62_tree = nil;
  CommonTree * char_literal63_tree = nil;
  CommonTree * char_literal65_tree = nil;
  RewriteRuleTokenStream * stream_RPAREN = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token RPAREN"] autorelease];
  RewriteRuleTokenStream * stream_DOT = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token DOT"] autorelease];
  RewriteRuleTokenStream * stream_ID = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token ID"] autorelease];
  RewriteRuleTokenStream * stream_LPAREN = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token LPAREN"] autorelease];
  RewriteRuleSubtreeStream * stream_mapExpr = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule mapExpr"] autorelease];

  @try {
    {
      {
        ID62 = (CommonToken *)[self match:input param1:ID param2:FOLLOW_ID_in_notConditionalExpr565];
        [stream_ID add:ID62];
        retval.tree = root_0;
        RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
        root_0 = (CommonTree *)[adaptor nil];
        {
          [adaptor addChild:root_0 param1:[stream_ID nextNode]];
        }
        retval.tree = root_0;
      }

      loop16: 
      do {
        int alt16 = 3;
        int LA16_0 = [input LA:1];
        if ((LA16_0 == DOT)) {
          int LA16_2 = [input LA:2];
          if ((LA16_2 == ID)) {
            alt16 = 1;
          }
           else if ((LA16_2 == LPAREN)) {
            alt16 = 2;
          }
        }

        switch (alt16) {
        case 1:
          {
            p = (CommonToken *)[self match:input param1:DOT param2:FOLLOW_DOT_in_notConditionalExpr576];
            [stream_DOT add:p];
            prop = (CommonToken *)[self match:input param1:ID param2:FOLLOW_ID_in_notConditionalExpr580];
            [stream_ID add:prop];
            retval.tree = root_0;
            RewriteRuleTokenStream * stream_prop = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token prop" param2:prop] autorelease];
            RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
            root_0 = (CommonTree *)[adaptor nil];
            {
              {
                CommonTree * root_1 = (CommonTree *)[adaptor nil];
                root_1 = (CommonTree *)[adaptor becomeRoot:(CommonTree *)[adaptor create:PROP param1:p param2:@"PROP"] param1:root_1];
                [adaptor addChild:root_1 param1:[stream_retval nextTree]];
                [adaptor addChild:root_1 param1:[stream_prop nextNode]];
                [adaptor addChild:root_0 param1:root_1];
              }
            }
            retval.tree = root_0;
          }
          break;
        case 2:
          {
            p = (CommonToken *)[self match:input param1:DOT param2:FOLLOW_DOT_in_notConditionalExpr606];
            [stream_DOT add:p];
            char_literal63 = (CommonToken *)[self match:input param1:LPAREN param2:FOLLOW_LPAREN_in_notConditionalExpr608];
            [stream_LPAREN add:char_literal63];
            [self pushFollow:FOLLOW_mapExpr_in_notConditionalExpr610];
            mapExpr64 = [self mapExpr];
            state._fsp--;
            [stream_mapExpr add:[mapExpr64 tree]];
            char_literal65 = (CommonToken *)[self match:input param1:RPAREN param2:FOLLOW_RPAREN_in_notConditionalExpr612];
            [stream_RPAREN add:char_literal65];
            retval.tree = root_0;
            RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
            root_0 = (CommonTree *)[adaptor nil];
            {
              {
                CommonTree * root_1 = (CommonTree *)[adaptor nil];
                root_1 = (CommonTree *)[adaptor becomeRoot:(CommonTree *)[adaptor create:PROP_IND param1:p param2:@"PROP_IND"] param1:root_1];
                [adaptor addChild:root_1 param1:[stream_retval nextTree]];
                [adaptor addChild:root_1 param1:[stream_mapExpr nextTree]];
                [adaptor addChild:root_0 param1:root_1];
              }
            }
            retval.tree = root_0;
          }
          break;
        default:
          break loop16;
        }
      }
       while (YES);
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

- (exprOptions_return *) exprOptions {
  exprOptions_return * retval = [[[exprOptions_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  CommonToken * char_literal67 = nil;
  option_return * option66 = nil;
  option_return * option68 = nil;
  CommonTree * char_literal67_tree = nil;
  RewriteRuleTokenStream * stream_COMMA = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token COMMA"] autorelease];
  RewriteRuleSubtreeStream * stream_option = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule option"] autorelease];

  @try {
    {
      [self pushFollow:FOLLOW_option_in_exprOptions642];
      option66 = [self option];
      state._fsp--;
      [stream_option add:[option66 tree]];

      loop17: 
      do {
        int alt17 = 2;
        int LA17_0 = [input LA:1];
        if ((LA17_0 == COMMA)) {
          alt17 = 1;
        }

        switch (alt17) {
        case 1:
          {
            char_literal67 = (CommonToken *)[self match:input param1:COMMA param2:FOLLOW_COMMA_in_exprOptions646];
            [stream_COMMA add:char_literal67];
            [self pushFollow:FOLLOW_option_in_exprOptions648];
            option68 = [self option];
            state._fsp--;
            [stream_option add:[option68 tree]];
          }
          break;
        default:
          break loop17;
        }
      }
       while (YES);
      retval.tree = root_0;
      RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
      root_0 = (CommonTree *)[adaptor nil];
      {
        {
          CommonTree * root_1 = (CommonTree *)[adaptor nil];
          root_1 = (CommonTree *)[adaptor becomeRoot:(CommonTree *)[adaptor create:OPTIONS param1:@"OPTIONS"] param1:root_1];

          while ([stream_option hasNext]) {
            [adaptor addChild:root_1 param1:[stream_option nextTree]];
          }

          [stream_option reset];
          [adaptor addChild:root_0 param1:root_1];
        }
      }
      retval.tree = root_0;
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

- (option_return *) option {
  option_return * retval = [[[option_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  CommonToken * ID69 = nil;
  CommonToken * char_literal70 = nil;
  exprNoComma_return * exprNoComma71 = nil;
  CommonTree * ID69_tree = nil;
  CommonTree * char_literal70_tree = nil;
  RewriteRuleTokenStream * stream_EQUALS = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token EQUALS"] autorelease];
  RewriteRuleTokenStream * stream_ID = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token ID"] autorelease];
  RewriteRuleSubtreeStream * stream_exprNoComma = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule exprNoComma"] autorelease];
  NSString * id = [[input LT:1] text];
  NSString * defVal = [Compiler.defaultOptionValues get:id];
  BOOL validOption = [Compiler.supportedOptions get:id] != nil;

  @try {
    {
      ID69 = (CommonToken *)[self match:input param1:ID param2:FOLLOW_ID_in_option675];
      [stream_ID add:ID69];
      if (!validOption) {
        [errMgr compileTimeError:ErrorType.NO_SUCH_OPTION param1:templateToken param2:ID69 param3:(ID69 != nil ? [ID69 text] : nil)];
      }
      int alt18 = 2;
      int LA18_0 = [input LA:1];
      if ((LA18_0 == EQUALS)) {
        alt18 = 1;
      }
       else if ((LA18_0 == COMMA || LA18_0 == RDELIM)) {
        alt18 = 2;
      }
       else {
        NoViableAltException * nvae = [[[NoViableAltException alloc] init:@"" param1:18 param2:0 param3:input] autorelease];
        @throw nvae;
      }

      switch (alt18) {
      case 1:
        {
          char_literal70 = (CommonToken *)[self match:input param1:EQUALS param2:FOLLOW_EQUALS_in_option685];
          [stream_EQUALS add:char_literal70];
          [self pushFollow:FOLLOW_exprNoComma_in_option687];
          exprNoComma71 = [self exprNoComma];
          state._fsp--;
          [stream_exprNoComma add:[exprNoComma71 tree]];
          retval.tree = root_0;
          RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
          root_0 = (CommonTree *)[adaptor nil];
          if (validOption) {
            {
              CommonTree * root_1 = (CommonTree *)[adaptor nil];
              root_1 = (CommonTree *)[adaptor becomeRoot:[stream_EQUALS nextNode] param1:root_1];
              [adaptor addChild:root_1 param1:[stream_ID nextNode]];
              [adaptor addChild:root_1 param1:[stream_exprNoComma nextTree]];
              [adaptor addChild:root_0 param1:root_1];
            }
          }
           else {
            root_0 = nil;
          }
          retval.tree = root_0;
        }
        break;
      case 2:
        {
          if (defVal == nil) {
            [errMgr compileTimeError:ErrorType.NO_DEFAULT_VALUE param1:templateToken param2:ID69];
          }
          retval.tree = root_0;
          RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
          root_0 = (CommonTree *)[adaptor nil];
          if (validOption && defVal != nil) {
            {
              CommonTree * root_1 = (CommonTree *)[adaptor nil];
              root_1 = (CommonTree *)[adaptor becomeRoot:(CommonTree *)[adaptor create:EQUALS param1:@"="] param1:root_1];
              [adaptor addChild:root_1 param1:[stream_ID nextNode]];
              [adaptor addChild:root_1 param1:(CommonTree *)[adaptor create:STRING param1:ID69 param2:['"' stringByAppendingString:defVal] + '"']];
              [adaptor addChild:root_0 param1:root_1];
            }
          }
           else {
            root_0 = nil;
          }
          retval.tree = root_0;
        }
        break;
      }
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

- (exprNoComma_return *) exprNoComma {
  exprNoComma_return * retval = [[[exprNoComma_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  CommonToken * char_literal73 = nil;
  memberExpr_return * memberExpr72 = nil;
  mapTemplateRef_return * mapTemplateRef74 = nil;
  CommonTree * char_literal73_tree = nil;
  RewriteRuleTokenStream * stream_COLON = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token COLON"] autorelease];
  RewriteRuleSubtreeStream * stream_memberExpr = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule memberExpr"] autorelease];
  RewriteRuleSubtreeStream * stream_mapTemplateRef = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule mapTemplateRef"] autorelease];

  @try {
    {
      [self pushFollow:FOLLOW_memberExpr_in_exprNoComma794];
      memberExpr72 = [self memberExpr];
      state._fsp--;
      [stream_memberExpr add:[memberExpr72 tree]];
      int alt19 = 2;
      int LA19_0 = [input LA:1];
      if ((LA19_0 == COLON)) {
        alt19 = 1;
      }
       else if ((LA19_0 == RPAREN || (LA19_0 >= RBRACK && LA19_0 <= COMMA) || LA19_0 == RDELIM)) {
        alt19 = 2;
      }
       else {
        NoViableAltException * nvae = [[[NoViableAltException alloc] init:@"" param1:19 param2:0 param3:input] autorelease];
        @throw nvae;
      }

      switch (alt19) {
      case 1:
        {
          char_literal73 = (CommonToken *)[self match:input param1:COLON param2:FOLLOW_COLON_in_exprNoComma800];
          [stream_COLON add:char_literal73];
          [self pushFollow:FOLLOW_mapTemplateRef_in_exprNoComma802];
          mapTemplateRef74 = [self mapTemplateRef];
          state._fsp--;
          [stream_mapTemplateRef add:[mapTemplateRef74 tree]];
          retval.tree = root_0;
          RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
          root_0 = (CommonTree *)[adaptor nil];
          {
            {
              CommonTree * root_1 = (CommonTree *)[adaptor nil];
              root_1 = (CommonTree *)[adaptor becomeRoot:(CommonTree *)[adaptor create:MAP param1:@"MAP"] param1:root_1];
              [adaptor addChild:root_1 param1:[stream_memberExpr nextTree]];
              [adaptor addChild:root_1 param1:[stream_mapTemplateRef nextTree]];
              [adaptor addChild:root_0 param1:root_1];
            }
          }
          retval.tree = root_0;
        }
        break;
      case 2:
        {
          retval.tree = root_0;
          RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
          root_0 = (CommonTree *)[adaptor nil];
          {
            [adaptor addChild:root_0 param1:[stream_memberExpr nextTree]];
          }
          retval.tree = root_0;
        }
        break;
      }
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

- (expr_return *) expr {
  expr_return * retval = [[[expr_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  mapExpr_return * mapExpr75 = nil;

  @try {
    {
      root_0 = (CommonTree *)[adaptor nil];
      [self pushFollow:FOLLOW_mapExpr_in_expr847];
      mapExpr75 = [self mapExpr];
      state._fsp--;
      [adaptor addChild:root_0 param1:[mapExpr75 tree]];
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

- (mapExpr_return *) mapExpr {
  mapExpr_return * retval = [[[mapExpr_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  CommonToken * c = nil;
  CommonToken * col = nil;
  CommonToken * char_literal79 = nil;
  NSMutableArray * list_x = nil;
  memberExpr_return * memberExpr76 = nil;
  memberExpr_return * memberExpr77 = nil;
  mapTemplateRef_return * mapTemplateRef78 = nil;
  RuleReturnScope * x = nil;
  CommonTree * c_tree = nil;
  CommonTree * col_tree = nil;
  CommonTree * char_literal79_tree = nil;
  RewriteRuleTokenStream * stream_COLON = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token COLON"] autorelease];
  RewriteRuleTokenStream * stream_COMMA = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token COMMA"] autorelease];
  RewriteRuleSubtreeStream * stream_memberExpr = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule memberExpr"] autorelease];
  RewriteRuleSubtreeStream * stream_mapTemplateRef = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule mapTemplateRef"] autorelease];

  @try {
    {
      [self pushFollow:FOLLOW_memberExpr_in_mapExpr859];
      memberExpr76 = [self memberExpr];
      state._fsp--;
      [stream_memberExpr add:[memberExpr76 tree]];
      int alt21 = 2;
      int LA21_0 = [input LA:1];
      if ((LA21_0 == COMMA)) {
        alt21 = 1;
      }
       else if ((LA21_0 == SEMI || LA21_0 == COLON || LA21_0 == RPAREN || LA21_0 == RDELIM)) {
        alt21 = 2;
      }
       else {
        NoViableAltException * nvae = [[[NoViableAltException alloc] init:@"" param1:21 param2:0 param3:input] autorelease];
        @throw nvae;
      }

      switch (alt21) {
      case 1:
        {
          int cnt20 = 0;

          loop20: 
          do {
            int alt20 = 2;
            int LA20_0 = [input LA:1];
            if ((LA20_0 == COMMA)) {
              alt20 = 1;
            }

            switch (alt20) {
            case 1:
              {
                c = (CommonToken *)[self match:input param1:COMMA param2:FOLLOW_COMMA_in_mapExpr868];
                [stream_COMMA add:c];
                [self pushFollow:FOLLOW_memberExpr_in_mapExpr870];
                memberExpr77 = [self memberExpr];
                state._fsp--;
                [stream_memberExpr add:[memberExpr77 tree]];
              }
              break;
            default:
              if (cnt20 >= 1)
                break loop20;
              EarlyExitException * eee = [[[EarlyExitException alloc] init:20 param1:input] autorelease];
              @throw eee;
            }
            cnt20++;
          }
           while (YES);
          col = (CommonToken *)[self match:input param1:COLON param2:FOLLOW_COLON_in_mapExpr876];
          [stream_COLON add:col];
          [self pushFollow:FOLLOW_mapTemplateRef_in_mapExpr878];
          mapTemplateRef78 = [self mapTemplateRef];
          state._fsp--;
          [stream_mapTemplateRef add:[mapTemplateRef78 tree]];
          retval.tree = root_0;
          RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
          root_0 = (CommonTree *)[adaptor nil];
          {
            {
              CommonTree * root_1 = (CommonTree *)[adaptor nil];
              root_1 = (CommonTree *)[adaptor becomeRoot:(CommonTree *)[adaptor create:ZIP param1:col] param1:root_1];
              {
                CommonTree * root_2 = (CommonTree *)[adaptor nil];
                root_2 = (CommonTree *)[adaptor becomeRoot:(CommonTree *)[adaptor create:ELEMENTS param1:@"ELEMENTS"] param1:root_2];
                if (!([stream_memberExpr hasNext])) {
                  @throw [[[RewriteEarlyExitException alloc] init] autorelease];
                }

                while ([stream_memberExpr hasNext]) {
                  [adaptor addChild:root_2 param1:[stream_memberExpr nextTree]];
                }

                [stream_memberExpr reset];
                [adaptor addChild:root_1 param1:root_2];
              }
              [adaptor addChild:root_1 param1:[stream_mapTemplateRef nextTree]];
              [adaptor addChild:root_0 param1:root_1];
            }
          }
          retval.tree = root_0;
        }
        break;
      case 2:
        {
          retval.tree = root_0;
          RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
          root_0 = (CommonTree *)[adaptor nil];
          {
            [adaptor addChild:root_0 param1:[stream_memberExpr nextTree]];
          }
          retval.tree = root_0;
        }
        break;
      }

      loop23: 
      do {
        int alt23 = 2;
        int LA23_0 = [input LA:1];
        if ((LA23_0 == COLON)) {
          alt23 = 1;
        }

        switch (alt23) {
        case 1:
          {
            if (list_x != nil)
              [list_x removeAllObjects];
            col = (CommonToken *)[self match:input param1:COLON param2:FOLLOW_COLON_in_mapExpr941];
            [stream_COLON add:col];
            [self pushFollow:FOLLOW_mapTemplateRef_in_mapExpr945];
            x = [self mapTemplateRef];
            state._fsp--;
            [stream_mapTemplateRef add:[x tree]];
            if (list_x == nil)
              list_x = [[[NSMutableArray alloc] init] autorelease];
            [list_x addObject:[x tree]];

            loop22: 
            do {
              int alt22 = 2;
              int LA22_0 = [input LA:1];
              if ((LA22_0 == COMMA) && ((c == nil))) {
                alt22 = 1;
              }

              switch (alt22) {
              case 1:
                {
                  if (!((c == nil))) {
                    @throw [[[FailedPredicateException alloc] init:input param1:@"mapExpr" param2:@"$c==null"] autorelease];
                  }
                  char_literal79 = (CommonToken *)[self match:input param1:COMMA param2:FOLLOW_COMMA_in_mapExpr951];
                  [stream_COMMA add:char_literal79];
                  [self pushFollow:FOLLOW_mapTemplateRef_in_mapExpr955];
                  x = [self mapTemplateRef];
                  state._fsp--;
                  [stream_mapTemplateRef add:[x tree]];
                  if (list_x == nil)
                    list_x = [[[NSMutableArray alloc] init] autorelease];
                  [list_x addObject:[x tree]];
                }
                break;
              default:
                break loop22;
              }
            }
             while (YES);
            retval.tree = root_0;
            RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
            RewriteRuleSubtreeStream * stream_x = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"token x" param2:list_x] autorelease];
            root_0 = (CommonTree *)[adaptor nil];
            {
              {
                CommonTree * root_1 = (CommonTree *)[adaptor nil];
                root_1 = (CommonTree *)[adaptor becomeRoot:(CommonTree *)[adaptor create:MAP param1:col] param1:root_1];
                [adaptor addChild:root_1 param1:[stream_retval nextTree]];
                if (!([stream_x hasNext])) {
                  @throw [[[RewriteEarlyExitException alloc] init] autorelease];
                }

                while ([stream_x hasNext]) {
                  [adaptor addChild:root_1 param1:[stream_x nextTree]];
                }

                [stream_x reset];
                [adaptor addChild:root_0 param1:root_1];
              }
            }
            retval.tree = root_0;
          }
          break;
        default:
          break loop23;
        }
      }
       while (YES);
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

- (mapTemplateRef_return *) mapTemplateRef {
  mapTemplateRef_return * retval = [[[mapTemplateRef_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  CommonToken * lp = nil;
  CommonToken * rp = nil;
  CommonToken * ID80 = nil;
  CommonToken * char_literal81 = nil;
  CommonToken * char_literal83 = nil;
  CommonToken * char_literal86 = nil;
  CommonToken * char_literal88 = nil;
  args_return * args82 = nil;
  subtemplate_return * subtemplate84 = nil;
  mapExpr_return * mapExpr85 = nil;
  argExprList_return * argExprList87 = nil;
  CommonTree * lp_tree = nil;
  CommonTree * rp_tree = nil;
  CommonTree * ID80_tree = nil;
  CommonTree * char_literal81_tree = nil;
  CommonTree * char_literal83_tree = nil;
  CommonTree * char_literal86_tree = nil;
  CommonTree * char_literal88_tree = nil;
  RewriteRuleTokenStream * stream_RPAREN = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token RPAREN"] autorelease];
  RewriteRuleTokenStream * stream_ID = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token ID"] autorelease];
  RewriteRuleTokenStream * stream_LPAREN = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token LPAREN"] autorelease];
  RewriteRuleSubtreeStream * stream_argExprList = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule argExprList"] autorelease];
  RewriteRuleSubtreeStream * stream_args = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule args"] autorelease];
  RewriteRuleSubtreeStream * stream_mapExpr = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule mapExpr"] autorelease];

  @try {
    int alt25 = 3;

    switch ([input LA:1]) {
    case ID:
      {
        alt25 = 1;
      }
      break;
    case LCURLY:
      {
        alt25 = 2;
      }
      break;
    case LPAREN:
      {
        alt25 = 3;
      }
      break;
    default:
      NoViableAltException * nvae = [[[NoViableAltException alloc] init:@"" param1:25 param2:0 param3:input] autorelease];
      @throw nvae;
    }

    switch (alt25) {
    case 1:
      {
        ID80 = (CommonToken *)[self match:input param1:ID param2:FOLLOW_ID_in_mapTemplateRef1002];
        [stream_ID add:ID80];
        char_literal81 = (CommonToken *)[self match:input param1:LPAREN param2:FOLLOW_LPAREN_in_mapTemplateRef1004];
        [stream_LPAREN add:char_literal81];
        [self pushFollow:FOLLOW_args_in_mapTemplateRef1006];
        args82 = [self args];
        state._fsp--;
        [stream_args add:[args82 tree]];
        char_literal83 = (CommonToken *)[self match:input param1:RPAREN param2:FOLLOW_RPAREN_in_mapTemplateRef1008];
        [stream_RPAREN add:char_literal83];
        retval.tree = root_0;
        RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
        root_0 = (CommonTree *)[adaptor nil];
        {
          {
            CommonTree * root_1 = (CommonTree *)[adaptor nil];
            root_1 = (CommonTree *)[adaptor becomeRoot:(CommonTree *)[adaptor create:INCLUDE param1:@"INCLUDE"] param1:root_1];
            [adaptor addChild:root_1 param1:[stream_ID nextNode]];
            if ([stream_args hasNext]) {
              [adaptor addChild:root_1 param1:[stream_args nextTree]];
            }
            [stream_args reset];
            [adaptor addChild:root_0 param1:root_1];
          }
        }
        retval.tree = root_0;
      }
      break;
    case 2:
      {
        root_0 = (CommonTree *)[adaptor nil];
        [self pushFollow:FOLLOW_subtemplate_in_mapTemplateRef1030];
        subtemplate84 = [self subtemplate];
        state._fsp--;
        [adaptor addChild:root_0 param1:[subtemplate84 tree]];
      }
      break;
    case 3:
      {
        lp = (CommonToken *)[self match:input param1:LPAREN param2:FOLLOW_LPAREN_in_mapTemplateRef1037];
        [stream_LPAREN add:lp];
        [self pushFollow:FOLLOW_mapExpr_in_mapTemplateRef1039];
        mapExpr85 = [self mapExpr];
        state._fsp--;
        [stream_mapExpr add:[mapExpr85 tree]];
        rp = (CommonToken *)[self match:input param1:RPAREN param2:FOLLOW_RPAREN_in_mapTemplateRef1043];
        [stream_RPAREN add:rp];
        char_literal86 = (CommonToken *)[self match:input param1:LPAREN param2:FOLLOW_LPAREN_in_mapTemplateRef1045];
        [stream_LPAREN add:char_literal86];
        int alt24 = 2;
        int LA24_0 = [input LA:1];
        if ((LA24_0 == SUPER || LA24_0 == LPAREN || LA24_0 == LBRACK || LA24_0 == LCURLY || (LA24_0 >= ID && LA24_0 <= STRING) || LA24_0 == AT)) {
          alt24 = 1;
        }

        switch (alt24) {
        case 1:
          {
            [self pushFollow:FOLLOW_argExprList_in_mapTemplateRef1047];
            argExprList87 = [self argExprList];
            state._fsp--;
            [stream_argExprList add:[argExprList87 tree]];
          }
          break;
        }
        char_literal88 = (CommonToken *)[self match:input param1:RPAREN param2:FOLLOW_RPAREN_in_mapTemplateRef1050];
        [stream_RPAREN add:char_literal88];
        retval.tree = root_0;
        RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
        root_0 = (CommonTree *)[adaptor nil];
        {
          {
            CommonTree * root_1 = (CommonTree *)[adaptor nil];
            root_1 = (CommonTree *)[adaptor becomeRoot:(CommonTree *)[adaptor create:INCLUDE_IND param1:@"INCLUDE_IND"] param1:root_1];
            [adaptor addChild:root_1 param1:[stream_mapExpr nextTree]];
            if ([stream_argExprList hasNext]) {
              [adaptor addChild:root_1 param1:[stream_argExprList nextTree]];
            }
            [stream_argExprList reset];
            [adaptor addChild:root_0 param1:root_1];
          }
        }
        retval.tree = root_0;
      }
      break;
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

- (memberExpr_return *) memberExpr {
  memberExpr_return * retval = [[[memberExpr_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  CommonToken * p = nil;
  CommonToken * ID90 = nil;
  CommonToken * char_literal91 = nil;
  CommonToken * char_literal93 = nil;
  includeExpr_return * includeExpr89 = nil;
  mapExpr_return * mapExpr92 = nil;
  CommonTree * p_tree = nil;
  CommonTree * ID90_tree = nil;
  CommonTree * char_literal91_tree = nil;
  CommonTree * char_literal93_tree = nil;
  RewriteRuleTokenStream * stream_RPAREN = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token RPAREN"] autorelease];
  RewriteRuleTokenStream * stream_DOT = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token DOT"] autorelease];
  RewriteRuleTokenStream * stream_ID = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token ID"] autorelease];
  RewriteRuleTokenStream * stream_LPAREN = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token LPAREN"] autorelease];
  RewriteRuleSubtreeStream * stream_includeExpr = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule includeExpr"] autorelease];
  RewriteRuleSubtreeStream * stream_mapExpr = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule mapExpr"] autorelease];

  @try {
    {
      {
        [self pushFollow:FOLLOW_includeExpr_in_memberExpr1072];
        includeExpr89 = [self includeExpr];
        state._fsp--;
        [stream_includeExpr add:[includeExpr89 tree]];
        retval.tree = root_0;
        RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
        root_0 = (CommonTree *)[adaptor nil];
        {
          [adaptor addChild:root_0 param1:[stream_includeExpr nextTree]];
        }
        retval.tree = root_0;
      }

      loop26: 
      do {
        int alt26 = 3;
        int LA26_0 = [input LA:1];
        if ((LA26_0 == DOT)) {
          int LA26_2 = [input LA:2];
          if ((LA26_2 == ID)) {
            alt26 = 1;
          }
           else if ((LA26_2 == LPAREN)) {
            alt26 = 2;
          }
        }

        switch (alt26) {
        case 1:
          {
            p = (CommonToken *)[self match:input param1:DOT param2:FOLLOW_DOT_in_memberExpr1083];
            [stream_DOT add:p];
            ID90 = (CommonToken *)[self match:input param1:ID param2:FOLLOW_ID_in_memberExpr1085];
            [stream_ID add:ID90];
            retval.tree = root_0;
            RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
            root_0 = (CommonTree *)[adaptor nil];
            {
              {
                CommonTree * root_1 = (CommonTree *)[adaptor nil];
                root_1 = (CommonTree *)[adaptor becomeRoot:(CommonTree *)[adaptor create:PROP param1:p param2:@"PROP"] param1:root_1];
                [adaptor addChild:root_1 param1:[stream_retval nextTree]];
                [adaptor addChild:root_1 param1:[stream_ID nextNode]];
                [adaptor addChild:root_0 param1:root_1];
              }
            }
            retval.tree = root_0;
          }
          break;
        case 2:
          {
            p = (CommonToken *)[self match:input param1:DOT param2:FOLLOW_DOT_in_memberExpr1111];
            [stream_DOT add:p];
            char_literal91 = (CommonToken *)[self match:input param1:LPAREN param2:FOLLOW_LPAREN_in_memberExpr1113];
            [stream_LPAREN add:char_literal91];
            [self pushFollow:FOLLOW_mapExpr_in_memberExpr1115];
            mapExpr92 = [self mapExpr];
            state._fsp--;
            [stream_mapExpr add:[mapExpr92 tree]];
            char_literal93 = (CommonToken *)[self match:input param1:RPAREN param2:FOLLOW_RPAREN_in_memberExpr1117];
            [stream_RPAREN add:char_literal93];
            retval.tree = root_0;
            RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
            root_0 = (CommonTree *)[adaptor nil];
            {
              {
                CommonTree * root_1 = (CommonTree *)[adaptor nil];
                root_1 = (CommonTree *)[adaptor becomeRoot:(CommonTree *)[adaptor create:PROP_IND param1:p param2:@"PROP_IND"] param1:root_1];
                [adaptor addChild:root_1 param1:[stream_retval nextTree]];
                [adaptor addChild:root_1 param1:[stream_mapExpr nextTree]];
                [adaptor addChild:root_0 param1:root_1];
              }
            }
            retval.tree = root_0;
          }
          break;
        default:
          break loop26;
        }
      }
       while (YES);
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

- (includeExpr_return *) includeExpr {
  includeExpr_return * retval = [[[includeExpr_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  CommonToken * rp = nil;
  CommonToken * ID94 = nil;
  CommonToken * char_literal95 = nil;
  CommonToken * char_literal97 = nil;
  CommonToken * string_literal98 = nil;
  CommonToken * char_literal99 = nil;
  CommonToken * ID100 = nil;
  CommonToken * char_literal101 = nil;
  CommonToken * char_literal103 = nil;
  CommonToken * ID104 = nil;
  CommonToken * char_literal105 = nil;
  CommonToken * char_literal107 = nil;
  CommonToken * char_literal108 = nil;
  CommonToken * string_literal109 = nil;
  CommonToken * char_literal110 = nil;
  CommonToken * ID111 = nil;
  CommonToken * char_literal112 = nil;
  CommonToken * char_literal113 = nil;
  CommonToken * ID114 = nil;
  CommonToken * char_literal115 = nil;
  expr_return * expr96 = nil;
  args_return * args102 = nil;
  args_return * args106 = nil;
  primary_return * primary116 = nil;
  CommonTree * rp_tree = nil;
  CommonTree * ID94_tree = nil;
  CommonTree * char_literal95_tree = nil;
  CommonTree * char_literal97_tree = nil;
  CommonTree * string_literal98_tree = nil;
  CommonTree * char_literal99_tree = nil;
  CommonTree * ID100_tree = nil;
  CommonTree * char_literal101_tree = nil;
  CommonTree * char_literal103_tree = nil;
  CommonTree * ID104_tree = nil;
  CommonTree * char_literal105_tree = nil;
  CommonTree * char_literal107_tree = nil;
  CommonTree * char_literal108_tree = nil;
  CommonTree * string_literal109_tree = nil;
  CommonTree * char_literal110_tree = nil;
  CommonTree * ID111_tree = nil;
  CommonTree * char_literal112_tree = nil;
  CommonTree * char_literal113_tree = nil;
  CommonTree * ID114_tree = nil;
  CommonTree * char_literal115_tree = nil;
  RewriteRuleTokenStream * stream_AT = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token AT"] autorelease];
  RewriteRuleTokenStream * stream_RPAREN = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token RPAREN"] autorelease];
  RewriteRuleTokenStream * stream_SUPER = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token SUPER"] autorelease];
  RewriteRuleTokenStream * stream_DOT = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token DOT"] autorelease];
  RewriteRuleTokenStream * stream_ID = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token ID"] autorelease];
  RewriteRuleTokenStream * stream_LPAREN = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token LPAREN"] autorelease];
  RewriteRuleSubtreeStream * stream_args = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule args"] autorelease];
  RewriteRuleSubtreeStream * stream_expr = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule expr"] autorelease];

  @try {
    int alt28 = 6;
    alt28 = [dfa28 predict:input];

    switch (alt28) {
    case 1:
      {
        if (!(([Compiler.funcs objectForKey:[input LT:1].text]))) {
          @throw [[[FailedPredicateException alloc] init:input param1:@"includeExpr" param2:@"Compiler.funcs.objectForKey:input.LT(1).text())"] autorelease];
        }
        ID94 = (CommonToken *)[self match:input param1:ID param2:FOLLOW_ID_in_includeExpr1161];
        [stream_ID add:ID94];
        char_literal95 = (CommonToken *)[self match:input param1:LPAREN param2:FOLLOW_LPAREN_in_includeExpr1163];
        [stream_LPAREN add:char_literal95];
        int alt27 = 2;
        int LA27_0 = [input LA:1];
        if ((LA27_0 == SUPER || LA27_0 == LPAREN || LA27_0 == LBRACK || LA27_0 == LCURLY || (LA27_0 >= ID && LA27_0 <= STRING) || LA27_0 == AT)) {
          alt27 = 1;
        }

        switch (alt27) {
        case 1:
          {
            [self pushFollow:FOLLOW_expr_in_includeExpr1165];
            expr96 = [self expr];
            state._fsp--;
            [stream_expr add:[expr96 tree]];
          }
          break;
        }
        char_literal97 = (CommonToken *)[self match:input param1:RPAREN param2:FOLLOW_RPAREN_in_includeExpr1168];
        [stream_RPAREN add:char_literal97];
        retval.tree = root_0;
        RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
        root_0 = (CommonTree *)[adaptor nil];
        {
          {
            CommonTree * root_1 = (CommonTree *)[adaptor nil];
            root_1 = (CommonTree *)[adaptor becomeRoot:(CommonTree *)[adaptor create:EXEC_FUNC param1:@"EXEC_FUNC"] param1:root_1];
            [adaptor addChild:root_1 param1:[stream_ID nextNode]];
            if ([stream_expr hasNext]) {
              [adaptor addChild:root_1 param1:[stream_expr nextTree]];
            }
            [stream_expr reset];
            [adaptor addChild:root_0 param1:root_1];
          }
        }
        retval.tree = root_0;
      }
      break;
    case 2:
      {
        string_literal98 = (CommonToken *)[self match:input param1:SUPER param2:FOLLOW_SUPER_in_includeExpr1189];
        [stream_SUPER add:string_literal98];
        char_literal99 = (CommonToken *)[self match:input param1:DOT param2:FOLLOW_DOT_in_includeExpr1191];
        [stream_DOT add:char_literal99];
        ID100 = (CommonToken *)[self match:input param1:ID param2:FOLLOW_ID_in_includeExpr1193];
        [stream_ID add:ID100];
        char_literal101 = (CommonToken *)[self match:input param1:LPAREN param2:FOLLOW_LPAREN_in_includeExpr1195];
        [stream_LPAREN add:char_literal101];
        [self pushFollow:FOLLOW_args_in_includeExpr1197];
        args102 = [self args];
        state._fsp--;
        [stream_args add:[args102 tree]];
        char_literal103 = (CommonToken *)[self match:input param1:RPAREN param2:FOLLOW_RPAREN_in_includeExpr1199];
        [stream_RPAREN add:char_literal103];
        retval.tree = root_0;
        RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
        root_0 = (CommonTree *)[adaptor nil];
        {
          {
            CommonTree * root_1 = (CommonTree *)[adaptor nil];
            root_1 = (CommonTree *)[adaptor becomeRoot:(CommonTree *)[adaptor create:INCLUDE_SUPER param1:@"INCLUDE_SUPER"] param1:root_1];
            [adaptor addChild:root_1 param1:[stream_ID nextNode]];
            if ([stream_args hasNext]) {
              [adaptor addChild:root_1 param1:[stream_args nextTree]];
            }
            [stream_args reset];
            [adaptor addChild:root_0 param1:root_1];
          }
        }
        retval.tree = root_0;
      }
      break;
    case 3:
      {
        ID104 = (CommonToken *)[self match:input param1:ID param2:FOLLOW_ID_in_includeExpr1218];
        [stream_ID add:ID104];
        char_literal105 = (CommonToken *)[self match:input param1:LPAREN param2:FOLLOW_LPAREN_in_includeExpr1220];
        [stream_LPAREN add:char_literal105];
        [self pushFollow:FOLLOW_args_in_includeExpr1222];
        args106 = [self args];
        state._fsp--;
        [stream_args add:[args106 tree]];
        char_literal107 = (CommonToken *)[self match:input param1:RPAREN param2:FOLLOW_RPAREN_in_includeExpr1224];
        [stream_RPAREN add:char_literal107];
        retval.tree = root_0;
        RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
        root_0 = (CommonTree *)[adaptor nil];
        {
          {
            CommonTree * root_1 = (CommonTree *)[adaptor nil];
            root_1 = (CommonTree *)[adaptor becomeRoot:(CommonTree *)[adaptor create:INCLUDE param1:@"INCLUDE"] param1:root_1];
            [adaptor addChild:root_1 param1:[stream_ID nextNode]];
            if ([stream_args hasNext]) {
              [adaptor addChild:root_1 param1:[stream_args nextTree]];
            }
            [stream_args reset];
            [adaptor addChild:root_0 param1:root_1];
          }
        }
        retval.tree = root_0;
      }
      break;
    case 4:
      {
        char_literal108 = (CommonToken *)[self match:input param1:AT param2:FOLLOW_AT_in_includeExpr1246];
        [stream_AT add:char_literal108];
        string_literal109 = (CommonToken *)[self match:input param1:SUPER param2:FOLLOW_SUPER_in_includeExpr1248];
        [stream_SUPER add:string_literal109];
        char_literal110 = (CommonToken *)[self match:input param1:DOT param2:FOLLOW_DOT_in_includeExpr1250];
        [stream_DOT add:char_literal110];
        ID111 = (CommonToken *)[self match:input param1:ID param2:FOLLOW_ID_in_includeExpr1252];
        [stream_ID add:ID111];
        char_literal112 = (CommonToken *)[self match:input param1:LPAREN param2:FOLLOW_LPAREN_in_includeExpr1254];
        [stream_LPAREN add:char_literal112];
        rp = (CommonToken *)[self match:input param1:RPAREN param2:FOLLOW_RPAREN_in_includeExpr1258];
        [stream_RPAREN add:rp];
        retval.tree = root_0;
        RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
        root_0 = (CommonTree *)[adaptor nil];
        {
          {
            CommonTree * root_1 = (CommonTree *)[adaptor nil];
            root_1 = (CommonTree *)[adaptor becomeRoot:(CommonTree *)[adaptor create:INCLUDE_SUPER_REGION param1:@"INCLUDE_SUPER_REGION"] param1:root_1];
            [adaptor addChild:root_1 param1:[stream_ID nextNode]];
            [adaptor addChild:root_0 param1:root_1];
          }
        }
        retval.tree = root_0;
      }
      break;
    case 5:
      {
        char_literal113 = (CommonToken *)[self match:input param1:AT param2:FOLLOW_AT_in_includeExpr1273];
        [stream_AT add:char_literal113];
        ID114 = (CommonToken *)[self match:input param1:ID param2:FOLLOW_ID_in_includeExpr1275];
        [stream_ID add:ID114];
        char_literal115 = (CommonToken *)[self match:input param1:LPAREN param2:FOLLOW_LPAREN_in_includeExpr1277];
        [stream_LPAREN add:char_literal115];
        rp = (CommonToken *)[self match:input param1:RPAREN param2:FOLLOW_RPAREN_in_includeExpr1281];
        [stream_RPAREN add:rp];
        retval.tree = root_0;
        RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
        root_0 = (CommonTree *)[adaptor nil];
        {
          {
            CommonTree * root_1 = (CommonTree *)[adaptor nil];
            root_1 = (CommonTree *)[adaptor becomeRoot:(CommonTree *)[adaptor create:INCLUDE_REGION param1:@"INCLUDE_REGION"] param1:root_1];
            [adaptor addChild:root_1 param1:[stream_ID nextNode]];
            [adaptor addChild:root_0 param1:root_1];
          }
        }
        retval.tree = root_0;
      }
      break;
    case 6:
      {
        root_0 = (CommonTree *)[adaptor nil];
        [self pushFollow:FOLLOW_primary_in_includeExpr1299];
        primary116 = [self primary];
        state._fsp--;
        [adaptor addChild:root_0 param1:[primary116 tree]];
      }
      break;
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

- (primary_return *) primary {
  primary_return * retval = [[[primary_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  CommonToken * lp = nil;
  CommonToken * ID117 = nil;
  CommonToken * STRING118 = nil;
  CommonToken * char_literal122 = nil;
  CommonToken * char_literal123 = nil;
  CommonToken * char_literal125 = nil;
  subtemplate_return * subtemplate119 = nil;
  list_return * list120 = nil;
  expr_return * expr121 = nil;
  argExprList_return * argExprList124 = nil;
  CommonTree * lp_tree = nil;
  CommonTree * ID117_tree = nil;
  CommonTree * STRING118_tree = nil;
  CommonTree * char_literal122_tree = nil;
  CommonTree * char_literal123_tree = nil;
  CommonTree * char_literal125_tree = nil;
  RewriteRuleTokenStream * stream_RPAREN = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token RPAREN"] autorelease];
  RewriteRuleTokenStream * stream_LPAREN = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token LPAREN"] autorelease];
  RewriteRuleSubtreeStream * stream_argExprList = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule argExprList"] autorelease];
  RewriteRuleSubtreeStream * stream_expr = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule expr"] autorelease];

  @try {
    int alt31 = 5;

    switch ([input LA:1]) {
    case ID:
      {
        alt31 = 1;
      }
      break;
    case STRING:
      {
        alt31 = 2;
      }
      break;
    case LCURLY:
      {
        alt31 = 3;
      }
      break;
    case LBRACK:
      {
        alt31 = 4;
      }
      break;
    case LPAREN:
      {
        alt31 = 5;
      }
      break;
    default:
      NoViableAltException * nvae = [[[NoViableAltException alloc] init:@"" param1:31 param2:0 param3:input] autorelease];
      @throw nvae;
    }

    switch (alt31) {
    case 1:
      {
        root_0 = (CommonTree *)[adaptor nil];
        ID117 = (CommonToken *)[self match:input param1:ID param2:FOLLOW_ID_in_primary1310];
        ID117_tree = (CommonTree *)[adaptor create:ID117];
        [adaptor addChild:root_0 param1:ID117_tree];
      }
      break;
    case 2:
      {
        root_0 = (CommonTree *)[adaptor nil];
        STRING118 = (CommonToken *)[self match:input param1:STRING param2:FOLLOW_STRING_in_primary1315];
        STRING118_tree = (CommonTree *)[adaptor create:STRING118];
        [adaptor addChild:root_0 param1:STRING118_tree];
      }
      break;
    case 3:
      {
        root_0 = (CommonTree *)[adaptor nil];
        [self pushFollow:FOLLOW_subtemplate_in_primary1320];
        subtemplate119 = [self subtemplate];
        state._fsp--;
        [adaptor addChild:root_0 param1:[subtemplate119 tree]];
      }
      break;
    case 4:
      {
        root_0 = (CommonTree *)[adaptor nil];
        [self pushFollow:FOLLOW_list_in_primary1325];
        list120 = [self list];
        state._fsp--;
        [adaptor addChild:root_0 param1:[list120 tree]];
      }
      break;
    case 5:
      {
        lp = (CommonToken *)[self match:input param1:LPAREN param2:FOLLOW_LPAREN_in_primary1332];
        [stream_LPAREN add:lp];
        [self pushFollow:FOLLOW_expr_in_primary1334];
        expr121 = [self expr];
        state._fsp--;
        [stream_expr add:[expr121 tree]];
        char_literal122 = (CommonToken *)[self match:input param1:RPAREN param2:FOLLOW_RPAREN_in_primary1336];
        [stream_RPAREN add:char_literal122];
        int alt30 = 2;
        int LA30_0 = [input LA:1];
        if ((LA30_0 == LPAREN)) {
          alt30 = 1;
        }
         else if ((LA30_0 == SEMI || LA30_0 == COLON || LA30_0 == RPAREN || (LA30_0 >= RBRACK && LA30_0 <= DOT) || LA30_0 == RDELIM || (LA30_0 >= OR && LA30_0 <= AND))) {
          alt30 = 2;
        }
         else {
          NoViableAltException * nvae = [[[NoViableAltException alloc] init:@"" param1:30 param2:0 param3:input] autorelease];
          @throw nvae;
        }

        switch (alt30) {
        case 1:
          {
            char_literal123 = (CommonToken *)[self match:input param1:LPAREN param2:FOLLOW_LPAREN_in_primary1342];
            [stream_LPAREN add:char_literal123];
            int alt29 = 2;
            int LA29_0 = [input LA:1];
            if ((LA29_0 == SUPER || LA29_0 == LPAREN || LA29_0 == LBRACK || LA29_0 == LCURLY || (LA29_0 >= ID && LA29_0 <= STRING) || LA29_0 == AT)) {
              alt29 = 1;
            }

            switch (alt29) {
            case 1:
              {
                [self pushFollow:FOLLOW_argExprList_in_primary1344];
                argExprList124 = [self argExprList];
                state._fsp--;
                [stream_argExprList add:[argExprList124 tree]];
              }
              break;
            }
            char_literal125 = (CommonToken *)[self match:input param1:RPAREN param2:FOLLOW_RPAREN_in_primary1347];
            [stream_RPAREN add:char_literal125];
            retval.tree = root_0;
            RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
            root_0 = (CommonTree *)[adaptor nil];
            {
              {
                CommonTree * root_1 = (CommonTree *)[adaptor nil];
                root_1 = (CommonTree *)[adaptor becomeRoot:(CommonTree *)[adaptor create:INCLUDE_IND param1:lp] param1:root_1];
                [adaptor addChild:root_1 param1:[stream_expr nextTree]];
                if ([stream_argExprList hasNext]) {
                  [adaptor addChild:root_1 param1:[stream_argExprList nextTree]];
                }
                [stream_argExprList reset];
                [adaptor addChild:root_0 param1:root_1];
              }
            }
            retval.tree = root_0;
          }
          break;
        case 2:
          {
            retval.tree = root_0;
            RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
            root_0 = (CommonTree *)[adaptor nil];
            {
              {
                CommonTree * root_1 = (CommonTree *)[adaptor nil];
                root_1 = (CommonTree *)[adaptor becomeRoot:(CommonTree *)[adaptor create:TO_STR param1:lp] param1:root_1];
                [adaptor addChild:root_1 param1:[stream_expr nextTree]];
                [adaptor addChild:root_0 param1:root_1];
              }
            }
            retval.tree = root_0;
          }
          break;
        }
      }
      break;
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

- (args_return *) args {
  args_return * retval = [[[args_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  CommonToken * char_literal128 = nil;
  argExprList_return * argExprList126 = nil;
  namedArg_return * namedArg127 = nil;
  namedArg_return * namedArg129 = nil;
  CommonTree * char_literal128_tree = nil;
  RewriteRuleTokenStream * stream_COMMA = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token COMMA"] autorelease];
  RewriteRuleSubtreeStream * stream_namedArg = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule namedArg"] autorelease];

  @try {
    int alt33 = 3;

    switch ([input LA:1]) {
    case ID:
      {
        int LA33_1 = [input LA:2];
        if (((LA33_1 >= COLON && LA33_1 <= RPAREN) || (LA33_1 >= COMMA && LA33_1 <= DOT))) {
          alt33 = 1;
        }
         else if ((LA33_1 == EQUALS)) {
          alt33 = 2;
        }
         else {
          NoViableAltException * nvae = [[[NoViableAltException alloc] init:@"" param1:33 param2:1 param3:input] autorelease];
          @throw nvae;
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
        alt33 = 1;
      }
      break;
    case RPAREN:
      {
        alt33 = 3;
      }
      break;
    default:
      NoViableAltException * nvae = [[[NoViableAltException alloc] init:@"" param1:33 param2:0 param3:input] autorelease];
      @throw nvae;
    }

    switch (alt33) {
    case 1:
      {
        root_0 = (CommonTree *)[adaptor nil];
        [self pushFollow:FOLLOW_argExprList_in_args1397];
        argExprList126 = [self argExprList];
        state._fsp--;
        [adaptor addChild:root_0 param1:[argExprList126 tree]];
      }
      break;
    case 2:
      {
        [self pushFollow:FOLLOW_namedArg_in_args1402];
        namedArg127 = [self namedArg];
        state._fsp--;
        [stream_namedArg add:[namedArg127 tree]];

        loop32: 
        do {
          int alt32 = 2;
          int LA32_0 = [input LA:1];
          if ((LA32_0 == COMMA)) {
            alt32 = 1;
          }

          switch (alt32) {
          case 1:
            {
              char_literal128 = (CommonToken *)[self match:input param1:COMMA param2:FOLLOW_COMMA_in_args1406];
              [stream_COMMA add:char_literal128];
              [self pushFollow:FOLLOW_namedArg_in_args1408];
              namedArg129 = [self namedArg];
              state._fsp--;
              [stream_namedArg add:[namedArg129 tree]];
            }
            break;
          default:
            break loop32;
          }
        }
         while (YES);
        retval.tree = root_0;
        RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
        root_0 = (CommonTree *)[adaptor nil];
        {
          if (!([stream_namedArg hasNext])) {
            @throw [[[RewriteEarlyExitException alloc] init] autorelease];
          }

          while ([stream_namedArg hasNext]) {
            [adaptor addChild:root_0 param1:[stream_namedArg nextTree]];
          }

          [stream_namedArg reset];
        }
        retval.tree = root_0;
      }
      break;
    case 3:
      {
        root_0 = (CommonTree *)[adaptor nil];
      }
      break;
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

- (argExprList_return *) argExprList {
  argExprList_return * retval = [[[argExprList_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  CommonToken * char_literal131 = nil;
  arg_return * arg130 = nil;
  arg_return * arg132 = nil;
  CommonTree * char_literal131_tree = nil;
  RewriteRuleTokenStream * stream_COMMA = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token COMMA"] autorelease];
  RewriteRuleSubtreeStream * stream_arg = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule arg"] autorelease];

  @try {
    {
      [self pushFollow:FOLLOW_arg_in_argExprList1429];
      arg130 = [self arg];
      state._fsp--;
      [stream_arg add:[arg130 tree]];

      loop34: 
      do {
        int alt34 = 2;
        int LA34_0 = [input LA:1];
        if ((LA34_0 == COMMA)) {
          alt34 = 1;
        }

        switch (alt34) {
        case 1:
          {
            char_literal131 = (CommonToken *)[self match:input param1:COMMA param2:FOLLOW_COMMA_in_argExprList1433];
            [stream_COMMA add:char_literal131];
            [self pushFollow:FOLLOW_arg_in_argExprList1435];
            arg132 = [self arg];
            state._fsp--;
            [stream_arg add:[arg132 tree]];
          }
          break;
        default:
          break loop34;
        }
      }
       while (YES);
      retval.tree = root_0;
      RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
      root_0 = (CommonTree *)[adaptor nil];
      {
        if (!([stream_arg hasNext])) {
          @throw [[[RewriteEarlyExitException alloc] init] autorelease];
        }

        while ([stream_arg hasNext]) {
          [adaptor addChild:root_0 param1:[stream_arg nextTree]];
        }

        [stream_arg reset];
      }
      retval.tree = root_0;
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

- (arg_return *) arg {
  arg_return * retval = [[[arg_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  exprNoComma_return * exprNoComma133 = nil;

  @try {
    {
      root_0 = (CommonTree *)[adaptor nil];
      [self pushFollow:FOLLOW_exprNoComma_in_arg1452];
      exprNoComma133 = [self exprNoComma];
      state._fsp--;
      [adaptor addChild:root_0 param1:[exprNoComma133 tree]];
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

- (namedArg_return *) namedArg {
  namedArg_return * retval = [[[namedArg_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  CommonToken * ID134 = nil;
  CommonToken * char_literal135 = nil;
  arg_return * arg136 = nil;
  CommonTree * ID134_tree = nil;
  CommonTree * char_literal135_tree = nil;
  RewriteRuleTokenStream * stream_EQUALS = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token EQUALS"] autorelease];
  RewriteRuleTokenStream * stream_ID = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token ID"] autorelease];
  RewriteRuleSubtreeStream * stream_arg = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule arg"] autorelease];

  @try {
    {
      ID134 = (CommonToken *)[self match:input param1:ID param2:FOLLOW_ID_in_namedArg1461];
      [stream_ID add:ID134];
      char_literal135 = (CommonToken *)[self match:input param1:EQUALS param2:FOLLOW_EQUALS_in_namedArg1463];
      [stream_EQUALS add:char_literal135];
      [self pushFollow:FOLLOW_arg_in_namedArg1465];
      arg136 = [self arg];
      state._fsp--;
      [stream_arg add:[arg136 tree]];
      retval.tree = root_0;
      RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
      root_0 = (CommonTree *)[adaptor nil];
      {
        {
          CommonTree * root_1 = (CommonTree *)[adaptor nil];
          root_1 = (CommonTree *)[adaptor becomeRoot:[stream_EQUALS nextNode] param1:root_1];
          [adaptor addChild:root_1 param1:[stream_ID nextNode]];
          [adaptor addChild:root_1 param1:[stream_arg nextTree]];
          [adaptor addChild:root_0 param1:root_1];
        }
      }
      retval.tree = root_0;
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

- (list_return *) list {
  list_return * retval = [[[list_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  CommonToken * lb = nil;
  CommonToken * char_literal137 = nil;
  CommonToken * char_literal139 = nil;
  CommonToken * char_literal141 = nil;
  listElement_return * listElement138 = nil;
  listElement_return * listElement140 = nil;
  CommonTree * lb_tree = nil;
  CommonTree * char_literal137_tree = nil;
  CommonTree * char_literal139_tree = nil;
  CommonTree * char_literal141_tree = nil;
  RewriteRuleTokenStream * stream_RBRACK = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token RBRACK"] autorelease];
  RewriteRuleTokenStream * stream_LBRACK = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token LBRACK"] autorelease];
  RewriteRuleTokenStream * stream_COMMA = [[[RewriteRuleTokenStream alloc] init:adaptor param1:@"token COMMA"] autorelease];
  RewriteRuleSubtreeStream * stream_listElement = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule listElement"] autorelease];

  @try {
    int alt36 = 2;
    int LA36_0 = [input LA:1];
    if ((LA36_0 == LBRACK)) {
      int LA36_1 = [input LA:2];
      if ((LA36_1 == RBRACK)) {
        int LA36_2 = [input LA:3];
        if ((([input LA:2] == RBRACK))) {
          alt36 = 1;
        }
         else if ((YES)) {
          alt36 = 2;
        }
         else {
          NoViableAltException * nvae = [[[NoViableAltException alloc] init:@"" param1:36 param2:2 param3:input] autorelease];
          @throw nvae;
        }
      }
       else if ((LA36_1 == SUPER || LA36_1 == LPAREN || LA36_1 == LBRACK || LA36_1 == COMMA || LA36_1 == LCURLY || (LA36_1 >= ID && LA36_1 <= STRING) || LA36_1 == AT)) {
        alt36 = 2;
      }
       else {
        NoViableAltException * nvae = [[[NoViableAltException alloc] init:@"" param1:36 param2:1 param3:input] autorelease];
        @throw nvae;
      }
    }
     else {
      NoViableAltException * nvae = [[[NoViableAltException alloc] init:@"" param1:36 param2:0 param3:input] autorelease];
      @throw nvae;
    }

    switch (alt36) {
    case 1:
      {
        if (!(([input LA:2] == RBRACK))) {
          @throw [[[FailedPredicateException alloc] init:input param1:@"list" param2:@"input.LA(2)==RBRACK"] autorelease];
        }
        lb = (CommonToken *)[self match:input param1:LBRACK param2:FOLLOW_LBRACK_in_list1490];
        [stream_LBRACK add:lb];
        char_literal137 = (CommonToken *)[self match:input param1:RBRACK param2:FOLLOW_RBRACK_in_list1492];
        [stream_RBRACK add:char_literal137];
        retval.tree = root_0;
        RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
        root_0 = (CommonTree *)[adaptor nil];
        {
          [adaptor addChild:root_0 param1:(CommonTree *)[adaptor create:LIST param1:lb]];
        }
        retval.tree = root_0;
      }
      break;
    case 2:
      {
        lb = (CommonToken *)[self match:input param1:LBRACK param2:FOLLOW_LBRACK_in_list1504];
        [stream_LBRACK add:lb];
        [self pushFollow:FOLLOW_listElement_in_list1506];
        listElement138 = [self listElement];
        state._fsp--;
        [stream_listElement add:[listElement138 tree]];

        loop35: 
        do {
          int alt35 = 2;
          int LA35_0 = [input LA:1];
          if ((LA35_0 == COMMA)) {
            alt35 = 1;
          }

          switch (alt35) {
          case 1:
            {
              char_literal139 = (CommonToken *)[self match:input param1:COMMA param2:FOLLOW_COMMA_in_list1510];
              [stream_COMMA add:char_literal139];
              [self pushFollow:FOLLOW_listElement_in_list1512];
              listElement140 = [self listElement];
              state._fsp--;
              [stream_listElement add:[listElement140 tree]];
            }
            break;
          default:
            break loop35;
          }
        }
         while (YES);
        char_literal141 = (CommonToken *)[self match:input param1:RBRACK param2:FOLLOW_RBRACK_in_list1517];
        [stream_RBRACK add:char_literal141];
        retval.tree = root_0;
        RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
        root_0 = (CommonTree *)[adaptor nil];
        {
          {
            CommonTree * root_1 = (CommonTree *)[adaptor nil];
            root_1 = (CommonTree *)[adaptor becomeRoot:(CommonTree *)[adaptor create:LIST param1:lb] param1:root_1];

            while ([stream_listElement hasNext]) {
              [adaptor addChild:root_1 param1:[stream_listElement nextTree]];
            }

            [stream_listElement reset];
            [adaptor addChild:root_0 param1:root_1];
          }
        }
        retval.tree = root_0;
      }
      break;
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

- (listElement_return *) listElement {
  listElement_return * retval = [[[listElement_return alloc] init] autorelease];
  retval.start = [input LT:1];
  CommonTree * root_0 = nil;
  exprNoComma_return * exprNoComma142 = nil;

  @try {
    int alt37 = 2;
    int LA37_0 = [input LA:1];
    if ((LA37_0 == SUPER || LA37_0 == LPAREN || LA37_0 == LBRACK || LA37_0 == LCURLY || (LA37_0 >= ID && LA37_0 <= STRING) || LA37_0 == AT)) {
      alt37 = 1;
    }
     else if (((LA37_0 >= RBRACK && LA37_0 <= COMMA))) {
      alt37 = 2;
    }
     else {
      NoViableAltException * nvae = [[[NoViableAltException alloc] init:@"" param1:37 param2:0 param3:input] autorelease];
      @throw nvae;
    }

    switch (alt37) {
    case 1:
      {
        root_0 = (CommonTree *)[adaptor nil];
        [self pushFollow:FOLLOW_exprNoComma_in_listElement1537];
        exprNoComma142 = [self exprNoComma];
        state._fsp--;
        [adaptor addChild:root_0 param1:[exprNoComma142 tree]];
      }
      break;
    case 2:
      {
        retval.tree = root_0;
        RewriteRuleSubtreeStream * stream_retval = [[[RewriteRuleSubtreeStream alloc] init:adaptor param1:@"rule retval" param2:retval != nil ? retval.tree : nil] autorelease];
        root_0 = (CommonTree *)[adaptor nil];
        {
          [adaptor addChild:root_0 param1:(CommonTree *)[adaptor create:NULL param1:@"NULL"]];
        }
        retval.tree = root_0;
      }
      break;
    }
    retval.stop = [input LT:-1];
    retval.tree = (CommonTree *)[adaptor rulePostProcessing:root_0];
    [adaptor setTokenBoundaries:retval.tree param1:retval.start param2:retval.stop];
  }
  @catch (RecognitionException * re) {
    @throw re;
  }
  @finally {
  }
  return retval;
}

+ (void) initialize {
  int numStates = DFA2_transitionS.length;
  DFA2_transition = [NSArray array];

  for (int i = 0; i < numStates; i++) {
    DFA2_transition[i] = [DFA unpackEncodedString:DFA2_transitionS[i]];
  }

}

+ (void) initialize {
  int numStates = DFA28_transitionS.length;
  DFA28_transition = [NSArray array];

  for (int i = 0; i < numStates; i++) {
    DFA28_transition[i] = [DFA unpackEncodedString:DFA28_transitionS[i]];
  }

}

- (void) dealloc
{
  if ( adaptor ) [adaptor release];
  if ( errMgr ) [errMgr release];
  if ( templateToken ) [templateToken release];
  if ( dfa2 ) [dfa2 release];
  if ( dfa28 ) [dfa28 release];
  [super dealloc];
}

@end
