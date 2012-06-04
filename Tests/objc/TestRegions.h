#import <Foundation/Foundation.h>
#import <ANTLR/ANTLR.h>
#import "BaseTest.h"
#import "ST.h"
#import "STErrorListener.h"
#import "STGroup.h"
#import "STGroupFile.h"
#import "ErrorBuffer.h"

@interface TestRegions : BaseTest {
}

- (void) test01EmbeddedRegion;
- (void) test02Region;
- (void) test03DefineRegionInSubgroup;
- (void) test04DefineRegionInSubgroupThatRefsSuper;
- (void) test05DefineRegionInSubgroup2;
- (void) test06DefineRegionInSameGroup;
- (void) test07AnonymousTemplateInRegion;
- (void) test08CantDefineEmbeddedRegionAgain;
- (void) test09CantDefineEmbeddedRegionAgainInTemplate;
- (void) test10MissingRegionName;
- (void) test11IndentBeforeRegionIsIgnored;
- (void) test12RegionOverrideStripsNewlines;
- (void) test13RegionOverrideRefSuperRegion;
- (void) test14RegionOverrideRefSuperRegion3Levels;
- (void) test15RegionOverrideRefSuperImplicitRegion;
- (void) test16UnknownRegionDefError;
- (void) test17SuperRegionRefMissingOk;
- (void) test18EmbeddedRegionOnOneLine;
- (void) test19EmbeddedRegionTagsOnSeparateLines;
@end
