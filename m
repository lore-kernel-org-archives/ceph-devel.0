From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: [PATCH 2/3] java: setup autotools to build cephfs-java
Date: Fri, 02 Mar 2012 16:49:40 -0800
Message-ID: <4F516AA4.1090908@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:37213 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215Ab2CCAtn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 19:49:43 -0500
Received: from martini.local (soenat3.cse.ucsc.edu [128.114.60.41])
	by mail-01.cse.ucsc.edu (Postfix) with ESMTPSA id 71C3C1008A88
	for <ceph-devel@vger.kernel.org>; Fri,  2 Mar 2012 16:49:43 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Adds --enable-cephfs-java and --with-jdk to build
the libcephfs Java bindings and specify the default
JDK directory, respectively.

Also adds default JDK paths to avoid --with-jdk in
the common case. Currently setup for the default
provided by Debian's default-jdk package, but other
default search paths can easily be added.

Signed-off-by: Noah Watkins <noahwatkins@gmail.com>
---
 configure.ac         |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/Makefile.am      |   15 +++++++++-
 src/java/.gitignore  |    4 +++
 src/java/Makefile.am |   49 +++++++++++++++++++++++++++++++++
 4 files changed, 141 insertions(+), 1 deletions(-)
 create mode 100644 src/java/.gitignore
 create mode 100644 src/java/Makefile.am

diff --git a/configure.ac b/configure.ac
index c90fceb..69c1862 100644
--- a/configure.ac
+++ b/configure.ac
@@ -241,7 +241,80 @@ AS_IF([test "x$with_tcmalloc" != xno],
 		  [no tcmalloc found (use --without-tcmalloc to disable)])])])
 AM_CONDITIONAL(WITH_TCMALLOC, [test "$HAVE_LIBTCMALLOC" = "1"])
 
+#
+# Java is painful
+#   - adapted from OMPI wrappers package
+#   - this might become bigger. maybe should be own m4 file
+#
+AC_ARG_ENABLE(cephfs-java,
+    AC_HELP_STRING([--enable-cephfs-java], [build libcephfs Java bindings]),
+    [], [enable_cephfs_java=no])
+
+AM_CONDITIONAL(ENABLE_CEPHFS_JAVA, test "x$enable_cephfs_java" = "xyes")
+
+AC_ARG_WITH(jdk-dir,
+    AC_HELP_STRING([--with-jdk-dir(=DIR)], [Path to JDK directory]))
+
+AC_DEFUN([JAVA_DNE],
+	AC_MSG_ERROR([Cannot find $1 '$2'. Try setting --with-jdk-dir]))
+
+AS_IF([test "x$enable_cephfs_java" = "xyes"], [
+
+	# setup bin/include dirs from --with-jdk-dir (search for jni.h, javac)
+	AS_IF([test -n "$with_jdk_dir"], [
+		   javac_prog=`find $with_jdk_dir/ -name javac | head -n 1`
+		   AS_IF([test -x "$javac_prog"], [
+				  EXTRA_JDK_BIN_DIR=`dirname $javac_prog`])
+		   jnih=`find $with_jdk_dir/ -name jni.h | head -n 1`
+		   AS_IF([test -r "$jnih"], [
+				  EXTRA_JDK_INC_DIR=`dirname $jnih`])])
+
+	# setup defaults for Debian default-jdk package (without --with-jdk-dir)
+	AS_IF([test -z "$with_jdk_dir"], [
+		   # This works with Debian's default-jdk package
+		   dir='/usr/lib/jvm/default-java/'
+		   javac_prog=`find $dir -name javac | head -n 1`
+		   AS_IF([test -x "$javac_prog"], [
+				  EXTRA_JDK_BIN_DIR=`dirname $javac_prog`])
+		   jnih=`find $dir -name jni.h | head -n 1`
+		   AS_IF([test -r "$jnih"], [
+				  EXTRA_JDK_INC_DIR=`dirname $jnih`])])
+
+	# Check for Java programs: javac, javah, jar
+    PATH_save=$PATH
+	PATH="$PATH:$EXTRA_JDK_BIN_DIR"
+	AC_PATH_PROG(JAVAC, javac)
+    AC_PATH_PROG(JAVAH, javah)
+    AC_PATH_PROG(JAR, jar)
+    PATH=$PATH_save
+
+    # Ensure we have them...
+    AS_IF([test -z "$JAVAC"], JAVA_DNE(program, javac))
+    AS_IF([test -z "$JAVAH"], JAVA_DNE(program, javah))
+    AS_IF([test -z "$JAR"], JAVA_DNE(program, jar))
+
+    # Check for jni.h
+	CPPFLAGS_save=$CPPFLAGS
+
+	AS_IF([test -n "$EXTRA_JDK_INC_DIR"],
+		  [JDK_CPPFLAGS="-I$EXTRA_JDK_INC_DIR"
+		   AS_IF([test -d "$EXTRA_JDK_INC_DIR/linux"],
+				 [JDK_CPPFLAGS="$JDK_CPPFLAGS -I$EXTRA_JDK_INC_DIR/linux"])
+		   CPPFLAGS="$CPPFLAGS $JDK_CPPFLAGS"])
+
+	AC_CHECK_HEADER([jni.h], [], JAVA_DNE(header, jni.h))
+
+	CPPFLAGS=$CPPFLAGS_save
+
+	# Setup output var
+	AC_SUBST(JDK_CPPFLAGS)
+])
+
 # jni?
+# clear cache (from java above) -- this whole thing will get
+# folded into the bigger java package later -- for now maintain
+# backward compat
+AS_UNSET(ac_cv_header_jni_h)
 AC_ARG_WITH([hadoop],
             [AS_HELP_STRING([--with-hadoop], [build hadoop client])],
             [],
@@ -409,6 +482,7 @@ AC_CONFIG_FILES([Makefile
 	src/Makefile
 	src/ocf/Makefile
 	src/ocf/ceph
+	src/java/Makefile
 	man/Makefile
 	ceph.spec])
 AC_OUTPUT
diff --git a/src/Makefile.am b/src/Makefile.am
index 3970476..d5363e5 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -1,5 +1,5 @@
 AUTOMAKE_OPTIONS = gnu
-SUBDIRS = ocf leveldb
+SUBDIRS = ocf leveldb java
 DIST_SUBDIRS = gtest ocf leveldb
 CLEANFILES =
 bin_PROGRAMS =
@@ -414,6 +414,19 @@ libhadoopcephfs_la_CFLAGS = ${AM_CFLAGS}
 libhadoopcephfs_la_CXXFLAGS = ${AM_CXXFLAGS}
 libhadoopcephfs_la_LDFLAGS = ${AM_LDFLAGS} -version-info 1:0:0 -export-symbols-regex 'hadoopcephfs_.*'
 lib_LTLIBRARIES += libhadoopcephfs.la
+
+endif
+
+## CephFS Java Wrappers
+##  - The JNI library is here
+##  - The Java source Makefile.am is in src/java
+if ENABLE_CEPHFS_JAVA
+libcephfs_jni_la_SOURCES = java/native/libcephfs_jni.cc
+libcephfs_jni_la_LIBADD = libcephfs.la
+libcephfs_jni_la_CFLAGS = $(JDK_CPPFLAGS) ${AM_CFLAGS}
+libcephfs_jni_la_CXXFLAGS = $(JDK_CPPFLAGS) ${AM_CXXFLAGS}
+libcephfs_jni_la_LDFLAGS = ${AM_LDFLAGS} -version-info 1:0:0
+lib_LTLIBRARIES += libcephfs_jni.la
 endif
 
 ## System tests
diff --git a/src/java/.gitignore b/src/java/.gitignore
new file mode 100644
index 0000000..aeb1e74
--- /dev/null
+++ b/src/java/.gitignore
@@ -0,0 +1,4 @@
+*.class
+libcephfs.jar
+native/net_newdream_ceph_fs_CephProxy.h
+TEST-*.txt
diff --git a/src/java/Makefile.am b/src/java/Makefile.am
new file mode 100644
index 0000000..89dd239
--- /dev/null
+++ b/src/java/Makefile.am
@@ -0,0 +1,49 @@
+# automake technique adapted from OpenMPI Java
+
+JAVA_SRC = \
+	java/net/newdream/ceph/fs/CephConstants.java \
+	java/net/newdream/ceph/fs/CephDirectory.java \
+	java/net/newdream/ceph/fs/CephException.java \
+	java/net/newdream/ceph/fs/CephMount.java \
+	java/net/newdream/ceph/fs/CephProxy.java \
+	java/net/newdream/ceph/fs/CephStat.java \
+	java/net/newdream/ceph/fs/CephStatVFS.java \
+	java/net/newdream/ceph/fs/CephInvalidStateException.java \
+	java/net/newdream/ceph/fs/CephStruct.java \
+	java/net/newdream/ceph/fs/CephNativeLoader.java
+
+EXTRA_DIST = $(JAVA_SRC)
+
+if ENABLE_CEPHFS_JAVA
+
+JAVA_CLASSES = $(JAVA_SRC:java/%.java=%.class)
+# This is dumb -- It might be better to split some work
+# between Make and Ant or Maven
+ESCAPED_JAVA_CLASSES = \
+	net/newdream/ceph/fs/CephMount\$$State.class \
+	net/newdream/ceph/fs/CephDirectory\$$State.class
+
+JAVA_H = native/net_newdream_ceph_fs_CephProxy.h
+
+# target to make automake happy
+CEPH_PROXY=java/net/newdream/ceph/fs/CephProxy.class
+
+$(CEPH_PROXY): $(JAVA_SRC)
+	export CLASSPATH=java/ ;
+	$(JAVAC) java/net/newdream/ceph/fs/*.java
+
+$(JAVA_H): $(CEPH_PROXY)
+	export CLASSPATH=java/ ; \
+	$(JAVAH) -jni -o $@ net.newdream.ceph.fs.CephProxy
+
+libcephfs.jar: $(CEPH_PROXY)
+	$(JAR) cf $@ $(JAVA_CLASSES:%=-C java %) $(ESCAPED_JAVA_CLASSES:%=-C java %)
+
+javadir = $(libdir)
+java_DATA = libcephfs.jar
+
+BUILT_SOURCES = $(JAVA_H)
+
+CLEANFILES = -rf java/net/newdream/ceph/fs/*.class $(JAVA_H) libcephfs.jar
+
+endif
-- 
1.7.5.4

