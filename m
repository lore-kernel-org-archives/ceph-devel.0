From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: Re: Preserve dir default_file_layout in encoded inode
Date: Fri, 17 Aug 2012 17:11:31 -0300
Message-ID: <ortxw1b7nw.fsf@livre.localdomain>
References: <orr4r7tn5q.fsf@livre.localdomain>
	<alpine.DEB.2.00.1208161759460.16032@cobra.newdream.net>
	<ord32qcbgu.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:45060 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755665Ab2HQULx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 17 Aug 2012 16:11:53 -0400
In-Reply-To: <ord32qcbgu.fsf@livre.localdomain> (Alexandre Oliva's message of
	"Fri, 17 Aug 2012 02:51:45 -0300")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Aug 17, 2012, Alexandre Oliva <oliva@lsd.ic.unicamp.br> wrote:

> On Aug 16, 2012, Sage Weil <sage@inktank.com> wrote:
>> I've dusted it off and repushed it.. can you take a look?  
>> wip-mds-layout.

> The patch looks good, but testing it is going to be a bit of a challenge
> because of the on-disk format change and the current unavailability of
> cluster snapshots.  I'll figure something out, once I'm done with an
> ongoing cluster operation.

I gather some of the changes would have required additional versioning
changes to avoid a fully incompatible format change (as in, failure to
decode properly an existing filesystem).

So I ended up applying this patch on top of yours, to keep the on-disk
format unchanged, so I could roll back to the prior format.  The
combination of the patches is something I'd be comfortable applying in a
stable branch.

I haven't yet completed testing (getting some layouts flushed from the
cache and loaded back in), but it's looking good so far.


From d1bae416891d5fa0289dcad4565365892b062e42 Mon Sep 17 00:00:00 2001
From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Date: Fri, 17 Aug 2012 16:26:05 -0300
Subject: mds: restore on-disk format for dir layouts

Revert on-disk and protocol changes introduced in 37485df86984.

Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
---
 src/mds/CInode.cc          |   33 +++++++++++++++++++++------------
 src/mds/CInode.h           |   40 +++++++++++++++++++++++++++++++++++-----
 src/mds/MDS.h              |    2 +-
 src/mds/events/EMetaBlob.h |   23 ++++++++++++++++-------
 4 files changed, 73 insertions(+), 25 deletions(-)

diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
index 2b29f01..53f9e69 100644
--- a/src/mds/CInode.cc
+++ b/src/mds/CInode.cc
@@ -1100,14 +1100,12 @@ void CInode::encode_lock_state(int type, bufferlist& bl)
     
   case CEPH_LOCK_IFILE:
     if (is_auth()) {
+      ::encode(inode.layout, bl);
+      ::encode(inode.size, bl);
       ::encode(inode.mtime, bl);
       ::encode(inode.atime, bl);
       ::encode(inode.time_warp_seq, bl);
-      if (!is_dir()) {
-	::encode(inode.layout, bl);
-	::encode(inode.size, bl);
-	::encode(inode.client_ranges, bl);
-      }
+      ::encode(inode.client_ranges, bl);
     } else {
       bool dirty = filelock.is_dirty();
       ::encode(dirty, bl);
@@ -1189,7 +1187,13 @@ void CInode::encode_lock_state(int type, bufferlist& bl)
 
   case CEPH_LOCK_IPOLICY:
     if (inode.is_dir()) {
-      ::encode(inode.layout, bl);
+      bool has_layout = inode.has_layout();
+      ::encode(has_layout, bl);
+      if (has_layout) {
+	__u8 lv = 1;
+	::encode(lv, bl);
+	::encode(inode.layout, bl);
+      }
     }
     break;
   
@@ -1283,14 +1287,12 @@ void CInode::decode_lock_state(int type, bufferlist& bl)
 
   case CEPH_LOCK_IFILE:
     if (!is_auth()) {
+      ::decode(inode.layout, p);
+      ::decode(inode.size, p);
       ::decode(inode.mtime, p);
       ::decode(inode.atime, p);
       ::decode(inode.time_warp_seq, p);
-      if (!is_dir()) {
-	::decode(inode.layout, p);
-	::decode(inode.size, p);
-	::decode(inode.client_ranges, p);
-      }
+      ::decode(inode.client_ranges, p);
     } else {
       bool replica_dirty;
       ::decode(replica_dirty, p);
@@ -1432,7 +1434,14 @@ void CInode::decode_lock_state(int type, bufferlist& bl)
 
   case CEPH_LOCK_IPOLICY:
     if (inode.is_dir()) {
-      ::decode(inode.layout, p);
+      bool has_layout;
+      ::decode(has_layout, p);
+      if (has_layout) {
+	__u8 lv;
+	::decode(lv, p);
+	assert(lv == 1);
+	::decode(inode.layout, p);
+      }
     }
     break;
 
diff --git a/src/mds/CInode.h b/src/mds/CInode.h
index d4c0aa8..0b74b64 100644
--- a/src/mds/CInode.h
+++ b/src/mds/CInode.h
@@ -530,7 +530,7 @@ private:
   unsigned encode_parent_mutation(ObjectOperation& m);
 
   void encode_store(bufferlist& bl) {
-    __u8 struct_v = 3;
+    __u8 struct_v = 2;
     ::encode(struct_v, bl);
     ::encode(inode, bl);
     if (is_symlink())
@@ -541,6 +541,15 @@ private:
     encode_snap_blob(snapbl);
     ::encode(snapbl, bl);
     ::encode(old_inodes, bl);
+    if (struct_v == 2 && inode.is_dir()) { // FIXME: this is redundant
+      bool has_layout = inode.has_layout();
+      ::encode(has_layout, bl);
+      if (has_layout) {
+	__u8 lv = 1;
+	::encode(lv, bl);
+	::encode(inode.layout, bl);
+      }
+    }
   }
   void decode_store(bufferlist::iterator& bl) {
     __u8 struct_v;
@@ -555,10 +564,12 @@ private:
     decode_snap_blob(snapbl);
     ::decode(old_inodes, bl);
     if (struct_v == 2 && inode.is_dir()) {
-      bool default_layout_exists;
-      ::decode(default_layout_exists, bl);
-      if (default_layout_exists) {
-	::decode(struct_v, bl);
+      bool has_layout;
+      ::decode(has_layout, bl);
+      if (has_layout) {
+	__u8 lv;
+	::decode(lv, bl);
+	assert (lv == 1);
 	::decode(inode.layout, bl);
       }
     }
@@ -576,6 +587,15 @@ private:
     
     _encode_base(bl);
     _encode_locks_state_for_replica(bl);
+    if (inode.is_dir()) { // FIXME: this is redundant
+      bool has_layout = inode.has_layout();
+      ::encode(has_layout, bl);
+      if (has_layout) {
+	__u8 lv = 1;
+	::encode(lv, bl);
+	::encode(inode.layout, bl);
+      }
+    }
   }
   void decode_replica(bufferlist::iterator& p, bool is_new) {
     __u32 nonce;
@@ -584,6 +604,16 @@ private:
     
     _decode_base(p);
     _decode_locks_state(p, is_new);
+    if (inode.is_dir()) { // FIXME: this is redundant
+      bool has_layout;
+      ::decode(has_layout, p);
+      if (has_layout) {
+	__u8 lv;
+	::decode(lv, p);
+	assert(lv == 1);
+	::decode(inode.layout, p);
+      }
+    }
   }
 
 
diff --git a/src/mds/MDS.h b/src/mds/MDS.h
index 71106c3..67a5102 100644
--- a/src/mds/MDS.h
+++ b/src/mds/MDS.h
@@ -35,7 +35,7 @@
 #include "SessionMap.h"
 
 
-#define CEPH_MDS_PROTOCOL    15 /* cluster internal */
+#define CEPH_MDS_PROTOCOL    14 /* cluster internal */
 
 
 enum {
diff --git a/src/mds/events/EMetaBlob.h b/src/mds/events/EMetaBlob.h
index f63266e..38131d6 100644
--- a/src/mds/events/EMetaBlob.h
+++ b/src/mds/events/EMetaBlob.h
@@ -97,6 +97,15 @@ public:
       if (i.is_dir()) {
 	::encode(dft, _enc);
 	::encode(sbl, _enc);
+	if (struct_v >= 2 && struct_v <= 3) { // FIXME: this is redundant
+	  bool has_layout = i.has_layout();
+	  ::encode(has_layout, _enc);
+	  if (has_layout) {
+	    __u8 lv = 1;
+	    ::encode(lv, _enc);
+	    ::encode(inode.layout, _enc);
+	  }
+	}
       }
       ::encode(dr, _enc);      
       ::encode(oi ? true : false, _enc);
@@ -110,8 +119,6 @@ public:
     ~fullbit() {}
 
     void encode(bufferlist& bl) const {
-      __u8 struct_v = 3;
-      ::encode(struct_v, bl);
       assert(_enc.length());
       bl.append(_enc); 
     }
@@ -129,11 +136,13 @@ public:
       if (inode.is_dir()) {
 	::decode(dirfragtree, bl);
 	::decode(snapbl, bl);
-	if (struct_v == 2) {
-	  bool dir_layout_exists;
-	  ::decode(dir_layout_exists, bl);
-	  if (dir_layout_exists) {
-	    ::decode(struct_v, bl);
+	if (struct_v >= 2 && struct_v <= 3) {
+	  bool has_layout;
+	  ::decode(has_layout, bl);
+	  if (has_layout) {
+	    __u8 lv;
+	    ::decode(lv, bl);
+	    assert(lv == 1);
 	    ::decode(inode.layout, bl);
 	  }
 	}
-- 
1.7.7.6



-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
