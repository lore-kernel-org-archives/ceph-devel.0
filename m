From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH v2] Inline data support
Date: Tue, 10 Sep 2013 21:24:10 +0800
Message-ID: <1378819450-8318-1-git-send-email-liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m53-178.qiye.163.com ([123.58.178.53]:47655 "EHLO
	m53-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872Ab3IJNY0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Sep 2013 09:24:26 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Li Wang <liwang@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

This patch implements inline data support for Ceph.

Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
Against v1:
With simplified process under multiple-writer case,
referred to
http://pad.ceph.com/p/mds-inline-data,
http://www.spinics.net/lists/ceph-devel/msg16018.html
---
 src/ceph_mds.cc             |    1 +
 src/client/Client.cc        |  202 +++++++++++++++++++++++++++++++++++++------
 src/client/Client.h         |    4 +
 src/client/Inode.h          |    5 ++
 src/include/ceph_features.h |    2 +
 src/include/ceph_fs.h       |    3 +
 src/include/rados.h         |    1 +
 src/mds/CInode.cc           |   22 +++++
 src/mds/Capability.h        |    2 +
 src/mds/Locker.cc           |    7 ++
 src/mds/mdstypes.cc         |   12 ++-
 src/mds/mdstypes.h          |    3 +
 src/messages/MClientCaps.h  |   18 +++-
 src/messages/MClientReply.h |    9 ++
 src/osd/ReplicatedPG.cc     |    5 +-
 src/osdc/Objecter.h         |   21 ++++-
 16 files changed, 283 insertions(+), 34 deletions(-)

diff --git a/src/ceph_mds.cc b/src/ceph_mds.cc
index 88b807b..dac676f 100644
--- a/src/ceph_mds.cc
+++ b/src/ceph_mds.cc
@@ -243,6 +243,7 @@ int main(int argc, const char **argv)
     CEPH_FEATURE_UID |
     CEPH_FEATURE_NOSRCADDR |
     CEPH_FEATURE_DIRLAYOUTHASH |
+    CEPH_FEATURE_MDS_INLINE_DATA |
     CEPH_FEATURE_PGID64 |
     CEPH_FEATURE_MSG_AUTH;
   uint64_t required =
diff --git a/src/client/Client.cc b/src/client/Client.cc
index 77fd208..f47579f 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -485,6 +485,8 @@ void Client::update_inode_file_bits(Inode *in,
 				    uint64_t time_warp_seq, utime_t ctime,
 				    utime_t mtime,
 				    utime_t atime,
+				    uint64_t inline_version,
+				    bufferlist& inline_data,
 				    int issued)
 {
   bool warn = false;
@@ -495,6 +497,11 @@ void Client::update_inode_file_bits(Inode *in,
 	   << " local " << in->time_warp_seq << dendl;
   uint64_t prior_size = in->size;
 
+  if (inline_version > in->inline_version) {
+    in->inline_data = inline_data;
+    in->inline_version = inline_version;
+  }
+
   if (truncate_seq > in->truncate_seq ||
       (truncate_seq == in->truncate_seq && size > in->size)) {
     ldout(cct, 10) << "size " << in->size << " -> " << size << dendl;
@@ -511,6 +518,13 @@ void Client::update_inode_file_bits(Inode *in,
 	_invalidate_inode_cache(in, truncate_size, prior_size - truncate_size, true);
       }
     }
+
+    // truncate inline data
+    if (in->inline_version < CEPH_INLINE_DISABLED) {
+      uint32_t len = in->inline_data.length();
+      if (size < len)
+        in->inline_data.splice(size, len - size);
+    }
   }
   if (truncate_seq >= in->truncate_seq &&
       in->truncate_size != truncate_size) {
@@ -645,6 +659,7 @@ Inode * Client::add_update_inode(InodeStat *st, utime_t from, MetaSession *sessi
   
     update_inode_file_bits(in, st->truncate_seq, st->truncate_size, st->size,
 			   st->time_warp_seq, st->ctime, st->mtime, st->atime,
+			   st->inline_version, st->inline_data,
 			   issued);
   }
 
@@ -2353,6 +2368,11 @@ void Client::send_cap(Inode *in, MetaSession *session, Cap *cap,
   in->ctime.encode_timeval(&m->head.ctime);
   m->head.time_warp_seq = in->time_warp_seq;
     
+  if (flush & CEPH_CAP_FILE_WR) {
+    m->inline_version = in->inline_version;
+    m->inline_data = in->inline_data;
+  }
+
   in->reported_size = in->size;
   m->set_snap_follows(follows);
   cap->wanted = want;
@@ -3482,7 +3502,9 @@ void Client::handle_cap_trunc(MetaSession *session, Inode *in, MClientCaps *m)
   issued |= implemented;
   update_inode_file_bits(in, m->get_truncate_seq(), m->get_truncate_size(),
                          m->get_size(), m->get_time_warp_seq(), m->get_ctime(),
-                         m->get_mtime(), m->get_atime(), issued);
+                         m->get_mtime(), m->get_atime(),
+                         m->inline_version, m->inline_data,
+                         issued);
   m->put();
 }
 
@@ -3589,7 +3611,8 @@ void Client::handle_cap_grant(MetaSession *session, Inode *in, Cap *cap, MClient
     in->xattr_version = m->head.xattr_version;
   }
   update_inode_file_bits(in, m->get_truncate_seq(), m->get_truncate_size(), m->get_size(),
-			 m->get_time_warp_seq(), m->get_ctime(), m->get_mtime(), m->get_atime(), issued);
+			 m->get_time_warp_seq(), m->get_ctime(), m->get_mtime(), m->get_atime(),
+			 m->inline_version, m->inline_data, issued);
 
   // max_size
   if (cap == in->auth_cap &&
@@ -5643,6 +5666,57 @@ void Client::unlock_fh_pos(Fh *f)
   f->pos_locked = false;
 }
 
+int Client::migration_inline_data(Inode *in)
+{
+  ObjectOperation ops;
+  bufferlist inline_version_bl;
+  ::encode(in->inline_version, inline_version_bl);
+  ops.cmpxattr("inline_version",
+               CEPH_OSD_CMPXATTR_OP_GT,
+               CEPH_OSD_CMPXATTR_MODE_U64,
+               CEPH_OSD_OP_FLAG_NOENTOK,
+               inline_version_bl);
+  bufferlist inline_data = in->inline_data;
+  ops.write(0, inline_data, in->truncate_size, in->truncate_seq);
+  ops.setxattr("inline_version", inline_version_bl);
+
+  char oid_buf[32];
+  snprintf(oid_buf, sizeof(oid_buf), "%llx.00000000", (long long unsigned)in->ino);
+  object_t oid = oid_buf;
+
+  Mutex flock("Client::migration_inline_data flock");
+  Cond cond;
+  bool done = false;
+  int ret;
+  Context *oncommit = new C_SafeCond(&flock, &cond, &done, &ret);
+
+  objecter->mutate(oid,
+                   OSDMap::file_to_object_locator(in->layout),
+                   ops,
+                   in->snaprealm->get_snap_context(),
+                   ceph_clock_now(cct),
+                   0,
+                   NULL,
+                   oncommit);
+
+  client_lock.Unlock();
+  flock.Lock();
+  while (!done)
+    cond.Wait(flock);
+  flock.Unlock();
+  client_lock.Lock();
+
+  if (ret >= 0 || ret == -ECANCELED) {
+    in->inline_data.clear();
+    in->inline_version = CEPH_INLINE_DISABLED;
+    mark_caps_dirty(in, CEPH_CAP_FILE_WR);
+    check_caps(in, false);
+
+    ret = 0;
+  }
+
+  return ret;
+}
 
 // 
 
@@ -5688,6 +5762,30 @@ int Client::_read(Fh *f, int64_t offset, uint64_t size, bufferlist *bl)
     movepos = true;
   }
 
+  if (in->inline_version < CEPH_INLINE_DISABLED) {
+    if (!(have & CEPH_CAP_FILE_CACHE)) {
+      r = migration_inline_data(in);
+      if (r < 0)
+        goto done;
+    } else {
+      uint32_t len = in->inline_data.length();
+
+      uint64_t endoff = offset + size;
+      if (endoff > in->size)
+        endoff = in->size;
+
+      if (endoff > len) {
+        if (offset < len)
+          bl->substr_of(in->inline_data, offset, len - offset);
+        bl->append_zero(endoff - len);
+      } else if (endoff > (uint64_t)offset) {
+        bl->substr_of(in->inline_data, offset, endoff - offset);
+      }
+
+      goto success;
+    }
+  }
+
   if (!conf->client_debug_force_sync_read &&
       (cct->_conf->client_oc && (have & CEPH_CAP_FILE_CACHE))) {
 
@@ -5704,6 +5802,8 @@ int Client::_read(Fh *f, int64_t offset, uint64_t size, bufferlist *bl)
     goto done;
   }
 
+success:
+
   if (movepos) {
     // adjust fd pos
     f->pos = offset+bl->length();
@@ -5995,6 +6095,29 @@ int Client::_write(Fh *f, int64_t offset, uint64_t size, const char *buf)
 
   ldout(cct, 10) << " snaprealm " << *in->snaprealm << dendl;
 
+  if (in->inline_version < CEPH_INLINE_DISABLED) {
+    if (endoff > CEPH_INLINE_SIZE || !(have & CEPH_CAP_FILE_BUFFER)) {
+      r = migration_inline_data(in);
+      if (r < 0)
+        goto done;
+    } else {
+      uint32_t len = in->inline_data.length();
+
+      if (endoff < len)
+        in->inline_data.copy(endoff, len - endoff, bl);
+
+      if (offset < len)
+        in->inline_data.splice(offset, len - offset);
+      else if (offset > len)
+        in->inline_data.append_zero(offset - len);
+
+      in->inline_data.append(bl);
+      in->inline_version++;
+
+      goto success;
+    }
+  }
+
   if (cct->_conf->client_oc && (have & CEPH_CAP_FILE_BUFFER)) {
     // do buffered write
     if (!in->oset.dirty_or_tx)
@@ -6045,7 +6168,7 @@ int Client::_write(Fh *f, int64_t offset, uint64_t size, const char *buf)
   }
 
   // if we get here, write was successful, update client metadata
-
+success:
   // time
   lat = ceph_clock_now(cct);
   lat -= start;
@@ -7719,33 +7842,60 @@ int Client::_fallocate(Fh *fh, int mode, int64_t offset, int64_t length)
     return r;
 
   if (mode & FALLOC_FL_PUNCH_HOLE) {
-    Mutex flock("Client::_punch_hole flock");
-    Cond cond;
-    bool done = false;
-    Context *onfinish = new C_SafeCond(&flock, &cond, &done);
-    Context *onsafe = new C_Client_SyncCommit(this, in);
+    if (in->inline_version < CEPH_INLINE_DISABLED &&
+        (have & CEPH_CAP_FILE_BUFFER)) {
+      bufferlist bl;
+      int len = in->inline_data.length();
+      if (offset < len) {
+        if (offset > 0)
+          in->inline_data.copy(0, offset, bl);
+        int size = length;
+        if (offset + size > len)
+          size = len - offset;
+        if (size > 0)
+          bl.append_zero(size);
+        if (offset + size < len)
+          in->inline_data.copy(offset + size, len - offset - size, bl);
+        in->inline_data = bl;
+        in->inline_version++;
+      }
+      in->mtime = ceph_clock_now(cct);
+      mark_caps_dirty(in, CEPH_CAP_FILE_WR);
+    } else {
+      if (in->inline_version < CEPH_INLINE_DISABLED) {
+        r = migration_inline_data(in);
+        if (r < 0)
+          goto done;
+      }
 
-    unsafe_sync_write++;
-    get_cap_ref(in, CEPH_CAP_FILE_BUFFER);
+      Mutex flock("Client::_punch_hole flock");
+      Cond cond;
+      bool done = false;
+      Context *onfinish = new C_SafeCond(&flock, &cond, &done);
+      Context *onsafe = new C_Client_SyncCommit(this, in);
 
-    _invalidate_inode_cache(in, offset, length, true);
-    r = filer->zero(in->ino, &in->layout,
-                    in->snaprealm->get_snap_context(),
-                    offset, length,
-                    ceph_clock_now(cct),
-                    0, true, onfinish, onsafe);
-    if (r < 0)
-      goto done;
+      unsafe_sync_write++;
+      get_cap_ref(in, CEPH_CAP_FILE_BUFFER);
 
-    in->mtime = ceph_clock_now(cct);
-    mark_caps_dirty(in, CEPH_CAP_FILE_WR);
+      _invalidate_inode_cache(in, offset, length, true);
+      r = filer->zero(in->ino, &in->layout,
+                      in->snaprealm->get_snap_context(),
+                      offset, length,
+                      ceph_clock_now(cct),
+                      0, true, onfinish, onsafe);
+      if (r < 0)
+        goto done;
 
-    client_lock.Unlock();
-    flock.Lock();
-    while (!done)
-      cond.Wait(flock);
-    flock.Unlock();
-    client_lock.Lock();
+      in->mtime = ceph_clock_now(cct);
+      mark_caps_dirty(in, CEPH_CAP_FILE_WR);
+
+      client_lock.Unlock();
+      flock.Lock();
+      while (!done)
+        cond.Wait(flock);
+      flock.Unlock();
+      client_lock.Lock();
+    }
   } else if (!(mode & FALLOC_FL_KEEP_SIZE)) {
     uint64_t size = offset + length;
     if (size > in->size) {
diff --git a/src/client/Client.h b/src/client/Client.h
index c7c9cef..5fc05f4 100644
--- a/src/client/Client.h
+++ b/src/client/Client.h
@@ -420,6 +420,9 @@ protected:
 
   void handle_lease(MClientLease *m);
 
+  // inline data
+  int migration_inline_data(Inode *in);
+
   // file caps
   void check_cap_issue(Inode *in, Cap *cap, unsigned issued);
   void add_update_cap(Inode *in, MetaSession *session, uint64_t cap_id,
@@ -495,6 +498,7 @@ protected:
   void update_inode_file_bits(Inode *in,
 			      uint64_t truncate_seq, uint64_t truncate_size, uint64_t size,
 			      uint64_t time_warp_seq, utime_t ctime, utime_t mtime, utime_t atime,
+			      uint64_t inline_version, bufferlist& inline_data,
 			      int issued);
   Inode *add_update_inode(InodeStat *st, utime_t ttl, MetaSession *session);
   Dentry *insert_dentry_inode(Dir *dir, const string& dname, LeaseStat *dlease, 
diff --git a/src/client/Inode.h b/src/client/Inode.h
index cc054a6..bb17706 100644
--- a/src/client/Inode.h
+++ b/src/client/Inode.h
@@ -111,6 +111,10 @@ class Inode {
   version_t version;           // auth only
   version_t xattr_version;
 
+  // inline data
+  uint64_t   inline_version;
+  bufferlist inline_data;
+
   bool is_symlink() const { return (mode & S_IFMT) == S_IFLNK; }
   bool is_dir()     const { return (mode & S_IFMT) == S_IFDIR; }
   bool is_file()    const { return (mode & S_IFMT) == S_IFREG; }
@@ -207,6 +211,7 @@ class Inode {
       rdev(0), mode(0), uid(0), gid(0), nlink(0),
       size(0), truncate_seq(1), truncate_size(-1),
       time_warp_seq(0), max_size(0), version(0), xattr_version(0),
+      inline_version(0),
       flags(0),
       dir_hashed(false), dir_replicated(false), auth_cap(NULL),
       dirty_caps(0), flushing_caps(0), flushing_cap_seq(0), shared_gen(0), cache_gen(0),
diff --git a/src/include/ceph_features.h b/src/include/ceph_features.h
index c0f01cc..70ee921 100644
--- a/src/include/ceph_features.h
+++ b/src/include/ceph_features.h
@@ -40,6 +40,7 @@
 #define CEPH_FEATURE_MON_SCRUB      (1ULL<<33)
 #define CEPH_FEATURE_OSD_PACKED_RECOVERY (1ULL<<34)
 #define CEPH_FEATURE_OSD_CACHEPOOL (1ULL<<35)
+#define CEPH_FEATURE_MDS_INLINE_DATA     (1ULL<<36)
 
 /*
  * The introduction of CEPH_FEATURE_OSD_SNAPMAPPER caused the feature
@@ -103,6 +104,7 @@ static inline unsigned long long ceph_sanitize_features(unsigned long long f) {
 	 CEPH_FEATURE_MON_SCRUB	|	    \
 	 CEPH_FEATURE_OSD_PACKED_RECOVERY | \
 	 CEPH_FEATURE_OSD_CACHEPOOL | \
+	 CEPH_FEATURE_MDS_INLINE_DATA | \
 	 0ULL)
 
 #define CEPH_FEATURES_SUPPORTED_DEFAULT  CEPH_FEATURES_ALL
diff --git a/src/include/ceph_fs.h b/src/include/ceph_fs.h
index 6c41d14..406b51e 100644
--- a/src/include/ceph_fs.h
+++ b/src/include/ceph_fs.h
@@ -522,6 +522,9 @@ struct ceph_filelock {
 
 int ceph_flags_to_mode(int flags);
 
+/* inline data state */
+#define CEPH_INLINE_DISABLED	((__u64)-1)
+#define CEPH_INLINE_SIZE	(1 << 12)
 
 /* capability bits */
 #define CEPH_CAP_PIN         1  /* no specific capabilities beyond the pin */
diff --git a/src/include/rados.h b/src/include/rados.h
index 178c171..c387a2e 100644
--- a/src/include/rados.h
+++ b/src/include/rados.h
@@ -342,6 +342,7 @@ enum {
 enum {
 	CEPH_OSD_OP_FLAG_EXCL = 1,      /* EXCL object create */
 	CEPH_OSD_OP_FLAG_FAILOK = 2,    /* continue despite failure */
+	CEPH_OSD_OP_FLAG_NOENTOK = 4,   /* ignore NOENT error */
 };
 
 #define EOLDSNAPC    85  /* ORDERSNAP flag set; writer has old snapc*/
diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
index 46f8d33..729f126 100644
--- a/src/mds/CInode.cc
+++ b/src/mds/CInode.cc
@@ -2825,6 +2825,16 @@ int CInode::encode_inodestat(bufferlist& bl, Session *session,
   e.files = i->dirstat.nfiles;
   e.subdirs = i->dirstat.nsubdirs;
 
+  // inline data
+  uint64_t inline_version = 0;
+  bufferlist inline_data;
+  if (!cap || (cap->client_inline_version < i->inline_version)) {
+    inline_version = i->inline_version;
+    inline_data = i->inline_data;
+    if (cap)
+      cap->client_inline_version = i->inline_version;
+  }
+
   // nest (do same as file... :/)
   i->rstat.rctime.encode_timeval(&e.rctime);
   e.rbytes = i->rstat.rbytes;
@@ -2863,6 +2873,7 @@ int CInode::encode_inodestat(bufferlist& bl, Session *session,
     bytes += (sizeof(__u32) + sizeof(__u32)) * dirfragtree._splits.size();
     bytes += sizeof(__u32) + symlink.length();
     bytes += sizeof(__u32) + xbl.length();
+    bytes += sizeof(__u64) + sizeof(__u32) + inline_data.length();
     if (bytes > max_bytes)
       return -ENOSPC;
   }
@@ -2958,6 +2969,10 @@ int CInode::encode_inodestat(bufferlist& bl, Session *session,
     ::encode(i->dir_layout, bl);
   }
   ::encode(xbl, bl);
+  if (session->connection->has_feature(CEPH_FEATURE_MDS_INLINE_DATA)) {
+    ::encode(inline_version, bl);
+    ::encode(inline_data, bl);
+  }
 
   return valid;
 }
@@ -2990,6 +3005,13 @@ void CInode::encode_cap_message(MClientCaps *m, Capability *cap)
   i->atime.encode_timeval(&m->head.atime);
   m->head.time_warp_seq = i->time_warp_seq;
 
+  if (cap->client_inline_version < i->inline_version) {
+    m->inline_version = cap->client_inline_version = i->inline_version;
+    m->inline_data = i->inline_data;
+  } else {
+    m->inline_version = 0;
+  }
+
   // max_size is min of projected, actual.
   uint64_t oldms = oi->client_ranges.count(client) ? oi->client_ranges[client].range.last : 0;
   uint64_t newms = pi->client_ranges.count(client) ? pi->client_ranges[client].range.last : 0;
diff --git a/src/mds/Capability.h b/src/mds/Capability.h
index fb6b3dc..995ea3a 100644
--- a/src/mds/Capability.h
+++ b/src/mds/Capability.h
@@ -209,6 +209,7 @@ private:
 public:
   snapid_t client_follows;
   version_t client_xattr_version;
+  uint64_t client_inline_version;
   
   xlist<Capability*>::item item_session_caps;
   xlist<Capability*>::item item_snaprealm_caps;
@@ -223,6 +224,7 @@ public:
     mseq(0),
     suppress(0), stale(false),
     client_follows(0), client_xattr_version(0),
+    client_inline_version(0),
     item_session_caps(this), item_snaprealm_caps(this) {
     g_num_cap++;
     g_num_capa++;
diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index 99bd761..4f1d322 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -2686,6 +2686,7 @@ void Locker::_update_cap_fields(CInode *in, int dirty, MClientCaps *m, inode_t *
     utime_t mtime = m->get_mtime();
     utime_t ctime = m->get_ctime();
     uint64_t size = m->get_size();
+    uint64_t inline_version = m->inline_version;
     
     if (((dirty & CEPH_CAP_FILE_WR) && mtime > pi->mtime) ||
 	((dirty & CEPH_CAP_FILE_EXCL) && mtime != pi->mtime)) {
@@ -2705,6 +2706,12 @@ void Locker::_update_cap_fields(CInode *in, int dirty, MClientCaps *m, inode_t *
       pi->size = size;
       pi->rstat.rbytes = size;
     }
+    if (in->inode.is_file() &&
+        (dirty & CEPH_CAP_FILE_WR) &&
+        inline_version > pi->inline_version) {
+      pi->inline_version = inline_version;
+      pi->inline_data = m->inline_data;
+    }
     if ((dirty & CEPH_CAP_FILE_EXCL) && atime != pi->atime) {
       dout(7) << "  atime " << pi->atime << " -> " << atime
 	      << " for " << *in << dendl;
diff --git a/src/mds/mdstypes.cc b/src/mds/mdstypes.cc
index 6886786..8634adf 100644
--- a/src/mds/mdstypes.cc
+++ b/src/mds/mdstypes.cc
@@ -204,7 +204,7 @@ ostream& operator<<(ostream& out, const client_writeable_range_t& r)
  */
 void inode_t::encode(bufferlist &bl) const
 {
-  ENCODE_START(7, 6, bl);
+  ENCODE_START(8, 8, bl);
 
   ::encode(ino, bl);
   ::encode(rdev, bl);
@@ -227,6 +227,8 @@ void inode_t::encode(bufferlist &bl) const
   ::encode(mtime, bl);
   ::encode(atime, bl);
   ::encode(time_warp_seq, bl);
+  ::encode(inline_version, bl);
+  ::encode(inline_data, bl);
   ::encode(client_ranges, bl);
 
   ::encode(dirstat, bl);
@@ -244,7 +246,7 @@ void inode_t::encode(bufferlist &bl) const
 
 void inode_t::decode(bufferlist::iterator &p)
 {
-  DECODE_START_LEGACY_COMPAT_LEN(7, 6, 6, p);
+  DECODE_START_LEGACY_COMPAT_LEN(8, 6, 6, p);
 
   ::decode(ino, p);
   ::decode(rdev, p);
@@ -273,6 +275,12 @@ void inode_t::decode(bufferlist::iterator &p)
   ::decode(mtime, p);
   ::decode(atime, p);
   ::decode(time_warp_seq, p);
+  if (struct_v >= 8) {
+    ::decode(inline_version, p);
+    ::decode(inline_data, p);
+  } else {
+    inline_version = CEPH_INLINE_DISABLED;
+  }
   if (struct_v >= 3) {
     ::decode(client_ranges, p);
   } else {
diff --git a/src/mds/mdstypes.h b/src/mds/mdstypes.h
index 902e310..928167c 100644
--- a/src/mds/mdstypes.h
+++ b/src/mds/mdstypes.h
@@ -335,6 +335,8 @@ struct inode_t {
   utime_t    mtime;   // file data modify time.
   utime_t    atime;   // file data access time.
   uint32_t   time_warp_seq;  // count of (potential) mtime/atime timewarps (i.e., utimes())
+  bufferlist inline_data;
+  uint64_t   inline_version;
 
   map<client_t,client_writeable_range_t> client_ranges;  // client(s) can write to these ranges
 
@@ -356,6 +358,7 @@ struct inode_t {
 	      size(0), truncate_seq(0), truncate_size(0), truncate_from(0),
 	      truncate_pending(0),
 	      time_warp_seq(0),
+	      inline_version(1),
 	      version(0), file_data_version(0), xattr_version(0), backtrace_version(0) {
     clear_layout();
     memset(&dir_layout, 0, sizeof(dir_layout));
diff --git a/src/messages/MClientCaps.h b/src/messages/MClientCaps.h
index 117f241..260d714 100644
--- a/src/messages/MClientCaps.h
+++ b/src/messages/MClientCaps.h
@@ -21,7 +21,7 @@
 
 class MClientCaps : public Message {
 
-  static const int HEAD_VERSION = 2;   // added flock metadata
+  static const int HEAD_VERSION = 3;   // added flock metadata, inline data
   static const int COMPAT_VERSION = 1;
 
  public:
@@ -29,6 +29,8 @@ class MClientCaps : public Message {
   bufferlist snapbl;
   bufferlist xattrbl;
   bufferlist flockbl;
+  uint64_t   inline_version;
+  bufferlist inline_data;
 
   int      get_caps() { return head.caps; }
   int      get_wanted() { return head.wanted; }
@@ -148,6 +150,13 @@ public:
     if (head.xattr_len)
       xattrbl = middle;
 
+    if (header.version >= 3) {
+      ::decode(inline_version, p);
+      ::decode(inline_data, p);
+    } else {
+      inline_version = CEPH_INLINE_DISABLED;
+    }
+
     // conditionally decode flock metadata
     if (header.version >= 2)
       ::decode(flockbl, p);
@@ -160,6 +169,13 @@ public:
 
     middle = xattrbl;
 
+    if (features & CEPH_FEATURE_MDS_INLINE_DATA) {
+      ::encode(inline_version, payload);
+      ::encode(inline_data, payload);
+    } else {
+      header.version = 2;
+    }
+
     // conditionally include flock metadata
     if (features & CEPH_FEATURE_FLOCK) {
       ::encode(flockbl, payload);
diff --git a/src/messages/MClientReply.h b/src/messages/MClientReply.h
index 896245f..a8e83c2 100644
--- a/src/messages/MClientReply.h
+++ b/src/messages/MClientReply.h
@@ -108,6 +108,8 @@ struct InodeStat {
   uint64_t truncate_size;
   utime_t ctime, mtime, atime;
   version_t time_warp_seq;
+  bufferlist inline_data;
+  uint64_t inline_version;
 
   frag_info_t dirstat;
   nest_info_t rstat;
@@ -174,6 +176,13 @@ struct InodeStat {
 
     xattr_version = e.xattr_version;
     ::decode(xattrbl, p);
+
+    if (features & CEPH_FEATURE_MDS_INLINE_DATA) {
+      ::decode(inline_version, p);
+      ::decode(inline_data, p);
+    } else {
+      inline_version = CEPH_INLINE_DISABLED;
+    }
   }
   
   // see CInode::encode_inodestat for encoder.
diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
index b391e17..30f7d01 100644
--- a/src/osd/ReplicatedPG.cc
+++ b/src/osd/ReplicatedPG.cc
@@ -2398,8 +2398,11 @@ int ReplicatedPG::do_osd_ops(OpContext *ctx, vector<OSDOp>& ops)
 	  result = osd->store->getattr(coll, soid, name.c_str(), xattr);
 	else
 	  result = osd->store->getattr(coll, src_obc->obs.oi.soid, name.c_str(), xattr);
-	if (result < 0 && result != -EEXIST && result != -ENODATA)
+       int flags = le32_to_cpu(op.flags);
+	if (result < 0 && result != -EEXIST && result != -ENODATA &&
+	    (!(flags & CEPH_OSD_OP_FLAG_NOENTOK) || result != -ENOENT)) {
 	  break;
+	}
 	
 	ctx->delta_stats.num_rd++;
 	ctx->delta_stats.num_rd_kb += SHIFT_ROUND_UP(xattr.length(), 10);
diff --git a/src/osdc/Objecter.h b/src/osdc/Objecter.h
index 154ee41..230745b 100644
--- a/src/osdc/Objecter.h
+++ b/src/osdc/Objecter.h
@@ -112,9 +112,10 @@ struct ObjectOperation {
       osd_op.indata.append(name);
     osd_op.indata.append(data);
   }
-  void add_xattr_cmp(int op, const char *name, uint8_t cmp_op, uint8_t cmp_mode, const bufferlist& data) {
+  void add_xattr_cmp(int op, const char *name, uint8_t cmp_op, uint8_t cmp_mode, uint32_t flags, const bufferlist& data) {
     OSDOp& osd_op = add_op(op);
     osd_op.op.op = op;
+    osd_op.op.flags = flags;
     osd_op.op.xattr.name_len = (name ? strlen(name) : 0);
     osd_op.op.xattr.value_len = data.length();
     osd_op.op.xattr.cmp_op = cmp_op;
@@ -279,8 +280,16 @@ struct ObjectOperation {
     out_handler[p] = h;
     out_rval[p] = prval;
   }
-  void write(uint64_t off, bufferlist& bl) {
+  void write(uint64_t off, bufferlist& bl,
+             uint64_t truncate_size,
+             uint32_t truncate_seq) {
     add_data(CEPH_OSD_OP_WRITE, off, bl.length(), bl);
+    OSDOp& o = *ops.rbegin();
+    o.op.extent.truncate_size = truncate_size;
+    o.op.extent.truncate_seq = truncate_seq;
+  }
+  void write(uint64_t off, bufferlist& bl) {
+    write(off, bl, 0, 0);
   }
   void write_full(bufferlist& bl) {
     add_data(CEPH_OSD_OP_WRITEFULL, 0, bl.length(), bl);
@@ -453,7 +462,10 @@ struct ObjectOperation {
     add_xattr(CEPH_OSD_OP_SETXATTR, name, bl);
   }
   void cmpxattr(const char *name, uint8_t cmp_op, uint8_t cmp_mode, const bufferlist& bl) {
-    add_xattr_cmp(CEPH_OSD_OP_CMPXATTR, name, cmp_op, cmp_mode, bl);
+    add_xattr_cmp(CEPH_OSD_OP_CMPXATTR, name, cmp_op, cmp_mode, 0, bl);
+  }
+  void cmpxattr(const char *name, uint8_t cmp_op, uint8_t cmp_mode, uint32_t flags, const bufferlist& bl) {
+    add_xattr_cmp(CEPH_OSD_OP_CMPXATTR, name, cmp_op, cmp_mode, flags, bl);
   }
   void rmxattr(const char *name) {
     bufferlist bl;
@@ -733,11 +745,12 @@ struct ObjectOperation {
   }
 
   void cmpxattr(const char *name, const bufferlist& val,
-		int op, int mode) {
+		int op, int mode, int flags = 0) {
     add_xattr(CEPH_OSD_OP_CMPXATTR, name, val);
     OSDOp& o = *ops.rbegin();
     o.op.xattr.cmp_op = op;
     o.op.xattr.cmp_mode = mode;
+    o.op.flags = flags;
   }
   void src_cmpxattr(const object_t& srcoid, snapid_t srcsnapid,
 		    const char *name, const bufferlist& val,
-- 
1.7.9.5

