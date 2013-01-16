From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH] configure.ac: fix problem with --enable-cephfs-java
Date: Wed, 16 Jan 2013 13:40:17 +0100
Message-ID: <1358340017-26454-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:33299 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751558Ab3APMkV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 16 Jan 2013 07:40:21 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Gary Lowell <gary.lowell@inktank.com>, Gregory Farnum <gregory.farnum@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

The AS_IF used to cover java related checks via --enable-cephfs-java
didn't work correctly. Use a plain 'if/fi' instead to make sure this
section is only executed if --enable-cephfs-java is used.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 configure.ac | 66 ++++++++++++++++++++++++++++++------------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/configure.ac b/configure.ac
index 32814b8..b67e5cd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -263,15 +263,15 @@ AM_CONDITIONAL(WITH_TCMALLOC, [test "$HAVE_LIBTCMALLOC" = "1"])
 #   - this might become bigger. maybe should be own m4 file
 #
 AC_ARG_ENABLE(cephfs-java,
-    AC_HELP_STRING([--enable-cephfs-java], [build libcephfs Java bindings]),
+    [AC_HELP_STRING([--enable-cephfs-java], [build libcephfs Java bindings])],
     [], [enable_cephfs_java=no])
 
-AM_CONDITIONAL(ENABLE_CEPHFS_JAVA, test "x$enable_cephfs_java" = "xyes")
+AM_CONDITIONAL(ENABLE_CEPHFS_JAVA, [test "x$enable_cephfs_java" = "xyes"])
 
 AC_ARG_WITH(jdk-dir,
     AC_HELP_STRING([--with-jdk-dir(=DIR)], [Path to JDK directory]))
 
-AS_IF([test "x$enable_cephfs_java" = "xyes"], [
+if test "x$enable_cephfs_java" = "xyes"; then
 
 	# setup bin/include dirs from --with-jdk-dir (search for jni.h, javac)
 	AS_IF([test -n "$with_jdk_dir"], [
@@ -293,36 +293,36 @@ AS_IF([test "x$enable_cephfs_java" = "xyes"], [
 		   AS_IF([test -r "$jnih"], [
 				  EXTRA_JDK_INC_DIR=`dirname $jnih`])])
 
-  # cephfs_java_test only makes sense if java is already turned on
+        # cephfs_java_test only makes sense if java is already turned on
 	# setup CLASSPATH for Debian default junit4.jar package 
-    #
-    # Configuring --with-debug and --enable-cephfs-java will throw an error if
-    # JUnit4 cannot be found. While currently this works for users who have
-    # installed via the package manager on Ubuntu, we need to expand this
-    # check to 1) support other distrubtions and 2) allow users to influence
-    # the search path.
-  AS_IF([test "x$with_debug" = "xyes"], [
-      dir='/usr/share/java'
-      junit4_jar=`find $dir -name junit4.jar | head -n 1`
-		  AS_IF([test -r "$junit4_jar"], [
-	      EXTRA_CLASSPATH_JAR=`dirname $junit4_jar`/junit4.jar
-      AC_SUBST(EXTRA_CLASSPATH_JAR)
-      [have_junit4=1]], [
-      AC_MSG_NOTICE([Cannot find junit4.jar (apt-get install junit4)])
-      [have_junit4=0]])])
-
-      AC_CHECK_CLASSPATH
-      AC_PROG_JAVAC
-      AC_PROG_JAVAH
-      AC_PROG_JAR
-
-      CLASSPATH=$CLASSPATH:$EXTRA_CLASSPATH_JAR
-      export CLASSPATH
-      AC_MSG_NOTICE([classpath - $CLASSPATH])
-      AS_IF([test "$have_junit4" = "1"], [
-	    AC_CHECK_CLASS([org.junit.rules.ExternalResource], [], [
-	    AC_MSG_NOTICE(Could not find org.junit.rules.ExternalResource)
-	    have_junit4=0])])
+        #
+        # Configuring --with-debug and --enable-cephfs-java will throw an error if
+        # JUnit4 cannot be found. While currently this works for users who have
+        # installed via the package manager on Ubuntu, we need to expand this
+        # check to 1 support other distrubtions and 2 allow users to influence
+        # the search path.
+        AS_IF([test "x$with_debug" = "xyes"], [
+        	dir='/usr/share/java'
+	        junit4_jar=`find $dir -name junit4.jar | head -n 1`
+		AS_IF([test -r "$junit4_jar"], [
+		      EXTRA_CLASSPATH_JAR=`dirname $junit4_jar`/junit4.jar
+		      AC_SUBST(EXTRA_CLASSPATH_JAR)
+		      [have_junit4=1]], [
+		      AC_MSG_NOTICE([Cannot find junit4.jar (apt-get install junit4)])
+		      [have_junit4=0]])])
+
+        AC_CHECK_CLASSPATH
+        AC_PROG_JAVAC
+        AC_PROG_JAVAH
+        AC_PROG_JAR
+
+        CLASSPATH=$CLASSPATH:$EXTRA_CLASSPATH_JAR
+        export CLASSPATH
+        AC_MSG_NOTICE([classpath - $CLASSPATH])
+        AS_IF([test "$have_junit4" = "1"], [
+		AC_CHECK_CLASS([org.junit.rules.ExternalResource], [], [
+		AC_MSG_NOTICE(Could not find org.junit.rules.ExternalResource)
+		have_junit4=0])])
 
         # Check for jni.h
 	CPPFLAGS_save=$CPPFLAGS
@@ -339,7 +339,7 @@ AS_IF([test "x$enable_cephfs_java" = "xyes"], [
 
 	# Setup output var
 	AC_SUBST(JDK_CPPFLAGS)
-])
+fi
 AM_CONDITIONAL(HAVE_JUNIT4, [test "$have_junit4" = "1"])
 
 # jni?
-- 
1.8.1

