#import <Foundation/Foundation.h>
#import <ANTLR/ANTLR.h>
#import "BaseTest.h"
#import "ErrorBuffer.h"

@interface Field_anon1 : NSObject {
  __strong NSString *name;
  NSInteger n;
}

- (id) init;
- (NSString *) description;

@property (retain) NSString *name;
@property (assign) NSInteger n;
@end

@interface Field_anon2 : NSObject {
  __strong NSString *name;
  NSInteger n;
}

- (id) init;
- (NSString *) description;

@property (retain) NSString *name;
@property (assign) NSInteger n;
@end

@interface Field_anon3 : NSObject {
  __strong NSString *name;
  NSInteger n;
}

- (id) init;
- (NSString *) description;

@property (retain) NSString *name;
@property (assign) NSInteger n;
@end

@interface Counter : NSObject {
  NSInteger n;
}

- (id) init;
- (NSString *) description;

@property (assign) NSInteger n;
@end

@interface TestGroups : BaseTest {
}

- (void) test01SimpleGroup;
- (void) test02EscapeOneRightAngle;
- (void) test03EscapeRightShift;
- (void) test04EscapeRightShift2;
- (void) test05EscapeRightShiftAtRightEdge;
- (void) test06EscapeRightShiftAtRightEdge2;
- (void) test07SimpleGroupFromString;
- (void) test08GroupWithTwoTemplates;
- (void) test09Subdir;
- (void) test10SubdirWithSubtemplate;
- (void) test11GroupFileInDir;
- (void) test12SubSubdir;
- (void) test13GroupFileInSubDir;
- (void) test14DupDef;
- (void) test15Alias;
- (void) test16AliasWithArgs;
- (void) test17SimpleDefaultArg;
- (void) test18DefaultArgument;
- (void) test19BooleanDefaultArguments;
- (void) test20DefaultArgument2;
- (void) test21SubtemplateAsDefaultArgSeesOtherArgs;
- (void) test22EarlyEvalOfDefaultArgs;
- (void) test23DefaultArgumentAsSimpleTemplate;
- (void) test24DefaultArgumentManuallySet;
- (void) test25DefaultArgumentSeesVarFromDynamicScoping;
- (void) test26DefaultArgumentImplicitlySet2;
- (void) test27DefaultArgumentAsTemplate;
- (void) test28DefaultArgumentAsTemplate2;
- (void) test29DoNotUseDefaultArgument;
- (void) test30DefaultArgumentInParensToEvalEarly;
- (void) test31TrueFalseArgs;
- (void) test32NamedArgsInOrder;
- (void) test33NamedArgsOutOfOrder;
- (void) test34UnknownNamedArg;
- (void) test35MissingNamedArg;
- (void) test36NamedArgsNotAllowInIndirectInclude;
- (void) test37CantSeeGroupDirIfGroupFileOfSameName;
- (void) test38UnloadingSimpleGroup;
- (void) test39UnloadingGroupFile;
- (void) test40GroupFileImport;
- (void) test41GetTemplateNames;
- (void) test42UnloadWithImports;
- (void) test43LineBreakInGroup;
- (void) test44LineBreakInGroup2;
- (void) test45LineBreakMissingTrailingNewline;
- (void) test46LineBreakWithScarfedTrailingNewline;


@end
