From: Andrew Shewmaker <agshew@gmail.com>
Subject: [PATCH V2 5/6] Rados support for blkin (LTTng + Zipkin) tracing
Date: Tue, 25 Nov 2014 10:54:27 -0800
Message-ID: <1416941668-26150-6-git-send-email-agshew@gmail.com>
References: <1416941668-26150-1-git-send-email-agshew@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:58121 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbaKYSy1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Nov 2014 13:54:27 -0500
Received: by mail-pd0-f173.google.com with SMTP id ft15so1101946pdb.32
        for <ceph-devel@vger.kernel.org>; Tue, 25 Nov 2014 10:54:27 -0800 (PST)
In-Reply-To: <1416941668-26150-1-git-send-email-agshew@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Andrew Shewmaker <agshew@gmail.com>, Marios-Evaggelos Kogias <marioskogias@gmail.com>, Filippos Giannakos <philipgian@grnet.gr>

 * Adds traced versions of Rados aio_read/write

Signed-off-by: Marios-Evaggelos Kogias <marioskogias@gmail.com>
Signed-off-by: Filippos Giannakos <philipgian@grnet.gr>
Signed-off-by: Andrew Shewmaker <agshew@gmail.com>
---
 src/include/rados/librados.h | 12 +++++++
 src/librados/IoCtxImpl.cc    | 75 ++++++++++++++++++++++++++++++++++++++++++++
 src/librados/IoCtxImpl.h     | 11 +++++++
 src/librados/RadosClient.cc  |  1 +
 src/librados/librados.cc     | 30 ++++++++++++++++++
 5 files changed, 129 insertions(+)

diff --git a/src/include/rados/librados.h b/src/include/rados/librados.h
index 3e68292..14586e6 100644
--- a/src/include/rados/librados.h
+++ b/src/include/rados/librados.h
@@ -1591,6 +1591,12 @@ int rados_aio_write(rados_ioctx_t io, const char *oid,
 		    rados_completion_t completion,
 		    const char *buf, size_t len, uint64_t off);
 
+#ifdef WITH_BLKIN
+int rados_aio_write_traced(rados_ioctx_t io, const char *o,
+        rados_completion_t completion,
+        const char *buf, size_t len, uint64_t off,
+        struct blkin_trace_info *info);
+#endif
 /**
  * Asychronously append data to an object
  *
@@ -1673,6 +1679,12 @@ int rados_aio_read(rados_ioctx_t io, const char *oid,
 		   rados_completion_t completion,
 		   char *buf, size_t len, uint64_t off);
 
+#ifdef WTIH_BLKIN
+int rados_aio_read_traced(rados_ioctx_t io, const char *o,
+        rados_completion_t completion,
+        char *buf, size_t len, uint64_t off,
+        struct blkin_trace_info *info);
+#endif
 /**
  * Block until all pending writes in an io context are safe
  *
diff --git a/src/librados/IoCtxImpl.cc b/src/librados/IoCtxImpl.cc
index 6fc22ad..b90b771 100644
--- a/src/librados/IoCtxImpl.cc
+++ b/src/librados/IoCtxImpl.cc
@@ -30,6 +30,7 @@ librados::IoCtxImpl::IoCtxImpl() :
   notify_timeout(30), aio_write_list_lock("librados::IoCtxImpl::aio_write_list_lock"),
   aio_write_seq(0), lock(NULL), objecter(NULL)
 {
+    BLKIN_MSG_END(ioctx, "0.0.0.0", 0, "ioctx");
 }
 
 librados::IoCtxImpl::IoCtxImpl(RadosClient *c, Objecter *objecter,
@@ -41,6 +42,7 @@ librados::IoCtxImpl::IoCtxImpl(RadosClient *c, Objecter *objecter,
     aio_write_list_lock("librados::IoCtxImpl::aio_write_list_lock"),
     aio_write_seq(0), lock(client_lock), objecter(objecter)
 {
+    BLKIN_MSG_END(ioctx, "0.0.0.0", 0, "ioctx");
 }
 
 void librados::IoCtxImpl::set_snap_read(snapid_t s)
@@ -523,6 +525,7 @@ int librados::IoCtxImpl::operate(const object_t& oid, ::ObjectOperation *o,
   Objecter::Op *objecter_op = objecter->prepare_mutate_op(oid, oloc,
 	                                                  *o, snapc, ut, flags,
 	                                                  NULL, oncommit, &ver);
+  BLKIN_OP_SET_TRACE(objecter_op, o->trace);
   lock->Lock();
   objecter->op_submit(objecter_op);
   lock->Unlock();
@@ -660,6 +663,40 @@ int librados::IoCtxImpl::aio_read(const object_t oid, AioCompletionImpl *c,
   return 0;
 }
 
+#ifdef WITH_BLKIN
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
+  trace = ZTracer::create_ZTrace("librados", ioctx_endpoint, info, true);
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
+#endif // WITH_BLKIN
+
 class C_ObjectOperation : public Context {
 public:
   ::ObjectOperation m_ops;
@@ -720,6 +757,44 @@ int librados::IoCtxImpl::aio_write(const object_t &oid, AioCompletionImpl *c,
   return 0;
 }
 
+#ifdef WITH_BLKIN
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
+  trace = ZTracer::create_ZTrace("librados", ioctx_endpoint, info, true);
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
+#endif // WITH_BLKIN
+
 int librados::IoCtxImpl::aio_append(const object_t &oid, AioCompletionImpl *c,
 				    const bufferlist& bl, size_t len)
 {
diff --git a/src/librados/IoCtxImpl.h b/src/librados/IoCtxImpl.h
index 528022f..7a81765 100644
--- a/src/librados/IoCtxImpl.h
+++ b/src/librados/IoCtxImpl.h
@@ -49,6 +49,7 @@ struct librados::IoCtxImpl {
 
   Mutex *lock;
   Objecter *objecter;
+  BLKIN_END_REF(ioctx_endpoint)
 
   IoCtxImpl();
   IoCtxImpl(RadosClient *c, Objecter *objecter, Mutex *client_lock,
@@ -172,11 +173,21 @@ struct librados::IoCtxImpl {
 	       bufferlist *pbl, size_t len, uint64_t off, uint64_t snapid);
   int aio_read(object_t oid, AioCompletionImpl *c,
 	       char *buf, size_t len, uint64_t off, uint64_t snapid);
+#ifdef WITH_BLKIN
+  int aio_read_traced(object_t oid, AioCompletionImpl *c,
+	       char *buf, size_t len, uint64_t off, uint64_t snapid,
+	       struct blkin_trace_info *info);
+#endif
   int aio_sparse_read(const object_t oid, AioCompletionImpl *c,
 		      std::map<uint64_t,uint64_t> *m, bufferlist *data_bl,
 		      size_t len, uint64_t off, uint64_t snapid);
   int aio_write(const object_t &oid, AioCompletionImpl *c,
 		const bufferlist& bl, size_t len, uint64_t off);
+#ifdef WITH_BLKIN
+  int aio_write_traced(const object_t &oid, AioCompletionImpl *c,
+		const bufferlist& bl, size_t len, uint64_t off,
+		struct blkin_trace_info *info);
+#endif
   int aio_append(const object_t &oid, AioCompletionImpl *c,
 		 const bufferlist& bl, size_t len);
   int aio_write_full(const object_t &oid, AioCompletionImpl *c,
diff --git a/src/librados/RadosClient.cc b/src/librados/RadosClient.cc
index 249c34f..caa0e18 100644
--- a/src/librados/RadosClient.cc
+++ b/src/librados/RadosClient.cc
@@ -84,6 +84,7 @@ librados::RadosClient::RadosClient(CephContext *cct_)
     finisher(cct),
     max_watch_cookie(0)
 {
+  BLKIN_ZTRACE_INIT();
 }
 
 int64_t librados::RadosClient::lookup_pool(const char *name)
diff --git a/src/librados/librados.cc b/src/librados/librados.cc
index 2358fb4..14199f3 100644
--- a/src/librados/librados.cc
+++ b/src/librados/librados.cc
@@ -2900,6 +2900,20 @@ extern "C" int rados_aio_read(rados_ioctx_t io, const char *o,
 		       buf, len, off, ctx->snap_seq);
 }
 
+#ifdef WITH_BLKIN
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
+#endif
+
 extern "C" int rados_aio_write(rados_ioctx_t io, const char *o,
 				rados_completion_t completion,
 				const char *buf, size_t len, uint64_t off)
@@ -2912,6 +2926,22 @@ extern "C" int rados_aio_write(rados_ioctx_t io, const char *o,
 			bl, len, off);
 }
 
+#ifdef WITH_BLKIN
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
+#endif
+
 extern "C" int rados_aio_append(rados_ioctx_t io, const char *o,
 				rados_completion_t completion,
 				const char *buf, size_t len)
-- 
2.1.0

