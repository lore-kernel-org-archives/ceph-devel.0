From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: [PATCH 4/4] hadoop: make listStatus quiet
Date: Tue,  8 Nov 2011 18:39:21 -0800
Message-ID: <1320806361-1801-5-git-send-email-jayhawk@cs.ucsc.edu>
References: <1320806361-1801-1-git-send-email-jayhawk@cs.ucsc.edu>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:44379 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420Ab1KIDBC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2011 22:01:02 -0500
Received: from piha.cse.ucsc.edu (piha.soe.ucsc.edu [128.114.52.38])
	by mail-01.cse.ucsc.edu (Postfix) with ESMTPSA id B35BA777C006
	for <ceph-devel@vger.kernel.org>; Tue,  8 Nov 2011 18:51:59 -0800 (PST)
In-Reply-To: <1320806361-1801-1-git-send-email-jayhawk@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

From: Noah Watkins <noahwatkins@gmail.com>


Signed-off-by: Noah Watkins <noahwatkins@gmail.com>
---
 src/client/hadoop/ceph/CephFileSystem.java |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/client/hadoop/ceph/CephFileSystem.java b/src/client/hadoop/ceph/CephFileSystem.java
index 00dc64b..95f2223 100644
--- a/src/client/hadoop/ceph/CephFileSystem.java
+++ b/src/client/hadoop/ceph/CephFileSystem.java
@@ -356,7 +356,7 @@ public class CephFileSystem extends FileSystem {
    *         null if path does not exist.
    */
   public FileStatus[] listStatus(Path path) throws IOException {
-    LOG.warn("listStatus:enter with path " + path);
+    LOG.debug("listStatus:enter with path " + path);
     Path abs_path = makeAbsolute(path);
     Path[] paths = listPaths(abs_path);
 
-- 
1.7.1

