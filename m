From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 25/39] mds: share inode max size after MDS recovers
Date: Sun, 17 Mar 2013 22:51:28 +0800
Message-ID: <1363531902-24909-26-git-send-email-zheng.z.yan@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23734 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932610Ab3CQOxf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Mar 2013 10:53:35 -0400
In-Reply-To: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The MDS may crash after journaling the new max size, but before sending
the new max size to the client. Later when the MDS recovers, the client
re-requests the new max size, but the MDS finds max size unchanged. So
the client waits for the new max size forever. This issue can be avoided
by checking client cap's last_sent, share inode max size if it is zero.
(reconnected cap's last_sent is zero)

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc  | 18 ++++++++++++++----
 src/mds/Locker.h   |  2 +-
 src/mds/MDCache.cc |  2 ++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index 0055a19..4d45f99 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -2089,7 +2089,7 @@ bool Locker::check_inode_max_size(CInode *in, bool force_wrlock,
 }
 
 
-void Locker::share_inode_max_size(CInode *in)
+void Locker::share_inode_max_size(CInode *in, Capability *only_cap)
 {
   /*
    * only share if currently issued a WR cap.  if client doesn't have it,
@@ -2097,9 +2097,12 @@ void Locker::share_inode_max_size(CInode *in)
    * the cap later.
    */
   dout(10) << "share_inode_max_size on " << *in << dendl;
-  for (map<client_t,Capability*>::iterator it = in->client_caps.begin();
-       it != in->client_caps.end();
-       ++it) {
+  map<client_t, Capability*>::iterator it;
+  if (only_cap)
+    it = in->client_caps.find(only_cap->get_client());
+  else
+    it = in->client_caps.begin();
+  for (; it != in->client_caps.end(); ++it) {
     const client_t client = it->first;
     Capability *cap = it->second;
     if (cap->is_suppress())
@@ -2115,6 +2118,8 @@ void Locker::share_inode_max_size(CInode *in)
       in->encode_cap_message(m, cap);
       mds->send_message_client_counted(m, client);
     }
+    if (only_cap)
+      break;
   }
 }
 
@@ -2398,6 +2403,11 @@ void Locker::handle_client_caps(MClientCaps *m)
       bool did_issue = eval(in, CEPH_CAP_LOCKS);
       if (!did_issue && (cap->wanted() & ~cap->pending()))
 	issue_caps(in, cap);
+      if (cap->get_last_seq() == 0 &&
+	  (cap->pending() & (CEPH_CAP_FILE_WR|CEPH_CAP_FILE_BUFFER))) {
+	cap->issue_norevoke(cap->issued());
+	share_inode_max_size(in, cap);
+      }
     }
   }
 
diff --git a/src/mds/Locker.h b/src/mds/Locker.h
index 3f79996..d98104f 100644
--- a/src/mds/Locker.h
+++ b/src/mds/Locker.h
@@ -276,7 +276,7 @@ public:
   void calc_new_client_ranges(CInode *in, uint64_t size, map<client_t, client_writeable_range_t>& new_ranges);
   bool check_inode_max_size(CInode *in, bool force_wrlock=false, bool update_size=false, uint64_t newsize=0,
 			    utime_t mtime=utime_t());
-  void share_inode_max_size(CInode *in);
+  void share_inode_max_size(CInode *in, Capability *only_cap=0);
 
 private:
   friend class C_MDL_CheckMaxSize;
diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 194f983..459b400 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -5073,6 +5073,8 @@ void MDCache::do_cap_import(Session *session, CInode *in, Capability *cap)
   SnapRealm *realm = in->find_snaprealm();
   if (realm->have_past_parents_open()) {
     dout(10) << "do_cap_import " << session->info.inst.name << " mseq " << cap->get_mseq() << " on " << *in << dendl;
+    if (cap->get_last_seq() == 0)
+      cap->issue_norevoke(cap->issued()); // reconnected cap
     cap->set_last_issue();
     MClientCaps *reap = new MClientCaps(CEPH_CAP_OP_IMPORT,
 					in->ino(),
-- 
1.7.11.7

