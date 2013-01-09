From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH] configure.ac: check for org.junit.rules.ExternalResource
Date: Wed,  9 Jan 2013 22:35:16 +0100
Message-ID: <1357767316-27868-2-git-send-email-danny.al-gaaf@bisect.de>
References: <1357767316-27868-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:51441 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933320Ab3AIVfU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 16:35:20 -0500
In-Reply-To: <1357767316-27868-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Check for org.junit.rules.ExternalResource if build with
--enable-cephfs-java and --with-debug. Checking for junit4
isn't enough since junit4 has this class not before 4.7.

Added some m4 files to get some JAVA related macros. Changed
autogen.sh to work with local m4 files/macros.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 autogen.sh                |   2 +-
 configure.ac              |  29 ++++++-------
 m4/ac_check_class.m4      | 108 ++++++++++++++++++++++++++++++++++++++++++++++
 m4/ac_check_classpath.m4  |  24 +++++++++++
 m4/ac_check_rqrd_class.m4 |  26 +++++++++++
 m4/ac_java_options.m4     |  33 ++++++++++++++
 m4/ac_prog_jar.m4         |  39 +++++++++++++++++
 m4/ac_prog_java.m4        |  83 +++++++++++++++++++++++++++++++++++
 m4/ac_prog_java_works.m4  |  98 +++++++++++++++++++++++++++++++++++++++++
 m4/ac_prog_javac.m4       |  45 +++++++++++++++++++
 m4/ac_prog_javac_works.m4 |  36 ++++++++++++++++
 m4/ac_prog_javah.m4       |  28 ++++++++++++
 m4/ac_try_compile_java.m4 |  40 +++++++++++++++++
 m4/ac_try_run_javac.m4    |  41 ++++++++++++++++++
 14 files changed, 615 insertions(+), 17 deletions(-)
 create mode 100644 m4/ac_check_class.m4
 create mode 100644 m4/ac_check_classpath.m4
 create mode 100644 m4/ac_check_rqrd_class.m4
 create mode 100644 m4/ac_java_options.m4
 create mode 100644 m4/ac_prog_jar.m4
 create mode 100644 m4/ac_prog_java.m4
 create mode 100644 m4/ac_prog_java_works.m4
 create mode 100644 m4/ac_prog_javac.m4
 create mode 100644 m4/ac_prog_javac_works.m4
 create mode 100644 m4/ac_prog_javah.m4
 create mode 100644 m4/ac_try_compile_java.m4
 create mode 100644 m4/ac_try_run_javac.m4

diff --git a/autogen.sh b/autogen.sh
index 08e435b..9d6a77b 100755
--- a/autogen.sh
+++ b/autogen.sh
@@ -12,7 +12,7 @@ check_for_pkg_config() {
 }
 
 rm -f config.cache
-aclocal #-I m4
+aclocal -I m4 --install
 check_for_pkg_config
 libtoolize --force --copy
 autoconf
diff --git a/configure.ac b/configure.ac
index 832054b..32814b8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -271,9 +271,6 @@ AM_CONDITIONAL(ENABLE_CEPHFS_JAVA, test "x$enable_cephfs_java" = "xyes")
 AC_ARG_WITH(jdk-dir,
     AC_HELP_STRING([--with-jdk-dir(=DIR)], [Path to JDK directory]))
 
-AC_DEFUN([JAVA_DNE],
-	AC_MSG_ERROR([Cannot find $1 '$2'. Try setting --with-jdk-dir]))
-
 AS_IF([test "x$enable_cephfs_java" = "xyes"], [
 
 	# setup bin/include dirs from --with-jdk-dir (search for jni.h, javac)
@@ -314,20 +311,20 @@ AS_IF([test "x$enable_cephfs_java" = "xyes"], [
       AC_MSG_NOTICE([Cannot find junit4.jar (apt-get install junit4)])
       [have_junit4=0]])])
 
-	# Check for Java programs: javac, javah, jar
-    PATH_save=$PATH
-	PATH="$PATH:$EXTRA_JDK_BIN_DIR"
-	AC_PATH_PROG(JAVAC, javac)
-    AC_PATH_PROG(JAVAH, javah)
-    AC_PATH_PROG(JAR, jar)
-    PATH=$PATH_save
+      AC_CHECK_CLASSPATH
+      AC_PROG_JAVAC
+      AC_PROG_JAVAH
+      AC_PROG_JAR
 
-    # Ensure we have them...
-    AS_IF([test -z "$JAVAC"], JAVA_DNE(program, javac))
-    AS_IF([test -z "$JAVAH"], JAVA_DNE(program, javah))
-    AS_IF([test -z "$JAR"], JAVA_DNE(program, jar))
+      CLASSPATH=$CLASSPATH:$EXTRA_CLASSPATH_JAR
+      export CLASSPATH
+      AC_MSG_NOTICE([classpath - $CLASSPATH])
+      AS_IF([test "$have_junit4" = "1"], [
+	    AC_CHECK_CLASS([org.junit.rules.ExternalResource], [], [
+	    AC_MSG_NOTICE(Could not find org.junit.rules.ExternalResource)
+	    have_junit4=0])])
 
-    # Check for jni.h
+        # Check for jni.h
 	CPPFLAGS_save=$CPPFLAGS
 
 	AS_IF([test -n "$EXTRA_JDK_INC_DIR"],
@@ -336,7 +333,7 @@ AS_IF([test "x$enable_cephfs_java" = "xyes"], [
 				 [JDK_CPPFLAGS="$JDK_CPPFLAGS -I$EXTRA_JDK_INC_DIR/linux"])
 		   CPPFLAGS="$CPPFLAGS $JDK_CPPFLAGS"])
 
-	AC_CHECK_HEADER([jni.h], [], JAVA_DNE(header, jni.h))
+	AC_CHECK_HEADER([jni.h], [], AC_MSG_ERROR([Cannot find header 'jni.h'. Try setting --with-jdk-dir]))
 
 	CPPFLAGS=$CPPFLAGS_save
 
diff --git a/m4/ac_check_class.m4 b/m4/ac_check_class.m4
new file mode 100644
index 0000000..17932c5
--- /dev/null
+++ b/m4/ac_check_class.m4
@@ -0,0 +1,108 @@
+dnl @synopsis AC_CHECK_CLASS
+dnl
+dnl AC_CHECK_CLASS tests the existence of a given Java class, either in
+dnl a jar or in a '.class' file.
+dnl
+dnl *Warning*: its success or failure can depend on a proper setting of
+dnl the CLASSPATH env. variable.
+dnl
+dnl Note: This is part of the set of autoconf M4 macros for Java
+dnl programs. It is VERY IMPORTANT that you download the whole set,
+dnl some macros depend on other. Unfortunately, the autoconf archive
+dnl does not support the concept of set of macros, so I had to break it
+dnl for submission. The general documentation, as well as the sample
+dnl configure.in, is included in the AC_PROG_JAVA macro.
+dnl
+dnl @category Java
+dnl @author Stephane Bortzmeyer <bortzmeyer@pasteur.fr>
+dnl @version 2000-07-19
+dnl @license GPLWithACException
+
+AC_DEFUN([AC_CHECK_CLASS],[
+AC_REQUIRE([AC_PROG_JAVA])
+ac_var_name=`echo $1 | sed 's/\./_/g'`
+dnl Normaly I'd use a AC_CACHE_CHECK here but since the variable name is
+dnl dynamic I need an extra level of extraction
+AC_MSG_CHECKING([for $1 class])
+AC_CACHE_VAL(ac_cv_class_$ac_var_name, [
+if test x$ac_cv_prog_uudecode_base64 = xyes; then
+dnl /**
+dnl  * Test.java: used to test dynamicaly if a class exists.
+dnl  */
+dnl public class Test
+dnl {
+dnl
+dnl public static void
+dnl main( String[] argv )
+dnl {
+dnl     Class lib;
+dnl     if (argv.length < 1)
+dnl      {
+dnl             System.err.println ("Missing argument");
+dnl             System.exit (77);
+dnl      }
+dnl     try
+dnl      {
+dnl             lib = Class.forName (argv[0]);
+dnl      }
+dnl     catch (ClassNotFoundException e)
+dnl      {
+dnl             System.exit (1);
+dnl      }
+dnl     lib = null;
+dnl     System.exit (0);
+dnl }
+dnl
+dnl }
+cat << \EOF > Test.uue
+begin-base64 644 Test.class
+yv66vgADAC0AKQcAAgEABFRlc3QHAAQBABBqYXZhL2xhbmcvT2JqZWN0AQAE
+bWFpbgEAFihbTGphdmEvbGFuZy9TdHJpbmc7KVYBAARDb2RlAQAPTGluZU51
+bWJlclRhYmxlDAAKAAsBAANlcnIBABVMamF2YS9pby9QcmludFN0cmVhbTsJ
+AA0ACQcADgEAEGphdmEvbGFuZy9TeXN0ZW0IABABABBNaXNzaW5nIGFyZ3Vt
+ZW50DAASABMBAAdwcmludGxuAQAVKExqYXZhL2xhbmcvU3RyaW5nOylWCgAV
+ABEHABYBABNqYXZhL2lvL1ByaW50U3RyZWFtDAAYABkBAARleGl0AQAEKEkp
+VgoADQAXDAAcAB0BAAdmb3JOYW1lAQAlKExqYXZhL2xhbmcvU3RyaW5nOylM
+amF2YS9sYW5nL0NsYXNzOwoAHwAbBwAgAQAPamF2YS9sYW5nL0NsYXNzBwAi
+AQAgamF2YS9sYW5nL0NsYXNzTm90Rm91bmRFeGNlcHRpb24BAAY8aW5pdD4B
+AAMoKVYMACMAJAoAAwAlAQAKU291cmNlRmlsZQEACVRlc3QuamF2YQAhAAEA
+AwAAAAAAAgAJAAUABgABAAcAAABtAAMAAwAAACkqvgSiABCyAAwSD7YAFBBN
+uAAaKgMyuAAeTKcACE0EuAAaAUwDuAAasQABABMAGgAdACEAAQAIAAAAKgAK
+AAAACgAAAAsABgANAA4ADgATABAAEwASAB4AFgAiABgAJAAZACgAGgABACMA
+JAABAAcAAAAhAAEAAQAAAAUqtwAmsQAAAAEACAAAAAoAAgAAAAQABAAEAAEA
+JwAAAAIAKA==
+====
+EOF
+                if uudecode$EXEEXT Test.uue; then
+                        :
+                else
+                        echo "configure: __oline__: uudecode had trouble decoding base 64 file 'Test.uue'" >&AC_FD_CC
+                        echo "configure: failed file was:" >&AC_FD_CC
+                        cat Test.uue >&AC_FD_CC
+                        ac_cv_prog_uudecode_base64=no
+                fi
+        rm -f Test.uue
+        if AC_TRY_COMMAND($JAVA $JAVAFLAGS Test $1) >/dev/null 2>&1; then
+                eval "ac_cv_class_$ac_var_name=yes"
+        else
+                eval "ac_cv_class_$ac_var_name=no"
+        fi
+        rm -f Test.class
+else
+        AC_TRY_COMPILE_JAVA([$1], , [eval "ac_cv_class_$ac_var_name=yes"],
+                [eval "ac_cv_class_$ac_var_name=no"])
+fi
+eval "ac_var_val=$`eval echo ac_cv_class_$ac_var_name`"
+eval "HAVE_$ac_var_name=$`echo ac_cv_class_$ac_var_val`"
+HAVE_LAST_CLASS=$ac_var_val
+if test x$ac_var_val = xyes; then
+        ifelse([$2], , :, [$2])
+else
+        ifelse([$3], , :, [$3])
+fi
+])
+dnl for some reason the above statment didn't fall though here?
+dnl do scripts have variable scoping?
+eval "ac_var_val=$`eval echo ac_cv_class_$ac_var_name`"
+AC_MSG_RESULT($ac_var_val)
+])
diff --git a/m4/ac_check_classpath.m4 b/m4/ac_check_classpath.m4
new file mode 100644
index 0000000..1782b5d
--- /dev/null
+++ b/m4/ac_check_classpath.m4
@@ -0,0 +1,24 @@
+dnl @synopsis AC_CHECK_CLASSPATH
+dnl
+dnl AC_CHECK_CLASSPATH just displays the CLASSPATH, for the edification
+dnl of the user.
+dnl
+dnl Note: This is part of the set of autoconf M4 macros for Java
+dnl programs. It is VERY IMPORTANT that you download the whole set,
+dnl some macros depend on other. Unfortunately, the autoconf archive
+dnl does not support the concept of set of macros, so I had to break it
+dnl for submission. The general documentation, as well as the sample
+dnl configure.in, is included in the AC_PROG_JAVA macro.
+dnl
+dnl @category Java
+dnl @author Stephane Bortzmeyer <bortzmeyer@pasteur.fr>
+dnl @version 2000-07-19
+dnl @license GPLWithACException
+
+AC_DEFUN([AC_CHECK_CLASSPATH],[
+if test "x$CLASSPATH" = x; then
+        echo "You have no CLASSPATH, I hope it is good"
+else
+        echo "You have CLASSPATH $CLASSPATH, hope it is correct"
+fi
+])
diff --git a/m4/ac_check_rqrd_class.m4 b/m4/ac_check_rqrd_class.m4
new file mode 100644
index 0000000..24b3d37
--- /dev/null
+++ b/m4/ac_check_rqrd_class.m4
@@ -0,0 +1,26 @@
+dnl @synopsis AC_CHECK_RQRD_CLASS
+dnl
+dnl AC_CHECK_RQRD_CLASS tests the existence of a given Java class,
+dnl either in a jar or in a '.class' file and fails if it doesn't
+dnl exist. Its success or failure can depend on a proper setting of the
+dnl CLASSPATH env. variable.
+dnl
+dnl Note: This is part of the set of autoconf M4 macros for Java
+dnl programs. It is VERY IMPORTANT that you download the whole set,
+dnl some macros depend on other. Unfortunately, the autoconf archive
+dnl does not support the concept of set of macros, so I had to break it
+dnl for submission. The general documentation, as well as the sample
+dnl configure.in, is included in the AC_PROG_JAVA macro.
+dnl
+dnl @category Java
+dnl @author Stephane Bortzmeyer <bortzmeyer@pasteur.fr>
+dnl @version 2000-07-19
+dnl @license GPLWithACException
+
+AC_DEFUN([AC_CHECK_RQRD_CLASS],[
+CLASS=`echo $1|sed 's/\./_/g'`
+AC_CHECK_CLASS($1)
+if test "$HAVE_LAST_CLASS" = "no"; then
+        AC_MSG_ERROR([Required class $1 missing, exiting.])
+fi
+])
diff --git a/m4/ac_java_options.m4 b/m4/ac_java_options.m4
new file mode 100644
index 0000000..aee3844
--- /dev/null
+++ b/m4/ac_java_options.m4
@@ -0,0 +1,33 @@
+dnl @synopsis AC_JAVA_OPTIONS
+dnl
+dnl AC_JAVA_OPTIONS adds configure command line options used for Java
+dnl m4 macros. This Macro is optional.
+dnl
+dnl Note: This is part of the set of autoconf M4 macros for Java
+dnl programs. It is VERY IMPORTANT that you download the whole set,
+dnl some macros depend on other. Unfortunately, the autoconf archive
+dnl does not support the concept of set of macros, so I had to break it
+dnl for submission. The general documentation, as well as the sample
+dnl configure.in, is included in the AC_PROG_JAVA macro.
+dnl
+dnl @category Java
+dnl @author Devin Weaver <ktohg@tritarget.com>
+dnl @version 2000-07-19
+dnl @license AllPermissive
+
+AC_DEFUN([AC_JAVA_OPTIONS],[
+AC_ARG_WITH(java-prefix,
+                        [  --with-java-prefix=PFX  prefix where Java runtime is installed (optional)])
+AC_ARG_WITH(javac-flags,
+                        [  --with-javac-flags=FLAGS flags to pass to the Java compiler (optional)])
+AC_ARG_WITH(java-flags,
+                        [  --with-java-flags=FLAGS flags to pass to the Java VM (optional)])
+JAVAPREFIX=$with_java_prefix
+JAVACFLAGS=$with_javac_flags
+JAVAFLAGS=$with_java_flags
+AC_SUBST(JAVAPREFIX)dnl
+AC_SUBST(JAVACFLAGS)dnl
+AC_SUBST(JAVAFLAGS)dnl
+AC_SUBST(JAVA)dnl
+AC_SUBST(JAVAC)dnl
+])
diff --git a/m4/ac_prog_jar.m4 b/m4/ac_prog_jar.m4
new file mode 100644
index 0000000..e5bf57c
--- /dev/null
+++ b/m4/ac_prog_jar.m4
@@ -0,0 +1,39 @@
+dnl @synopsis AC_PROG_JAR
+dnl
+dnl AC_PROG_JAR tests for an existing jar program. It uses the
+dnl environment variable JAR then tests in sequence various common jar
+dnl programs.
+dnl
+dnl If you want to force a specific compiler:
+dnl
+dnl - at the configure.in level, set JAR=yourcompiler before calling
+dnl AC_PROG_JAR
+dnl
+dnl - at the configure level, setenv JAR
+dnl
+dnl You can use the JAR variable in your Makefile.in, with @JAR@.
+dnl
+dnl Note: This macro depends on the autoconf M4 macros for Java
+dnl programs. It is VERY IMPORTANT that you download that whole set,
+dnl some macros depend on other. Unfortunately, the autoconf archive
+dnl does not support the concept of set of macros, so I had to break it
+dnl for submission.
+dnl
+dnl The general documentation of those macros, as well as the sample
+dnl configure.in, is included in the AC_PROG_JAVA macro.
+dnl
+dnl @category Java
+dnl @author Egon Willighagen <e.willighagen@science.ru.nl>
+dnl @version 2000-07-19
+dnl @license AllPermissive
+
+AC_DEFUN([AC_PROG_JAR],[
+AC_REQUIRE([AC_EXEEXT])dnl
+if test "x$JAVAPREFIX" = x; then
+        test "x$JAR" = x && AC_CHECK_PROGS(JAR, jar$EXEEXT)
+else
+        test "x$JAR" = x && AC_CHECK_PROGS(JAR, jar, $JAVAPREFIX)
+fi
+test "x$JAR" = x && AC_MSG_ERROR([no acceptable jar program found in \$PATH])
+AC_PROVIDE([$0])dnl
+])
diff --git a/m4/ac_prog_java.m4 b/m4/ac_prog_java.m4
new file mode 100644
index 0000000..d16c2d6
--- /dev/null
+++ b/m4/ac_prog_java.m4
@@ -0,0 +1,83 @@
+dnl @synopsis AC_PROG_JAVA
+dnl
+dnl Here is a summary of the main macros:
+dnl
+dnl AC_PROG_JAVAC: finds a Java compiler.
+dnl
+dnl AC_PROG_JAVA: finds a Java virtual machine.
+dnl
+dnl AC_CHECK_CLASS: finds if we have the given class (beware of
+dnl CLASSPATH!).
+dnl
+dnl AC_CHECK_RQRD_CLASS: finds if we have the given class and stops
+dnl otherwise.
+dnl
+dnl AC_TRY_COMPILE_JAVA: attempt to compile user given source.
+dnl
+dnl AC_TRY_RUN_JAVA: attempt to compile and run user given source.
+dnl
+dnl AC_JAVA_OPTIONS: adds Java configure options.
+dnl
+dnl AC_PROG_JAVA tests an existing Java virtual machine. It uses the
+dnl environment variable JAVA then tests in sequence various common
+dnl Java virtual machines. For political reasons, it starts with the
+dnl free ones. You *must* call [AC_PROG_JAVAC] before.
+dnl
+dnl If you want to force a specific VM:
+dnl
+dnl - at the configure.in level, set JAVA=yourvm before calling
+dnl AC_PROG_JAVA
+dnl
+dnl   (but after AC_INIT)
+dnl
+dnl - at the configure level, setenv JAVA
+dnl
+dnl You can use the JAVA variable in your Makefile.in, with @JAVA@.
+dnl
+dnl *Warning*: its success or failure can depend on a proper setting of
+dnl the CLASSPATH env. variable.
+dnl
+dnl TODO: allow to exclude virtual machines (rationale: most Java
+dnl programs cannot run with some VM like kaffe).
+dnl
+dnl Note: This is part of the set of autoconf M4 macros for Java
+dnl programs. It is VERY IMPORTANT that you download the whole set,
+dnl some macros depend on other. Unfortunately, the autoconf archive
+dnl does not support the concept of set of macros, so I had to break it
+dnl for submission.
+dnl
+dnl A Web page, with a link to the latest CVS snapshot is at
+dnl <http://www.internatif.org/bortzmeyer/autoconf-Java/>.
+dnl
+dnl This is a sample configure.in Process this file with autoconf to
+dnl produce a configure script.
+dnl
+dnl    AC_INIT(UnTag.java)
+dnl
+dnl    dnl Checks for programs.
+dnl    AC_CHECK_CLASSPATH
+dnl    AC_PROG_JAVAC
+dnl    AC_PROG_JAVA
+dnl
+dnl    dnl Checks for classes
+dnl    AC_CHECK_RQRD_CLASS(org.xml.sax.Parser)
+dnl    AC_CHECK_RQRD_CLASS(com.jclark.xml.sax.Driver)
+dnl
+dnl    AC_OUTPUT(Makefile)
+dnl
+dnl @category Java
+dnl @author Stephane Bortzmeyer <bortzmeyer@pasteur.fr>
+dnl @version 2000-07-19
+dnl @license GPLWithACException
+
+AC_DEFUN([AC_PROG_JAVA],[
+AC_REQUIRE([AC_EXEEXT])dnl
+if test x$JAVAPREFIX = x; then
+        test x$JAVA = x && AC_CHECK_PROGS(JAVA, kaffe$EXEEXT java$EXEEXT)
+else
+        test x$JAVA = x && AC_CHECK_PROGS(JAVA, kaffe$EXEEXT java$EXEEXT, $JAVAPREFIX)
+fi
+test x$JAVA = x && AC_MSG_ERROR([no acceptable Java virtual machine found in \$PATH])
+AC_PROG_JAVA_WORKS
+AC_PROVIDE([$0])dnl
+])
diff --git a/m4/ac_prog_java_works.m4 b/m4/ac_prog_java_works.m4
new file mode 100644
index 0000000..bb14a88
--- /dev/null
+++ b/m4/ac_prog_java_works.m4
@@ -0,0 +1,98 @@
+dnl @synopsis AC_PROG_JAVA_WORKS
+dnl
+dnl Internal use ONLY.
+dnl
+dnl Note: This is part of the set of autoconf M4 macros for Java
+dnl programs. It is VERY IMPORTANT that you download the whole set,
+dnl some macros depend on other. Unfortunately, the autoconf archive
+dnl does not support the concept of set of macros, so I had to break it
+dnl for submission. The general documentation, as well as the sample
+dnl configure.in, is included in the AC_PROG_JAVA macro.
+dnl
+dnl @category Java
+dnl @author Stephane Bortzmeyer <bortzmeyer@pasteur.fr>
+dnl @version 2000-07-19
+dnl @license GPLWithACException
+
+AC_DEFUN([AC_PROG_JAVA_WORKS], [
+AC_CHECK_PROG(uudecode, uudecode$EXEEXT, yes)
+if test x$uudecode = xyes; then
+AC_CACHE_CHECK([if uudecode can decode base 64 file], ac_cv_prog_uudecode_base64, [
+dnl /**
+dnl  * Test.java: used to test if java compiler works.
+dnl  */
+dnl public class Test
+dnl {
+dnl
+dnl public static void
+dnl main( String[] argv )
+dnl {
+dnl     System.exit (0);
+dnl }
+dnl
+dnl }
+cat << \EOF > Test.uue
+begin-base64 644 Test.class
+yv66vgADAC0AFQcAAgEABFRlc3QHAAQBABBqYXZhL2xhbmcvT2JqZWN0AQAE
+bWFpbgEAFihbTGphdmEvbGFuZy9TdHJpbmc7KVYBAARDb2RlAQAPTGluZU51
+bWJlclRhYmxlDAAKAAsBAARleGl0AQAEKEkpVgoADQAJBwAOAQAQamF2YS9s
+YW5nL1N5c3RlbQEABjxpbml0PgEAAygpVgwADwAQCgADABEBAApTb3VyY2VG
+aWxlAQAJVGVzdC5qYXZhACEAAQADAAAAAAACAAkABQAGAAEABwAAACEAAQAB
+AAAABQO4AAyxAAAAAQAIAAAACgACAAAACgAEAAsAAQAPABAAAQAHAAAAIQAB
+AAEAAAAFKrcAErEAAAABAAgAAAAKAAIAAAAEAAQABAABABMAAAACABQ=
+====
+EOF
+if uudecode$EXEEXT Test.uue; then
+        ac_cv_prog_uudecode_base64=yes
+else
+        echo "configure: __oline__: uudecode had trouble decoding base 64 file 'Test.uue'" >&AC_FD_CC
+        echo "configure: failed file was:" >&AC_FD_CC
+        cat Test.uue >&AC_FD_CC
+        ac_cv_prog_uudecode_base64=no
+fi
+rm -f Test.uue])
+fi
+if test x$ac_cv_prog_uudecode_base64 != xyes; then
+        rm -f Test.class
+        AC_MSG_WARN([I have to compile Test.class from scratch])
+        if test x$ac_cv_prog_javac_works = xno; then
+                AC_MSG_ERROR([Cannot compile java source. $JAVAC does not work properly])
+        fi
+        if test x$ac_cv_prog_javac_works = x; then
+                AC_PROG_JAVAC
+        fi
+fi
+AC_CACHE_CHECK(if $JAVA works, ac_cv_prog_java_works, [
+JAVA_TEST=Test.java
+CLASS_TEST=Test.class
+TEST=Test
+changequote(, )dnl
+cat << \EOF > $JAVA_TEST
+/* [#]line __oline__ "configure" */
+public class Test {
+public static void main (String args[]) {
+        System.exit (0);
+} }
+EOF
+changequote([, ])dnl
+if test x$ac_cv_prog_uudecode_base64 != xyes; then
+        if AC_TRY_COMMAND($JAVAC $JAVACFLAGS $JAVA_TEST) && test -s $CLASS_TEST; then
+                :
+        else
+          echo "configure: failed program was:" >&AC_FD_CC
+          cat $JAVA_TEST >&AC_FD_CC
+          AC_MSG_ERROR(The Java compiler $JAVAC failed (see config.log, check the CLASSPATH?))
+        fi
+fi
+if AC_TRY_COMMAND($JAVA $JAVAFLAGS $TEST) >/dev/null 2>&1; then
+  ac_cv_prog_java_works=yes
+else
+  echo "configure: failed program was:" >&AC_FD_CC
+  cat $JAVA_TEST >&AC_FD_CC
+  AC_MSG_ERROR(The Java VM $JAVA failed (see config.log, check the CLASSPATH?))
+fi
+rm -fr $JAVA_TEST $CLASS_TEST Test.uue
+])
+AC_PROVIDE([$0])dnl
+]
+)
diff --git a/m4/ac_prog_javac.m4 b/m4/ac_prog_javac.m4
new file mode 100644
index 0000000..91463e8
--- /dev/null
+++ b/m4/ac_prog_javac.m4
@@ -0,0 +1,45 @@
+dnl @synopsis AC_PROG_JAVAC
+dnl
+dnl AC_PROG_JAVAC tests an existing Java compiler. It uses the
+dnl environment variable JAVAC then tests in sequence various common
+dnl Java compilers. For political reasons, it starts with the free
+dnl ones.
+dnl
+dnl If you want to force a specific compiler:
+dnl
+dnl - at the configure.in level, set JAVAC=yourcompiler before calling
+dnl AC_PROG_JAVAC
+dnl
+dnl - at the configure level, setenv JAVAC
+dnl
+dnl You can use the JAVAC variable in your Makefile.in, with @JAVAC@.
+dnl
+dnl *Warning*: its success or failure can depend on a proper setting of
+dnl the CLASSPATH env. variable.
+dnl
+dnl TODO: allow to exclude compilers (rationale: most Java programs
+dnl cannot compile with some compilers like guavac).
+dnl
+dnl Note: This is part of the set of autoconf M4 macros for Java
+dnl programs. It is VERY IMPORTANT that you download the whole set,
+dnl some macros depend on other. Unfortunately, the autoconf archive
+dnl does not support the concept of set of macros, so I had to break it
+dnl for submission. The general documentation, as well as the sample
+dnl configure.in, is included in the AC_PROG_JAVA macro.
+dnl
+dnl @category Java
+dnl @author Stephane Bortzmeyer <bortzmeyer@pasteur.fr>
+dnl @version 2000-07-19
+dnl @license GPLWithACException
+
+AC_DEFUN([AC_PROG_JAVAC],[
+AC_REQUIRE([AC_EXEEXT])dnl
+if test "x$JAVAPREFIX" = x; then
+        test "x$JAVAC" = x && AC_CHECK_PROGS(JAVAC, "gcj$EXEEXT -C" guavac$EXEEXT jikes$EXEEXT javac$EXEEXT)
+else
+        test "x$JAVAC" = x && AC_CHECK_PROGS(JAVAC, "gcj$EXEEXT -C" guavac$EXEEXT jikes$EXEEXT javac$EXEEXT, $JAVAPREFIX)
+fi
+test "x$JAVAC" = x && AC_MSG_ERROR([no acceptable Java compiler found in \$PATH])
+AC_PROG_JAVAC_WORKS
+AC_PROVIDE([$0])dnl
+])
diff --git a/m4/ac_prog_javac_works.m4 b/m4/ac_prog_javac_works.m4
new file mode 100644
index 0000000..8727e7f
--- /dev/null
+++ b/m4/ac_prog_javac_works.m4
@@ -0,0 +1,36 @@
+dnl @synopsis AC_PROG_JAVAC_WORKS
+dnl
+dnl Internal use ONLY.
+dnl
+dnl Note: This is part of the set of autoconf M4 macros for Java
+dnl programs. It is VERY IMPORTANT that you download the whole set,
+dnl some macros depend on other. Unfortunately, the autoconf archive
+dnl does not support the concept of set of macros, so I had to break it
+dnl for submission. The general documentation, as well as the sample
+dnl configure.in, is included in the AC_PROG_JAVA macro.
+dnl
+dnl @category Java
+dnl @author Stephane Bortzmeyer <bortzmeyer@pasteur.fr>
+dnl @version 2000-07-19
+dnl @license GPLWithACException
+
+AC_DEFUN([AC_PROG_JAVAC_WORKS],[
+AC_CACHE_CHECK([if $JAVAC works], ac_cv_prog_javac_works, [
+JAVA_TEST=Test.java
+CLASS_TEST=Test.class
+cat << \EOF > $JAVA_TEST
+/* [#]line __oline__ "configure" */
+public class Test {
+}
+EOF
+if AC_TRY_COMMAND($JAVAC $JAVACFLAGS $JAVA_TEST) >/dev/null 2>&1; then
+  ac_cv_prog_javac_works=yes
+else
+  AC_MSG_ERROR([The Java compiler $JAVAC failed (see config.log, check the CLASSPATH?)])
+  echo "configure: failed program was:" >&AC_FD_CC
+  cat $JAVA_TEST >&AC_FD_CC
+fi
+rm -f $JAVA_TEST $CLASS_TEST
+])
+AC_PROVIDE([$0])dnl
+])
diff --git a/m4/ac_prog_javah.m4 b/m4/ac_prog_javah.m4
new file mode 100644
index 0000000..0cc93f9
--- /dev/null
+++ b/m4/ac_prog_javah.m4
@@ -0,0 +1,28 @@
+dnl @synopsis AC_PROG_JAVAH
+dnl
+dnl AC_PROG_JAVAH tests the availability of the javah header generator
+dnl and looks for the jni.h header file. If available, JAVAH is set to
+dnl the full path of javah and CPPFLAGS is updated accordingly.
+dnl
+dnl @category Java
+dnl @author Luc Maisonobe <luc@spaceroots.org>
+dnl @version 2002-03-25
+dnl @license AllPermissive
+
+AC_DEFUN([AC_PROG_JAVAH],[
+AC_REQUIRE([AC_CANONICAL_SYSTEM])dnl
+AC_REQUIRE([AC_PROG_CPP])dnl
+AC_PATH_PROG(JAVAH,javah)
+if test x"`eval 'echo $ac_cv_path_JAVAH'`" != x ; then
+  AC_TRY_CPP([#include <jni.h>],,[
+    ac_save_CPPFLAGS="$CPPFLAGS"
+changequote(, )dnl
+    ac_dir=`echo $ac_cv_path_JAVAH | sed 's,\(.*\)/[^/]*/[^/]*$,\1/include,'`
+    ac_machdep=`echo $build_os | sed 's,[-0-9].*,,' | sed 's,cygwin,win32,'`
+changequote([, ])dnl
+    CPPFLAGS="$ac_save_CPPFLAGS -I$ac_dir -I$ac_dir/$ac_machdep"
+    AC_TRY_CPP([#include <jni.h>],
+               ac_save_CPPFLAGS="$CPPFLAGS",
+               AC_MSG_WARN([unable to include <jni.h>]))
+    CPPFLAGS="$ac_save_CPPFLAGS"])
+fi])
diff --git a/m4/ac_try_compile_java.m4 b/m4/ac_try_compile_java.m4
new file mode 100644
index 0000000..102a04c
--- /dev/null
+++ b/m4/ac_try_compile_java.m4
@@ -0,0 +1,40 @@
+dnl @synopsis AC_TRY_COMPILE_JAVA
+dnl
+dnl AC_TRY_COMPILE_JAVA attempt to compile user given source.
+dnl
+dnl *Warning*: its success or failure can depend on a proper setting of
+dnl the CLASSPATH env. variable.
+dnl
+dnl Note: This is part of the set of autoconf M4 macros for Java
+dnl programs. It is VERY IMPORTANT that you download the whole set,
+dnl some macros depend on other. Unfortunately, the autoconf archive
+dnl does not support the concept of set of macros, so I had to break it
+dnl for submission. The general documentation, as well as the sample
+dnl configure.in, is included in the AC_PROG_JAVA macro.
+dnl
+dnl @category Java
+dnl @author Devin Weaver <ktohg@tritarget.com>
+dnl @version 2000-07-19
+dnl @license AllPermissive
+
+AC_DEFUN([AC_TRY_COMPILE_JAVA],[
+AC_REQUIRE([AC_PROG_JAVAC])dnl
+cat << \EOF > Test.java
+/* [#]line __oline__ "configure" */
+ifelse([$1], , , [import $1;])
+public class Test {
+[$2]
+}
+EOF
+if AC_TRY_COMMAND($JAVAC $JAVACFLAGS Test.java) && test -s Test.class
+then
+dnl Don't remove the temporary files here, so they can be examined.
+  ifelse([$3], , :, [$3])
+else
+  echo "configure: failed program was:" >&AC_FD_CC
+  cat Test.java >&AC_FD_CC
+ifelse([$4], , , [  rm -fr Test*
+  $4
+])dnl
+fi
+rm -fr Test*])
diff --git a/m4/ac_try_run_javac.m4 b/m4/ac_try_run_javac.m4
new file mode 100644
index 0000000..e8e975c
--- /dev/null
+++ b/m4/ac_try_run_javac.m4
@@ -0,0 +1,41 @@
+dnl @synopsis AC_TRY_RUN_JAVA
+dnl
+dnl AC_TRY_RUN_JAVA attempt to compile and run user given source.
+dnl
+dnl *Warning*: its success or failure can depend on a proper setting of
+dnl the CLASSPATH env. variable.
+dnl
+dnl Note: This is part of the set of autoconf M4 macros for Java
+dnl programs. It is VERY IMPORTANT that you download the whole set,
+dnl some macros depend on other. Unfortunately, the autoconf archive
+dnl does not support the concept of set of macros, so I had to break it
+dnl for submission. The general documentation, as well as the sample
+dnl configure.in, is included in the AC_PROG_JAVA macro.
+dnl
+dnl @category Java
+dnl @author Devin Weaver <ktohg@tritarget.com>
+dnl @version 2000-07-19
+dnl @license AllPermissive
+
+AC_DEFUN([AC_TRY_RUN_JAVA],[
+AC_REQUIRE([AC_PROG_JAVAC])dnl
+AC_REQUIRE([AC_PROG_JAVA])dnl
+cat << \EOF > Test.java
+/* [#]line __oline__ "configure" */
+ifelse([$1], , , [include $1;])
+public class Test {
+[$2]
+}
+EOF
+if AC_TRY_COMMAND($JAVAC $JAVACFLAGS Test.java) && test -s Test.class && ($JAVA $JAVAFLAGS Test; exit) 2>/dev/null
+then
+dnl Don't remove the temporary files here, so they can be examined.
+  ifelse([$3], , :, [$3])
+else
+  echo "configure: failed program was:" >&AC_FD_CC
+  cat Test.java >&AC_FD_CC
+ifelse([$4], , , [  rm -fr Test*
+  $4
+])dnl
+fi
+rm -fr Test*])
-- 
1.8.1

