From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: [PATCH] hadoop: fix contract for listStatus
Date: Fri, 28 Oct 2011 17:25:28 -0700 (PDT)
Message-ID: <975279467.13273.1319847928971.JavaMail.root@mail-01.cse.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:32876 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914Ab1J2AZ3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Oct 2011 20:25:29 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>

Return NULL when the path does not exist. Although
unspecified in the declaration header, other file
systems return a single result when the path is a file.

This fixes tracker issue #1661

Signed-off-by: Noah Watkins <noahwatkins@gmail.com>
---
 src/client/hadoop/ceph/CephFileSystem.java |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/client/hadoop/ceph/CephFileSystem.java b/src/client/hadoop/ceph/CephFileSystem.java
index c697075..a7317b1 100644
--- a/src/client/hadoop/ceph/CephFileSystem.java
+++ b/src/client/hadoop/ceph/CephFileSystem.java
@@ -435,9 +435,8 @@ public class CephFileSystem extends FileSystem {
    * Get the FileStatus for each listing in a directory.
    * @param path The directory to get listings from.
    * @return FileStatus[] containing one FileStatus for each directory listing;
-   * null if path is not a directory.
+   *         null if path does not exist.
    * @throws IOException if initialize() hasn't been called.
-   * @throws FileNotFoundException if the input path can't be found.
    */
   public FileStatus[] listStatus(Path path) throws IOException {
     if (!initialized) {
@@ -458,11 +457,12 @@ public class CephFileSystem extends FileSystem {
       ceph.debug("listStatus:exit", ceph.DEBUG);
       return statuses;
     }
-    if (!isFile(path)) {
-      throw new FileNotFoundException();
-    } // if we get here, listPaths returned null
-    // which means that the input wasn't a directory, so throw an Exception if it's not a file
-    return null; // or return null if it's a file
+
+    if (isFile(path)) {
+      return new FileStatus[] { getFileStatus(path) };
+    }
+
+    return null;
   }
 
   @Override
-- 
1.7.5.4
