From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/8] mds: don't update migrate_seq when importing non-auth cap
Date: Mon, 17 Jun 2013 20:10:22 +0800
Message-ID: <1371471029-10589-2-git-send-email-zheng.z.yan@intel.com>
References: <1371471029-10589-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50572 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932725Ab3FQMLC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Jun 2013 08:11:02 -0400
In-Reply-To: <1371471029-10589-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

We use migrate_seq to distinguish old and new auth MDS. So we should
not change migrate_seq when importing non-auth cap.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Capability.h | 5 +++--
 src/mds/Migrator.cc  | 8 ++++----
 src/mds/Migrator.h   | 3 ++-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/src/mds/Capability.h b/src/mds/Capability.h
index 54d2312..fdecb90 100644
--- a/src/mds/Capability.h
+++ b/src/mds/Capability.h
@@ -273,7 +273,7 @@ public:
     return Export(_wanted, issued(), pending(), client_follows, mseq+1, last_issue_stamp);
   }
   void rejoin_import() { mseq++; }
-  void merge(Export& other) {
+  void merge(Export& other, bool auth_cap) {
     // issued + pending
     int newpending = other.pending | pending();
     if (other.issued & ~newpending)
@@ -286,7 +286,8 @@ public:
 
     // wanted
     _wanted = _wanted | other.wanted;
-    mseq = other.mseq;
+    if (auth_cap)
+      mseq = other.mseq;
   }
   void merge(int otherwanted, int otherissued) {
     // issued + pending
diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
index 6ea28c9..0647448 100644
--- a/src/mds/Migrator.cc
+++ b/src/mds/Migrator.cc
@@ -2223,7 +2223,7 @@ void Migrator::import_logged_start(dirfrag_t df, CDir *dir, int from,
   for (map<CInode*, map<client_t,Capability::Export> >::iterator p = import_caps[dir].begin();
        p != import_caps[dir].end();
        ++p) {
-    finish_import_inode_caps(p->first, from, p->second);
+    finish_import_inode_caps(p->first, true, p->second);
   }
   
   // send notify's etc.
@@ -2398,7 +2398,7 @@ void Migrator::decode_import_inode_caps(CInode *in,
   }
 }
 
-void Migrator::finish_import_inode_caps(CInode *in, int from, 
+void Migrator::finish_import_inode_caps(CInode *in, bool auth_cap,
 					map<client_t,Capability::Export> &cap_map)
 {
   for (map<client_t,Capability::Export>::iterator it = cap_map.begin();
@@ -2412,7 +2412,7 @@ void Migrator::finish_import_inode_caps(CInode *in, int from,
     if (!cap) {
       cap = in->add_client_cap(it->first, session);
     }
-    cap->merge(it->second);
+    cap->merge(it->second, auth_cap);
 
     mds->mdcache->do_cap_import(session, in, cap);
   }
@@ -2688,7 +2688,7 @@ void Migrator::logged_import_caps(CInode *in,
   mds->server->finish_force_open_sessions(client_map, sseqmap);
 
   assert(cap_imports.count(in));
-  finish_import_inode_caps(in, from, cap_imports[in]);  
+  finish_import_inode_caps(in, false, cap_imports[in]);
   mds->locker->eval(in, CEPH_CAP_LOCKS, true);
 
   mds->send_message_mds(new MExportCapsAck(in->ino()), from);
diff --git a/src/mds/Migrator.h b/src/mds/Migrator.h
index 70b59bc..afe2e6c 100644
--- a/src/mds/Migrator.h
+++ b/src/mds/Migrator.h
@@ -256,7 +256,8 @@ public:
   void decode_import_inode_caps(CInode *in,
 				bufferlist::iterator &blp,
 				map<CInode*, map<client_t,Capability::Export> >& cap_imports);
-  void finish_import_inode_caps(CInode *in, int from, map<client_t,Capability::Export> &cap_map);
+  void finish_import_inode_caps(CInode *in, bool auth_cap,
+			        map<client_t,Capability::Export> &cap_map);
   int decode_import_dir(bufferlist::iterator& blp,
 			int oldauth,
 			CDir *import_root,
-- 
1.8.1.4

