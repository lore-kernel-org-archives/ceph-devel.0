From: Sage Weil <sage@newdream.net>
Subject: Re: [Qemu-devel] Qemu + RBD = ceph::buffer::end_of_buffer
Date: Fri, 6 May 2011 13:28:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105061326210.9905@cobra.newdream.net>
References: <346055bf24b9f7eabcfafa1cc53a4f66.squirrel@localhost>
 <fb4546550b96ff2f54c7a2f5e795131d.squirrel@localhost> <4DC45149.8020101@dreamhost.com>
 <984ed3487d4f68b72f4b0720d3caf27e.squirrel@localhost>
 <Pine.LNX.4.64.1105061303270.1445@cobra.newdream.net>
 <e9667a76329fbf406791fd3d79aa6244.squirrel@localhost>
 <Pine.LNX.4.64.1105061311500.1445@cobra.newdream.net>
 <04a5fc1fcc55ce2fd9d913ca2ae449ed.squirrel@localhost>
 <Pine.LNX.4.64.1105061321230.9905@cobra.newdream.net>
 <da32a6a0a2cf4b75f26eb409dbe53a53.squirrel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48226 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756570Ab1EFU1z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 May 2011 16:27:55 -0400
In-Reply-To: <da32a6a0a2cf4b75f26eb409dbe53a53.squirrel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dyweni - Qemu-Devel <8SScqsnYX8tr@dyweni.com>
Cc: ceph-devel@vger.kernel.org, Josh Durgin <josh.durgin@dreamhost.com>, qemu-devel@nongnu.org

On Fri, 6 May 2011, Dyweni - Qemu-Devel wrote:
> Hi Sage/Lists!
> 
> Yes!  The entire Ceph cluster (1 Mon, 1 MSD, 3 OSD) are 32bit linux.
> 
> The machine running Qemu is 64bit linux.

Excellent.  This is now fixed by 48d94f6e34da8ace2b5cb128de1bcfb34b3c40b5 
in the stable and master branches of ceph.git.  Or you can apply the patch 
below.

Thanks!
sage



From 48d94f6e34da8ace2b5cb128de1bcfb34b3c40b5 Mon Sep 17 00:00:00 2001
From: Sage Weil <sage@newdream.net>
Date: Fri, 6 May 2011 13:42:23 -0700
Subject: [PATCH] osd: used fixed size types for fiemap/mapext/sparseread encoding

The client expects <uint64_t,uint64_t>, so this breaks on any 32-bit osd.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 src/os/FileStore.cc     |    4 ++--
 src/osd/ReplicatedPG.cc |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/os/FileStore.cc b/src/os/FileStore.cc
index 81bc91d..ca11435 100644
--- a/src/os/FileStore.cc
+++ b/src/os/FileStore.cc
@@ -2198,7 +2198,7 @@ int FileStore::fiemap(coll_t cid, const sobject_t& oid,
 {
 
   if (!ioctl_fiemap) {
-    map<off_t, size_t> m;
+    map<uint64_t, uint64_t> m;
     m[offset] = len;
     ::encode(m, bl);
     return 0;
@@ -2207,7 +2207,7 @@ int FileStore::fiemap(coll_t cid, const sobject_t& oid,
 
   char fn[PATH_MAX];
   struct fiemap *fiemap = NULL;
-  map<off_t, size_t> extmap;
+  map<uint64_t, uint64_t> extmap;
 
   get_coname(cid, oid, fn, sizeof(fn));
 
diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
index ba76b05..84399ca 100644
--- a/src/osd/ReplicatedPG.cc
+++ b/src/osd/ReplicatedPG.cc
@@ -1142,10 +1142,10 @@ int ReplicatedPG::do_osd_ops(OpContext *ctx, vector<OSDOp>& ops,
 	  result = r;
           break;
 	}
-        map<off_t, size_t> m;
+        map<uint64_t, uint64_t> m;
         bufferlist::iterator iter = bl.begin();
         ::decode(m, iter);
-        map<off_t, size_t>::iterator miter;
+        map<uint64_t, uint64_t>::iterator miter;
         bufferlist data_bl;
         for (miter = m.begin(); miter != m.end(); ++miter) {
           bufferlist tmpbl;
-- 
1.7.0

