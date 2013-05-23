From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 10/30] mds: remove buggy cache rejoin code
Date: Thu, 23 May 2013 16:06:38 +0800
Message-ID: <1369296418-14871-11-git-send-email-zheng.z.yan@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51279 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756681Ab3EWINL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 04:13:11 -0400
In-Reply-To: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, sam.lang@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

I previously added code to handle a corner case of cache rejoin:
entire subtree, together with the inode subtree root belongs to,
were trimmed between sending cache rejoin and receiving rejoin ack.
In this case, we should send cache expire message to the subtree's
auth MDS. But the code is complete broken, remove it temporarily.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 9db51b1..5e8f2a5 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -4511,7 +4511,7 @@ void MDCache::handle_cache_rejoin_ack(MMDSCacheRejoin *ack)
   int from = ack->get_source().num();
 
   // for sending cache expire message
-  list<CInode*> isolated_inodes;
+  set<CInode*> isolated_inodes;
 
   // dirs
   for (map<dirfrag_t, MMDSCacheRejoin::dirfrag_strong>::iterator p = ack->strong_dirfrags.begin();
@@ -4527,19 +4527,20 @@ void MDCache::handle_cache_rejoin_ack(MMDSCacheRejoin *ack)
 	diri = new CInode(this, false);
 	diri->inode.ino = p->first.ino;
 	diri->inode.mode = S_IFDIR;
-	if (MDS_INO_MDSDIR(p->first.ino)) {
+	add_inode(diri);
+	if (MDS_INO_MDSDIR(from) == p->first.ino) {
 	  diri->inode_auth = pair<int,int>(from, CDIR_AUTH_UNKNOWN);
-	  add_inode(diri);
 	  dout(10) << " add inode " << *diri << dendl;
 	} else {
-	  diri->inode_auth = CDIR_AUTH_UNDEF;
-	  isolated_inodes.push_back(diri);
+	  diri->inode_auth = CDIR_AUTH_DEFAULT;
+	  isolated_inodes.insert(diri);
 	  dout(10) << " unconnected dirfrag " << p->first << dendl;
 	}
       }
       // barebones dirfrag; the full dirfrag loop below will clean up.
       dir = diri->add_dirfrag(new CDir(diri, p->first.frag, this, false));
-      if (dir->authority().first != from)
+      if (dir->authority() != CDIR_AUTH_UNDEF &&
+	  dir->authority().first != from)
 	adjust_subtree_auth(dir, from);
       dout(10) << " add dirfrag " << *dir << dendl;
     }
@@ -4604,6 +4605,7 @@ void MDCache::handle_cache_rejoin_ack(MMDSCacheRejoin *ack)
 	    in->get_parent_dir()->unlink_inode(in->get_parent_dn());
 	  }
 	  dn->dir->link_primary_inode(dn, in);
+	  isolated_inodes.erase(in);
 	}
       }
 
@@ -4665,20 +4667,9 @@ void MDCache::handle_cache_rejoin_ack(MMDSCacheRejoin *ack)
     dout(10) << " got inode locks " << *in << dendl;
   }
 
-  // trim unconnected subtree
-  if (!isolated_inodes.empty()) {
-    map<int, MCacheExpire*> expiremap;
-    for (list<CInode*>::iterator p = isolated_inodes.begin();
-	 p != isolated_inodes.end();
-	 ++p) {
-      list<CDir*> ls;
-      (*p)->get_dirfrags(ls);
-      trim_dirfrag(*ls.begin(), 0, expiremap);
-      assert((*p)->get_num_ref() == 0);
-      delete *p;
-    }
-    send_expire_messages(expiremap);
-  }
+  // FIXME: This can happen if entire subtree, together with the inode subtree root
+  // belongs to, were trimmed between sending cache rejoin and receiving rejoin ack.
+  assert(isolated_inodes.empty());
 
   // done?
   assert(rejoin_ack_gather.count(from));
-- 
1.8.1.4

