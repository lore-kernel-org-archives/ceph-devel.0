From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 03/29] mds: don't trigger assertion when discover races with rename
Date: Fri,  4 Jan 2013 17:01:54 +0800
Message-ID: <1357290140-17044-4-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51114 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752605Ab3ADJC3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:29 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Discover reply that adds replica dentry and inode can race with rename
if slave request for rename sends discover and waits, but waked up by
reply for different discover.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CDentry.cc | 17 ++++++-----------
 src/mds/MDCache.cc |  5 ++---
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/src/mds/CDentry.cc b/src/mds/CDentry.cc
index 7dd88ac..5ff6e61 100644
--- a/src/mds/CDentry.cc
+++ b/src/mds/CDentry.cc
@@ -439,23 +439,18 @@ void CDentry::decode_replica(bufferlist::iterator& p, bool is_new)
 
   inodeno_t rino;
   unsigned char rdtype;
+  __s32 ls;
   ::decode(rino, p);
   ::decode(rdtype, p);
-  if (rino) {
-    if (linkage.is_null())
-      dir->link_remote_inode(this, rino, rdtype);
-    else
-      assert(linkage.is_remote() && linkage.remote_ino == rino);
-  }
-  
-  __s32 ls;
   ::decode(ls, p);
-  if (is_new)
+
+  if (is_new) {
+    if (rino)
+      dir->link_remote_inode(this, rino, rdtype);
     lock.set_state(ls);
+  }
 }
 
-
-
 // ----------------------------
 // locking
 
diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 0a88714..5014b5d 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -9150,12 +9150,11 @@ CInode *MDCache::add_replica_inode(bufferlist::iterator& p, CDentry *dn, list<Co
   } else {
     in->decode_replica(p, false);
     dout(10) << "add_replica_inode had " << *in << dendl;
-    assert(!dn || dn->get_linkage()->get_inode() == in);
   }
 
   if (dn) {
-    assert(dn->get_linkage()->is_primary());
-    assert(dn->get_linkage()->get_inode() == in);
+    if (!dn->get_linkage()->is_primary() || dn->get_linkage()->get_inode() != in)
+      dout(10) << "add_replica_inode different linkage in dentry " << *dn << dendl;
     
     dn->get_dir()->take_ino_waiting(in->ino(), finished);
   }
-- 
1.7.11.7

