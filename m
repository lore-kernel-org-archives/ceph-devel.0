From: Filippos Giannakos <philipgian@grnet.gr>
Subject: [PATCH] implement librados aio_stat
Date: Fri, 14 Dec 2012 13:18:41 +0200
Message-ID: <1355483921-15654-1-git-send-email-philipgian@grnet.gr>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from averel.grnet-hq.admin.grnet.gr ([195.251.29.3]:39190 "EHLO
	averel.grnet-hq.admin.grnet.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753945Ab2LNLeE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 14 Dec 2012 06:34:04 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: synefo-devel@googlegroups.com, philipgian@grnet.gr

---
 src/include/rados/librados.h   |   14 ++++++++++++++
 src/include/rados/librados.hpp |   15 +++++++++++++-
 src/librados/IoCtxImpl.cc      |   42 ++++++++++++++++++++++++++++++++++++++++
 src/librados/IoCtxImpl.h       |    9 +++++++++
 src/librados/librados.cc       |   10 ++++++++++
 5 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/src/include/rados/librados.h b/src/include/rados/librados.h
index 44d6f71..7f4b5c0 100644
--- a/src/include/rados/librados.h
+++ b/src/include/rados/librados.h
@@ -1444,6 +1444,20 @@ int rados_aio_read(rados_ioctx_t io, const char *oid,
  */
 int rados_aio_flush(rados_ioctx_t io);
 
+
+/**
+ * Asynchronously get object stats (size/mtime)
+ *
+ * @param io ioctx
+ * @param o object name
+ * @param psize where to store object size
+ * @param pmtime where to store modification time
+ * @returns 0 on success, negative error code on failure
+ */
+int rados_aio_stat(rados_ioctx_t io, const char *o,
+		   rados_completion_t completion,
+		   uint64_t *psize, time_t *pmtime);
+
 /** @} Asynchronous I/O */
 
 /**
diff --git a/src/include/rados/librados.hpp b/src/include/rados/librados.hpp
index e50acdb..96bfc15 100644
--- a/src/include/rados/librados.hpp
+++ b/src/include/rados/librados.hpp
@@ -473,9 +473,22 @@ namespace librados
      * other than CEPH_NOSNAP
      */
     int aio_remove(const std::string& oid, AioCompletion *c);
-    
+
     int aio_flush();
 
+    /**
+     * Asynchronously get object stats (size/mtime)
+     *
+     * @param io ioctx
+     * @param o object name
+     * @param psize where to store object size
+     * @param pmtime where to store modification time
+     * @returns 0 on success, negative error code on failure
+     */
+    int rados_aio_stat(rados_ioctx_t io, const char *o,
+		       rados_completion_t completion,
+		       uint64_t *psize, time_t *pmtime);
+
     int aio_exec(const std::string& oid, AioCompletion *c, const char *cls, const char *method,
 	         bufferlist& inbl, bufferlist *outbl);
 
diff --git a/src/librados/IoCtxImpl.cc b/src/librados/IoCtxImpl.cc
index 01b4a94..50aab1e 100644
--- a/src/librados/IoCtxImpl.cc
+++ b/src/librados/IoCtxImpl.cc
@@ -851,6 +851,21 @@ int librados::IoCtxImpl::aio_remove(const object_t &oid, AioCompletionImpl *c)
   return 0;
 }
 
+
+int librados::IoCtxImpl::aio_stat(const object_t& oid, AioCompletionImpl *c,
+		                  uint64_t *psize, time_t *pmtime)
+{
+  c->io = this;
+  C_aio_stat_Ack *onack = new C_aio_stat_Ack(c, pmtime);
+
+  Mutex::Locker l(*lock);
+  objecter->stat(oid, oloc,
+		 snap_seq, psize, &onack->mtime, 0,
+		 onack, &c->objver);
+
+  return 0;
+}
+
 int librados::IoCtxImpl::remove(const object_t& oid)
 {
   utime_t ut = ceph_clock_now(client->cct);
@@ -1562,6 +1577,33 @@ void librados::IoCtxImpl::C_aio_Ack::finish(int r)
   c->put_unlock();
 }
 
+///////////////////////////// C_aio_stat_Ack ////////////////////////////
+
+librados::IoCtxImpl::C_aio_stat_Ack::C_aio_stat_Ack(AioCompletionImpl *_c,
+						    time_t *pm)
+   : c(_c), pmtime(pm)
+{
+  c->get();
+}
+
+void librados::IoCtxImpl::C_aio_stat_Ack::finish(int r)
+{
+  c->lock.Lock();
+  c->rval = r;
+  c->ack = true;
+  c->cond.Signal();
+
+  if (r >= 0 && pmtime) {
+    *pmtime = mtime.sec();
+  }
+
+  if (c->callback_complete) {
+    c->io->client->finisher.queue(new C_AioComplete(c));
+  }
+
+  c->put_unlock();
+}
+
 /////////////////////// C_aio_sparse_read_Ack //////////////////////////

 librados::IoCtxImpl::C_aio_sparse_read_Ack::C_aio_sparse_read_Ack(AioCompletionImpl *_c,
diff --git a/src/librados/IoCtxImpl.h b/src/librados/IoCtxImpl.h
index feea0e8..55b07ee 100644
--- a/src/librados/IoCtxImpl.h
+++ b/src/librados/IoCtxImpl.h
@@ -144,6 +144,14 @@ struct librados::IoCtxImpl {
     C_aio_Ack(AioCompletionImpl *_c);
     void finish(int r);
   };
+
+  struct C_aio_stat_Ack : public Context {
+    librados::AioCompletionImpl *c;
+    time_t *pmtime;
+    utime_t mtime;
+    C_aio_stat_Ack(AioCompletionImpl *_c, time_t *pm);
+    void finish(int r);
+  };

   struct C_aio_sparse_read_Ack : public Context {
     AioCompletionImpl *c;
@@ -177,6 +185,7 @@ struct librados::IoCtxImpl {
   int aio_remove(const object_t &oid, AioCompletionImpl *c);
   int aio_exec(const object_t& oid, AioCompletionImpl *c, const char *cls,
 	       const char *method, bufferlist& inbl, bufferlist *outbl);
+  int aio_stat(const object_t& oid, AioCompletionImpl *c, uint64_t *psize, time_t *pmtime);

   int pool_change_auid(unsigned long long auid);
   int pool_change_auid_async(unsigned long long auid, PoolAsyncCompletionImpl *c);
diff --git a/src/librados/librados.cc b/src/librados/librados.cc
index 274119c..af36b38 100644
--- a/src/librados/librados.cc
+++ b/src/librados/librados.cc
@@ -2167,6 +2167,16 @@ extern "C" int rados_aio_flush(rados_ioctx_t io)
   return 0;
 }

+extern "C" int rados_aio_stat(rados_ioctx_t io, const char *o,
+			      rados_completion_t completion,
+			      uint64_t *psize, time_t *pmtime)
+{
+  librados::IoCtxImpl *ctx = (librados::IoCtxImpl *)io;
+  object_t oid(o);
+  return ctx->aio_stat(oid, (librados::AioCompletionImpl*)completion,
+		       psize, pmtime);
+}
+
 struct C_WatchCB : public librados::WatchCtx {
   rados_watchcb_t wcb;
   void *arg;
--
1.7.10.4

