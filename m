From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] osdc: re-calculate truncate_size for strip objects
Date: Thu, 20 Jun 2013 15:50:18 +0800
Message-ID: <1371714618-495-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43990 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753619Ab3FTHuW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 20 Jun 2013 03:50:22 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Fixes #5380
Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/client/Client.cc     |  8 ++++----
 src/librbd/ImageCtx.cc   |  4 ++--
 src/librbd/internal.cc   | 10 +++++-----
 src/osd/osd_types.h      |  6 ++++--
 src/osdc/Filer.cc        |  2 +-
 src/osdc/Filer.h         | 12 ++++++------
 src/osdc/ObjectCacher.cc | 28 ++++++++++++++--------------
 src/osdc/ObjectCacher.h  | 17 ++++++++++-------
 src/osdc/Objecter.h      |  8 ++++----
 src/osdc/Striper.cc      | 45 ++++++++++++++++++++++++++++++++++++++++++---
 src/osdc/Striper.h       | 11 +++++++----
 src/test/test_striper.cc |  5 ++++-
 12 files changed, 103 insertions(+), 53 deletions(-)

diff --git a/src/client/Client.cc b/src/client/Client.cc
index 80cce8a..45ad949 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -2665,7 +2665,7 @@ void Client::_invalidate_inode_cache(Inode *in, int64_t off, int64_t len, bool k
   // invalidate our userspace inode cache
   if (cct->_conf->client_oc) {
     vector<ObjectExtent> ls;
-    Striper::file_to_extents(cct, in->ino, &in->layout, off, len, ls);
+    Striper::file_to_extents(cct, in->ino, &in->layout, off, len, in->truncate_size, ls);
     objectcacher->discard_set(&in->oset, ls);
   }
 
@@ -7740,7 +7740,7 @@ int Client::get_file_extent_osds(int fd, loff_t off, loff_t *len, vector<int>& o
   Inode *in = f->inode;
 
   vector<ObjectExtent> extents;
-  Striper::file_to_extents(cct, in->ino, &in->layout, off, 1, extents);
+  Striper::file_to_extents(cct, in->ino, &in->layout, off, 1, in->truncate_size, extents);
   assert(extents.size() == 1);
 
   pg_t pg = osdmap->object_locator_to_pg(extents[0].oid, extents[0].oloc);
@@ -7787,7 +7787,7 @@ int Client::get_file_stripe_address(int fd, loff_t offset, vector<entity_addr_t>
 
   // which object?
   vector<ObjectExtent> extents;
-  Striper::file_to_extents(cct, in->ino, &in->layout, offset, 1, extents);
+  Striper::file_to_extents(cct, in->ino, &in->layout, offset, 1, in->truncate_size, extents);
   assert(extents.size() == 1);
 
   // now we have the object and its 'layout'
@@ -7828,7 +7828,7 @@ int Client::enumerate_layout(int fd, vector<ObjectExtent>& result,
   Inode *in = f->inode;
 
   // map to a list of extents
-  Striper::file_to_extents(cct, in->ino, &in->layout, offset, length, result);
+  Striper::file_to_extents(cct, in->ino, &in->layout, offset, length, in->truncate_size, result);
 
   ldout(cct, 3) << "enumerate_layout(" << fd << ", " << length << ", " << offset << ") = 0" << dendl;
   return 0;
diff --git a/src/librbd/ImageCtx.cc b/src/librbd/ImageCtx.cc
index 6796bc8..2ab5fd9 100644
--- a/src/librbd/ImageCtx.cc
+++ b/src/librbd/ImageCtx.cc
@@ -475,7 +475,7 @@ namespace librbd {
     snap_lock.get_read();
     ObjectCacher::OSDRead *rd = object_cacher->prepare_read(snap_id, bl, 0);
     snap_lock.put_read();
-    ObjectExtent extent(o, 0 /* a lie */, off, len);
+    ObjectExtent extent(o, 0 /* a lie */, off, len, 0);
     extent.oloc.pool = data_ctx.get_id();
     extent.buffer_extents.push_back(make_pair(0, len));
     rd->extents.push_back(extent);
@@ -492,7 +492,7 @@ namespace librbd {
     ObjectCacher::OSDWrite *wr = object_cacher->prepare_write(snapc, bl,
 							      utime_t(), 0);
     snap_lock.put_read();
-    ObjectExtent extent(o, 0, off, len);
+    ObjectExtent extent(o, 0, off, len, 0);
     extent.oloc.pool = data_ctx.get_id();
     extent.buffer_extents.push_back(make_pair(0, len));
     wr->extents.push_back(extent);
diff --git a/src/librbd/internal.cc b/src/librbd/internal.cc
index 789ef86..1fd7942 100644
--- a/src/librbd/internal.cc
+++ b/src/librbd/internal.cc
@@ -184,7 +184,7 @@ namespace librbd {
     if (delete_off > newsize) {
       vector<ObjectExtent> extents;
       Striper::file_to_extents(ictx->cct, ictx->format_string, &ictx->layout,
-			       newsize, delete_off - newsize, extents);
+			       newsize, delete_off - newsize, 0, extents);
 
       for (vector<ObjectExtent>::iterator p = extents.begin();
 	   p != extents.end(); ++p) {
@@ -2482,7 +2482,7 @@ reprotect_and_return_err:
       // map to extents
       map<object_t,vector<ObjectExtent> > object_extents;
       Striper::file_to_extents(ictx->cct, ictx->format_string, &ictx->layout,
-			       off, read_len, object_extents, 0);
+			       off, read_len, 0, object_extents, 0);
 
       // get snap info for each object
       for (map<object_t,vector<ObjectExtent> >::iterator p = object_extents.begin();
@@ -2880,7 +2880,7 @@ reprotect_and_return_err:
 
     // map
     vector<ObjectExtent> extents;
-    Striper::file_to_extents(ictx->cct, ictx->format_string, &ictx->layout, off, mylen, extents);
+    Striper::file_to_extents(ictx->cct, ictx->format_string, &ictx->layout, off, mylen, 0, extents);
 
     c->get();
     c->init_time(ictx, AIO_TYPE_WRITE);
@@ -2960,7 +2960,7 @@ reprotect_and_return_err:
 
     // map
     vector<ObjectExtent> extents;
-    Striper::file_to_extents(ictx->cct, ictx->format_string, &ictx->layout, off, len, extents);
+    Striper::file_to_extents(ictx->cct, ictx->format_string, &ictx->layout, off, len, 0, extents);
 
     c->get();
     c->init_time(ictx, AIO_TYPE_DISCARD);
@@ -3056,7 +3056,7 @@ reprotect_and_return_err:
 	return r;
 
       Striper::file_to_extents(ictx->cct, ictx->format_string, &ictx->layout,
-			       p->first, len, object_extents, buffer_ofs);
+			       p->first, len, 0, object_extents, buffer_ofs);
       buffer_ofs += len;
     }
 
diff --git a/src/osd/osd_types.h b/src/osd/osd_types.h
index a266fff..a0b6455 100644
--- a/src/osd/osd_types.h
+++ b/src/osd/osd_types.h
@@ -1637,13 +1637,15 @@ class ObjectExtent {
   uint64_t    objectno;
   uint64_t    offset;    // in object
   uint64_t    length;    // in object
+  uint64_t    truncate_size;	// in object
 
   object_locator_t oloc;   // object locator (pool etc)
 
   vector<pair<uint64_t,uint64_t> >  buffer_extents;  // off -> len.  extents in buffer being mapped (may be fragmented bc of striping!)
   
-  ObjectExtent() : objectno(0), offset(0), length(0) {}
-  ObjectExtent(object_t o, uint64_t ono, uint64_t off, uint64_t l) : oid(o), objectno(ono), offset(off), length(l) { }
+  ObjectExtent() : objectno(0), offset(0), length(0), truncate_size(0) {}
+  ObjectExtent(object_t o, uint64_t ono, uint64_t off, uint64_t l, uint64_t ts) :
+    oid(o), objectno(ono), offset(off), length(l), truncate_size(ts) { }
 };
 
 inline ostream& operator<<(ostream& out, const ObjectExtent &ex)
diff --git a/src/osdc/Filer.cc b/src/osdc/Filer.cc
index aec2910..7eb4ad6 100644
--- a/src/osdc/Filer.cc
+++ b/src/osdc/Filer.cc
@@ -102,7 +102,7 @@ void Filer::_probe(Probe *probe)
   probe->known_size.clear();
   probe->probing.clear();
   Striper::file_to_extents(cct, probe->ino, &probe->layout,
-			   probe->probing_off, probe->probing_len, probe->probing);
+			   probe->probing_off, probe->probing_len, 0, probe->probing);
   
   for (vector<ObjectExtent>::iterator p = probe->probing.begin();
        p != probe->probing.end();
diff --git a/src/osdc/Filer.h b/src/osdc/Filer.h
index cde4502..86ff601 100644
--- a/src/osdc/Filer.h
+++ b/src/osdc/Filer.h
@@ -107,7 +107,7 @@ class Filer {
            Context *onfinish) {
     assert(snap);  // (until there is a non-NOSNAP write)
     vector<ObjectExtent> extents;
-    Striper::file_to_extents(cct, ino, layout, offset, len, extents);
+    Striper::file_to_extents(cct, ino, layout, offset, len, 0, extents);
     objecter->sg_read(extents, snap, bl, flags, onfinish);
     return 0;
   }
@@ -124,7 +124,7 @@ class Filer {
            Context *onfinish) {
     assert(snap);  // (until there is a non-NOSNAP write)
     vector<ObjectExtent> extents;
-    Striper::file_to_extents(cct, ino, layout, offset, len, extents);
+    Striper::file_to_extents(cct, ino, layout, offset, len, truncate_size, extents);
     objecter->sg_read_trunc(extents, snap, bl, flags,
 			    truncate_size, truncate_seq, onfinish);
     return 0;
@@ -141,7 +141,7 @@ class Filer {
             Context *onack,
             Context *oncommit) {
     vector<ObjectExtent> extents;
-    Striper::file_to_extents(cct, ino, layout, offset, len, extents);
+    Striper::file_to_extents(cct, ino, layout, offset, len, 0, extents);
     objecter->sg_write(extents, snapc, bl, mtime, flags, onack, oncommit);
     return 0;
   }
@@ -159,7 +159,7 @@ class Filer {
             Context *onack,
             Context *oncommit) {
     vector<ObjectExtent> extents;
-    Striper::file_to_extents(cct, ino, layout, offset, len, extents);
+    Striper::file_to_extents(cct, ino, layout, offset, len, truncate_size, extents);
     objecter->sg_write_trunc(extents, snapc, bl, mtime, flags,
 		       truncate_size, truncate_seq, onack, oncommit);
     return 0;
@@ -176,7 +176,7 @@ class Filer {
 	       Context *onack,
 	       Context *oncommit) {
     vector<ObjectExtent> extents;
-    Striper::file_to_extents(cct, ino, layout, offset, len, extents);
+    Striper::file_to_extents(cct, ino, layout, offset, len, 0, extents);
     if (extents.size() == 1) {
       vector<OSDOp> ops(1);
       ops[0].op.op = CEPH_OSD_OP_TRIMTRUNC;
@@ -211,7 +211,7 @@ class Filer {
            Context *onack,
            Context *oncommit) {
     vector<ObjectExtent> extents;
-    Striper::file_to_extents(cct, ino, layout, offset, len, extents);
+    Striper::file_to_extents(cct, ino, layout, offset, len, 0, extents);
     if (extents.size() == 1) {
       if (extents[0].offset == 0 && extents[0].length == layout->fl_object_size)
 	objecter->remove(extents[0].oid, extents[0].oloc, 
diff --git a/src/osdc/ObjectCacher.cc b/src/osdc/ObjectCacher.cc
index 56c56d6..0481c6c 100644
--- a/src/osdc/ObjectCacher.cc
+++ b/src/osdc/ObjectCacher.cc
@@ -555,19 +555,25 @@ void ObjectCacher::perf_stop()
 
 /* private */
 ObjectCacher::Object *ObjectCacher::get_object(sobject_t oid, ObjectSet *oset,
-                                 object_locator_t &l)
+					       object_locator_t &l,
+					       uint64_t truncate_size,
+					       uint64_t truncate_seq)
 {
   assert(lock.is_locked());
   // have it?
   if ((uint32_t)l.pool < objects.size()) {
-    if (objects[l.pool].count(oid))
-      return objects[l.pool][oid];
+    if (objects[l.pool].count(oid)) {
+      Object *o = objects[l.pool][oid];
+      o->truncate_size = truncate_size;
+      o->truncate_seq = truncate_seq;
+      return o;
+    }
   } else {
     objects.resize(l.pool+1);
   }
 
   // create it.
-  Object *o = new Object(this, oid, oset, l);
+  Object *o = new Object(this, oid, oset, l, truncate_size, truncate_seq);
   objects[l.pool][oid] = o;
   ob_lru.lru_insert_top(o);
   return o;
@@ -600,13 +606,10 @@ void ObjectCacher::bh_read(BufferHead *bh)
   // finisher
   C_ReadFinish *onfinish = new C_ReadFinish(this, bh->ob,
 					    bh->start(), bh->length());
-
-  ObjectSet *oset = bh->ob->oset;
-
   // go
   writeback_handler.read(bh->ob->get_oid(), bh->ob->get_oloc(),
 			 bh->start(), bh->length(), bh->ob->get_snap(),
-			 &onfinish->bl, oset->truncate_size, oset->truncate_seq,
+			 &onfinish->bl, bh->ob->truncate_size, bh->ob->truncate_seq,
 			 onfinish);
   ++reads_outstanding;
 }
@@ -786,14 +789,11 @@ void ObjectCacher::bh_write(BufferHead *bh)
   // finishers
   C_WriteCommit *oncommit = new C_WriteCommit(this, bh->ob->oloc.pool,
                                               bh->ob->get_soid(), bh->start(), bh->length());
-
-  ObjectSet *oset = bh->ob->oset;
-
   // go
   tid_t tid = writeback_handler.write(bh->ob->get_oid(), bh->ob->get_oloc(),
 				      bh->start(), bh->length(),
 				      bh->snapc, bh->bl, bh->last_write,
-				      oset->truncate_size, oset->truncate_seq,
+				      bh->ob->truncate_size, bh->ob->truncate_seq,
 				      oncommit);
   ldout(cct, 20) << " tid " << tid << " on " << bh->ob->get_oid() << dendl;
 
@@ -1022,7 +1022,7 @@ int ObjectCacher::_readx(OSDRead *rd, ObjectSet *oset, Context *onfinish,
 
     // get Object cache
     sobject_t soid(ex_it->oid, rd->snap);
-    Object *o = get_object(soid, oset, ex_it->oloc);
+    Object *o = get_object(soid, oset, ex_it->oloc, ex_it->truncate_size, oset->truncate_seq);
     touch_ob(o);
 
     // does not exist and no hits?
@@ -1256,7 +1256,7 @@ int ObjectCacher::writex(OSDWrite *wr, ObjectSet *oset, Mutex& wait_on_lock,
        ++ex_it) {
     // get object cache
     sobject_t soid(ex_it->oid, CEPH_NOSNAP);
-    Object *o = get_object(soid, oset, ex_it->oloc);
+    Object *o = get_object(soid, oset, ex_it->oloc, ex_it->truncate_size, oset->truncate_seq);
 
     // map it all into a single bufferhead.
     BufferHead *bh = o->map_write(wr);
diff --git a/src/osdc/ObjectCacher.h b/src/osdc/ObjectCacher.h
index 80a90bd..4441cfa 100644
--- a/src/osdc/ObjectCacher.h
+++ b/src/osdc/ObjectCacher.h
@@ -171,6 +171,7 @@ class ObjectCacher {
     ObjectSet *oset;
     xlist<Object*>::item set_item;
     object_locator_t oloc;
+    uint64_t truncate_size, truncate_seq;
     
     bool complete;
     bool exists;
@@ -190,10 +191,12 @@ class ObjectCacher {
     Object(const Object& other);
     const Object& operator=(const Object& other);
 
-    Object(ObjectCacher *_oc, sobject_t o, ObjectSet *os, object_locator_t& l) : 
+    Object(ObjectCacher *_oc, sobject_t o, ObjectSet *os, object_locator_t& l,
+	   uint64_t ts, uint64_t tq) :
       ref(0),
       oc(_oc),
       oid(o), oset(os), set_item(this), oloc(l),
+      truncate_size(ts), truncate_seq(tq),
       complete(false), exists(true),
       last_write_tid(0), last_commit_tid(0),
       dirty_or_tx(0) {
@@ -363,8 +366,8 @@ class ObjectCacher {
     return NULL;
   }
 
-  Object *get_object(sobject_t oid, ObjectSet *oset,
-                     object_locator_t &l);
+  Object *get_object(sobject_t oid, ObjectSet *oset, object_locator_t &l,
+		     uint64_t truncate_size, uint64_t truncate_seq);
   void close_object(Object *ob);
 
   // bh stats
@@ -626,7 +629,7 @@ public:
   int file_is_cached(ObjectSet *oset, ceph_file_layout *layout, snapid_t snapid,
 		     loff_t offset, uint64_t len) {
     vector<ObjectExtent> extents;
-    Striper::file_to_extents(cct, oset->ino, layout, offset, len, extents);
+    Striper::file_to_extents(cct, oset->ino, layout, offset, len, oset->truncate_size, extents);
     return is_cached(oset, extents, snapid);
   }
 
@@ -636,7 +639,7 @@ public:
 		int flags,
                 Context *onfinish) {
     OSDRead *rd = prepare_read(snapid, bl, flags);
-    Striper::file_to_extents(cct, oset->ino, layout, offset, len, rd->extents);
+    Striper::file_to_extents(cct, oset->ino, layout, offset, len, oset->truncate_size, rd->extents);
     return readx(rd, oset, onfinish);
   }
 
@@ -645,14 +648,14 @@ public:
                  bufferlist& bl, utime_t mtime, int flags,
 		 Mutex& wait_on_lock) {
     OSDWrite *wr = prepare_write(snapc, bl, mtime, flags);
-    Striper::file_to_extents(cct, oset->ino, layout, offset, len, wr->extents);
+    Striper::file_to_extents(cct, oset->ino, layout, offset, len, oset->truncate_size, wr->extents);
     return writex(wr, oset, wait_on_lock, NULL);
   }
 
   bool file_flush(ObjectSet *oset, ceph_file_layout *layout, const SnapContext& snapc,
                   loff_t offset, uint64_t len, Context *onfinish) {
     vector<ObjectExtent> extents;
-    Striper::file_to_extents(cct, oset->ino, layout, offset, len, extents);
+    Striper::file_to_extents(cct, oset->ino, layout, offset, len, oset->truncate_size, extents);
     return flush_set(oset, extents, onfinish);
   }
 };
diff --git a/src/osdc/Objecter.h b/src/osdc/Objecter.h
index bc4b0ae..b4086f6 100644
--- a/src/osdc/Objecter.h
+++ b/src/osdc/Objecter.h
@@ -1696,14 +1696,14 @@ public:
 		uint64_t trunc_size, __u32 trunc_seq, Context *onfinish) {
     if (extents.size() == 1) {
       read_trunc(extents[0].oid, extents[0].oloc, extents[0].offset, extents[0].length,
-	   snap, bl, flags, trunc_size, trunc_seq, onfinish);
+	   snap, bl, flags, extents[0].truncate_size, trunc_seq, onfinish);
     } else {
       C_GatherBuilder gather(cct);
       vector<bufferlist> resultbl(extents.size());
       int i=0;
       for (vector<ObjectExtent>::iterator p = extents.begin(); p != extents.end(); ++p) {
 	read_trunc(p->oid, p->oloc, p->offset, p->length,
-	     snap, &resultbl[i++], flags, trunc_size, trunc_seq, gather.new_sub());
+	     snap, &resultbl[i++], flags, p->truncate_size, trunc_seq, gather.new_sub());
       }
       gather.set_finisher(new C_SGRead(this, extents, resultbl, bl, onfinish));
       gather.activate();
@@ -1719,7 +1719,7 @@ public:
 		Context *onack, Context *oncommit) {
     if (extents.size() == 1) {
       write_trunc(extents[0].oid, extents[0].oloc, extents[0].offset, extents[0].length,
-	    snapc, bl, mtime, flags, trunc_size, trunc_seq, onack, oncommit);
+	    snapc, bl, mtime, flags, extents[0].truncate_size, trunc_seq, onack, oncommit);
     } else {
       C_GatherBuilder gack(cct, onack);
       C_GatherBuilder gcom(cct, oncommit);
@@ -1731,7 +1731,7 @@ public:
 	  bl.copy(bit->first, bit->second, cur);
 	assert(cur.length() == p->length);
 	write_trunc(p->oid, p->oloc, p->offset, p->length, 
-	      snapc, cur, mtime, flags, trunc_size, trunc_seq,
+	      snapc, cur, mtime, flags, p->truncate_size, trunc_seq,
 	      onack ? gack.new_sub():0,
 	      oncommit ? gcom.new_sub():0);
       }
diff --git a/src/osdc/Striper.cc b/src/osdc/Striper.cc
index b062845..bde3284 100644
--- a/src/osdc/Striper.cc
+++ b/src/osdc/Striper.cc
@@ -28,18 +28,19 @@
 
 void Striper::file_to_extents(CephContext *cct, const char *object_format,
 			    ceph_file_layout *layout,
-			    uint64_t offset, uint64_t len,
+			    uint64_t offset, uint64_t len, uint64_t trunc_size,
 			    vector<ObjectExtent>& extents,
 			    uint64_t buffer_offset)
 {
   map<object_t,vector<ObjectExtent> > object_extents;
-  file_to_extents(cct, object_format, layout, offset, len, object_extents, buffer_offset);
+  file_to_extents(cct, object_format, layout, offset, len, trunc_size,
+		  object_extents, buffer_offset);
   assimilate_extents(object_extents, extents);
 }
 
 void Striper::file_to_extents(CephContext *cct, const char *object_format,
 			      ceph_file_layout *layout,
-			      uint64_t offset, uint64_t len,
+			      uint64_t offset, uint64_t len, uint64_t trunc_size,
 			      map<object_t,vector<ObjectExtent> >& object_extents,
 			      uint64_t buffer_offset)
 {
@@ -108,6 +109,8 @@ void Striper::file_to_extents(CephContext *cct, const char *object_format,
 
       ex->offset = x_offset;
       ex->length = x_len;
+      ex->truncate_size = object_truncate_size(cct, layout, objectno, trunc_size);
+
       ldout(cct, 20) << " added new " << *ex << dendl;
     } else {
       // add to extent
@@ -174,6 +177,42 @@ void Striper::extent_to_file(CephContext *cct, ceph_file_layout *layout,
   }
 }
 
+uint64_t Striper::object_truncate_size(CephContext *cct, ceph_file_layout *layout,
+				       uint64_t objectno, uint64_t trunc_size)
+{
+  uint64_t obj_trunc_size;
+  if (trunc_size == 0 || trunc_size == (uint64_t)-1) {
+    obj_trunc_size = trunc_size;
+  } else {
+    __u32 object_size = layout->fl_object_size;
+    __u32 su = layout->fl_stripe_unit;
+    __u32 stripe_count = layout->fl_stripe_count;
+    assert(object_size >= su);
+    uint64_t stripes_per_object = object_size / su;
+
+    uint64_t objectsetno = objectno / stripe_count;
+    uint64_t trunc_objectsetno = trunc_size / object_size / stripe_count;
+    if (objectsetno > trunc_objectsetno)
+      obj_trunc_size = 0;
+    else if (objectsetno < trunc_objectsetno)
+      obj_trunc_size = object_size;
+    else {
+      uint64_t trunc_blockno = trunc_size / su;
+      uint64_t trunc_stripeno = trunc_blockno / stripe_count;
+      uint64_t trunc_stripepos = trunc_blockno % stripe_count;
+      uint64_t trunc_objectno = trunc_objectsetno * stripe_count + trunc_stripepos;
+      if (objectno < trunc_objectno)
+	obj_trunc_size = ((trunc_stripeno % stripes_per_object) + 1) * su;
+      else if (objectno > trunc_objectno)
+	obj_trunc_size = (trunc_stripeno % stripes_per_object) * su;
+      else
+	obj_trunc_size = (trunc_stripeno % stripes_per_object) * su + (trunc_size % su);
+    }
+  }
+  ldout(cct, 20) << "object_truncate_size " << objectno << " "
+		 << trunc_size << "->" << obj_trunc_size << dendl;
+  return obj_trunc_size;
+}
 
 // StripedReadResult
 
diff --git a/src/osdc/Striper.h b/src/osdc/Striper.h
index 9f05635..bd61fc8 100644
--- a/src/osdc/Striper.h
+++ b/src/osdc/Striper.h
@@ -30,25 +30,25 @@ class CephContext;
      */
     static void file_to_extents(CephContext *cct, const char *object_format,
 				ceph_file_layout *layout,
-				uint64_t offset, uint64_t len,
+				uint64_t offset, uint64_t len, uint64_t trunc_size,
 				map<object_t, vector<ObjectExtent> >& extents,
 				uint64_t buffer_offset=0);
 
     static void file_to_extents(CephContext *cct, const char *object_format,
 				ceph_file_layout *layout,
-				uint64_t offset, uint64_t len,
+				uint64_t offset, uint64_t len, uint64_t trunc_size,
 				vector<ObjectExtent>& extents,
 				uint64_t buffer_offset=0);
 
     static void file_to_extents(CephContext *cct, inodeno_t ino,
 				ceph_file_layout *layout,
-				uint64_t offset, uint64_t len,
+				uint64_t offset, uint64_t len, uint64_t trunc_size,
 				vector<ObjectExtent>& extents) {
       // generate prefix/format
       char buf[32];
       snprintf(buf, sizeof(buf), "%llx.%%08llx", (long long unsigned)ino);
 
-      file_to_extents(cct, buf, layout, offset, len, extents);
+      file_to_extents(cct, buf, layout, offset, len, trunc_size, extents);
     }
 
     static void assimilate_extents(map<object_t,vector<ObjectExtent> >& object_extents,
@@ -61,6 +61,9 @@ class CephContext;
 			       uint64_t objectno, uint64_t off, uint64_t len,
 			       vector<pair<uint64_t, uint64_t> >& extents);
 
+    static uint64_t object_truncate_size(CephContext *cct, ceph_file_layout *layout,
+					 uint64_t objectno, uint64_t trunc_size);
+
     /*
      * helper to assemble a striped result
      */
diff --git a/src/test/test_striper.cc b/src/test/test_striper.cc
index d3e9285..262fba3 100644
--- a/src/test/test_striper.cc
+++ b/src/test/test_striper.cc
@@ -16,11 +16,14 @@ TEST(Striper, Stripe1)
   l.fl_stripe_count = 3;
 
   vector<ObjectExtent> ex;
-  Striper::file_to_extents(g_ceph_context, 1, &l, 5006035, 46419, ex);
+  Striper::file_to_extents(g_ceph_context, 1, &l, 5006035, 46419, 5006035, ex);
 
   cout << "result " << ex << std::endl;
 
   ASSERT_EQ(3u, ex.size());
+  ASSERT_EQ(98304u, ex[0].truncate_size);
+  ASSERT_EQ(ex[1].offset, ex[1].truncate_size);
+  ASSERT_EQ(94208u, ex[2].truncate_size);
 }
 
 
-- 
1.8.1.4

