From: Li Wang <liwang@ubuntukylin.com>
Subject: [RFC] Inline data support
Date: Wed,  3 Jul 2013 22:46:07 +0800
Message-ID: <1372862768-8194-1-git-send-email-liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:60906 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932705Ab3GCOqm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Jul 2013 10:46:42 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Yehuda Sadeh <yehuda@inktank.com>, Li Wang <liwang@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

This patch gives a preliminary implementation of inline data support for Ceph.
Comments are appreciated.

Signed-off-by: Li Wang <liwang@ubuntukylin.com>
Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
---
 src/client/Client.cc        |  158 ++++++++++++++++++++++++++++++++++++++-----
 src/client/Inode.h          |    6 ++
 src/include/ceph_fs.h       |    9 +++
 src/mds/CInode.cc           |   22 ++++++
 src/mds/Capability.h        |    3 +
 src/mds/Locker.cc           |   48 +++++++++++++
 src/mds/mdstypes.cc         |    4 ++
 src/mds/mdstypes.h          |    3 +
 src/messages/MClientCaps.h  |    6 ++
 src/messages/MClientReply.h |    4 ++
 10 files changed, 246 insertions(+), 17 deletions(-)

diff --git a/src/client/Client.cc b/src/client/Client.cc
index bddfa0a..fe947be 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -632,6 +632,11 @@ Inode * Client::add_update_inode(InodeStat *st, utime_t from, MetaSession *sessi
     in->layout = st->layout;
     in->ctime = st->ctime;
     in->max_size = st->max_size;  // right?
+
+    if (st->inline_version > in->inline_version) {
+      in->inline_version = st->inline_version;
+      in->inline_data = st->inline_data;
+    }
   
     update_inode_file_bits(in, st->truncate_seq, st->truncate_size, st->size,
 			   st->time_warp_seq, st->ctime, st->mtime, st->atime,
@@ -2321,6 +2326,17 @@ void Client::send_cap(Inode *in, MetaSession *session, Cap *cap,
     ::encode(in->xattrs, m->xattrbl);
     m->head.xattr_version = in->xattr_version;
   }
+
+  if ((flush & CEPH_CAP_FILE_WR) &&
+      (flush & CEPH_CAP_FILE_BUFFER)) {
+    if (in->inline_commit_data.length()) {
+      m->head.inline_version = 0;
+      m->inline_data = in->inline_commit_data;
+    } else {
+      m->head.inline_version = in->inline_version;
+      m->inline_data = in->inline_data;
+    }
+  }
   
   m->head.layout = in->layout;
   m->head.size = in->size;
@@ -3550,6 +3566,13 @@ void Client::handle_cap_grant(MetaSession *session, Inode *in, Cap *cap, MClient
     ::decode(in->xattrs, p);
     in->xattr_version = m->head.xattr_version;
   }
+  if ((new_caps & CEPH_CAP_FILE_CACHE) &&
+      (m->get_inline_version() >= in->inline_version)) {
+    ldout(cct, 10) << " update inline version " << m->get_inline_version() << dendl;
+    in->inline_version = m->get_inline_version();
+    in->inline_data = m->inline_data;
+  }
+
   update_inode_file_bits(in, m->get_truncate_seq(), m->get_truncate_size(), m->get_size(),
 			 m->get_time_warp_seq(), m->get_ctime(), m->get_mtime(), m->get_atime(), issued);
 
@@ -5637,6 +5660,13 @@ int Client::_read(Fh *f, int64_t offset, uint64_t size, bufferlist *bl)
   Inode *in = f->inode;
 
   //bool lazy = f->mode == CEPH_FILE_MODE_LAZY;
+  if ((in->inline_version != CEPH_INLINE_DISABLED) &&
+      !(in->caps_issued(NULL) & CEPH_CAP_FILE_CACHE)) {
+    ldout(cct, 10) << " read inline from mds." << dendl;
+    int ret = _getattr(in, CEPH_STAT_CAP_INLINE, -1, -1, true);
+    if (ret < 0)
+      return ret;
+  }
 
   int have;
   int r = get_caps(in, CEPH_CAP_FILE_RD, CEPH_CAP_FILE_CACHE, &have, -1);
@@ -5650,15 +5680,31 @@ int Client::_read(Fh *f, int64_t offset, uint64_t size, bufferlist *bl)
     movepos = true;
   }
 
-  if (!conf->client_debug_force_sync_read &&
-      (cct->_conf->client_oc && (have & CEPH_CAP_FILE_CACHE))) {
+  unsigned int inlinesize = 0;
+  if (in->inline_version != CEPH_INLINE_DISABLED) {
+    if (offset < in->inline_data.length()) {
+      inlinesize = in->inline_data.length() - offset;
+      if (inlinesize > size)
+        inlinesize = size;
+      in->inline_data.copy(offset, inlinesize, *bl);
+    }
+  }
+
+  if (size > inlinesize) {
+    bufferlist blread;
+    int64_t bloffset = offset + inlinesize;
+    uint64_t blsize = size - inlinesize;
+    if (!conf->client_debug_force_sync_read &&
+        (cct->_conf->client_oc && (have & CEPH_CAP_FILE_CACHE))) {
 
-    if (f->flags & O_RSYNC) {
-      _flush_range(in, offset, size);
+      if (f->flags & O_RSYNC) {
+        _flush_range(in, bloffset, blsize);
+      }
+      r = _read_async(f, bloffset, blsize, &blread);
+    } else {
+      r = _read_sync(f, bloffset, blsize, &blread);
     }
-    r = _read_async(f, offset, size, bl);
-  } else {
-    r = _read_sync(f, offset, size, bl);
+    bl->claim_append(blread);
   }
 
   // don't move pointer if the read failed
@@ -5935,22 +5981,91 @@ int Client::_write(Fh *f, int64_t offset, uint64_t size, const char *buf)
   // time it.
   utime_t start = ceph_clock_now(cct);
 
-  // copy into fresh buffer (since our write may be resub, async)
-  bufferptr bp;
-  if (size > 0) bp = buffer::copy(buf, size);
-  bufferlist bl;
-  bl.push_back( bp );
-
   utime_t lat;
   uint64_t totalwritten;
   uint64_t endoff = offset + size;
   int have;
-  int r = get_caps(in, CEPH_CAP_FILE_WR, CEPH_CAP_FILE_BUFFER, &have, endoff);
+  int want;
+  if (in->inline_version != CEPH_INLINE_DISABLED) {
+    want = 0;
+    if (offset < CEPH_INLINE_SIZE)
+      want |= CEPH_CAP_FILE_CACHE;
+    if (offset + size > CEPH_INLINE_SIZE)
+      want |= CEPH_CAP_FILE_BUFFER;
+  } else {
+    want = CEPH_CAP_FILE_BUFFER;
+  }
+  int r = get_caps(in, CEPH_CAP_FILE_WR, want, &have, endoff);
   if (r < 0)
     return r;
 
   ldout(cct, 10) << " snaprealm " << *in->snaprealm << dendl;
 
+  bufferlist inlinebl, osdbl;
+  if (size > 0) {
+    // copy into fresh buffer (since our write may be resub, async)
+    bufferptr bp(buf, size);
+    if ((in->inline_version != CEPH_INLINE_DISABLED) &&
+        (want & CEPH_CAP_FILE_CACHE)) {
+
+      if (want & CEPH_CAP_FILE_BUFFER) {
+        bufferptr inlinebp(bp, 0, CEPH_INLINE_SIZE - offset);
+        inlinebl.push_back(inlinebp);
+        bufferptr osdbp(bp, CEPH_INLINE_SIZE - offset, size + offset - CEPH_INLINE_SIZE);
+        osdbl.push_back(osdbp);
+      } else {
+        inlinebl.push_back(bp);
+      }
+
+      if (have & CEPH_CAP_FILE_CACHE) {
+        bufferlist bl;
+
+        uint32_t len = in->inline_data.length();
+        if (offset < len) {
+          bl.substr_of(in->inline_data, 0, offset);
+        } else {
+          bl.append(in->inline_data);
+          if (offset > len)
+            bl.append_zero(offset - len);
+        }
+        bl.append(inlinebl);
+        if (bl.length() < len)
+          in->inline_data.copy(bl.length(), len - bl.length(), bl);
+
+        if (in->inline_version >= CEPH_INLINE_MIGRATION) {
+          ldout(cct, 10) << " migrate data." << dendl;
+          bl.append(osdbl);
+          osdbl.claim(bl);
+        } else {
+          in->inline_data.claim(bl);
+        }
+      } else {
+        encode((uint32_t)offset, in->inline_commit_data);
+        encode(inlinebl, in->inline_commit_data);
+      }
+
+      if ((in->inline_version < CEPH_INLINE_MIGRATION) ||
+          !(have & CEPH_CAP_FILE_CACHE)) {
+        mark_caps_dirty(in, CEPH_CAP_FILE_WR | CEPH_CAP_FILE_BUFFER);
+        check_caps(in, true);
+      }
+
+      if (!(have & CEPH_CAP_FILE_CACHE)) {
+        in->inline_commit_data.clear();
+      }
+    } else {
+      osdbl.push_back(bp);
+    }
+  }
+
+  uint64_t osdsize = osdbl.length();
+  int64_t osdoffset = offset + size - osdsize;
+  if (osdoffset < 0)
+    osdoffset = 0;
+
+  if (!osdsize)
+    goto skip_osd;
+
   if (cct->_conf->client_oc && (have & CEPH_CAP_FILE_BUFFER)) {
     // do buffered write
     if (!in->oset.dirty_or_tx)
@@ -5960,7 +6075,7 @@ int Client::_write(Fh *f, int64_t offset, uint64_t size, const char *buf)
 
     // async, caching, non-blocking.
     r = objectcacher->file_write(&in->oset, &in->layout, in->snaprealm->get_snap_context(),
-			         offset, size, bl, ceph_clock_now(cct), 0,
+			         osdoffset, osdsize, osdbl, ceph_clock_now(cct), 0,
 			         client_lock);
 
     put_cap_ref(in, CEPH_CAP_FILE_BUFFER);
@@ -5972,7 +6087,7 @@ int Client::_write(Fh *f, int64_t offset, uint64_t size, const char *buf)
     // O_DSYNC == O_SYNC on linux < 2.6.33
     // O_SYNC = __O_SYNC | O_DSYNC on linux >= 2.6.33
     if ((f->flags & O_SYNC) || (f->flags & O_DSYNC)) {
-      _flush_range(in, offset, size);
+      _flush_range(in, osdoffset, osdsize);
     }
   } else {
     // simple, non-atomic sync write
@@ -5986,7 +6101,7 @@ int Client::_write(Fh *f, int64_t offset, uint64_t size, const char *buf)
     get_cap_ref(in, CEPH_CAP_FILE_BUFFER);  // released by onsafe callback
 
     r = filer->write_trunc(in->ino, &in->layout, in->snaprealm->get_snap_context(),
-			   offset, size, bl, ceph_clock_now(cct), 0,
+			   osdoffset, osdsize, osdbl, ceph_clock_now(cct), 0,
 			   in->truncate_size, in->truncate_seq,
 			   onfinish, onsafe);
     if (r < 0)
@@ -6001,6 +6116,15 @@ int Client::_write(Fh *f, int64_t offset, uint64_t size, const char *buf)
   }
 
   // if we get here, write was successful, update client metadata
+skip_osd:
+  if ((have & CEPH_CAP_FILE_CACHE) &&
+      (in->inline_version >= CEPH_INLINE_MIGRATION)) {
+    ldout(cct, 10) << " disable inline." << dendl;
+    in->inline_version = CEPH_INLINE_DISABLED;
+    in->inline_data.clear();
+    mark_caps_dirty(in, CEPH_CAP_FILE_WR | CEPH_CAP_FILE_BUFFER);
+    check_caps(in, true);
+  }
 
   // time
   lat = ceph_clock_now(cct);
diff --git a/src/client/Inode.h b/src/client/Inode.h
index b33c38e..455fc37 100644
--- a/src/client/Inode.h
+++ b/src/client/Inode.h
@@ -111,6 +111,11 @@ class Inode {
   version_t version;           // auth only
   version_t xattr_version;
 
+  // inline data
+  bufferlist inline_data;
+  version_t  inline_version;
+  bufferlist inline_commit_data;
+
   bool is_symlink() const { return (mode & S_IFMT) == S_IFLNK; }
   bool is_dir()     const { return (mode & S_IFMT) == S_IFDIR; }
   bool is_file()    const { return (mode & S_IFMT) == S_IFREG; }
@@ -205,6 +210,7 @@ class Inode {
       rdev(0), mode(0), uid(0), gid(0), nlink(0),
       size(0), truncate_seq(1), truncate_size(-1),
       time_warp_seq(0), max_size(0), version(0), xattr_version(0),
+      inline_version(0),
       flags(0),
       dir_hashed(false), dir_replicated(false), auth_cap(NULL),
       dirty_caps(0), flushing_caps(0), flushing_cap_seq(0), shared_gen(0), cache_gen(0),
diff --git a/src/include/ceph_fs.h b/src/include/ceph_fs.h
index 6c41d14..bd81687 100644
--- a/src/include/ceph_fs.h
+++ b/src/include/ceph_fs.h
@@ -471,6 +471,7 @@ struct ceph_mds_reply_inode {
 	struct ceph_file_layout layout;
 	struct ceph_timespec ctime, mtime, atime;
 	__le32 time_warp_seq;
+	__le32 inline_version;
 	__le64 size, max_size, truncate_size;
 	__le32 truncate_seq;
 	__le32 mode, uid, gid;
@@ -522,6 +523,10 @@ struct ceph_filelock {
 
 int ceph_flags_to_mode(int flags);
 
+/* inline data state */
+#define CEPH_INLINE_DISABLED   ((__u32)-1)
+#define CEPH_INLINE_MIGRATION  (CEPH_INLINE_DISABLED >> 1)
+#define CEPH_INLINE_SIZE       (1 << 8)
 
 /* capability bits */
 #define CEPH_CAP_PIN         1  /* no specific capabilities beyond the pin */
@@ -580,6 +585,7 @@ int ceph_flags_to_mode(int flags);
 #define CEPH_STAT_CAP_MTIME    CEPH_CAP_FILE_SHARED
 #define CEPH_STAT_CAP_SIZE     CEPH_CAP_FILE_SHARED
 #define CEPH_STAT_CAP_ATIME    CEPH_CAP_FILE_SHARED  /* fixme */
+#define CEPH_STAT_CAP_INLINE   CEPH_CAP_FILE_SHARED
 #define CEPH_STAT_CAP_XATTR    CEPH_CAP_XATTR_SHARED
 #define CEPH_STAT_CAP_INODE_ALL (CEPH_CAP_PIN |			\
 				 CEPH_CAP_AUTH_SHARED |	\
@@ -657,6 +663,9 @@ struct ceph_mds_caps {
 	struct ceph_timespec mtime, atime, ctime;
 	struct ceph_file_layout layout;
 	__le32 time_warp_seq;
+
+	/* ilnine data */
+	__le32 inline_version;
 } __attribute__ ((packed));
 
 /* cap release msg head */
diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
index 781ed72..3999078 100644
--- a/src/mds/CInode.cc
+++ b/src/mds/CInode.cc
@@ -2706,6 +2706,17 @@ int CInode::encode_inodestat(bufferlist& bl, Session *session,
   e.rfiles = i->rstat.rfiles;
   e.rsubdirs = i->rstat.rsubdirs;
 
+  // inline data
+  bufferlist inline_data;
+  if (!cap || (cap->client_inline_version < i->inline_version)) {
+    e.inline_version = i->inline_version;
+    inline_data = i->inline_data;
+  }
+  if (cap && (cap->client_inline_version < i->inline_version)) {
+    cap->client_inline_version = i->inline_version;
+    cap->server_inline_version = i->inline_version;
+  }
+
   // auth
   i = pauth ? pi:oi;
   e.mode = i->mode;
@@ -2738,6 +2749,7 @@ int CInode::encode_inodestat(bufferlist& bl, Session *session,
     bytes += (sizeof(__u32) + sizeof(__u32)) * dirfragtree._splits.size();
     bytes += sizeof(__u32) + symlink.length();
     bytes += sizeof(__u32) + xbl.length();
+    bytes += sizeof(__u32) + inline_data.length();
     if (bytes > max_bytes)
       return -ENOSPC;
   }
@@ -2833,6 +2845,7 @@ int CInode::encode_inodestat(bufferlist& bl, Session *session,
     ::encode(i->dir_layout, bl);
   }
   ::encode(xbl, bl);
+  ::encode(inline_data, bl);
 
   return valid;
 }
@@ -2865,6 +2878,15 @@ void CInode::encode_cap_message(MClientCaps *m, Capability *cap)
   i->atime.encode_timeval(&m->head.atime);
   m->head.time_warp_seq = i->time_warp_seq;
 
+  if ((cap->pending() & CEPH_CAP_FILE_CACHE) &&
+      (i->inline_version > cap->client_inline_version)) {
+    dout(10) << " push updated inline data version " << i->inline_version << dendl;
+    m->head.inline_version = i->inline_version;
+    m->inline_data = i->inline_data;
+    cap->client_inline_version = i->inline_version;
+    cap->server_inline_version = i->inline_version;
+  }
+  
   // max_size is min of projected, actual.
   uint64_t oldms = oi->client_ranges.count(client) ? oi->client_ranges[client].range.last : 0;
   uint64_t newms = pi->client_ranges.count(client) ? pi->client_ranges[client].range.last : 0;
diff --git a/src/mds/Capability.h b/src/mds/Capability.h
index 54d2312..aa8fbb9 100644
--- a/src/mds/Capability.h
+++ b/src/mds/Capability.h
@@ -207,6 +207,8 @@ private:
 public:
   snapid_t client_follows;
   version_t client_xattr_version;
+  version_t client_inline_version;
+  version_t server_inline_version;
   
   xlist<Capability*>::item item_session_caps;
   xlist<Capability*>::item item_snaprealm_caps;
@@ -221,6 +223,7 @@ public:
     mseq(0),
     suppress(0), stale(false),
     client_follows(0), client_xattr_version(0),
+    client_inline_version(0), server_inline_version(0),
     item_session_caps(this), item_snaprealm_caps(this) {
     g_num_cap++;
     g_num_capa++;
diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index c5ddb92..a45a4db 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -2844,6 +2844,54 @@ bool Locker::_do_cap_update(CInode *in, Capability *cap,
 
   _update_cap_fields(in, dirty, m, pi);
 
+  if ((dirty & CEPH_CAP_FILE_WR) && 
+      (dirty & CEPH_CAP_FILE_BUFFER) && 
+      in->inode.is_file()) {
+    if (!m->get_inline_version()) {
+      bufferlist::iterator p = m->inline_data.begin();
+
+      uint32_t offset = 0;
+      bufferlist inlinebl;
+      if (!p.end())
+        decode(offset, p);
+      if (!p.end())
+        decode(inlinebl, p);
+
+      if (offset + inlinebl.length() > 0) {
+        bufferlist bl;
+
+        uint32_t len = pi->inline_data.length();
+        if (offset < len) {
+          bl.substr_of(pi->inline_data, 0, offset);
+        } else {
+          bl.append(pi->inline_data);
+          if (offset > len)
+            bl.append_zero(offset - len);
+        }
+        bl.append(inlinebl);
+        if (bl.length() < len)
+          pi->inline_data.copy(bl.length(), len - bl.length(), bl);
+
+        pi->inline_data.claim(bl);
+        pi->inline_version++;
+        if ((pi->size > CEPH_INLINE_SIZE) && (pi->inline_version < CEPH_INLINE_MIGRATION))
+          pi->inline_version = CEPH_INLINE_MIGRATION;
+      }
+    } else {
+      if (cap && 
+          (m->get_inline_version() >= cap->client_inline_version) &&
+          (cap->server_inline_version == pi->inline_version)) {
+        pi->inline_data = m->inline_data;
+        version_t newversion = pi->inline_version + 1;
+        if (m->get_inline_version() > newversion)
+          newversion = m->get_inline_version();
+        if ((pi->size > CEPH_INLINE_SIZE) && (newversion < CEPH_INLINE_MIGRATION))
+          newversion = CEPH_INLINE_MIGRATION;
+        pi->inline_version = cap->server_inline_version = newversion;
+      }
+    }
+  }
+
   if (change_max) {
     dout(7) << "  max_size " << old_max << " -> " << new_max
 	    << " for " << *in << dendl;
diff --git a/src/mds/mdstypes.cc b/src/mds/mdstypes.cc
index b1ce640..bb56122 100644
--- a/src/mds/mdstypes.cc
+++ b/src/mds/mdstypes.cc
@@ -227,6 +227,8 @@ void inode_t::encode(bufferlist &bl) const
   ::encode(mtime, bl);
   ::encode(atime, bl);
   ::encode(time_warp_seq, bl);
+  ::encode(inline_version, bl);
+  ::encode(inline_data, bl);
   ::encode(client_ranges, bl);
 
   ::encode(dirstat, bl);
@@ -273,6 +275,8 @@ void inode_t::decode(bufferlist::iterator &p)
   ::decode(mtime, p);
   ::decode(atime, p);
   ::decode(time_warp_seq, p);
+  ::decode(inline_version, p);
+  ::decode(inline_data, p);
   if (struct_v >= 3) {
     ::decode(client_ranges, p);
   } else {
diff --git a/src/mds/mdstypes.h b/src/mds/mdstypes.h
index aa9d165..7e8a69a 100644
--- a/src/mds/mdstypes.h
+++ b/src/mds/mdstypes.h
@@ -334,6 +334,8 @@ struct inode_t {
   utime_t    mtime;   // file data modify time.
   utime_t    atime;   // file data access time.
   uint32_t   time_warp_seq;  // count of (potential) mtime/atime timewarps (i.e., utimes())
+  bufferlist inline_data;
+  version_t  inline_version;
 
   map<client_t,client_writeable_range_t> client_ranges;  // client(s) can write to these ranges
 
@@ -355,6 +357,7 @@ struct inode_t {
 	      size(0), truncate_seq(0), truncate_size(0), truncate_from(0),
 	      truncate_pending(0),
 	      time_warp_seq(0),
+	      inline_version(1),
 	      version(0), file_data_version(0), xattr_version(0), last_renamed_version(0) { 
     clear_layout();
     memset(&dir_layout, 0, sizeof(dir_layout));
diff --git a/src/messages/MClientCaps.h b/src/messages/MClientCaps.h
index 117f241..aab28d2 100644
--- a/src/messages/MClientCaps.h
+++ b/src/messages/MClientCaps.h
@@ -29,6 +29,7 @@ class MClientCaps : public Message {
   bufferlist snapbl;
   bufferlist xattrbl;
   bufferlist flockbl;
+  bufferlist inline_data;
 
   int      get_caps() { return head.caps; }
   int      get_wanted() { return head.wanted; }
@@ -49,6 +50,7 @@ class MClientCaps : public Message {
   utime_t get_mtime() { return utime_t(head.mtime); }
   utime_t get_atime() { return utime_t(head.atime); }
   __u32 get_time_warp_seq() { return head.time_warp_seq; }
+  __u32 get_inline_version() { return head.inline_version; }
 
   ceph_file_layout& get_layout() { return head.layout; }
 
@@ -151,6 +153,8 @@ public:
     // conditionally decode flock metadata
     if (header.version >= 2)
       ::decode(flockbl, p);
+
+    ::decode(inline_data, p);
   }
   void encode_payload(uint64_t features) {
     head.snap_trace_len = snapbl.length();
@@ -166,6 +170,8 @@ public:
     } else {
       header.version = 1;  // old
     }
+
+    ::encode(inline_data, payload);
   }
 };
 
diff --git a/src/messages/MClientReply.h b/src/messages/MClientReply.h
index 896245f..b15e843 100644
--- a/src/messages/MClientReply.h
+++ b/src/messages/MClientReply.h
@@ -108,6 +108,8 @@ struct InodeStat {
   uint64_t truncate_size;
   utime_t ctime, mtime, atime;
   version_t time_warp_seq;
+  bufferlist inline_data;
+  version_t inline_version;
 
   frag_info_t dirstat;
   nest_info_t rstat;
@@ -144,6 +146,7 @@ struct InodeStat {
     mtime.decode_timeval(&e.mtime);
     atime.decode_timeval(&e.atime);
     time_warp_seq = e.time_warp_seq;
+    inline_version = e.inline_version;
     mode = e.mode;
     uid = e.uid;
     gid = e.gid;
@@ -174,6 +177,7 @@ struct InodeStat {
 
     xattr_version = e.xattr_version;
     ::decode(xattrbl, p);
+    ::decode(inline_data, p);
   }
   
   // see CInode::encode_inodestat for encoder.
-- 
1.7.9.5


