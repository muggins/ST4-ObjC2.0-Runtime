#import "TestImports.h"

@implementation TestImports

- (void) test01ImportDir
{
    /*
     dir1
     g.stg has a() that imports dir2 with absolute path
     dir2
     a.st
     b.st
     */
    NSString *dir1 = [NSString stringWithFormat:@"%@/dir1", [self getRandomDir]];
    NSString *dir2 = [NSString stringWithFormat:@"%@/dir2", [self getRandomDir]];
    NSString *gstr = [NSString stringWithFormat:@"import \"%@\"\na() ::= <<dir1 a>>\n", dir2];
    [self writeFile:dir1 fileName:@"g.stg" content:gstr];
    
    NSString *a = @"a() ::= <<dir2 a>>\n";
    NSString *b = @"b() ::= <<dir2 b>>\n";
    [self writeFile:dir2 fileName:@"a.st" content:a];
    [self writeFile:dir2 fileName:@"b.st" content:b];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/g.stg", dir1]];
    ST *st = [group getInstanceOf:@"b"]; // visible only if import worked
    NSString *expected = @"dir2 b";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

#ifdef DONTUSEYET
- (void) test02ImportDirInJarViaCLASSPATH
{
    NSString *root = [self getRandomDir];
    NSString *sub  = [NSString stringWithFormat:@"%@/sub", root];
    NSString *base = [NSString stringWithFormat:@"%@/base", root];
    NSString *gstr = [@"import \"base\"\n" stringByAppendingString:@"a() ::= <<sub a>>\n"];
    [self writeFile:sub fileName:@"g.stg" content:gstr];
    NSString *a = @"a() ::= <<base a>>\n";
    NSString *b = @"b() ::= <<base b>>\n";
    [self writeFile:base fileName:@"a.st" content:a];
    [self writeFile:base fileName:@"b.st" content:b];
    [self writeTestFile:[[@"STGroup group = new STGroupFile(\"sub/g.stg\");\n" stringByAppendingString:@"ST st = group.getInstanceOf(\"b\");\n"] stringByAppendingString:@"String result = st.render();\n"] param1:root];
    [self compile:@"Test.java" param1:root];
    [self jar:@"test.jar" param1:[NSArray arrayWithObjects:@"sub", @"base", nil] param2:root];
    [[Runtime runtime] exec:[[[[@"rm -rf " stringByAppendingString:root] stringByAppendingString:@"/sub "] stringByAppendingString:root] stringByAppendingString:@"/base"]];
    NSString *result = [self java:@"Test" param1:@"test.jar" param2:root];
    NSString *expected = [@"base b" stringByAppendingString:newline];
    [self assertEquals:expected result:result];
}

- (void) test03ImportGroupAtSameLevelInJar
{
    NSString *root = [self getRandomDir];
    [System.out println:root];
    NSString *dir = [root stringByAppendingString:@"/org/foo/templates"];
    NSString *main = [[@"import \"lib.stg\"\n" stringByAppendingString:@"a() ::= <<main a calls <bold()>!>>\n"] stringByAppendingString:@"b() ::= <<main b>>\n"];
    [self writeFile:dir fileName:@"main.stg" content:main];
    NSString *lib = @"bold() ::= <<lib bold>>\n";
    [self writeFile:dir fileName:@"lib.stg" content:lib];
    [self writeTestFile:[[@"STGroup group = new STGroupFile(\"org/foo/templates/main.stg\");\n" stringByAppendingString:@"ST st = group.getInstanceOf(\"a\");\n"] stringByAppendingString:@"String result = st.render();\n"] param1:root];
    [self compile:@"Test.java" param1:root];
    [self jar:@"test.jar" param1:[NSArray arrayWithObjects:@"org", nil] param2:root];
    [[Runtime runtime] exec:[[@"rm -rf " stringByAppendingString:root] stringByAppendingString:@"/org"]];
    NSString *result = [self java:@"Test" param1:@"test.jar" param2:root];
    NSString *expected = [@"main a calls lib bold!" stringByAppendingString:newline];
    [self assertEquals:expected result:result];
}

- (void) test04ImportGroupInJarViaCLASSPATH
{
    NSString *root = [self getRandomDir];
    NSLog( @"%@", root);
    NSString *dir = [NSString stringWithFormat:@"%@/org/foo/templates", root];
    NSString *main = @"import \"org/foo/lib/lib.stg\"\na() ::= <<main a calls <bold()>!>>\nb() ::= <<main b>>\n";
    [self writeFile:dir fileName:@"main.stg" content:main];
    NSString *lib = @"bold() ::= <<lib bold>>\n";
    dir = [NSString stringWithFormat:@"%@/org/foo/lib", root];
    [self writeFile:dir fileName:@"lib.stg" content:lib];
    [self writeTestFile:[[@"STGroup group = new STGroupFile(\"org/foo/templates/main.stg\");\n" stringByAppendingString:@"ST st = group.getInstanceOf(\"a\");\n"] stringByAppendingString:@"String result = st.render();\n"] param1:root];
    [self compile:@"Test.java" param1:root];
    [self jar:@"test.jar" param1:[NSArray arrayWithObjects:@"org", nil] param2:root];
    [[Runtime runtime] exec:[[@"rm -rf " stringByAppendingString:root] stringByAppendingString:@"/org"]];
    NSString *result = [self java:@"Test" param1:@"test.jar" param2:root];
    NSString *expected = [@"main a calls lib bold!" stringByAppendingString:newline];
    [self assertEquals:expected result:result];
}
#endif

- (void) test05ImportRelativeDir
{
    NSString *dir = [self getRandomDir];
    NSString *gstr = @"import \"subdir\"\na() ::= <<dir1 a>>\n";
    [self writeFile:dir fileName:@"g.stg" content:gstr];
    NSString *a = @"a() ::= <<subdir a>>\n";
    NSString *b = @"b() ::= <<subdir b>>\n";
    NSString *c = @"c() ::= <<subdir c>>\n";
    [self writeFile:dir fileName:@"subdir/a.st" content:a];
    [self writeFile:dir fileName:@"subdir/b.st" content:b];
    [self writeFile:dir fileName:@"subdir/c.st" content:c];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/g.stg", dir]];
    ST *st = [group getInstanceOf:@"b"];
    NSString *expected = @"subdir b";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    st = [group getInstanceOf:@"c"];
    expected = @"subdir c";
    result = [st render];
    [self assertEquals:expected result:result];
}

#ifdef DONTUSEYET
@Test public void testImportRelativeDirInJarViaCLASSPATH() throws Exception {
    /*
     org/foo/templates
     g.stg has a() that imports subdir with relative path
     subdir
     a.st
     b.st
     c.st
     */
    String root = getRandomDir();
    System.out.println(root);
    String dir = root+"/org/foo/templates";
    String gstr =
    "import \"subdir\"\n" + // finds subdir in dir
    "a() ::= <<dir1 a>>\n";
    writeFile(dir, "g.stg", gstr);
    
    String a = "a() ::= <<subdir a>>\n";
    String b = "b() ::= <<subdir b>>\n";
    String c = "c() ::= <<subdir b>>\n";
    writeFile(dir, "subdir/a.st", a);
    writeFile(dir, "subdir/b.st", b);
    writeFile(dir, "subdir/c.st", c);
    
    jar("test.jar", new String[] {"org"}, root);
    deleteFile(root + "/org");
    
    File path = new File(root + File.separatorChar + "test.jar");
    assertTrue(path.isFile());
    URLClassLoader loader = new URLClassLoader(new URL[] { path.toURI().toURL() });
    STGroup group = new STGroupFile(loader.getResource("org/foo/templates/g.stg"), "UTF-8", '<', '>');
    ST st = group.getInstanceOf("b");
    String result = st.render();
    
    String expected = "subdir b";
    assertEquals(expected, result);
}

@Test public void testEmptyGroupImportGroupFileSameDir() throws Exception {
    /*
     dir
     group1.stg		that imports group2.stg in same dir with just filename
     group2.stg		has c()
     */
    String dir = getRandomDir();
    String groupFile =
    "import \"group2.stg\"\n";
    writeFile(dir, "group1.stg", groupFile);
    
    groupFile =
    "c() ::= \"g2 c\"\n";
    writeFile(dir, "group2.stg", groupFile);
    
    STGroup group1 = new STGroupFile(dir+"/group1.stg");
    ST st = group1.getInstanceOf("c"); // should see c()
    String expected = "g2 c";
    String result = st.render();
    assertEquals(expected, result);
}

#endif

- (void) test06ImportGroupFileSameDir
{
    NSString *dir = [self getRandomDir];
    NSString *groupFile = @"import \"group2.stg\"\na() ::= \"g1 a\"\nb() ::= \"<c()>\"\n";
    [self writeFile:dir fileName:@"group1.stg" content:groupFile];
    groupFile = @"c() ::= \"g2 c\"\n";
    [self writeFile:dir fileName:@"group2.stg" content:groupFile];
    STGroup *group1 = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/group1.stg", dir]];
    ST *st = [group1 getInstanceOf:@"c"];
    NSString *expected = @"g2 c";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test07ImportRelativeGroupFile
{
    NSString *dir = [self getRandomDir];
    NSString *groupFile = @"import \"subdir/group2.stg\"\na() ::= \"g1 a\"\nb() ::= \"<c()>\"\n";
    [self writeFile:dir fileName:@"group1.stg" content:groupFile];
    groupFile = @"c() ::= \"g2 c\"\n";
    [self writeFile:dir fileName:@"subdir/group2.stg" content:groupFile];
    STGroup *group1 = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/group1.stg", dir]];
    ST *st = [group1 getInstanceOf:@"c"];
    NSString *expected = @"g2 c";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test08ImportTemplateFileSameDir
{
    NSString *dir = [self getRandomDir];
    NSString *groupFile = @"import \"c.st\"\na() ::= \"g1 a\"\nb() ::= \"<c()>\"\n";
    [self writeFile:dir fileName:@"group1.stg" content:groupFile];
    groupFile = @"c() ::= \"c\"\n";
    [self writeFile:dir fileName:@"c.st" content:groupFile];
    STGroup *group1 = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/group1.stg", dir]];
    ST *st = [group1 getInstanceOf:@"c"];
    NSString *expected = @"c";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test09ImportRelativeTemplateFile
{
    NSString *dir = [self getRandomDir];
    NSString *groupFile = @"import \"subdir/c.st\"\na() ::= \"g1 a\"\nb() ::= \"<c()>\"\n";
    [self writeFile:dir fileName:@"group1.stg" content:groupFile];
    NSString *stFile = @"c() ::= \"c\"\n";
    [self writeFile:dir fileName:@"subdir/c.st" content:stFile];
    STGroup *group1 = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/group1.stg", dir]];
    ST *st = [group1 getInstanceOf:@"c"];
    NSString *expected = @"c";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test10ImportTemplateFromAnotherGroupObject
{
    NSString *dir1 = [self getRandomDir];
    NSString *a = @"a() ::= <<dir1 a>>\n";
    NSString *b = @"b() ::= <<dir1 b>>\n";
    [self writeFile:dir1 fileName:@"a.st" content:a];
    [self writeFile:dir1 fileName:@"b.st" content:b];
    NSString *dir2 = [self getRandomDir];
    a = @"a() ::= << <b()> >>\n";
    [self writeFile:dir2 fileName:@"a.st" content:a];
    STGroup *group1 = [STGroupDir newSTGroupDir:dir1];
    STGroup *group2 = [STGroupDir newSTGroupDir:dir2];
    [group2 importTemplates:group1];
    ST *st = [group2 getInstanceOf:@"b"];
    NSString *expected = @"dir1 b";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    st = [group2 getInstanceOf:@"a"];
    expected = @" dir1 b ";
    result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test11ImportTemplateInGroupFileFromDir
{
    NSString *dir = [self getRandomDir];
    NSString *a = @"a() ::= << <b()> >>\n";
    [self writeFile:dir fileName:@"x/a.st" content:a];
    NSString *groupFile = @"b() ::= \"group file b\"\nc() ::= \"group file c\"\n";
    [self writeFile:dir fileName:@"y/group.stg" content:groupFile];
    STGroup *group1 = [STGroupDir newSTGroupDir:[NSString stringWithFormat:@"%@/x", dir]];
    STGroup *group2 = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/y/group.stg", dir]];
    [group1 importTemplates:group2];
    ST *st = [group1 getInstanceOf:@"a"];
    [st.impl dump];
    NSString *expected = @" group file b ";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test12ImportTemplateInGroupFileFromGroupFile
{
    NSString *dir = [self getRandomDir];
    NSString *groupFile = @"a() ::= \"g1 a\"\nb() ::= \"<c()>\"\n";
    [self writeFile:dir fileName:@"x/group.stg" content:groupFile];
    groupFile = @"b() ::= \"g2 b\"\nc() ::= \"g2 c\"\n";
    [self writeFile:dir fileName:@"y/group.stg" content:groupFile];
    STGroup *group1 = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/x/group.stg", dir]];
    STGroup *group2 = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/y/group.stg", dir]];
    [group1 importTemplates:group2];
    ST *st = [group1 getInstanceOf:@"b"];
    NSString *expected = @"g2 c";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test13ImportTemplateFromSubdir
{
    NSString *dir = [self getRandomDir];
    NSString *a = @"a() ::= << </subdir/b()> >>";
    NSString *b = @"b() ::= <<x's subdir/b>>";
    [self writeFile:dir fileName:@"x/subdir/a.st" content:a];
    [self writeFile:dir fileName:@"y/subdir/b.st" content:b];
    STGroup *group1 = [STGroupDir newSTGroupDir:[NSString stringWithFormat:@"%@/x", dir]];
    STGroup *group2 = [STGroupDir newSTGroupDir:[NSString stringWithFormat:@"%@/y", dir]];
    [group1 importTemplates:group2];
    ST *st = [group1 getInstanceOf:@"/subdir/a"];
    NSString *expected = @" x's subdir/b ";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test14ImportTemplateFromGroupFile
{
    NSString *dir = [self getRandomDir];
    NSString *a = @"a() ::= << </subdir/b()> >>";
    [self writeFile:dir fileName:@"x/subdir/a.st" content:a];
    NSString *groupFile = @"a() ::= \"group file: a\"\nb() ::= \"group file: b\"\n";
    [self writeFile:dir fileName:@"y/subdir.stg" content:groupFile];
    STGroup *group1 = [STGroupDir newSTGroupDir:[NSString stringWithFormat:@"%@/x", dir]];
    STGroup *group2 = [STGroupDir newSTGroupDir:[NSString stringWithFormat:@"%@/y", dir]];
    [group1 importTemplates:group2];
    ST *st = [group1 getInstanceOf:@"subdir/a"];
    NSString *expected = @" group file: b ";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test15PolymorphicTemplateReference
{
    NSString *dir1 = [self getRandomDir];
    NSString *b = @"b() ::= <<dir1 b>>\n";
    [self writeFile:dir1 fileName:@"b.st" content:b];
    NSString *dir2 = [self getRandomDir];
    NSString *a = @"a() ::= << <b()> >>\n";
    b = @"b() ::= <<dir2 b>>\n";
    [self writeFile:dir2 fileName:@"a.st" content:a];
    [self writeFile:dir2 fileName:@"b.st" content:b];
    STGroup *group1 = [STGroupDir newSTGroupDir:dir1];
    STGroup *group2 = [STGroupDir newSTGroupDir:dir2];
    [group1 importTemplates:group2];
    ST *st = [group2 getInstanceOf:@"a"];
    NSString *expected = @" dir2 b ";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
    st = [group1 getInstanceOf:@"a"];
    expected = @" dir1 b ";
    result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test16Super
{
    NSString *dir1 = [self getRandomDir];
    NSString *a = @"a() ::= <<dir1 a>>\n";
    NSString *b = @"b() ::= <<dir1 b>>\n";
    [self writeFile:dir1 fileName:@"a.st" content:a];
    [self writeFile:dir1 fileName:@"b.st" content:b];
    NSString *dir2 = [self getRandomDir];
    a = @"a() ::= << [<super.a()>] >>\n";
    [self writeFile:dir2 fileName:@"a.st" content:a];
    STGroup *group1 = [STGroupDir newSTGroupDir:dir1];
    STGroup *group2 = [STGroupDir newSTGroupDir:dir2];
    [group2 importTemplates:group1];
    ST *st = [group2 getInstanceOf:@"a"];
    NSString *expected = @" [dir1 a] ";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test17UnloadImportedTemplate
{
    NSString *dir1 = [self getRandomDir];
    NSString *a = @"a() ::= <<dir1 a>>\n";
    NSString *b = @"b() ::= <<dir1 b>>\n";
    [self writeFile:dir1 fileName:@"a.st" content:a];
    [self writeFile:dir1 fileName:@"b.st" content:b];
    NSString *dir2 = [self getRandomDir];
    a = @"a() ::= << <b()> >>\n";
    [self writeFile:dir2 fileName:@"a.st" content:a];
    STGroup *group1 = [STGroupDir newSTGroupDir:dir1];
    STGroup *group2 = [STGroupDir newSTGroupDir:dir2];
    [group2 importTemplates:group1];
    ST *st = [group2 getInstanceOf:@"a"];
    ST *st2 = [group2 getInstanceOf:@"b"];
    NSInteger originalHashCode = [st hash];
    NSInteger originalHashCode2 = [st2 hash];
    [group1 unload];
    st = [group2 getInstanceOf:@"a"];
    NSInteger newHashCode = [st hash];
    NSString *expected = @"(originalHashCode2 == newHashCode) == NO";
    NSString *result = [NSString stringWithFormat:@"(originalHashCode2 == newHashCode) == %@", ((originalHashCode2 == newHashCode) ? @"YES" : @"NO")];
    [self assertEquals:expected result:result];
    expected = @" dir1 b ";
    result = [st render];
    [self assertEquals:expected result:result];
    st = [group2 getInstanceOf:@"b"];
    NSInteger newHashCode2 = [st hash];
    expected = [NSString stringWithFormat:@"(originalHashCode2(%08x) == newHashCode2(%08x)) == NO", originalHashCode2, newHashCode2];
    result = [NSString stringWithFormat:@"(originalHashCode2(%08x) == newHashCode2(%08x)) == %@", originalHashCode2, newHashCode2, ((originalHashCode2 == newHashCode2) ? @"YES" : @"NO")];
    [self assertEquals:expected result:result];
    expected = @"dir1 b";
    result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test18ImportStatementWithDir
{
    /*
     sub
     g.stg has a() and imports base via classpath
     base
     a.st
     b.st
     */
    //    NSString *root = [self getRandomDir];
    //    NSString *aSub  = [NSString stringWithFormat:@"%@/sub", root];
    //    NSString *aBase = [NSString stringWithFormat:@"%@/base", root];;
    //    NSString *gStr = @"import \"base\"\na() ::= <<sub a>>\n";

    NSString *dir1 = [NSString stringWithFormat:@"%@/dir1", [self getRandomDir]];
    NSString *dir2 = [NSString stringWithFormat:@"%@/dir2", [self getRandomDir]];
    NSString *gstr = [NSString stringWithFormat:@"import \"%@\"\na() ::= <<dir1 a>>\n", dir2];
    [self writeFile:dir1 fileName:@"a.stg" content:gstr];
    NSString *a = @"a() ::= <<dir2 a>>\n";
    NSString *b = @"b() ::= <<dir2 b>>\n";
    [self writeFile:dir2 fileName:@"a.st" content:a];
    [self writeFile:dir2 fileName:@"b.st" content:b];
    STGroup *group = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/a.stg", dir1]];
    ST *st = [group getInstanceOf:@"b"];
    NSString *expected = @"dir2 b";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

- (void) test19ImportStatementWithFile
{
    NSString *dir = [self getRandomDir];
    NSString *groupFile = [NSString stringWithFormat:@"import \"%@/group2.stg\"\na() ::= \"g1 a\"\nb() ::= \"<c()>\"\n", dir];
    [self writeFile:dir fileName:@"group1.stg" content:groupFile];
    groupFile = @"c() ::= \"g2 c\"\n";
    [self writeFile:dir fileName:@"group2.stg" content:groupFile];
    STGroup *group1 = [STGroupFile newSTGroupFile:[NSString stringWithFormat:@"%@/group1.stg", dir]];
    ST *st = [group1 getInstanceOf:@"c"];
    NSString *expected = @"g2 c";
    NSString *result = [st render];
    [self assertEquals:expected result:result];
}

@end
