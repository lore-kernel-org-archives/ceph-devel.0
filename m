From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 05/14] mds: set want_base_dir to false for MDCache::discover_ino()
Date: Tue, 11 Dec 2012 16:30:51 +0800
Message-ID: <1355214660-26354-6-git-send-email-zheng.z.yan@intel.com>
References: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:65284 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821Ab2LKIbJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Dec 2012 03:31:09 -0500
In-Reply-To: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

When frozen inode is encountered, MDCache::handle_discover() sends
reply immediately if the reply message is not empty. When handling
"discover ino" requests, the reply message always contains the base
directory fragment. But requestor already has the base directory
fragment, the only effect of the reply message is wake the requestor
and make it send same "discover ino" request again. So the requestor
keeps sending "discover ino" requests but can't make any progress.

The fix is set want_base_dir to false for MDCache::discover_ino().
After set want_base_dir to false, also need update the code that
handles "discover ino" error.

This patch also remove unused error handling code for flag_error_dn

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 7733d0d..893b651 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -8547,7 +8547,7 @@ void MDCache::discover_ino(CDir *base,
     d.ino = base->ino();
     d.frag = base->get_frag();
     d.want_ino = want_ino;
-    d.want_base_dir = true;
+    d.want_base_dir = false;
     d.want_xlocked = want_xlocked;
     _send_discover(d);
   }
@@ -8890,6 +8890,18 @@ void MDCache::handle_discover_reply(MDiscoverReply *m)
     }
   }
 
+  // discover ino error
+  if (p.end() && m->is_flag_error_ino()) {
+    assert(cur->is_dir());
+    CDir *dir = cur->get_dirfrag(m->get_base_dir_frag());
+    if (dir) {
+      dout(7) << " flag_error on ino " << m->get_wanted_ino()
+	      << ", triggering ino" << dendl;
+      dir->take_ino_waiting(m->get_wanted_ino(), error);
+    } else
+      assert(0);
+  }
+
   // discover may start with an inode
   if (!p.end() && next == MDiscoverReply::INODE) {
     cur = add_replica_inode(p, NULL, finished);
@@ -8925,30 +8937,6 @@ void MDCache::handle_discover_reply(MDiscoverReply *m)
 	curdir = cur->get_dirfrag(m->get_base_dir_frag());
     }
 
-    // dentry error?
-    if (p.end() && (m->is_flag_error_dn() || m->is_flag_error_ino())) {
-      // error!
-      assert(cur->is_dir());
-      if (curdir) {
-	if (m->get_error_dentry().length()) {
-	  dout(7) << " flag_error on dentry " << m->get_error_dentry()
-		  << ", triggering dentry" << dendl;
-	  curdir->take_dentry_waiting(m->get_error_dentry(), 
-				      m->get_wanted_snapid(), m->get_wanted_snapid(), error);
-	} else {
-	  dout(7) << " flag_error on ino " << m->get_wanted_ino()
-		  << ", triggering ino" << dendl;
-	  curdir->take_ino_waiting(m->get_wanted_ino(), error);
-	}
-      } else {
-	dout(7) << " flag_error on dentry " << m->get_error_dentry() 
-		<< ", triggering dir?" << dendl;
-	cur->take_waiting(CInode::WAIT_DIR, error);
-      }
-      break;
-    }
-    assert(curdir);
-
     if (p.end())
       break;
     
-- 
1.7.11.7

