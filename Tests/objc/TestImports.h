#import "Test.h"
#import "ST.h"
#import "STGroup.h"
#import "STGroupDir.h"
#import "STGroupFile.h"
#import "Assert.h"

@interface TestImports : BaseTest {
}

- (void) testImportTemplate;
- (void) testImportStatementWithDir;
- (void) testImportStatementWithFile;
- (void) testImportTemplateInGroupFileFromDir;
- (void) testImportTemplateInGroupFileFromGroupFile;
- (void) testImportTemplateFromSubdir;
- (void) testImportTemplateFromGroupFile;
- (void) testPolymorphicTemplateReference;
- (void) testSuper;
- (void) testUnloadImportedTemplate;
@end
