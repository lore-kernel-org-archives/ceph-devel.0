From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 21/25] mds: don't journal opened non-auth inode
Date: Wed, 23 Jan 2013 11:08:57 +0800
Message-ID: <1358910541-15535-22-git-send-email-zheng.z.yan@intel.com>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:1721 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150Ab3AWDJX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jan 2013 22:09:23 -0500
In-Reply-To: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

If we journal opened non-auth inode, during journal replay, the corresponding
entry will add non-auth objects to the cache. But the MDS does not journal all
subsequent modifications (rmdir,rename) to these non-auth objects, so the code
that manages cache and subtree may get confused. Besides non-auth objects will
be trimmed at the resolve stage.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc   | 2 ++
 src/mds/Migrator.cc | 2 ++
 src/mds/Server.cc   | 3 ++-
 src/mds/journal.cc  | 2 +-
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index e0c149f..aca7052 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -2138,6 +2138,8 @@ void Locker::adjust_cap_wanted(Capability *cap, int wanted, int issue_seq)
   }
 
   CInode *cur = cap->get_inode();
+  if (!cur->is_auth())
+    return;
   if (cap->wanted() == 0) {
     if (cur->item_open_file.is_on_list() &&
 	!cur->is_any_caps_wanted()) {
diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
index bda8035..453cfaf 100644
--- a/src/mds/Migrator.cc
+++ b/src/mds/Migrator.cc
@@ -1093,6 +1093,8 @@ void Migrator::finish_export_inode(CInode *in, utime_t now, list<Context*>& fini
   
   in->clear_dirty_rstat();
 
+  in->item_open_file.remove_myself();
+
   // waiters
   in->take_waiting(CInode::WAIT_ANY_MASK, finished);
   
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 4ea6d0e..1b3d49e 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -2553,7 +2553,8 @@ void Server::handle_client_open(MDRequest *mdr)
     mds->locker->check_inode_max_size(cur);
 
   // make sure this inode gets into the journal
-  if (!cur->item_open_file.is_on_list() && cur->last == CEPH_NOSNAP) {
+  if (cur->is_auth() && cur->last == CEPH_NOSNAP &&
+      !cur->item_open_file.is_on_list()) {
     LogSegment *ls = mds->mdlog->get_current_segment();
     EOpen *le = new EOpen(mds->mdlog);
     mdlog->start_entry(le);
diff --git a/src/mds/journal.cc b/src/mds/journal.cc
index 111a0f3..e8b8c2f 100644
--- a/src/mds/journal.cc
+++ b/src/mds/journal.cc
@@ -145,7 +145,7 @@ void LogSegment::try_to_expire(MDS *mds, C_GatherBuilder &gather_bld)
       CInode *in = *p;
       assert(in->last == CEPH_NOSNAP);
       ++p;
-      if (in->is_any_caps()) {
+      if (in->is_auth() && in->is_any_caps()) {
 	if (in->is_any_caps_wanted()) {
 	  dout(20) << "try_to_expire requeueing open file " << *in << dendl;
 	  if (!le) {
-- 
1.7.11.7

