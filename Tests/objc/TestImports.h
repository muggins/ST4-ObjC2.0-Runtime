#import <Foundation/Foundation.h>
#import <ANTLR/ANTLR.h>
#import "BaseTest.h"
#import "ST.h"
#import "STGroup.h"
#import "STGroupDir.h"
#import "STGroupFile.h"

@interface TestImports : BaseTest {
}

- (void) test01ImportDir;
#ifdef DONTUSEYET
- (void) test02ImportDirInJarViaCLASSPATH;
- (void) test03ImportGroupAtSameLevelInJar;
- (void) test04ImportGroupInJarViaCLASSPATH;
#endif
- (void) test05ImportRelativeDir;
- (void) test06ImportGroupFileSameDir;
- (void) test07ImportRelativeGroupFile;
- (void) test08ImportTemplateFileSameDir;
- (void) test09ImportRelativeTemplateFile;
- (void) test10ImportTemplateFromAnotherGroupObject;
- (void) test11ImportTemplateInGroupFileFromDir;
- (void) test12ImportTemplateInGroupFileFromGroupFile;
- (void) test13ImportTemplateFromSubdir;
- (void) test14ImportTemplateFromGroupFile;
- (void) test15PolymorphicTemplateReference;
- (void) test16Super;
- (void) test17UnloadImportedTemplate;
- (void) test18ImportStatementWithDir;
- (void) test19ImportStatementWithFile;
@end
