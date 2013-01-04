From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 6/6] configure.ac: change junit4 handling
Date: Fri,  4 Jan 2013 18:51:31 +0100
Message-ID: <1357321891-20202-7-git-send-email-danny.al-gaaf@bisect.de>
References: <1357321891-20202-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:54159 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754131Ab3ADRve (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 12:51:34 -0500
In-Reply-To: <1357321891-20202-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Change handling of --with-debug and junit4. Add a new conditional HAVE_JUNIT4
to be able to build ceph-test package also if junit4 isn't available. In
this case simply don't build libcephfs-test.jar, but the rest of the tools.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 configure.ac         | 7 +++++--
 src/java/Makefile.am | 4 ++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 15430dd..832054b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -309,8 +309,10 @@ AS_IF([test "x$enable_cephfs_java" = "xyes"], [
       junit4_jar=`find $dir -name junit4.jar | head -n 1`
 		  AS_IF([test -r "$junit4_jar"], [
 	      EXTRA_CLASSPATH_JAR=`dirname $junit4_jar`/junit4.jar
-      AC_SUBST(EXTRA_CLASSPATH_JAR)], [
-      AC_MSG_ERROR([Cannot find junit4.jar (apt-get install junit4)])])])
+      AC_SUBST(EXTRA_CLASSPATH_JAR)
+      [have_junit4=1]], [
+      AC_MSG_NOTICE([Cannot find junit4.jar (apt-get install junit4)])
+      [have_junit4=0]])])
 
 	# Check for Java programs: javac, javah, jar
     PATH_save=$PATH
@@ -341,6 +343,7 @@ AS_IF([test "x$enable_cephfs_java" = "xyes"], [
 	# Setup output var
 	AC_SUBST(JDK_CPPFLAGS)
 ])
+AM_CONDITIONAL(HAVE_JUNIT4, [test "$have_junit4" = "1"])
 
 # jni?
 # clear cache (from java above) -- this whole thing will get
diff --git a/src/java/Makefile.am b/src/java/Makefile.am
index 1f87885..788bea2 100644
--- a/src/java/Makefile.am
+++ b/src/java/Makefile.am
@@ -51,7 +51,7 @@ CLEANFILES = -rf java/com/ceph/fs/*.class $(JAVA_H) libcephfs.jar
 BUILT_SOURCES = $(JAVA_H)
 
 # build the tests if *both* --enable-cephfs-java and --with-debug were specifed
-if WITH_DEBUG 
+if HAVE_JUNIT4
 
 JAVA_TEST_CLASSES = $(JAVA_TEST_SRC:test/%.java=%.class)
 ESCAPED_JAVA_TEST_CLASSES = com/ceph/fs/CephAllTests\$$1.class
@@ -68,5 +68,5 @@ libcephfs-test.jar: $(CEPH_TEST_PROXY)
 java_DATA += libcephfs-test.jar
 
 CLEANFILES += test/com/ceph/fs/*.class libcephfs-test.jar
-endif # WITH_DEBUG
+endif # HAVE_JUNIT4 (includes WITH_DEBUG)
 endif #ENABLE_CEPHFS_JAVA
-- 
1.8.0.2

