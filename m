From: Andrew Shewmaker <agshew@gmail.com>
Subject: [PATCH 4/6] Rados support for blkin (LTTng + Zipkin) tracing
Date: Wed, 12 Nov 2014 16:20:56 -0700
Message-ID: <20141112232056.GE6892@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:53644 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583AbaKLXU7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Nov 2014 18:20:59 -0500
Received: by mail-pd0-f180.google.com with SMTP id ft15so13060253pdb.25
        for <ceph-devel@vger.kernel.org>; Wed, 12 Nov 2014 15:20:58 -0800 (PST)
Received: from localhost (host-69-145-59-76.bln-mt.client.bresnan.net. [69.145.59.76])
        by mx.google.com with ESMTPSA id c4sm23127334pdh.53.2014.11.12.15.20.57
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 15:20:58 -0800 (PST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Added traced versions of Rados aio_read/write

These changes are Marios', with the following exceptions:
 - split out Rados support from other tracing changes
 - only Message.h includes blkin, as others include Message.h
 - whitespace issues have been fixed

Signed-off-by: Andrew Shewmaker <agshew@gmail.com>
---
 src/include/rados/librados.h |  8 +++++
 src/librados/IoCtxImpl.cc    | 70 ++++++++++++++++++++++++++++++++++++++++++++
 src/librados/IoCtxImpl.h     |  7 +++++
 src/librados/RadosClient.cc  |  1 +
 src/librados/librados.cc     | 26 ++++++++++++++++
 5 files changed, 112 insertions(+)

diff --git a/src/include/rados/librados.h b/src/include/rados/librados.h
index 3e68292..8c7462c 100644
--- a/src/include/rados/librados.h
+++ b/src/include/rados/librados.h
@@ -1591,6 +1591,10 @@ int rados_aio_write(rados_ioctx_t io, const char *oid,
 		    rados_completion_t completion,
 		    const char *buf, size_t len, uint64_t off);
 
+int rados_aio_write_traced(rados_ioctx_t io, const char *o,
+        rados_completion_t completion,
+        const char *buf, size_t len, uint64_t off,
+        struct blkin_trace_info *info);
 /**
  * Asychronously append data to an object
  *
@@ -1673,6 +1677,10 @@ int rados_aio_read(rados_ioctx_t io, const char *oid,
 		   rados_completion_t completion,
 		   char *buf, size_t len, uint64_t off);
 
+int rados_aio_read_traced(rados_ioctx_t io, const char *o,
+        rados_completion_t completion,
+        char *buf, size_t len, uint64_t off,
+        struct blkin_trace_info *info);
 /**
  * Block until all pending writes in an io context are safe
  *
diff --git a/src/librados/IoCtxImpl.cc b/src/librados/IoCtxImpl.cc
index 6fc22ad..04087ab 100644
--- a/src/librados/IoCtxImpl.cc
+++ b/src/librados/IoCtxImpl.cc
@@ -30,6 +30,7 @@ librados::IoCtxImpl::IoCtxImpl() :
   notify_timeout(30), aio_write_list_lock("librados::IoCtxImpl::aio_write_list_lock"),
   aio_write_seq(0), lock(NULL), objecter(NULL)
 {
+    ioctx_endp = ZTracer::create_ZTraceEndpoint("0.0.0.0", 0, "Ioctx");
 }
 
 librados::IoCtxImpl::IoCtxImpl(RadosClient *c, Objecter *objecter,
@@ -41,6 +42,7 @@ librados::IoCtxImpl::IoCtxImpl(RadosClient *c, Objecter *objecter,
     aio_write_list_lock("librados::IoCtxImpl::aio_write_list_lock"),
     aio_write_seq(0), lock(client_lock), objecter(objecter)
 {
+    ioctx_endp = ZTracer::create_ZTraceEndpoint("0.0.0.0", 0, "Ioctx");
 }
 
 void librados::IoCtxImpl::set_snap_read(snapid_t s)
@@ -523,6 +525,7 @@ int librados::IoCtxImpl::operate(const object_t& oid, ::ObjectOperation *o,
   Objecter::Op *objecter_op = objecter->prepare_mutate_op(oid, oloc,
 	                                                  *o, snapc, ut, flags,
 	                                                  NULL, oncommit, &ver);
+  objecter_op->set_trace(o->trace);
   lock->Lock();
   objecter->op_submit(objecter_op);
   lock->Unlock();
@@ -660,6 +663,38 @@ int librados::IoCtxImpl::aio_read(const object_t oid, AioCompletionImpl *c,
   return 0;
 }
 
+int librados::IoCtxImpl::aio_read_traced(const object_t oid, AioCompletionImpl *c,
+					 char *buf, size_t len, uint64_t off,
+					 uint64_t snapid,
+					 struct blkin_trace_info *info)
+{
+  if (len > (size_t) INT_MAX)
+    return -EDOM;
+
+  /*handle trace*/
+  ZTracer::ZTraceRef trace;
+  trace = ZTracer::create_ZTrace("librados", ioctx_endp, info, true);
+  trace->event("librados accept");
+  Context *onack = new C_aio_Ack(c);
+
+  c->is_read = true;
+  c->io = this;
+  c->bl.clear();
+  c->bl.push_back(buffer::create_static(len, buf));
+  c->blp = &c->bl;
+
+  Mutex::Locker l(*lock);
+  trace->event("send to objecter");
+  struct blkin_trace_info *child_info = (struct blkin_trace_info *)
+      malloc(sizeof(struct blkin_trace_info));
+  trace->get_trace_info(child_info);
+  objecter->read_traced(oid, oloc,
+		 off, len, snapid, &c->bl, 0,
+		 onack, child_info, &c->objver);
+
+  return 0;
+}
+
 class C_ObjectOperation : public Context {
 public:
   ::ObjectOperation m_ops;
@@ -720,6 +755,41 @@ int librados::IoCtxImpl::aio_write(const object_t &oid, AioCompletionImpl *c,
   return 0;
 }
 
+int librados::IoCtxImpl::aio_write_traced(const object_t &oid,
+					  AioCompletionImpl *c,
+					  const bufferlist& bl, size_t len,
+					  uint64_t off,
+					  struct blkin_trace_info *info)
+{
+  utime_t ut = ceph_clock_now(client->cct);
+  ldout(client->cct, 20) << "aio_write_traced " << oid << " " << off << "~" << len << " snapc=" << snapc << " snap_seq=" << snap_seq << dendl;
+
+  /* can't write to a snapshot */
+  if (snap_seq != CEPH_NOSNAP)
+    return -EROFS;
+
+  /*handle trace*/
+  ZTracer::ZTraceRef trace;
+  trace = ZTracer::create_ZTrace("librados", ioctx_endp, info, true);
+  trace->event("librados accept");
+
+  c->io = this;
+  queue_aio_write(c);
+
+  Context *onack = new C_aio_Ack(c);
+  Context *onsafe = new C_aio_Safe(c);
+
+  Mutex::Locker l(*lock);
+  trace->event("send to objecter");
+  struct blkin_trace_info *child_info = (struct blkin_trace_info *)
+      malloc(sizeof(struct blkin_trace_info));
+  trace->get_trace_info(child_info);
+  objecter->write_traced(oid, oloc,
+		  off, len, snapc, bl, ut, 0,
+		  onack, onsafe, child_info, &c->objver);
+
+  return 0;
+}
 int librados::IoCtxImpl::aio_append(const object_t &oid, AioCompletionImpl *c,
 				    const bufferlist& bl, size_t len)
 {
diff --git a/src/librados/IoCtxImpl.h b/src/librados/IoCtxImpl.h
index 528022f..c41ca3b 100644
--- a/src/librados/IoCtxImpl.h
+++ b/src/librados/IoCtxImpl.h
@@ -49,6 +49,7 @@ struct librados::IoCtxImpl {
 
   Mutex *lock;
   Objecter *objecter;
+  ZTracer::ZTraceEndpointRef ioctx_endp;
 
   IoCtxImpl();
   IoCtxImpl(RadosClient *c, Objecter *objecter, Mutex *client_lock,
@@ -172,11 +173,17 @@ struct librados::IoCtxImpl {
 	       bufferlist *pbl, size_t len, uint64_t off, uint64_t snapid);
   int aio_read(object_t oid, AioCompletionImpl *c,
 	       char *buf, size_t len, uint64_t off, uint64_t snapid);
+  int aio_read_traced(object_t oid, AioCompletionImpl *c,
+	       char *buf, size_t len, uint64_t off, uint64_t snapid,
+	       struct blkin_trace_info *info);
   int aio_sparse_read(const object_t oid, AioCompletionImpl *c,
 		      std::map<uint64_t,uint64_t> *m, bufferlist *data_bl,
 		      size_t len, uint64_t off, uint64_t snapid);
   int aio_write(const object_t &oid, AioCompletionImpl *c,
 		const bufferlist& bl, size_t len, uint64_t off);
+  int aio_write_traced(const object_t &oid, AioCompletionImpl *c,
+		const bufferlist& bl, size_t len, uint64_t off,
+		struct blkin_trace_info *info);
   int aio_append(const object_t &oid, AioCompletionImpl *c,
 		 const bufferlist& bl, size_t len);
   int aio_write_full(const object_t &oid, AioCompletionImpl *c,
diff --git a/src/librados/RadosClient.cc b/src/librados/RadosClient.cc
index 249c34f..0f7d42b 100644
--- a/src/librados/RadosClient.cc
+++ b/src/librados/RadosClient.cc
@@ -84,6 +84,7 @@ librados::RadosClient::RadosClient(CephContext *cct_)
     finisher(cct),
     max_watch_cookie(0)
 {
+  ZTracer::ztrace_init();
 }
 
 int64_t librados::RadosClient::lookup_pool(const char *name)
diff --git a/src/librados/librados.cc b/src/librados/librados.cc
index 2358fb4..5a55c1d 100644
--- a/src/librados/librados.cc
+++ b/src/librados/librados.cc
@@ -2900,6 +2900,18 @@ extern "C" int rados_aio_read(rados_ioctx_t io, const char *o,
 		       buf, len, off, ctx->snap_seq);
 }
 
+extern "C" int rados_aio_read_traced(rados_ioctx_t io, const char *o,
+				rados_completion_t completion,
+				char *buf, size_t len, uint64_t off,
+				struct blkin_trace_info *info)
+{
+	librados::IoCtxImpl *ctx = (librados::IoCtxImpl *)io;
+	object_t oid(o);
+	return ctx->aio_read_traced(oid,
+			(librados::AioCompletionImpl*)completion, buf, len,
+			off, ctx->snap_seq, info);
+}
+
 extern "C" int rados_aio_write(rados_ioctx_t io, const char *o,
 				rados_completion_t completion,
 				const char *buf, size_t len, uint64_t off)
@@ -2912,6 +2924,20 @@ extern "C" int rados_aio_write(rados_ioctx_t io, const char *o,
 			bl, len, off);
 }
 
+extern "C" int rados_aio_write_traced(rados_ioctx_t io, const char *o,
+		rados_completion_t completion,
+		const char *buf, size_t len, uint64_t off,
+		struct blkin_trace_info *info)
+{
+	librados::IoCtxImpl *ctx = (librados::IoCtxImpl *)io;
+	object_t oid(o);
+	bufferlist bl;
+	bl.append(buf, len);
+	return ctx->aio_write_traced(oid,
+			(librados::AioCompletionImpl*)completion,bl, len, off,
+			info);
+}
+
 extern "C" int rados_aio_append(rados_ioctx_t io, const char *o,
 				rados_completion_t completion,
 				const char *buf, size_t len)
-- 
2.1.0

