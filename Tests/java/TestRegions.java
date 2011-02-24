/*
 [The "BSD license"]
 Copyright (c) 2009 Terence Parr
 All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:
 1. Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.
 2. Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.
 3. The name of the author may not be used to endorse or promote products
    derived from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
package org.stringtemplate.v4.test;

import org.junit.Test;
import org.stringtemplate.v4.ST;
import org.stringtemplate.v4.STErrorListener;
import org.stringtemplate.v4.STGroup;
import org.stringtemplate.v4.STGroupFile;
import org.stringtemplate.v4.misc.ErrorBuffer;

import static org.junit.Assert.assertEquals;

public class TestRegions extends BaseTest {
    @Test public void testEmbeddedRegion() throws Exception {
        String dir = getRandomDir();
        String groupFile =
            "a() ::= <<\n" +
            "[<@r>bar<@end>]\n" +
            ">>\n";
        writeFile(dir, "group.stg", groupFile);
        STGroup group = new STGroupFile(dir+"/group.stg");
        ST st = group.getInstanceOf("a");
        String expected = "[bar]";
        String result = st.render();
        assertEquals(expected, result);
    }

    @Test public void testRegion() throws Exception {
        String dir = getRandomDir();
        String groupFile =
            "a() ::= <<\n" +
            "[<@r()>]\n" +
            ">>\n";
        writeFile(dir, "group.stg", groupFile);
        STGroup group = new STGroupFile(dir+"/group.stg");
        ST st = group.getInstanceOf("a");
        String expected = "[]";
        String result = st.render();
        assertEquals(expected, result);
    }

	@Test public void testDefineRegionInSubgroup() throws Exception {
		String dir = getRandomDir();
		String g1 = "a() ::= <<[<@r()>]>>\n";
		writeFile(dir, "g1.stg", g1);
		String g2 = "@a.r() ::= <<foo>>\n";
		writeFile(dir, "g2.stg", g2);

		STGroup group1 = new STGroupFile(dir+"/g1.stg");
		STGroup group2 = new STGroupFile(dir+"/g2.stg");
		group2.importTemplates(group1); // define r in g2
		ST st = group2.getInstanceOf("a");
		String expected = "[foo]";
		String result = st.render();
		assertEquals(expected, result);
	}

    @Test public void testDefineRegionInSubgroupThatRefsSuper() throws Exception {
        String dir = getRandomDir();
        String g1 = "a() ::= <<[<@r>foo<@end>]>>\n";
        writeFile(dir, "g1.stg", g1);
        String g2 = "@a.r() ::= <<(<@super.r()>)>>\n";
        writeFile(dir, "g2.stg", g2);

        STGroup group1 = new STGroupFile(dir+"/g1.stg");
        STGroup group2 = new STGroupFile(dir+"/g2.stg");
        group2.importTemplates(group1); // define r in g2
        ST st = group2.getInstanceOf("a");
        String expected = "[(foo)]";
        String result = st.render();
        assertEquals(expected, result);
    }

    @Test public void testDefineRegionInSubgroup2() throws Exception {
        String dir = getRandomDir();
        String g1 = "a() ::= <<[<@r()>]>>\n";
        writeFile(dir, "g1.stg", g1);
        String g2 = "@a.r() ::= <<foo>>>\n";
        writeFile(dir, "g2.stg", g2);

        STGroup group1 = new STGroupFile(dir+"/g1.stg");
        STGroup group2 = new STGroupFile(dir+"/g2.stg");
        group1.importTemplates(group2); // opposite of previous; g1 imports g2
        ST st = group1.getInstanceOf("a");
        String expected = "[]"; // @a.r implicitly defined in g1; can't see g2's
        String result = st.render();
        assertEquals(expected, result);
    }

    @Test public void testDefineRegionInSameGroup() throws Exception {
        String dir = getRandomDir();
        String g = "a() ::= <<[<@r()>]>>\n"+
                   "@a.r() ::= <<foo>>\n";
        writeFile(dir, "g.stg", g);

        STGroup group = new STGroupFile(dir+"/g.stg");
        ST st = group.getInstanceOf("a");
        String expected = "[foo]";
        String result = st.render();
        assertEquals(expected, result);
    }

	@Test public void testAnonymousTemplateInRegion() throws Exception {
		String dir = getRandomDir();
		String g = "a() ::= <<[<@r()>]>>\n" +
				   "@a.r() ::= <<\n" +
				   "<[\"foo\"]:{x|<x>}>\n" +
				   ">>\n";
		writeFile(dir, "g.stg", g);

		STGroup group = new STGroupFile(dir+"/g.stg");
		ST st = group.getInstanceOf("a");
		String expected = "[foo]";
		String result = st.render();
		assertEquals(expected, result);
	}

    @Test public void testCantDefineEmbeddedRegionAgain() throws Exception {
        String dir = getRandomDir();
        String g = "a() ::= <<[<@r>foo<@end>]>>\n"+
                   "@a.r() ::= <<bar>>\n"; // error; dup
        writeFile(dir, "g.stg", g);

        STGroupFile group = new STGroupFile(dir+"/g.stg");
        ErrorBuffer errors = new ErrorBuffer();
        group.setListener(errors);
        group.load();
        String expected = "g.stg 2:3: region a.r is embedded and thus already implicitly defined"+newline;
        String result = errors.toString();
        assertEquals(expected, result);
    }

	@Test public void testIndentBeforeRegionIsIgnored() throws Exception {
		String dir = getRandomDir();
		String g = "a() ::= <<[\n" +
				   "  <@r>\n" +
				   "  foo\n" +
				   "  <@end>\n" +
				   "]>>\n";
		writeFile(dir, "g.stg", g);

		STGroupFile group = new STGroupFile(dir+"/g.stg");
		ST st = group.getInstanceOf("a");
		String expected = "[\n" +
						  "  foo\n" +
						  "]";
		String result = st.render();
		assertEquals(expected, result);
	}

	@Test public void testRegionOverrideStripsNewlines() throws Exception {
		String dir = getRandomDir();
		String g =
				"a() ::= \"X<@r()>Y\"" +
				"@a.r() ::= <<\n" +
				"foo\n" +
				">>\n";
		writeFile(dir, "g.stg", g);
		STGroupFile group = new STGroupFile(dir+"/g.stg");

		String sub =
				"@a.r() ::= \"A<@super.r()>B\"" +newline;
		writeFile(dir, "sub.stg", sub);
		STGroupFile subGroup = new STGroupFile(dir+"/sub.stg");
		subGroup.importTemplates(group);

		ST st = subGroup.getInstanceOf("a");
		String result = st.render();
		String expecting = "XAfooBY";
		assertEquals(expecting, result);
	}

    //

    @Test public void testRegionOverrideRefSuperRegion() throws Exception {
        String dir = getRandomDir();
        String g =
                "a() ::= \"X<@r()>Y\"" +
                "@a.r() ::= \"foo\"" +newline;
        writeFile(dir, "g.stg", g);
        STGroupFile group = new STGroupFile(dir+"/g.stg");

        String sub =
                "@a.r() ::= \"A<@super.r()>B\"" +newline;
        writeFile(dir, "sub.stg", sub);
        STGroupFile subGroup = new STGroupFile(dir+"/sub.stg");
        subGroup.importTemplates(group);

        ST st = subGroup.getInstanceOf("a");
        String result = st.render();
        String expecting = "XAfooBY";
        assertEquals(expecting, result);
    }

    @Test public void testRegionOverrideRefSuperRegion3Levels() throws Exception {
        String dir = getRandomDir();
        // Bug: This was causing infinite recursion:
        // getInstanceOf(super::a)
        // getInstanceOf(sub::a)
        // getInstanceOf(subsub::a)
        // getInstanceOf(subsub::region__a__r)
        // getInstanceOf(subsub::super.region__a__r)
        // getInstanceOf(subsub::super.region__a__r)
        // getInstanceOf(subsub::super.region__a__r)
        // ...
        // Somehow, the ref to super in subsub is not moving up the chain
        // to the @super.r(); oh, i introduced a bug when i put setGroup
        // into STG.getInstanceOf()!

        String g =
                "a() ::= \"X<@r()>Y\"" +
                "@a.r() ::= \"foo\"" +newline;
        writeFile(dir, "g.stg", g);
        STGroupFile group = new STGroupFile(dir+"/g.stg");

        String sub =
                "@a.r() ::= \"<@super.r()>2\"" +newline;
        writeFile(dir, "sub.stg", sub);
        STGroupFile subGroup = new STGroupFile(dir+"/sub.stg");
        subGroup.importTemplates(group);

        String subsub =
                "@a.r() ::= \"<@super.r()>3\"" +newline;
        writeFile(dir, "subsub.stg", subsub);
        STGroupFile subSubGroup = new STGroupFile(dir+"/subsub.stg");
        subSubGroup.importTemplates(subGroup);

        ST st = subSubGroup.getInstanceOf("a");

        String result = st.render();
        String expecting = "Xfoo23Y";
        assertEquals(expecting, result);
    }

    @Test public void testRegionOverrideRefSuperImplicitRegion() throws Exception {
        String dir = getRandomDir();
        String g =
                "a() ::= \"X<@r>foo<@end>Y\""+newline;
        writeFile(dir, "g.stg", g);
        STGroupFile group = new STGroupFile(dir+"/g.stg");

        String sub =
                "@a.r() ::= \"A<@super.r()>\"" +newline;
        writeFile(dir, "sub.stg", sub);
        STGroupFile subGroup = new STGroupFile(dir+"/sub.stg");
        subGroup.importTemplates(group);

        ST st = subGroup.getInstanceOf("a");
        String result = st.render();
        String expecting = "XAfooY";
        assertEquals(expecting, result);
    }

    @Test public void testUnknownRegionDefError() throws Exception {
        String dir = getRandomDir();
        String g =
                "a() ::= <<\n" +
                "X<@r()>Y" +
                ">>\n"+
                "@a.q() ::= \"foo\"" +newline;
        STErrorListener errors = new ErrorBuffer();
        writeFile(dir, "g.stg", g);
        STGroupFile group = new STGroupFile(dir+"/g.stg");
		group.setListener(errors);
        ST st = group.getInstanceOf("a");
        st.render();
        String result = errors.toString();
        String expecting = "g.stg 3:3: template a doesn't have a region called q"+newline;
        assertEquals(expecting, result);
    }

    @Test public void testSuperRegionRefMissingOk() throws Exception {
        String dir = getRandomDir();
        String g =
            "a() ::= \"X<@r()>Y\"" +
            "@a.r() ::= \"foo\"" +newline;
        writeFile(dir, "g.stg", g);
        STGroupFile group = new STGroupFile(dir+"/g.stg");

        String sub =
            "@a.r() ::= \"A<@super.q()>B\"" +newline; // allow this; trap at runtime
        STErrorListener errors = new ErrorBuffer();
        group.setListener(errors);
        writeFile(dir, "sub.stg", sub);
        STGroupFile subGroup = new STGroupFile(dir+"/sub.stg");
        subGroup.importTemplates(group);

        ST st = subGroup.getInstanceOf("a");
        String result = st.render();
        String expecting = "XABY";
        assertEquals(expecting, result);
    }
}
