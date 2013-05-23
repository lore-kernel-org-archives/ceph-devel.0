From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 24/30] mds: rename last_renamed_version to backtrace_version
Date: Thu, 23 May 2013 16:06:52 +0800
Message-ID: <1369296418-14871-25-git-send-email-zheng.z.yan@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51279 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757107Ab3EWINS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 04:13:18 -0400
In-Reply-To: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, sam.lang@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CDir.cc     | 17 +++++++----------
 src/mds/CDir.h      |  2 +-
 src/mds/Server.cc   |  1 -
 src/mds/mdstypes.cc |  6 +++---
 src/mds/mdstypes.h  | 12 ++++++++++--
 5 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/src/mds/CDir.cc b/src/mds/CDir.cc
index 6342dcb..211cec0 100644
--- a/src/mds/CDir.cc
+++ b/src/mds/CDir.cc
@@ -1728,11 +1728,11 @@ public:
 
 class C_Dir_Committed : public Context {
   CDir *dir;
-  version_t version, last_renamed_version;
+  version_t version;
 public:
-  C_Dir_Committed(CDir *d, version_t v, version_t lrv) : dir(d), version(v), last_renamed_version(lrv) { }
+  C_Dir_Committed(CDir *d, version_t v) : dir(d), version(v) { }
   void finish(int r) {
-    dir->_committed(version, last_renamed_version);
+    dir->_committed(version);
   }
 };
 
@@ -1993,12 +1993,9 @@ void CDir::_commit(version_t want)
 
   if (committed_dn == items.end())
     cache->mds->objecter->mutate(oid, oloc, m, snapc, ceph_clock_now(g_ceph_context), 0, NULL,
-                                 new C_Dir_Committed(this, get_version(),
-                                       inode->inode.last_renamed_version));
+                                 new C_Dir_Committed(this, get_version()));
   else { // send in a different Context
-    C_GatherBuilder gather(g_ceph_context, 
-	    new C_Dir_Committed(this, get_version(),
-		      inode->inode.last_renamed_version));
+    C_GatherBuilder gather(g_ceph_context, new C_Dir_Committed(this, get_version()));
     while (committed_dn != items.end()) {
       ObjectOperation n = ObjectOperation();
       committed_dn = _commit_partial(n, snaps, max_write_size, committed_dn);
@@ -2027,9 +2024,9 @@ void CDir::_commit(version_t want)
  *
  * @param v version i just committed
  */
-void CDir::_committed(version_t v, version_t lrv)
+void CDir::_committed(version_t v)
 {
-  dout(10) << "_committed v " << v << " (last renamed " << lrv << ") on " << *this << dendl;
+  dout(10) << "_committed v " << v << " on " << *this << dendl;
   assert(is_auth());
 
   bool stray = inode->is_stray();
diff --git a/src/mds/CDir.h b/src/mds/CDir.h
index 7e1db73..87c79c2 100644
--- a/src/mds/CDir.h
+++ b/src/mds/CDir.h
@@ -494,7 +494,7 @@ private:
                        unsigned max_write_size=-1,
                        map_t::iterator last_committed_dn=map_t::iterator());
   void _encode_dentry(CDentry *dn, bufferlist& bl, const set<snapid_t> *snaps);
-  void _committed(version_t v, version_t last_renamed_version);
+  void _committed(version_t v);
   void wait_for_commit(Context *c, version_t v=0);
 
   // -- dirtyness --
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 8a0719c..53858e9 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -6228,7 +6228,6 @@ void Server::_rename_prepare(MDRequest *mdr,
 
   if (!silent) {
     if (pi) {
-      pi->last_renamed_version = pi->version;
       pi->ctime = mdr->now;
       if (linkmerge)
 	pi->nlink--;
diff --git a/src/mds/mdstypes.cc b/src/mds/mdstypes.cc
index b1ce640..6886786 100644
--- a/src/mds/mdstypes.cc
+++ b/src/mds/mdstypes.cc
@@ -236,7 +236,7 @@ void inode_t::encode(bufferlist &bl) const
   ::encode(version, bl);
   ::encode(file_data_version, bl);
   ::encode(xattr_version, bl);
-  ::encode(last_renamed_version, bl);
+  ::encode(backtrace_version, bl);
   ::encode(old_pools, bl);
 
   ENCODE_FINISH(bl);
@@ -291,7 +291,7 @@ void inode_t::decode(bufferlist::iterator &p)
   ::decode(file_data_version, p);
   ::decode(xattr_version, p);
   if (struct_v >= 2)
-    ::decode(last_renamed_version, p);
+    ::decode(backtrace_version, p);
   if (struct_v >= 7)
     ::decode(old_pools, p);
 
@@ -357,7 +357,7 @@ void inode_t::dump(Formatter *f) const
   f->dump_unsigned("version", version);
   f->dump_unsigned("file_data_version", file_data_version);
   f->dump_unsigned("xattr_version", xattr_version);
-  f->dump_unsigned("last_renamed_version", last_renamed_version);
+  f->dump_unsigned("backtrace_version", backtrace_version);
 }
 
 void inode_t::generate_test_instances(list<inode_t*>& ls)
diff --git a/src/mds/mdstypes.h b/src/mds/mdstypes.h
index aa9d165..5537407 100644
--- a/src/mds/mdstypes.h
+++ b/src/mds/mdstypes.h
@@ -347,7 +347,7 @@ struct inode_t {
   version_t file_data_version; // auth only
   version_t xattr_version;
 
-  version_t last_renamed_version;      // when i was last renamed
+  version_t backtrace_version;
 
   inode_t() : ino(0), rdev(0),
 	      mode(0), uid(0), gid(0),
@@ -355,7 +355,7 @@ struct inode_t {
 	      size(0), truncate_seq(0), truncate_size(0), truncate_from(0),
 	      truncate_pending(0),
 	      time_warp_seq(0),
-	      version(0), file_data_version(0), xattr_version(0), last_renamed_version(0) { 
+	      version(0), file_data_version(0), xattr_version(0), backtrace_version(0) {
     clear_layout();
     memset(&dir_layout, 0, sizeof(dir_layout));
   }
@@ -425,7 +425,15 @@ struct inode_t {
     }
   }
 
+  bool is_backtrace_updated() {
+    return backtrace_version == version;
+  }
+  void update_backtrace() {
+    backtrace_version = version;
+  }
+
   void add_old_pool(int64_t l) {
+    backtrace_version = version;
     old_pools.push_back(l);
   }
 
-- 
1.8.1.4

