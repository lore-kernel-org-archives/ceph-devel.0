From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [GIT PULL v5] java: add libcephfs Java bindings
Date: Wed, 10 Oct 2012 15:00:19 -0700
Message-ID: <5075EFF3.9000106@cs.ucsc.edu>
References: <CAPrxi5-6JAWzUdsgdfHw=pG+6r5LN5i8X92DwxdejosY0xT0Dw@mail.gmail.com> <alpine.DEB.2.00.1209052051270.7974@cobra.newdream.net> <CAPrxi5-_AYV0UUuABCM+LkSpRVOM63R5XPDmjz9HE3UxFBe7AA@mail.gmail.com> <CAPrxi59Per-OMrc83pVLAkUs3rU=+RF9bN_X5bb+K1zC+STUng@mail.gmail.com> <alpine.DEB.2.00.1210031238300.23173@cobra.newdream.net> <506DF09B.20505@ubuntu.com> <1349388042.11633.161.camel@julia> <CAPrxi58Cm98s0e1qZUBhsZBVgV2bSEb7cESxHF9Vk1_+QMg=tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65359 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755199Ab2JJWAW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Oct 2012 18:00:22 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1163738pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 10 Oct 2012 15:00:21 -0700 (PDT)
In-Reply-To: <CAPrxi58Cm98s0e1qZUBhsZBVgV2bSEb7cESxHF9Vk1_+QMg=tQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>
Cc: James Page <james.page@ubuntu.com>, Sage Weil <sage@inktank.com>, Joe Buck <buck@soe.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>

Laszlo, James:

Changes based on your previous feedback are ready for review. I pushed the changes here:

  git://github.com/noahdesu/ceph.git wip-java-cephfs

Thanks!
- Noah

From 0d8c4dc39f9b8f2e264bb2503c053418ad72b705 Mon Sep 17 00:00:00 2001
From: Noah Watkins <noahwatkins@gmail.com>
Date: Wed, 10 Oct 2012 13:57:03 -0700
Subject: [PATCH] java: update deb bits from ceph-devel feedback

Signed-off-by: Noah Watkins <noahwatkins@gmail.com>
---
 debian/.gitignore            |    3 ++-
 debian/control               |   10 ++++++++--
 debian/libceph-java.jlibs    |    1 +
 debian/libceph-jni.install   |    1 +
 debian/libceph1-java.install |    2 --
 debian/rules                 |    1 +
 src/java/.gitignore          |    2 +-
 src/java/Makefile.am         |    8 ++++----
 src/java/README              |    2 +-
 src/java/build.xml           |    6 +++---
 10 files changed, 22 insertions(+), 14 deletions(-)
 create mode 100644 debian/libceph-java.jlibs
 create mode 100644 debian/libceph-jni.install
 delete mode 100644 debian/libceph1-java.install

diff --git a/debian/.gitignore b/debian/.gitignore
index c5b73ce..2fd5a05 100644
--- a/debian/.gitignore
+++ b/debian/.gitignore
@@ -30,5 +30,6 @@
 /rest-bench-dbg
 /rest-bench
 /python-ceph
-/libceph1-java
+/libceph-java
+/libceph-jni
 /tmp
diff --git a/debian/control b/debian/control
index 579855f..62c85d9 100644
--- a/debian/control
+++ b/debian/control
@@ -319,8 +319,14 @@ Description: Python libraries for the Ceph distributed filesystem
  This package contains Python libraries for interacting with Ceph's
  RADOS object storage, and RBD (RADOS block device).
 
-Package: libceph1-java
+Package: libceph-java
 Section: java
+Architecture: all
+Depends: libceph-jni, ${java:Depends}, ${misc:Depends}
+Description: Java libraries for the Ceph File System.
+
+Package: libceph-jni
 Architecture: linux-any
+Section: libs
 Depends: libcephfs1, ${shlibs:Depends}, ${java:Depends}, ${misc:Depends}
-Description: Java libraries for the Ceph File System
+Description: Java Native Interface library for CephFS Java bindings.
diff --git a/debian/libceph-java.jlibs b/debian/libceph-java.jlibs
new file mode 100644
index 0000000..952a190
--- /dev/null
+++ b/debian/libceph-java.jlibs
@@ -0,0 +1 @@
+src/java/ceph.jar
diff --git a/debian/libceph-jni.install b/debian/libceph-jni.install
new file mode 100644
index 0000000..072b990
--- /dev/null
+++ b/debian/libceph-jni.install
@@ -0,0 +1 @@
+usr/lib/libcephfs_jni.so* usr/lib/jni
diff --git a/debian/libceph1-java.install b/debian/libceph1-java.install
deleted file mode 100644
index 98133e4..0000000
--- a/debian/libceph1-java.install
+++ /dev/null
@@ -1,2 +0,0 @@
-usr/lib/libcephfs_jni.so* usr/lib/jni
-usr/lib/libcephfs.jar usr/share/java
diff --git a/debian/rules b/debian/rules
index b848ddc..6d61385 100755
--- a/debian/rules
+++ b/debian/rules
@@ -93,6 +93,7 @@ install: build
 # Add here commands to install the package into debian/testpack.
 # Build architecture-independent files here.
 binary-indep: build install
+	jh_installlibs -v -i
 
 # We have nothing to do by default.
 # Build architecture-dependent files here.
diff --git a/src/java/.gitignore b/src/java/.gitignore
index 8208e2b..b8eb0e9 100644
--- a/src/java/.gitignore
+++ b/src/java/.gitignore
@@ -1,4 +1,4 @@
 *.class
-libcephfs.jar
+ceph.jar
 native/com_ceph_fs_CephMount.h
 TEST-*.txt
diff --git a/src/java/Makefile.am b/src/java/Makefile.am
index 5c54f36..87d763d 100644
--- a/src/java/Makefile.am
+++ b/src/java/Makefile.am
@@ -24,20 +24,20 @@ CEPH_PROXY=java/com/ceph/fs/CephMount.class
 
 $(CEPH_PROXY): $(JAVA_SRC)
 	export CLASSPATH=java/ ;
-	$(JAVAC) java/com/ceph/fs/*.java
+	$(JAVAC) -source 1.5 -target 1.5 java/com/ceph/fs/*.java
 
 $(JAVA_H): $(CEPH_PROXY)
 	export CLASSPATH=java/ ; \
 	$(JAVAH) -jni -o $@ com.ceph.fs.CephMount
 
-libcephfs.jar: $(CEPH_PROXY)
+ceph.jar: $(CEPH_PROXY)
 	$(JAR) cf $@ $(JAVA_CLASSES:%=-C java %) # $(ESCAPED_JAVA_CLASSES:%=-C java %)
 
 javadir = $(libdir)
-java_DATA = libcephfs.jar
+java_DATA = ceph.jar
 
 BUILT_SOURCES = $(JAVA_H)
 
-CLEANFILES = -rf java/com/ceph/fs/*.class $(JAVA_H) libcephfs.jar
+CLEANFILES = -rf java/com/ceph/fs/*.class $(JAVA_H) ceph.jar
 
 endif
diff --git a/src/java/README b/src/java/README
index ca39a44..d58ab8a 100644
--- a/src/java/README
+++ b/src/java/README
@@ -33,7 +33,7 @@ Ant is used to run the unit test (apt-get install ant). For example:
 
 1. The tests depend on the compiled wrappers. If the wrappers are installed as
 part of a package (e.g. Debian package) then this should 'just work'. Ant will
-also look in the current directory for 'libcephfs.jar' and in ../.libs for the
+also look in the current directory for 'ceph.jar' and in ../.libs for the
 JNI library.  If all else fails, set the environment variables CEPHFS_JAR, and
 CEPHFS_JNI_LIB accordingly.
 
diff --git a/src/java/build.xml b/src/java/build.xml
index f846ca4..203ffc0 100644
--- a/src/java/build.xml
+++ b/src/java/build.xml
@@ -31,10 +31,10 @@
 
 	<target name="compile-tests" depends="makedir">
         <javac srcdir="${test.src.dir}" destdir="${test.build.dir}"
-            includeantruntime="false">
+            includeantruntime="false" source="1.5" target="1.5">
             <classpath>
 				<pathelement location="${env.CEPHFS_JAR}"/>
-				<pathelement location="libcephfs.jar"/>
+				<pathelement location="ceph.jar"/>
                 <fileset dir="${lib.dir}">
                     <include name="**/*.jar"/>
                 </fileset>
@@ -51,7 +51,7 @@
                     <include name="**/*.jar"/>
                 </fileset>
 				<pathelement location="${env.CEPHFS_JAR}"/>
-				<pathelement location="libcephfs.jar"/>
+				<pathelement location="ceph.jar"/>
                 <pathelement path="${test.build.dir}"/>
                 <pathelement path="${test.src.dir}"/>
             </classpath>
