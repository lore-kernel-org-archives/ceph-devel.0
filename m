From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: [PATCH 3/4] hadoop: return all replica hostnames
Date: Tue,  8 Nov 2011 18:39:20 -0800
Message-ID: <1320806361-1801-4-git-send-email-jayhawk@cs.ucsc.edu>
References: <1320806361-1801-1-git-send-email-jayhawk@cs.ucsc.edu>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:44377 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151Ab1KIDBB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2011 22:01:01 -0500
Received: from piha.cse.ucsc.edu (piha.soe.ucsc.edu [128.114.52.38])
	by mail-01.cse.ucsc.edu (Postfix) with ESMTPSA id A6BC7777C005
	for <ceph-devel@vger.kernel.org>; Tue,  8 Nov 2011 18:51:59 -0800 (PST)
In-Reply-To: <1320806361-1801-1-git-send-email-jayhawk@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

From: Noah Watkins <noahwatkins@gmail.com>

Updates CephFileSystem to return all replica locations,
and in addition attempts to use reverse DNS to convert
the OSD IPs into hostnames. Hadoop does not do well at
comparing the IP with hostnames, and locality is lost.

Signed-off-by: Noah Watkins <noahwatkins@gmail.com>
---
 src/client/hadoop/ceph/CephFileSystem.java |   72 +++++++++++++++-------------
 1 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/src/client/hadoop/ceph/CephFileSystem.java b/src/client/hadoop/ceph/CephFileSystem.java
index 6889b02..00dc64b 100644
--- a/src/client/hadoop/ceph/CephFileSystem.java
+++ b/src/client/hadoop/ceph/CephFileSystem.java
@@ -25,8 +25,10 @@ import java.io.IOException;
 import java.io.FileNotFoundException;
 import java.io.OutputStream;
 import java.net.URI;
+import java.net.InetAddress;
 import java.util.EnumSet;
 import java.lang.Math;
+import java.util.ArrayList;
 
 import org.apache.commons.logging.Log;
 import org.apache.commons.logging.LogFactory;
@@ -41,6 +43,7 @@ import org.apache.hadoop.fs.Path;
 import org.apache.hadoop.fs.permission.FsPermission;
 import org.apache.hadoop.util.Progressable;
 import org.apache.hadoop.fs.FileStatus;
+import org.apache.hadoop.net.DNS;
 
 
 /**
@@ -72,6 +75,10 @@ public class CephFileSystem extends FileSystem {
   private final Path root;
   private CephFS ceph = null;
 
+  private static String CEPH_NAMESERVER;
+  private static final String CEPH_NAMESERVER_KEY = "fs.ceph.nameserver";
+  private static final String CEPH_NAMESERVER_DEFAULT = "localhost";
+
   /**
    * Create a new CephFileSystem.
    */
@@ -115,6 +122,9 @@ public class CephFileSystem extends FileSystem {
     if (ceph == null) {
       ceph = new CephTalker(conf, LOG);
     }
+
+    CEPH_NAMESERVER = conf.get(CEPH_NAMESERVER_KEY, CEPH_NAMESERVER_DEFAULT);
+
     // build up the arguments for Ceph
     String arguments = "CephFSInterface";
 
@@ -580,6 +590,25 @@ public class CephFileSystem extends FileSystem {
     return result;
   }
 
+  /*
+   * Attempt to convert an IP into its hostname
+   */
+  private String[] ips2Hosts(String[] ips) {
+    ArrayList<String> hosts = new ArrayList<String>();
+    for (String ip : ips) {
+      try {
+        String host = DNS.reverseDns(InetAddress.getByName(ip), CEPH_NAMESERVER);
+        if (host.charAt(host.length()-1) == '.') {
+          host = host.substring(0, host.length()-1);
+        }
+        hosts.add(host); /* append */
+      } catch (Exception e) {
+        LOG.error("reverseDns ["+ip+"] failed: "+ e);
+      }
+    }
+    return hosts.toArray(new String[hosts.size()]);
+  }
+
   /**
    * Get a BlockLocation object for each block in a file.
    *
@@ -595,52 +624,27 @@ public class CephFileSystem extends FileSystem {
    */
   @Override
   public BlockLocation[] getFileBlockLocations(FileStatus file, long start, long len) throws IOException {
-    LOG.debug(
-        "getFileBlockLocations:enter with path " + file.getPath()
-        + ", start pos " + start + ", length " + len);
-    // sanitize and get the filehandle
     Path abs_path = makeAbsolute(file.getPath());
 
-    LOG.trace("getFileBlockLocations:call ceph_open_for_read from Java");
     int fh = ceph.ceph_open_for_read(getCephPath(abs_path));
-
-    LOG.trace(
-        "getFileBlockLocations:return from ceph_open_for_read to Java with fh "
-            + fh);
     if (fh < 0) {
-      LOG.error(
-          "getFileBlockLocations:got error " + fh
-          + ", exiting and returning null!");
+      LOG.error("getFileBlockLocations:got error " + fh + ", exiting and returning null!");
       return null;
     }
-    // get the block size
-    LOG.trace("getFileBlockLocations:call ceph_getblocksize from Java");
-    long blockSize = ceph.ceph_getblocksize(getCephPath(abs_path));
 
-    LOG.trace("getFileBlockLocations:return from ceph_getblocksize");
+    long blockSize = ceph.ceph_getblocksize(getCephPath(abs_path));
     BlockLocation[] locations = new BlockLocation[(int) Math.ceil(len / (float) blockSize)];
-    long offset;
 
     for (int i = 0; i < locations.length; ++i) {
-      offset = start + i * blockSize;
-      LOG.trace(
-          "getFileBlockLocations:call ceph_hosts from Java on fh " + fh
-          + " and offset " + offset);
-      String host[] = ceph.ceph_hosts(fh, offset);
-
-      LOG.trace(
-          "getFileBlockLocations:return from ceph_hosts to Java with host "
-              + host[0]);
-      String[] hostArray = new String[1];
-
-      hostArray[0] = host[0];
-      locations[i] = new BlockLocation(hostArray, hostArray,
-          start + i * blockSize - (start % blockSize), blockSize);
+      long offset = start + i * blockSize;
+      long blockStart = start + i * blockSize - (start % blockSize);
+      String ips[] = ceph.ceph_hosts(fh, offset);
+      String hosts[] = ips2Hosts(ips);
+      locations[i] = new BlockLocation(null, hosts, blockStart, blockSize);
+      LOG.debug("getFileBlockLocations: location[" + i + "]: " + locations[i]);
     }
-    LOG.trace("getFileBlockLocations:call ceph_close from Java on fh " + fh);
+
     ceph.ceph_close(fh);
-    LOG.debug(
-        "getFileBlockLocations:return with " + locations.length + " locations");
     return locations;
   }
 
-- 
1.7.1

