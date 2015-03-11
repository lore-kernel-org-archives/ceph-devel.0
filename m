From: Andrew Shewmaker <agshew@gmail.com>
Subject: [PATCH V6 4/5] Rados support for blkin (LTTng + Zipkin) tracing
Date: Tue, 10 Mar 2015 19:43:29 -0700
Message-ID: <1426041810-3942-5-git-send-email-agshew@gmail.com>
References: <1426041810-3942-1-git-send-email-agshew@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:39072 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbbCKCoJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Mar 2015 22:44:09 -0400
Received: by pdbft15 with SMTP id ft15so7227127pdb.6
        for <ceph-devel@vger.kernel.org>; Tue, 10 Mar 2015 19:44:09 -0700 (PDT)
In-Reply-To: <1426041810-3942-1-git-send-email-agshew@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: agshew@gmail.com, marioskogias@gmail.com, chendi.xue@intel.com

 * Adds traced versions of Rados aio_read/write

Signed-off-by: Marios-Evaggelos Kogias <marioskogias@gmail.com>
Signed-off-by: Filippos Giannakos <philipgian@grnet.gr>
Signed-off-by: Andrew Shewmaker <agshew@gmail.com>
Signed-off-by: Chendi.Xue <chendi.xue@intel.com>
---
 include/rados/librados.h |   13 ++++++
 librados/IoCtxImpl.cc    |   91 +++++++++++++++++++++++++++++++++++++++++++++++
 librados/IoCtxImpl.h     |   12 ++++++
 librados/RadosClient.cc  |    1 
 librados/librados.cc     |   30 +++++++++++++++
 5 files changed, 147 insertions(+)

diff --git a/src/include/rados/librados.h b/src/include/rados/librados.h
index 15a225b..aa0416e 100644
--- a/src/include/rados/librados.h
+++ b/src/include/rados/librados.h
@@ -1736,6 +1736,13 @@ CEPH_RADOS_API int rados_aio_write(rados_ioctx_t io, const char *oid,
 		                   rados_completion_t completion,
 		                   const char *buf, size_t len, uint64_t off);
 
+#ifdef WITH_BLKIN
+struct blkin_trace_info;
+int rados_aio_write_traced(rados_ioctx_t io, const char *oid,
+        rados_completion_t completion,
+        const char *buf, size_t len, uint64_t off,
+        struct blkin_trace_info *info);
+#endif
 /**
  * Asychronously append data to an object
  *
@@ -1818,6 +1825,12 @@ CEPH_RADOS_API int rados_aio_read(rados_ioctx_t io, const char *oid,
 		                  rados_completion_t completion,
 		                  char *buf, size_t len, uint64_t off);
 
+#ifdef WTIH_BLKIN
+int rados_aio_read_traced(rados_ioctx_t io, const char *oid,
+        rados_completion_t completion,
+        char *buf, size_t len, uint64_t off,
+        struct blkin_trace_info *info);
+#endif
 /**
  * Block until all pending writes in an io context are safe
  *
diff --git a/src/librados/IoCtxImpl.cc b/src/librados/IoCtxImpl.cc
index 5ef56c0..cfff8a6 100644
--- a/src/librados/IoCtxImpl.cc
+++ b/src/librados/IoCtxImpl.cc
@@ -31,6 +31,7 @@ librados::IoCtxImpl::IoCtxImpl() :
   aio_write_seq(0), cached_pool_names_lock("librados::IoCtxImpl::cached_pool_names_lock"),
   objecter(NULL)
 {
+    BLKIN_MSG_END(ioctx_endpoint, "0.0.0.0", 0, "ioctx");
 }
 
 librados::IoCtxImpl::IoCtxImpl(RadosClient *c, Objecter *objecter,
@@ -42,6 +43,7 @@ librados::IoCtxImpl::IoCtxImpl(RadosClient *c, Objecter *objecter,
     aio_write_seq(0), cached_pool_names_lock("librados::IoCtxImpl::cached_pool_names_lock"),
     objecter(objecter)
 {
+    BLKIN_MSG_END(ioctx_endpoint, "0.0.0.0", 0, "ioctx");
 }
 
 void librados::IoCtxImpl::set_snap_read(snapid_t s)
@@ -516,6 +518,7 @@ int librados::IoCtxImpl::operate(const object_t& oid, ::ObjectOperation *o,
   Objecter::Op *objecter_op = objecter->prepare_mutate_op(oid, oloc,
 	                                                  *o, snapc, ut, flags,
 	                                                  NULL, oncommit, &ver);
+  BLKIN_OP_SET_TRACE(objecter_op, o->trace);
   objecter->op_submit(objecter_op);
 
   mylock.Lock();
@@ -645,6 +648,48 @@ int librados::IoCtxImpl::aio_read(const object_t oid, AioCompletionImpl *c,
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
+  if (!trace) {
+    ldout(client->cct, 5) << "librados read trace could not be created" << dendl;
+    return -1;
+  }
+
+  trace->event("librados accept");
+  Context *onack = new C_aio_Ack(c);
+
+  c->is_read = true;
+  c->io = this;
+  c->bl.clear();
+  c->bl.push_back(buffer::create_static(len, buf));
+  c->blp = &c->bl;
+
+  c->tid = objecter->read(oid, oloc,
+		 off, len, snapid, &c->bl, 0,
+		 onack, &c->objver);
+
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
@@ -705,6 +750,52 @@ int librados::IoCtxImpl::aio_write(const object_t &oid, AioCompletionImpl *c,
   return 0;
 }
 
+#ifdef WITH_BLKIN
+int librados::IoCtxImpl::aio_write_traced(const object_t &oid, AioCompletionImpl *c,
+					  const bufferlist& bl, size_t len,
+					  uint64_t off, struct blkin_trace_info *info)
+{
+  utime_t ut = ceph_clock_now(client->cct);
+  ldout(client->cct, 20) << "aio_write_traced " << oid << " " << off << "~" << len << " snapc=" << snapc << " snap_seq=" << snap_seq << dendl;
+
+  if (len > UINT_MAX/2)
+    return -E2BIG;
+  /* can't write to a snapshot */
+  if (snap_seq != CEPH_NOSNAP)
+    return -EROFS;
+
+  /*handle trace*/
+  ZTracer::ZTraceRef trace;
+  trace = ZTracer::create_ZTrace("librados", ioctx_endpoint, info, true);
+  if (!trace) {
+    ldout(client->cct, 5) << "librados write trace could not be created" << dendl;
+    return -1;
+  }
+
+  trace->event("librados accept");
+
+  c->io = this;
+  queue_aio_write(c);
+
+  Context *onack = new C_aio_Ack(c);
+  Context *onsafe = new C_aio_Safe(c);
+
+  c->tid = objecter->write(oid, oloc,
+		  off, len, snapc, bl, ut, 0,
+		  onack, onsafe, &c->objver);
+
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
index df73b03..916c690 100644
--- a/src/librados/IoCtxImpl.h
+++ b/src/librados/IoCtxImpl.h
@@ -51,6 +51,8 @@ struct librados::IoCtxImpl {
 
   Objecter *objecter;
 
+  BLKIN_END_REF(ioctx_endpoint)
+
   IoCtxImpl();
   IoCtxImpl(RadosClient *c, Objecter *objecter,
 	    int64_t poolid, snapid_t s);
@@ -174,11 +176,21 @@ struct librados::IoCtxImpl {
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
index 8e63fce..f19bf69 100644
--- a/src/librados/RadosClient.cc
+++ b/src/librados/RadosClient.cc
@@ -79,6 +79,7 @@ librados::RadosClient::RadosClient(CephContext *cct_)
     log_last_version(0), log_cb(NULL), log_cb_arg(NULL),
     finisher(cct)
 {
+  BLKIN_ZTRACE_INIT();
 }
 
 int64_t librados::RadosClient::lookup_pool(const char *name)
diff --git a/src/librados/librados.cc b/src/librados/librados.cc
index cbefe0b..918bce7 100644
--- a/src/librados/librados.cc
+++ b/src/librados/librados.cc
@@ -3744,6 +3744,20 @@ extern "C" int rados_aio_read(rados_ioctx_t io, const char *o,
   return retval;
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
@@ -3761,6 +3775,22 @@ extern "C" int rados_aio_write(rados_ioctx_t io, const char *o,
   return retval;
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
