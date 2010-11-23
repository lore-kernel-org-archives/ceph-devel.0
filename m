From: =?utf-8?Q?Alex=E2=80=8E_Nelson?= <ajnelson@cs.ucsc.edu>
Subject: [PATCH] Expose Ceph data location information to Hadoop
Date: Tue, 23 Nov 2010 15:41:29 -0800
Message-ID: <41ABF261-6D76-46A5-95BC-2C5461EDB0DD@cs.ucsc.edu>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from services.cse.ucsc.edu ([128.114.48.10]:40458 "EHLO
	services.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199Ab0KWXl3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Nov 2010 18:41:29 -0500
Received: from [192.168.50.242] (soenat3.cse.ucsc.edu [128.114.60.41])
	(authenticated bits=0)
	by services.cse.ucsc.edu (8.13.6/8.13.6) with ESMTP id oANNfTuZ001016
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <ceph-devel@vger.kernel.org>; Tue, 23 Nov 2010 15:41:29 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello all,

This patch is not a part of the Ceph code base, but is instead a part of HADOOP-6779 [1], which aims to bring Ceph to Hadoop as an underlying file system instead of HDFS.  I was part of the group that wrote the USENIX ;login: article comparing Ceph and HDFS, to which I will refer those wanting a comparison of the file systems [2].

In a nutshell, this is the purpose of the patch:  Help Hadoop move the computation to the data, without incurring metadata traffic, and reducing data traffic from misplaced jobs.  Hadoop exposes an interface called RawLocalFileSystem, which uses any directory on the local Hadoop node for storage.  Ceph can easily act as a raw local file system, but if it does so Hadoop has no idea on which nodes data reside.  This patch produces a new file system that is basically RawLocalFileSystem with GetFileBlockLocations() implemented as a native method.  The method must be in JNI because Java explicitly does not support ioctl calls, and the data locations are retrieved solely through Ceph's ioctls designed to report data locations.

I'm providing this patch here because it won't yet pass Hadoop submission guidelines, but it should get into the hands of the Hadoop community, eventually officially.  These issues will have to be resolved before the JIRA [1] process can finish:

* Test suite:  From my own setups, I have not gotten Hadoop to pass the unit test suite, even unpatched.  Patched, and running  "ant -Dtest.build.data=/mnt/ceph test-core" has yet to finish successfully for me.
* I am uncertain what the Hadoop ramifications are of modifying a unit test---that is, whether that should be broken out into its own patch.
* For those concerned with debugging, I have some debug print statements commented out with "//debug//".  Obviously, those won't be going into Hadoop, but they can illustrate what's going on in some places if you find a weird corner case.
* The JNI code probably leaks memory.  This was my first experience writing JNI, so that code needs to undergo review by someone more experienced with native C++ for JNI.
* The code was developed against release-0.20.2, which is slightly out of date.  This happened to be the Hadoop version for which we had a working installation.  The code should change to trunk, but only after it's better evaluated on a stable build.
* Less interesting:  I am inexperienced with automake, and was unable to integrate the native code into the ant and automake build process. Assistance on that would be greatly appreciated (even an email to a good reference article).  Until that is fixed, there are explicit instructions to compile the native component in the file README-HADOOP-6779.txt.

The patch git-applies to release-0.20.2.  I hope this gets the Hadoop and Ceph communities talking more.  I think the two projects have a lot they can do for each other.

--Alex

[1] https://issues.apache.org/jira/browse/HADOOP-6779
[2] http://www.usenix.org/publications/login/2010-08/openpdfs/maltzahn.pdf


diff --git a/.gitignore b/.gitignore
index cecce34..330514f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -18,6 +18,8 @@
.project
.settings
.svn
+.idea
+*.iml
build/
conf/masters
conf/slaves
diff --git a/README-HADOOP-6779.txt b/README-HADOOP-6779.txt
new file mode 100644
index 0000000..65cbf66
--- /dev/null
+++ b/README-HADOOP-6779.txt
@@ -0,0 +1,46 @@
+= HADOOP-6779 =
+
+This document contains setup instructions for the Ceph Locality patch for Hadoop.  It describes compiling Hadoop and the native methods.
+
+== Environmental setup ==
+
+Must define at least these environment variables:
+HADOOP_HOME
+	Home of the Hadoop source.
+CEPH_HOME
+	$CEPH_HOME/src is the location of client/ioctl.h.
+JAVA_HOME
+	$JAVA_HOME/include or $JAVA_HOME/include/linux has jni.h.
+
+== Prerequisite software ==
+
+Ubuntu 10.10:
+apt-get install ant g++ #Hadoop
+apt-get install automake libtool libboost-dev libedit-dev libssl-dev #Ceph
+
+Fedora Core 14:
+yum install ant ant-junit gcc-c++ #Hadoop
+yum install autoconf automake libtool boost-devel libedit-devel openssl-devel #Ceph
+
+Fedora Core 14 comes with SELinux enabled.  This causes things like `touch /mnt/ceph/foo` to fail, so disabling SELinux could help.
+
+
+== Compiling ==
+
+To compile the JNI CPP code manually, first do the Ant build in Hadoop for the "jar" target:
+
+ant jar
+
+Then run these commands:
+
+cd $HADOOP_HOME/build/classes
+javah -jni org.apache.hadoop.fs.CephLocalityFileSystem
+cd $HADOOP_HOME/src/native/src/org/apache/hadoop/fs && g++ -shared -fPIC CephLocalityFileSystem.cpp -o libCephLocalityFileSystem.so -iquote$HADOOP_HOME/build/classes -iquote$CEPH_HOME/src -I$JAVA_HOME/include -I$JAVA_HOME/include/linux && cd $HADOOP_HOME
+
+
+== Testing ==
+
+To employ Ceph in the unit test suite, set up the Ceph system (assuming mounting at /mnt/ceph), and then run:
+ant -Dtest.build.data=/mnt/ceph/TestGetFileBlockLocations test-core
+
+The additional flag "-Dtestcase=TestGetFileBlockLocations" runs just the unit test modified for this patch.
\ No newline at end of file
diff --git a/bin/hadoop b/bin/hadoop
index 273549f..c1e8f02 100755
--- a/bin/hadoop
+++ b/bin/hadoop
@@ -253,14 +253,19 @@ if $cygwin; then
TOOL_PATH=`cygpath -p -w "$TOOL_PATH"`
fi
# setup 'java.library.path' for native-hadoop code if necessary
+#TODO Once ant compiles CephLocalityFileSystem properly, remove the third clause in this.
JAVA_LIBRARY_PATH=''
-if [ -d "${HADOOP_HOME}/build/native" -o -d "${HADOOP_HOME}/lib/native" ]; then
+if [ -d "${HADOOP_HOME}/build/native" -o -d "${HADOOP_HOME}/lib/native" -o -d "$HADOOP_HOME/src/native/src/org/apache/hadoop/fs" ]; then
JAVA_PLATFORM=`CLASSPATH=${CLASSPATH} ${JAVA} -Xmx32m org.apache.hadoop.util.PlatformName | sed -e "s/ /_/g"`
-  
+
if [ -d "$HADOOP_HOME/build/native" ]; then
 JAVA_LIBRARY_PATH=${HADOOP_HOME}/build/native/${JAVA_PLATFORM}/lib
fi
-  
+
+  if [ -d "$HADOOP_HOME/src/native/src/org/apache/hadoop/fs" ]; then
+    JAVA_LIBRARY_PATH=${HADOOP_HOME}/src/native/src/org/apache/hadoop/fs
+  fi
+
if [ -d "${HADOOP_HOME}/lib/native" ]; then
 if [ "x$JAVA_LIBRARY_PATH" != "x" ]; then
   JAVA_LIBRARY_PATH=${JAVA_LIBRARY_PATH}:${HADOOP_HOME}/lib/native/${JAVA_PLATFORM}
diff --git a/build.xml b/build.xml
index 602fcfe..7c34f41 100644
--- a/build.xml
+++ b/build.xml
@@ -455,6 +455,7 @@
	
 <mkdir dir="${build.native}/lib"/>
 <mkdir dir="${build.native}/src/org/apache/hadoop/io/compress/zlib"/>
+    <mkdir dir="${build.native}/src/org/apache/hadoop/fs"/>

	<javah
	  classpath="${build.classes}"
@@ -466,6 +467,15 @@
   <class name="org.apache.hadoop.io.compress.zlib.ZlibDecompressor" />
	</javah>

+    <javah
+      classpath="${build.classes}"
+      destdir="${build.native}/src/org/apache/hadoop/fs"
+      force="yes"
+      verbose="yes"
+      >
+      <class name="org.apache.hadoop.fs.CephLocalityFileSystem" />
+    </javah>
+
	<exec dir="${build.native}" executable="sh" failonerror="true">
	  <env key="OS_NAME" value="${os.name}"/>
	  <env key="OS_ARCH" value="${os.arch}"/>
@@ -727,7 +737,7 @@
   <sysproperty key="test.build.extraconf" value="${test.build.extraconf}" />
   <sysproperty key="hadoop.policy.file" value="hadoop-policy.xml"/>
   <sysproperty key="java.library.path"
-       value="${build.native}/lib:${lib.dir}/native/${build.platform}"/>
+       value="${build.native}/lib:${lib.dir}/native/${build.platform}:${basedir}/src/native/src/org/apache/hadoop/fs"/>
   <sysproperty key="install.c++.examples" value="${install.c++.examples}"/>
   <!-- set io.compression.codec.lzo.class in the child jvm only if it is set -->
	  <syspropertyset dynamic="no">
diff --git a/src/core/core-default.xml b/src/core/core-default.xml
index a26e733..9a055df 100644
--- a/src/core/core-default.xml
+++ b/src/core/core-default.xml
@@ -113,10 +113,17 @@
<property>
<name>fs.file.impl</name>
<value>org.apache.hadoop.fs.LocalFileSystem</value>
+  <!--<value>org.apache.hadoop.fs.CephLocalityFileSystem</value>-->
<description>The FileSystem for file: uris.</description>
</property>

<property>
+  <name>fs.cephk.impl</name>
+  <value>org.apache.hadoop.fs.CephLocalityFileSystem</value>
+  <description>The FileSystem for cephk: uris, which should be the Ceph client's mount point.  (cephk used to distinguish from HADOOP-6253 Ceph userspace shim.)</description>
+</property>
+
+<property>
<name>fs.hdfs.impl</name>
<value>org.apache.hadoop.hdfs.DistributedFileSystem</value>
<description>The FileSystem for hdfs: uris.</description>
diff --git a/src/core/org/apache/hadoop/fs/CephLocalityFileSystem.java b/src/core/org/apache/hadoop/fs/CephLocalityFileSystem.java
new file mode 100644
index 0000000..11ef6d2
--- /dev/null
+++ b/src/core/org/apache/hadoop/fs/CephLocalityFileSystem.java
@@ -0,0 +1,149 @@
+/**
+ * Licensed to the Apache Software Foundation (ASF) under one
+ * or more contributor license agreements.  See the NOTICE file
+ * distributed with this work for additional information
+ * regarding copyright ownership.  The ASF licenses this file
+ * to you under the Apache License, Version 2.0 (the
+ * "License"); you may not use this file except in compliance
+ * with the License.  You may obtain a copy of the License at
+ *
+ *     http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ */
+
+package org.apache.hadoop.fs;
+
+import java.io.*;
+import java.net.URI;
+import java.nio.ByteBuffer;
+import java.nio.channels.FileLock;
+import java.util.*;
+
+import org.apache.hadoop.conf.Configuration;
+import org.apache.hadoop.fs.permission.*;
+import org.apache.hadoop.util.Progressable;
+import org.apache.hadoop.util.StringUtils;
+import org.apache.hadoop.util.Shell;
+
+/****************************************************************
+ * Extend the RawFileSystem API for the Ceph filesystem.
+ *
+ * Presently, deployment must include manually-compiled C++ classes.
+ * Please see $HADOOP_HOME/README-HADOOP-6779.txt.
+ *
+ *****************************************************************/
+public class CephLocalityFileSystem extends RawLocalFileSystem {
+  /**
+   * Inherited from HADOOP-6253's CephFileSystem.java.
+   */
+  private boolean initialized = false;
+
+  /**
+   * Inherited from HADOOP-6253's CephFileSystem.java.
+   * //TODO Determine if it's possible to set the authority on this uri; there's no setter field.
+   */
+  private URI uri;
+
+  /**
+   * Inherited from RawLocalFileSystem.java.
+   */
+  static final URI NAME = URI.create("cephk:///");
+
+  public CephLocalityFileSystem() {
+    super();
+
+    //Debug
+    //System.out.println(String.format("CephLocalityFileSystem() called."));
+    //System.out.println("System.getProperty(\"user.dir\"):\t" + System.getProperty("user.dir"));
+    //System.out.println("new Path(System.getProperty(\"user.dir\")).makeQualified(this):\t" + (new Path(System.getProperty("user.dir")).makeQualified(this)));
+
+    //TODO Maybe we want to tweak the workingDir?
+    //this.workingDir =  new Path("file:///mnt/ceph");
+
+    //Debug
+    //System.out.println(String.format("CephLocalityFileSystem() finished."));
+  }
+
+  /**
+   * The default constructor for RawLocalFileSystem
+   * takes environment's cwd and makes that this file system's starting
+   * point.  With this constructor, specify your own starting point.
+   *
+   * @param startDir
+   */
+  public CephLocalityFileSystem(Path startDir) {
+    //Debug
+    //System.out.println(String.format("CephLocalityFileSystem(%s) called.", startDir.toString()));
+
+    this.workingDir = startDir;
+
+    //Debug
+    //System.out.println(String.format("CephLocalityFileSystem(%s) finished.", startDir.toString()));
+  }
+
+  /**
+   * Return an array containing hostnames, offset and size of
+   * portions of the given file.  For a nonexistent
+   * file or regions, null will be returned.
+   *
+   * For the Ceph file system, this employs ioctl() calls through JNI.
+   * The ioctl() data structures are not returned directly to Java space
+   * because running ioctl() requires an open file handle.  We operate
+   * the file handle logistics in local code for now; an alternative
+   * is to use a JNI call to open the file handle and another call to
+   * destroy it.
+   */
+  public native BlockLocation[] getFileBlockLocations(FileStatus file, long start, long len) throws IOException;
+
+  /**
+   * Convenience method for JNI, to save a few crossings between the
+   * C++/Java boundary.
+   *
+   * @param fs
+   * @return Returns the string of the path in fs.
+   */
+  public String getPathStringFromFileStatus(FileStatus fs) {
+    return fs.getPath().toUri().getRawPath();
+  }
+
+  //TODO Ceph exposes file block size through an ioctl.  getBlockSize is deprecated; overwrite getFileStatus() instead.
+
+  /**
+   * Code inherited and evolved from HADOOP-6253's CephFileSystem.java class.
+   * Probably doesn't need to bother with this.initialized member variable; 6253 used that for starting up Ceph.
+   */
+  @Override
+  public void initialize(URI uri, Configuration conf) throws IOException{
+    //Debug
+    //System.out.println("CephLocalityFileSystem.initialize() called.");
+    if (!this.initialized) {
+      super.initialize(uri, conf);
+      setConf(conf);
+      this.uri=uri;  //Note:  This is not set in the superclasses, must be set here.
+      //Debug
+      //System.out.println("uri:\t"+uri);
+      //System.out.println("uri.getScheme():\t"+uri.getScheme());
+      //System.out.println("uri.getAuthority():\t"+uri.getAuthority());
+      //System.out.println("this.uri:\t"+this.uri);
+      //System.out.println("this.uri.getAuthority():\t"+this.uri.getAuthority());
+      //System.out.println("Working directory:\t" + this.workingDir);
+      this.initialized = true;
+    }
+    //Debug
+    //System.out.println("CephLocalityFileSystem.initialize() finished.");
+  }
+
+  /**
+   * Overrides RawLocalFileSystem's "file:///".
+   */
+  public URI getUri() {
+    return NAME;
+  }
+
+  static{ System.loadLibrary("CephLocalityFileSystem"); }
+}
diff --git a/src/core/org/apache/hadoop/fs/FileStatus.java b/src/core/org/apache/hadoop/fs/FileStatus.java
index 1249846..e663514 100644
--- a/src/core/org/apache/hadoop/fs/FileStatus.java
+++ b/src/core/org/apache/hadoop/fs/FileStatus.java
@@ -249,4 +249,32 @@ public class FileStatus implements Writable, Comparable {
public int hashCode() {
 return getPath().hashCode();
}
+
+  public String report() {
+    StringBuilder result = new StringBuilder();
+    result.append("Status of " + path + ":\n");
+
+    result.append("\tlength\t\t");
+    result.append(length);
+    result.append("\n");
+
+    result.append("\tblocksize\t\t");
+    result.append(blocksize);
+    result.append("\n");
+
+    result.append("\tblock_replication\t");
+    result.append(block_replication);
+    result.append("\n");
+
+    return result.toString();
+    /*
+  private boolean isdir;
+  private long modification_time;
+  private long access_time;
+  private FsPermission permission;
+  private String owner;
+  private String group;
+
+     */
+  }
}
diff --git a/src/core/org/apache/hadoop/fs/FileSystem.java b/src/core/org/apache/hadoop/fs/FileSystem.java
index 304c136..4474051 100644
--- a/src/core/org/apache/hadoop/fs/FileSystem.java
+++ b/src/core/org/apache/hadoop/fs/FileSystem.java
@@ -1370,10 +1370,15 @@ public abstract class FileSystem extends Configured implements Closeable {

private static FileSystem createFileSystem(URI uri, Configuration conf
   ) throws IOException {
+    //Debug:  Report the class of the file system
+    //LOG.info("java.library.path:\t" + System.getProperty("java.library.path") + "\n");
+    //LOG.info("uri:\t" + uri + "\n");
+    //LOG.info("uri.getScheme():\t" + uri.getScheme() + "\n");
 Class<?> clazz = conf.getClass("fs." + uri.getScheme() + ".impl", null);
 if (clazz == null) {
   throw new IOException("No FileSystem for scheme: " + uri.getScheme());
 }
+    //LOG.info("clazz.toString():\t" + clazz.toString() + "\n");
 FileSystem fs = (FileSystem)ReflectionUtils.newInstance(clazz, conf);
 fs.initialize(uri, conf);
 return fs;
diff --git a/src/core/org/apache/hadoop/fs/RawLocalFileSystem.java b/src/core/org/apache/hadoop/fs/RawLocalFileSystem.java
index 8d439f9..5a4b65b 100644
--- a/src/core/org/apache/hadoop/fs/RawLocalFileSystem.java
+++ b/src/core/org/apache/hadoop/fs/RawLocalFileSystem.java
@@ -36,7 +36,7 @@ import org.apache.hadoop.util.Shell;
*****************************************************************/
public class RawLocalFileSystem extends FileSystem {
static final URI NAME = URI.create("file:///");
-  private Path workingDir;
+  protected Path workingDir;

public RawLocalFileSystem() {
 workingDir = new Path(System.getProperty("user.dir")).makeQualified(this);
@@ -474,7 +474,7 @@ public class RawLocalFileSystem extends FileSystem {
     String.format("%04o", permission.toShort()));
}

-  private static String execCommand(File f, String... cmd) throws IOException {
+  protected static String execCommand(File f, String... cmd) throws IOException {
 String[] args = new String[cmd.length + 1];
 System.arraycopy(cmd, 0, args, 0, cmd.length);
 args[cmd.length] = f.getCanonicalPath();
diff --git a/src/mapred/org/apache/hadoop/mapred/JobTracker.java b/src/mapred/org/apache/hadoop/mapred/JobTracker.java
index a8e86f9..1e91497 100644
--- a/src/mapred/org/apache/hadoop/mapred/JobTracker.java
+++ b/src/mapred/org/apache/hadoop/mapred/JobTracker.java
@@ -3465,7 +3465,9 @@ public class JobTracker implements MRConstants, InterTrackerProtocol,
* @see org.apache.hadoop.mapred.JobSubmissionProtocol#getSystemDir()
*/
public String getSystemDir() {
-    Path sysDir = new Path(conf.get("mapred.system.dir", "/tmp/hadoop/mapred/system"));  
+    String mapredsystemdir = conf.get("mapred.system.dir", "/tmp/hadoop/mapred/system");
+    LOG.info("mapred.system.dir configuration: " + mapredsystemdir);
+    Path sysDir = new Path(mapredsystemdir);
 return fs.makeQualified(sysDir).toString();
}

diff --git a/src/native/Makefile.am b/src/native/Makefile.am
index 3d44cbc..108775e 100644
--- a/src/native/Makefile.am
+++ b/src/native/Makefile.am
@@ -36,7 +36,7 @@
export PLATFORM = $(shell echo $$OS_NAME | tr [A-Z] [a-z])

# List the sub-directories here
-SUBDIRS = src/org/apache/hadoop/io/compress/zlib lib
+SUBDIRS = src/org/apache/hadoop/io/compress/zlib src/org/apache/hadoop/fs lib

# The following export is needed to build libhadoop.so in the 'lib' directory
export SUBDIRS
diff --git a/src/native/src/org/apache/hadoop/fs/CephLocalityFileSystem.cpp b/src/native/src/org/apache/hadoop/fs/CephLocalityFileSystem.cpp
new file mode 100644
index 0000000..5183314
--- /dev/null
+++ b/src/native/src/org/apache/hadoop/fs/CephLocalityFileSystem.cpp
@@ -0,0 +1,344 @@
+/**
+This file's main function was originally in
+$CEPH_HOME/src/client/test_ioctls.c .
+
+In the present form, it converts ceph_ioctl_dataloc to BlockLocations.
+
+BlockLocations require:
+String[] names, String[] hosts, long offset, long length
+
+The ceph_ioctl_dataloc supplies:
+struct ceph_ioctl_dataloc {
+	__u64 file_offset;           // in+out: file offset
+	__u64 object_offset;         // out: offset in object
+	__u64 object_no;             // out: object #
+	__u64 object_size;           // out: object size
+	char object_name[64];        // out: object name
+	__u64 block_offset;          // out: offset in block
+	__u64 block_size;            // out: block length
+	__s64 osd;                   // out: osd #
+	struct sockaddr_storage osd_addr; // out: osd address
+};
+
+
+The required items and the supplied items line up like so:
+String[] names     dataloc.osd_addr
+String[] hosts     dataloc.osd_addr
+long offset        start
+long length        len
+*/
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+#include <sys/ioctl.h>
+#include <netinet/in.h>
+#include <sys/socket.h>
+#include <netdb.h>
+
+#include <string.h>  //memset
+
+#include <errno.h>
+
+#include <time.h>    //Debugging
+#include <iostream>  //Debugging
+#include <fstream>   //Debugging
+using namespace std; //Debugging
+
+//JNI include
+#include "org_apache_hadoop_fs_CephLocalityFileSystem.h"
+
+//Ceph includes
+#include "client/ioctl.h"
+
+/**
+ * Arguments:  (FileStatus file, long start, long len)
+  Exemplar code:  Java_org_apache_hadoop_fs_ceph_CephTalker_ceph_1getdir
+  Original Java function body:
+
+  public BlockLocation[] getFileBlockLocations(FileStatus file,
+      long start, long len) throws IOException {
+    if (file == null) {
+      return null;
+    }
+
+    if ( (start<0) || (len < 0) ) {
+      throw new IllegalArgumentException("Invalid start or len parameter");
+    }
+
+    if (file.getLen() < start) {
+      return new BlockLocation[0];
+
+    }
+    String[] name = { "localhost:50010" };
+    String[] host = { "localhost" };
+    return new BlockLocation[] { new BlockLocation(name, host, 0, file.getLen()) };
+  }
+
+   Reference for building new objects:
+   http://java.sun.com/docs/books/jni/html/fldmeth.html#26254
+
+   TODO Clean up memory.  Some reading is here:
+   http://java.sun.com/developer/onlineTraining/Programming/JDCBook/jniref.html
+ */
+JNIEXPORT jobjectArray JNICALL Java_org_apache_hadoop_fs_CephLocalityFileSystem_getFileBlockLocations
+  (JNIEnv *env, jobject obj, jobject j_file, jlong j_start, jlong j_len) {
+
+  ////Variables
+  //Native...
+  //debug//const char *logpath = "/home/alex/TestGetFileBlockLocations.txt";
+  const char *c_path = "";
+  int fd, err;
+  long c_start, c_len;
+  long blocksize, numblocks;
+  struct ceph_ioctl_layout ceph_layout;
+  struct ceph_ioctl_dataloc dl;
+  char errdesc[256];
+
+  //Java...
+  jmethodID constrid;              //This can probably be cached ( http://www.ibm.com/developerworks/java/library/j-jni/ )
+  jmethodID filelenid;
+  jmethodID methodid_getPathStringFromFileStatus;
+  jfieldID pathfieldid;
+  jclass BlockLocationClass, StringClass, FileStatusClass, CephLocalityFileSystemClass;
+  jobjectArray aryBlockLocations;  //Returning item
+  jstring j_path;
+  jlong fileLength;
+  jclass IllegalArgumentExceptionClass, IOExceptionClass, OutOfMemoryErrorClass;
+
+
+  ////Debugging
+  //Setup
+  time_t rawtime;
+  time(&rawtime);
+  struct tm *timeinfo = localtime(&rawtime);
+  //debug//ofstream debugstream(logpath, ios_base::app);
+  //debug//debugstream << "Starting.  Current time:  " << asctime(timeinfo) << "." << endl;
+  //debug//debugstream << "Arguments:  <j_file>, " << j_start << ", " << j_len << endl;
+  memset(errdesc, NULL, 256);
+
+
+  ////Grab the exception classes for all the little things that can go wrong.
+  IllegalArgumentExceptionClass = env->FindClass("java/lang/IllegalArgumentException");
+  IOExceptionClass = env->FindClass("java/io/IOException");
+  OutOfMemoryErrorClass = env->FindClass("java/lang/OutOfMemoryError");
+  if (IllegalArgumentExceptionClass == NULL || IOExceptionClass == NULL || OutOfMemoryErrorClass == NULL) {
+    //debug//debugstream << "Failed to get an exception to throw.  Giving up." << endl;
+    return NULL;
+  }
+
+
+  ////Sanity-check arguments (one more check comes after class declarations)
+  if (j_file == NULL) {
+    return NULL;
+  }
+
+
+  if (j_start < 0) {
+    env->ThrowNew(IllegalArgumentExceptionClass, "Invalid start parameter (negative).");
+    return NULL;
+  }
+  if (j_len <= 0) {
+    env->ThrowNew(IllegalArgumentExceptionClass, "Invalid len parameter (nonpositive).");
+    return NULL;
+  }
+
+
+  ////Grab the reference to the Java classes needed to set up end structure
+  StringClass = env->FindClass("java/lang/String");
+  if (StringClass == NULL) {
+    env->ThrowNew(IOExceptionClass, "Java String class not found; dying a horrible, painful death.");
+    return NULL;
+  }
+  BlockLocationClass = env->FindClass("org/apache/hadoop/fs/BlockLocation");
+  if (BlockLocationClass == NULL) {
+    env->ThrowNew(IOExceptionClass, "Hadoop BlockLocation class not found.");
+    return NULL;
+  }
+  FileStatusClass = env->GetObjectClass(j_file);
+  if (FileStatusClass == NULL) {
+    env->ThrowNew(IOExceptionClass, "Hadoop FileStatus class not found.");
+    return NULL;
+  }
+  CephLocalityFileSystemClass = env->GetObjectClass(obj);
+  if (CephLocalityFileSystemClass == NULL) {
+    env->ThrowNew(IOExceptionClass, "Hadoop CephLocalityFileSystemClass class not found.");
+    return NULL;
+  }
+
+  //debug//debugstream << "Classes retrieved." << endl;
+
+
+  ////Grab class methods and members
+  //(Type syntax reference: http://java.sun.com/javase/6/docs/technotes/guides/jni/spec/types.html#wp16432 )
+
+  //Grab the file length method
+  filelenid = env->GetMethodID(FileStatusClass, "getLen", "()J");
+  if (filelenid == NULL) {
+    env->ThrowNew(IOExceptionClass, "Could not get filelenid.");
+    return NULL;
+  }
+  //debug//debugstream << "filelenid retrieval complete." << endl;
+
+  //Grab the BlockLocation constructor
+  constrid = env->GetMethodID(BlockLocationClass, "<init>", "([Ljava/lang/String;[Ljava/lang/String;JJ)V");
+  if (constrid == NULL) {
+    env->ThrowNew(IOExceptionClass, "Could not get constructor id for BlockLocationClass.");
+    return NULL;
+  }
+  //debug//debugstream << "constrid retrieval complete." << endl;
+
+  //Grab the helper method for quick path conversion
+  methodid_getPathStringFromFileStatus = env->GetMethodID(CephLocalityFileSystemClass, "getPathStringFromFileStatus", "(Lorg/apache/hadoop/fs/FileStatus;)Ljava/lang/String;");
+  if (methodid_getPathStringFromFileStatus == NULL) {
+    env->ThrowNew(IOExceptionClass, "ERROR:  Could not get methodid_getPathStringFromFileStatus.");
+    return NULL;
+  }
+  //debug//debugstream << "methodid_getPathStringFromFileStatus retrieval complete." << endl;
+
+
+  ////Calling methods
+  //Grab the file length
+  fileLength = env->CallLongMethod(j_file, filelenid);
+  //debug//debugstream << "Called fileLen()." << endl;
+  //One last sanity check
+  if (fileLength < j_start) {
+    //debug//debugstream << "Starting point after end of file; returning 0 block locations." << endl;
+    aryBlockLocations = env->NewObjectArray(0, BlockLocationClass, NULL);
+    if (aryBlockLocations == NULL) {
+      env->ThrowNew(OutOfMemoryErrorClass,"Unable to allocate 0-length BlockLocation array.");
+      return NULL;
+    }
+    return aryBlockLocations;
+  }
+  //debug//debugstream << "File length according to FileStatus:  " << fileLength << endl;
+
+  //Grab the file name
+  j_path = (jstring) env->CallObjectMethod(obj, methodid_getPathStringFromFileStatus, j_file);
+  if (j_path == NULL) {
+    env->ThrowNew(IOExceptionClass, "j_path retrieval failed.");
+    return NULL;
+  }
+  //debug//debugstream << "j_path retrieval complete." << endl;
+
+  c_path = env->GetStringUTFChars(j_path, NULL);
+  if (c_path == NULL) {
+    env->ThrowNew(IOExceptionClass, "c_path is NULL.");
+    return NULL;
+  }
+  //debug//debugstream << "c_path path is " << c_path << endl;
+
+
+  ////Really-native code:  Start the file I/O.
+  //Open the file (need descriptor for ioctl())
+  fd = open(c_path , O_CREAT|O_RDWR, 0644);  //TODO Not sure why this opens RDRW and CREAT (code copied from Ceph test).  Necessary for ioctl?
+  if (fd <= 0) {
+    env->ThrowNew(IOExceptionClass, "Couldn't open file.");
+    //debug//debugstream << "ERROR:  Couldn't open file.  errno:  " << strerror(errno) << ".  fd:  " << strerror(fd) << endl;  //TODO Clean this up.
+    return NULL;
+  }
+  //debug//debugstream << "File opening complete." << endl;
+  //Cleanup:  Don't need file name characters anymore.
+  env->ReleaseStringUTFChars(j_path, c_path);
+
+  //Get layout
+  err = ioctl(fd, CEPH_IOC_GET_LAYOUT, (unsigned long)&ceph_layout);
+  if (err) {
+    env->ThrowNew(IOExceptionClass, "ioctl failed (layout).");
+    return NULL;
+  }
+  blocksize=ceph_layout.object_size;  //TODO (big) Expose this object size to the Java file system.
+  //debug//debugstream << "Block size is " << blocksize << endl;
+
+  //Determine the number of blocks we're looking for.  (The problem:  How many buckets.  Can't remember if there's a library call to find this quickly...)
+  numblocks = (j_start+j_len-1)/blocksize - j_start/blocksize + 1;
+  //debug//debugstream << "Expecting to work on " << numblocks << " blocks." << endl;
+
+  aryBlockLocations = (jobjectArray) env->NewObjectArray(numblocks, BlockLocationClass, NULL);
+  if (aryBlockLocations == NULL) {
+    env->ThrowNew(OutOfMemoryErrorClass, "Unable to allocate BlockLocation array.");
+    return NULL;
+  }
+
+  //Run an ioctl for each block.
+  //jthrowable exc;
+  char buf[80];
+  jlong blocklength;
+  jlong curoffset;
+  //TODO This loop test will very probably suffer data races with updates to the file.  Oh; is that why ioctl() gets RDRW?
+  jlong loopinit=j_start/blocksize;
+  jlong i=loopinit;
+  for (jlong imax=j_start+j_len; i*blocksize < imax; i++) {
+    //Note <=; we go through the last requested byte.
+    //Set up the data location object
+    curoffset = i*blocksize;
+    dl.file_offset = curoffset;
+    //debug//debugstream << "Running dataloc ioctl loop for dl.file_offset=" << dl.file_offset << " (curoffset=" << curoffset << ")" << endl;
+
+    //Run the ioctl to get block location()
+    err = ioctl(fd, CEPH_IOC_GET_DATALOC, (unsigned long)&dl);
+    if (err) {
+      sprintf(errdesc, "ioctl failed (dataloc); err=%d.", err);
+      env->ThrowNew(IOExceptionClass, errdesc);
+      return NULL;
+    }
+
+    //Create string object.
+    //TODO:  Check if freeing this causes a null pointer exception in Java.
+    //jstring j_tmpname = env->NewStringUTF("localhost:50010");
+    //jstring j_tmphost = env->NewStringUTF("localhost");
+    memset(buf, 0, 80);
+    getnameinfo((struct sockaddr *)&dl.osd_addr, sizeof(dl.osd_addr), buf, sizeof(buf), 0, 0, NI_NUMERICHOST);
+    //debug//debugstream << "Found host " << buf << endl;
+    jstring j_tmphost = env->NewStringUTF(buf);
+    //The names list should include the port number if following the example getFileBlockLocations from FileSystem;
+    //however, as of 0.20.2, nothing invokes BlockLocation.getNames().
+    jstring j_tmpname = env->NewStringUTF(buf);
+    if (j_tmphost == NULL || j_tmpname == NULL) {
+      env->ThrowNew(OutOfMemoryErrorClass, "Unable to convert String for name or host.");
+      return NULL;
+    }
+
+    //Define an array of strings for names, and one for hosts (only going to be one element long for now)
+    jobjectArray aryNames = (jobjectArray) env->NewObjectArray(1, StringClass, NULL);
+    jobjectArray aryHosts = (jobjectArray) env->NewObjectArray(1, StringClass, NULL);
+    if (aryHosts == NULL || aryNames == NULL) {
+      env->ThrowNew(OutOfMemoryErrorClass, "Unable to allocate String array for names or hosts.");
+      return NULL;
+    }
+
+    env->SetObjectArrayElement(aryNames, 0, j_tmpname);
+    ////TODO Hunt for ArrayIndex exceptions
+    //exc = env->ExceptionOccurred();
+    //if (exc) {
+    //  //debug//debugstream << "Exception occurred.";
+    //  return NULL;
+    //}
+    env->SetObjectArrayElement(aryHosts, 0, j_tmphost);
+    ////Probably safe if the above one worked.
+
+
+    //debug//debugstream << "imax:  " << imax << endl;
+    //debug//debugstream << "curoffset:  " << curoffset << endl;
+    //debug//debugstream << "blocksize:  " << blocksize << endl;
+    //debug//debugstream << "imax-curoffset:  " << imax-curoffset << endl;
+    blocklength = (imax-curoffset)<blocksize ? imax-curoffset : blocksize;  //TODO verify boundary condition on < vs. <=
+    //debug//debugstream << "Block length:  " << blocklength << endl;
+    jobject tmpBlockLocation = env->NewObject(BlockLocationClass, constrid, aryNames, aryHosts, curoffset, blocklength);
+    env->SetObjectArrayElement(aryBlockLocations, i-loopinit, tmpBlockLocation);
+    //TODO Hunt for ArrayIndex exceptions
+  }
+  //Reminder:  i will be 1 too large after the loop finishes.  No need to add another 1.
+  //debug//debugstream << "Finished looping over " << (i-loopinit) << " of " << numblocks << " blocks." << endl;
+  //debug//debugstream << "(Makes " << ((i-loopinit)==numblocks ? "" : "no ") << "sense.)" << endl;
+
+  //Cleanup
+  close(fd);
+  //debug//debugstream.close();
+
+  return aryBlockLocations;
+}
diff --git a/src/test/org/apache/hadoop/fs/TestGetFileBlockLocations.java b/src/test/org/apache/hadoop/fs/TestGetFileBlockLocations.java
index c85cc98..aa6a506 100644
--- a/src/test/org/apache/hadoop/fs/TestGetFileBlockLocations.java
+++ b/src/test/org/apache/hadoop/fs/TestGetFileBlockLocations.java
@@ -32,7 +32,7 @@ import org.apache.hadoop.conf.Configuration;
public class TestGetFileBlockLocations extends TestCase {
private static String TEST_ROOT_DIR =
   System.getProperty("test.build.data", "/tmp/testGetFileBlockLocations");
-  private static final int FileLength = 4 * 1024 * 1024; // 4MB
+  private static final int FileLength = 64 * 1024 * 1024; // 64MB
private Configuration conf;
private Path path;
private FileSystem fs;
@@ -47,6 +47,10 @@ public class TestGetFileBlockLocations extends TestCase {
 Path rootPath = new Path(TEST_ROOT_DIR);
 path = new Path(rootPath, "TestGetFileBlockLocations");
 fs = rootPath.getFileSystem(conf);
+    //Debug:  Verify the class of the file system.
+    //System.out.println("TEST_ROOT_DIR:\t" + TEST_ROOT_DIR);
+    //System.out.println("rootPath:\t" + rootPath);
+    //System.out.println("fs.getClass().getName():\t" + fs.getClass().getName());
 FSDataOutputStream fsdos = fs.create(path, true);
 byte[] buffer = new byte[1024];
 while (fsdos.getPos() < FileLength) {
@@ -58,6 +62,7 @@ public class TestGetFileBlockLocations extends TestCase {

private void oneTest(int offBegin, int offEnd, FileStatus status)
   throws IOException {
+    //debug//System.out.println("oneTest(" + offBegin + ", " + offEnd + ") called.");
 if (offBegin > offEnd) {
   int tmp = offBegin;
   offBegin = offEnd;
@@ -65,6 +70,11 @@ public class TestGetFileBlockLocations extends TestCase {
 }
 BlockLocation[] locations =
     fs.getFileBlockLocations(status, offBegin, offEnd - offBegin);
+    if (locations == null) {
+      //debug//System.out.println("Null result.");
+      return;
+    }
+    //debug//System.out.println("oneTest(" + offBegin + ", " + offEnd + ") returns " + locations.length + " locations.");
 if (offBegin < status.getLen()) {
   Arrays.sort(locations, new Comparator<BlockLocation>() {

@@ -84,6 +94,9 @@ public class TestGetFileBlockLocations extends TestCase {
   offEnd = (int) Math.min(offEnd, status.getLen());
   BlockLocation first = locations[0];
   BlockLocation last = locations[locations.length - 1];
+      //debug//for (int i=0, imax=locations.length; i<imax; i++) {
+      //debug//  System.out.println(i + ":\t" + locations[i]);
+      //debug//}
   assertTrue(first.getOffset() <= offBegin);
   assertTrue(offEnd <= last.getOffset() + last.getLength());
 } else {
@@ -101,6 +114,7 @@ public class TestGetFileBlockLocations extends TestCase {

public void testFailureNegativeParameters() throws IOException {
 FileStatus status = fs.getFileStatus(path);
+    //debug//System.out.println(status.report());
 try {
   BlockLocation[] locations = fs.getFileBlockLocations(status, -1, 100);
   fail("Expecting exception being throw");
@@ -117,8 +131,12 @@ public class TestGetFileBlockLocations extends TestCase {
}

public void testGetFileBlockLocations1() throws IOException {
+    //debug//System.out.println("Begin:  testGetFileBlockLocations1");
 FileStatus status = fs.getFileStatus(path);
+    //debug//System.out.println(status.report());
+    oneTest(0, (int) status.getLen()-1, status);
 oneTest(0, (int) status.getLen(), status);
+    oneTest(0, (int) status.getLen()+1, status);
 oneTest(0, (int) status.getLen() * 2, status);
 oneTest((int) status.getLen() * 2, (int) status.getLen() * 4, status);
 oneTest((int) status.getLen() / 2, (int) status.getLen() * 3, status);
@@ -130,6 +148,7 @@ public class TestGetFileBlockLocations extends TestCase {

public void testGetFileBlockLocations2() throws IOException {
 FileStatus status = fs.getFileStatus(path);
+    //debug//System.out.println(status.report());
 for (int i = 0; i < 1000; ++i) {
   int offBegin = random.nextInt((int) (2 * status.getLen()));
   int offEnd = random.nextInt((int) (2 * status.getLen()));
