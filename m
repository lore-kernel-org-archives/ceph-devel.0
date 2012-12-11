From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 06/14] mds: fix error hanlding in MDCache::handle_discover_reply()
Date: Tue, 11 Dec 2012 16:30:52 +0800
Message-ID: <1355214660-26354-7-git-send-email-zheng.z.yan@intel.com>
References: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16602 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752108Ab2LKIbL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Dec 2012 03:31:11 -0500
In-Reply-To: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The error hanlding code in MDCache::handle_discover_reply() has two
main issues. MDCache::handle_discover_reply() does not wake waiters
if dir_auth_hint in reply message is equal to itself's nodeid. This
can happen if discover race with subtree importing. Another issue is
that it checks the existence of cached directory fragment to decide
if it should take waiter from inode or from directory fragment. The
check is unreliable because subtree importing can add directory
fragments to the cache.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 54 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 893b651..eb18eeb 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -8957,9 +8957,7 @@ void MDCache::handle_discover_reply(MDiscoverReply *m)
   if (m->is_flag_error_dir() && !cur->is_dir()) {
     // not a dir.
     cur->take_waiting(CInode::WAIT_DIR, error);
-  } else if (m->is_flag_error_dir() ||
-	     (m->get_dir_auth_hint() != CDIR_AUTH_UNKNOWN &&
-	      m->get_dir_auth_hint() != mds->get_nodeid())) {
+  } else if (m->is_flag_error_dir() || m->get_dir_auth_hint() != CDIR_AUTH_UNKNOWN) {
     int who = m->get_dir_auth_hint();
     if (who == mds->get_nodeid()) who = -1;
     if (who >= 0)
@@ -8971,27 +8969,47 @@ void MDCache::handle_discover_reply(MDiscoverReply *m)
       frag_t fg = cur->pick_dirfrag(m->get_error_dentry());
       CDir *dir = cur->get_dirfrag(fg);
       filepath relpath(m->get_error_dentry(), 0);
+
+      if (cur->is_waiter_for(CInode::WAIT_DIR)) {
+	if (cur->is_auth() || dir)
+	  cur->take_waiting(CInode::WAIT_DIR, finished);
+	else
+	  discover_path(cur, m->get_wanted_snapid(), relpath, 0, m->get_wanted_xlocked(), who);
+      } else
+	  dout(7) << " doing nothing, nobody is waiting for dir" << dendl;
+
       if (dir) {
 	// don't actaully need the hint, now
-	if (dir->lookup(m->get_error_dentry()) == 0 &&
-	    dir->is_waiting_for_dentry(m->get_error_dentry().c_str(), m->get_wanted_snapid())) 
-	  discover_path(dir, m->get_wanted_snapid(), relpath, 0, m->get_wanted_xlocked()); 
-	else 
-	  dout(7) << " doing nothing, have dir but nobody is waiting on dentry " 
+	if (dir->is_waiting_for_dentry(m->get_error_dentry().c_str(), m->get_wanted_snapid())) {
+	  if (dir->is_auth() || dir->lookup(m->get_error_dentry()))
+	    dir->take_dentry_waiting(m->get_error_dentry(), m->get_wanted_snapid(),
+				     m->get_wanted_snapid(), finished);
+	  else
+	    discover_path(dir, m->get_wanted_snapid(), relpath, 0, m->get_wanted_xlocked());
+	} else
+	  dout(7) << " doing nothing, have dir but nobody is waiting on dentry "
 		  << m->get_error_dentry() << dendl;
-      } else {
-	if (cur->is_waiter_for(CInode::WAIT_DIR)) 
-	  discover_path(cur, m->get_wanted_snapid(), relpath, 0, m->get_wanted_xlocked(), who);
-	else
-	  dout(7) << " doing nothing, nobody is waiting for dir" << dendl;
       }
     } else {
-      // wanted just the dir
+      // wanted dir or ino
       frag_t fg = m->get_base_dir_frag();
-      if (cur->get_dirfrag(fg) == 0 && cur->is_waiter_for(CInode::WAIT_DIR))
-	discover_dir_frag(cur, fg, 0, who);
-      else
-	dout(7) << " doing nothing, nobody is waiting for dir" << dendl;	  
+      CDir *dir = cur->get_dirfrag(fg);
+
+      if (cur->is_waiter_for(CInode::WAIT_DIR)) {
+	if (cur->is_auth() || dir)
+	  cur->take_waiting(CInode::WAIT_DIR, finished);
+	else
+	  discover_dir_frag(cur, fg, 0, who);
+      } else
+	dout(7) << " doing nothing, nobody is waiting for dir" << dendl;
+
+      if (dir && m->get_wanted_ino() && dir->is_waiting_for_ino(m->get_wanted_ino())) {
+	if (dir->is_auth() || get_inode(m->get_wanted_ino()))
+	  dir->take_ino_waiting(m->get_wanted_ino(), finished);
+	else
+	  discover_ino(dir, m->get_wanted_ino(), 0, m->get_wanted_xlocked());
+      } else
+	dout(7) << " doing nothing, nobody is waiting for ino" << dendl;
     }
   }
 
-- 
1.7.11.7

