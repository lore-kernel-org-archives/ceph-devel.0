From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: [PATCH 2/4] hadoop: handle new ceph_get_file_stripe_address
Date: Tue,  8 Nov 2011 18:39:19 -0800
Message-ID: <1320806361-1801-3-git-send-email-jayhawk@cs.ucsc.edu>
References: <1320806361-1801-1-git-send-email-jayhawk@cs.ucsc.edu>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:44376 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274Ab1KIDBB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2011 22:01:01 -0500
Received: from piha.cse.ucsc.edu (piha.soe.ucsc.edu [128.114.52.38])
	by mail-01.cse.ucsc.edu (Postfix) with ESMTPSA id A4599774C009
	for <ceph-devel@vger.kernel.org>; Tue,  8 Nov 2011 18:51:59 -0800 (PST)
In-Reply-To: <1320806361-1801-1-git-send-email-jayhawk@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

From: Noah Watkins <noahwatkins@gmail.com>

Updates the Hadoop JNI/CephFileSystem to handle
the new version of ceph_get_file_stripe_address
which returns the locations of replicas in addition
to the primary.

Signed-off-by: Noah Watkins <noahwatkins@gmail.com>
---
 src/client/hadoop/CephFSInterface.cc       |   74 +++++++++++++++++++++-------
 src/client/hadoop/CephFSInterface.h        |    4 +-
 src/client/hadoop/ceph/CephFS.java         |    4 +-
 src/client/hadoop/ceph/CephFaker.java      |    6 +-
 src/client/hadoop/ceph/CephFileSystem.java |    6 +-
 src/client/hadoop/ceph/CephTalker.java     |    2 +-
 6 files changed, 67 insertions(+), 29 deletions(-)

diff --git a/src/client/hadoop/CephFSInterface.cc b/src/client/hadoop/CephFSInterface.cc
index f8e41c6..4a050f2 100644
--- a/src/client/hadoop/CephFSInterface.cc
+++ b/src/client/hadoop/CephFSInterface.cc
@@ -759,35 +759,73 @@ JNIEXPORT jint JNICALL Java_org_apache_hadoop_fs_ceph_CephTalker_ceph_1replicati
 /*
  * Class:     org_apache_hadoop_fs_ceph_CephTalker
  * Method:    ceph_hosts
- * Signature: (IJ)Ljava/lang/String;
+ * Signature: (IJ)[Ljava/lang/String;
  * Find the IP:port addresses of the primary OSD for a given file and offset.
  * Inputs:
  *  jint j_fh: The filehandle for the file.
  *  jlong j_offset: The offset to get the location of.
  * Returns: a jstring of the location as IP, or NULL if there is an error.
  */
-JNIEXPORT jstring JNICALL Java_org_apache_hadoop_fs_ceph_CephTalker_ceph_1hosts
+JNIEXPORT jobjectArray JNICALL Java_org_apache_hadoop_fs_ceph_CephTalker_ceph_1hosts
 (JNIEnv *env, jobject obj, jint j_fh, jlong j_offset)
 {
-  //get the address
-  const static int IP_ADDR_LENGTH = 24;//a buffer size; may want to up for IPv6.
-  char *address = new char[IP_ADDR_LENGTH];
   struct ceph_mount_info *cmount = get_ceph_mount_t(env, obj);
-  int r = ceph_get_file_stripe_address(cmount, j_fh, j_offset,
-				       address, IP_ADDR_LENGTH);
-  if (r == -ERANGE) {//buffer's too small
-    delete [] address;
-    int size = ceph_get_file_stripe_address(cmount, j_fh, j_offset, address, 0);
-    address = new char[size];
-    r = ceph_get_file_stripe_address(cmount, j_fh, j_offset, address, size);
+  struct sockaddr_storage *ss;
+  char address[30];
+  jobjectArray addr_array;
+  jclass string_cls;
+  jstring j_addr;
+  int r, n = 3; /* initial guess at # of replicas */
+
+  for (;;) {
+    ss = new struct sockaddr_storage[n];
+    r = ceph_get_file_stripe_address(cmount, j_fh, j_offset, ss, n);
+    if (r < 0) {
+      if (r == -ERANGE) {
+	delete [] ss;
+	n *= 2;
+	continue;
+      }
+      return NULL;
+    }
+    n = r;
+    break;
   }
-  if (r != 0) { //some rather worse problem
-    if (r == -EINVAL) return NULL; //ceph thinks there are no OSDs
+
+  /* TODO: cache this */
+  string_cls = env->FindClass("java/lang/String");
+  if (!string_cls)
+    goto out;
+
+  addr_array = env->NewObjectArray(n, string_cls, NULL);
+  if (!addr_array)
+    goto out;
+
+  for (r = 0; r < n; r++) {
+    /* Hadoop only deals with IPv4 */
+    if (ss[r].ss_family != AF_INET)
+      goto out;
+
+    memset(address, 0, sizeof(address));
+
+    inet_ntop(ss[r].ss_family, &((struct sockaddr_in *)&ss[r])->sin_addr,
+	      address, sizeof(address));
+
+    j_addr = env->NewStringUTF(address);
+
+    env->SetObjectArrayElement(addr_array, r, j_addr);
+    if (env->ExceptionOccurred())
+      goto out;
+
+    env->DeleteLocalRef(j_addr);
   }
-  //make java String of address
-  jstring j_addr = env->NewStringUTF(address);
-  delete [] address;
-  return j_addr;
+
+  delete [] ss;
+  return addr_array;
+
+out:
+  delete [] ss;
+  return NULL;
 }
 
 /*
diff --git a/src/client/hadoop/CephFSInterface.h b/src/client/hadoop/CephFSInterface.h
index 0db9343..6939b3a 100644
--- a/src/client/hadoop/CephFSInterface.h
+++ b/src/client/hadoop/CephFSInterface.h
@@ -185,9 +185,9 @@ JNIEXPORT jint JNICALL Java_org_apache_hadoop_fs_ceph_CephTalker_ceph_1replicati
 /*
  * Class:     org_apache_hadoop_fs_ceph_CephTalker
  * Method:    ceph_hosts
- * Signature: (IJ)Ljava/lang/String;
+ * Signature: (IJ)[Ljava/lang/String;
  */
-JNIEXPORT jstring JNICALL Java_org_apache_hadoop_fs_ceph_CephTalker_ceph_1hosts
+JNIEXPORT jobjectArray JNICALL Java_org_apache_hadoop_fs_ceph_CephTalker_ceph_1hosts
   (JNIEnv *, jobject, jint, jlong);
 
 /*
diff --git a/src/client/hadoop/ceph/CephFS.java b/src/client/hadoop/ceph/CephFS.java
index cf39b5a..5d51eb2 100644
--- a/src/client/hadoop/ceph/CephFS.java
+++ b/src/client/hadoop/ceph/CephFS.java
@@ -193,9 +193,9 @@ abstract class CephFS {
    * Inputs:
    *  int fh: The filehandle for the file.
    *  long offset: The offset to get the location of.
-   * Returns: a String of the location as IP, or NULL if there is an error.
+   * Returns: an array of String of the location as IP, or NULL if there is an error.
    */
-  abstract protected String ceph_hosts(int fh, long offset);
+  abstract protected String[] ceph_hosts(int fh, long offset);
 
   /*
    * Set the mtime and atime for a given path.
diff --git a/src/client/hadoop/ceph/CephFaker.java b/src/client/hadoop/ceph/CephFaker.java
index 71ad206..c598f53 100644
--- a/src/client/hadoop/ceph/CephFaker.java
+++ b/src/client/hadoop/ceph/CephFaker.java
@@ -348,15 +348,15 @@ class CephFaker extends CephFS {
     return ret;
   }
 
-  protected String ceph_hosts(int fh, long offset) {
-    String ret = null;
+  protected String[] ceph_hosts(int fh, long offset) {
+    String[] ret = null;
 
     try {
       BlockLocation[] locs = localFS.getFileBlockLocations(
           localFS.getFileStatus(new Path(filenames.get(new Integer(fh)))),
           offset, 1);
 
-      ret = locs[0].getNames()[0];
+      ret = locs[0].getNames();
     } catch (IOException e) {} catch (NullPointerException f) {}
     return ret;
   }
diff --git a/src/client/hadoop/ceph/CephFileSystem.java b/src/client/hadoop/ceph/CephFileSystem.java
index 3f5b0f8..6889b02 100644
--- a/src/client/hadoop/ceph/CephFileSystem.java
+++ b/src/client/hadoop/ceph/CephFileSystem.java
@@ -626,14 +626,14 @@ public class CephFileSystem extends FileSystem {
       LOG.trace(
           "getFileBlockLocations:call ceph_hosts from Java on fh " + fh
           + " and offset " + offset);
-      String host = ceph.ceph_hosts(fh, offset);
+      String host[] = ceph.ceph_hosts(fh, offset);
 
       LOG.trace(
           "getFileBlockLocations:return from ceph_hosts to Java with host "
-              + host);
+              + host[0]);
       String[] hostArray = new String[1];
 
-      hostArray[0] = host;
+      hostArray[0] = host[0];
       locations[i] = new BlockLocation(hostArray, hostArray,
           start + i * blockSize - (start % blockSize), blockSize);
     }
diff --git a/src/client/hadoop/ceph/CephTalker.java b/src/client/hadoop/ceph/CephTalker.java
index 9809bd8..569652f 100644
--- a/src/client/hadoop/ceph/CephTalker.java
+++ b/src/client/hadoop/ceph/CephTalker.java
@@ -77,7 +77,7 @@ class CephTalker extends CephFS {
 
   protected native int ceph_replication(String Path);
 
-  protected native String ceph_hosts(int fh, long offset);
+  protected native String[] ceph_hosts(int fh, long offset);
 
   protected native int ceph_setTimes(String path, long mtime, long atime);
 
-- 
1.7.1

