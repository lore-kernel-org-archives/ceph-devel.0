From: Sage Weil <sage@newdream.net>
Subject: librados compound operations
Date: Mon, 28 Mar 2011 15:46:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1103281539580.17288@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35743 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755458Ab1C1Wn0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Mar 2011 18:43:26 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 6F2C7BC670
	for <ceph-devel@vger.kernel.org>; Mon, 28 Mar 2011 15:46:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 529A9BC670
	for <ceph-devel@vger.kernel.org>; Mon, 28 Mar 2011 15:46:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Below is a patch that wraps the internal Objecter compound ObjectOperation 
so that we can send compound operations to the OSDs via librados.

The internal ObjectOperationImpl ends up being unnecessary; I just cast it 
to the internal type directly.

One weird thing I noticed is with the constructor.  In Rados:: did

+    static ObjectOperation *operation_create();

and the user then deletes it when they're done (after using it for one or 
more calls to operate() or aio_operate()).  Is that the the approach we 
want?  Because right above that in the header is

     int ioctx_create(const char *name, IoCtx &pioctx);

which is a totally different convention.  It does match

    static AioCompletion *aio_create_completion();

though (although there the noun_verb is mixed up a bit).  Sigh.

Anyway, seem okay?
sage



Signed-off-by: Sage Weil <sage.weil@dreamhost.com>
---
 src/include/rados/librados.hpp |   38 +++++++++
 src/librados.cc                |  175 ++++++++++++++++++++++++++++++++++++----
 src/testradospp.cc             |    8 ++
 3 files changed, 204 insertions(+), 17 deletions(-)

diff --git a/src/include/rados/librados.hpp b/src/include/rados/librados.hpp
index 029648f..8f09612 100644
--- a/src/include/rados/librados.hpp
+++ b/src/include/rados/librados.hpp
@@ -20,6 +20,7 @@ namespace librados
   class AioCompletionImpl;
   class IoCtx;
   class IoCtxImpl;
+  class ObjectOperationImpl;
   class ObjListCtx;
   class RadosClient;
 
@@ -89,6 +90,37 @@ namespace librados
     AioCompletionImpl *pc;
   };
 
+  /*
+   * ObjectOperation : compount object operation
+   * Batch multiple object operations into a single request, to be applied
+   * atomically.
+   */
+  class ObjectOperation
+  {
+  public:
+    ~ObjectOperation();
+
+    void write(uint64_t off, const bufferlist& bl);
+    void write_full(const bufferlist& bl);
+    void append(const bufferlist& bl);
+    void remove();
+    void truncate(uint64_t off);
+    void zero(uint64_t off, uint64_t len);
+    void rmxattr(const char *name);
+    void setxattr(const char *name, const bufferlist& bl);
+    void tmap_update(const bufferlist& cmdbl);
+
+    void exec(const char *cls, const char *method, bufferlist& bl);
+
+  private:
+    ObjectOperationImpl *impl;
+    ObjectOperation(ObjectOperationImpl *impl_) : impl(impl_) {}
+    ObjectOperation(const ObjectOperation& rhs);
+    ObjectOperation& operator=(const ObjectOperation& rhs);
+    friend class IoCtx;
+    friend class Rados;
+  };
+
   /* IoCtx : This is a context in which we can perform I/O.
    * It includes a Pool,
    *
@@ -180,6 +212,10 @@ namespace librados
 		  size_t len);
     int aio_write_full(const std::string& oid, AioCompletion *c, const bufferlist& bl);
 
+    // compound object operations
+    int operate(const std::string& oid, ObjectOperation *op, bufferlist *pbl);
+    int aio_operate(const std::string& oid, AioCompletion *c, ObjectOperation *op, bufferlist *pbl);
+
     // watch/notify
     int watch(const std::string& o, uint64_t ver, uint64_t *handle,
 	      librados::WatchCtx *ctx);
@@ -227,6 +263,8 @@ namespace librados
 
     int ioctx_create(const char *name, IoCtx &pioctx);
 
+    static ObjectOperation *operation_create();
+
     /* listing objects */
     int pool_list(std::list<std::string>& v);
     int get_pool_stats(std::list<std::string>& v,
diff --git a/src/librados.cc b/src/librados.cc
index 198850a..788e1cc 100644
--- a/src/librados.cc
+++ b/src/librados.cc
@@ -132,6 +132,69 @@ struct librados::IoCtxImpl {
   }
 };
 
+
+void librados::ObjectOperation::write(uint64_t off, const bufferlist& bl)
+{
+  ::ObjectOperation *o = (::ObjectOperation *)impl;
+  bufferlist c = bl;
+  o->write(off, c);
+}
+
+void librados::ObjectOperation::write_full(const bufferlist& bl)
+{
+  ::ObjectOperation *o = (::ObjectOperation *)impl;
+  bufferlist c = bl;
+  o->write_full(c);
+}
+
+void librados::ObjectOperation::append(const bufferlist& bl)
+{
+  ::ObjectOperation *o = (::ObjectOperation *)impl;
+  bufferlist c = bl;
+  o->append(c);
+}
+
+void librados::ObjectOperation::remove()
+{
+  ::ObjectOperation *o = (::ObjectOperation *)impl;
+  o->remove();
+}
+
+void librados::ObjectOperation::truncate(uint64_t off)
+{
+  ::ObjectOperation *o = (::ObjectOperation *)impl;
+  o->truncate(off);
+}
+
+void librados::ObjectOperation::zero(uint64_t off, uint64_t len)
+{
+  ::ObjectOperation *o = (::ObjectOperation *)impl;
+  o->zero(off, len);
+}
+
+void librados::ObjectOperation::rmxattr(const char *name)
+{
+  ::ObjectOperation *o = (::ObjectOperation *)impl;
+  o->rmxattr(name);
+}
+
+void librados::ObjectOperation::setxattr(const char *name, const bufferlist& v)
+{
+  ::ObjectOperation *o = (::ObjectOperation *)impl;
+  o->setxattr(name, v);
+}
+
+void librados::ObjectOperation::tmap_update(const bufferlist& cmdbl)
+{
+  ::ObjectOperation *o = (::ObjectOperation *)impl;
+  bufferlist c = cmdbl;
+  o->tmap_update(c);
+}
+
+
+
+
+
 librados::WatchCtx::
 ~WatchCtx()
 {
@@ -340,6 +403,9 @@ public:
 
   int list(Objecter::ListContext *context, int max_entries);
 
+  int operate(IoCtxImpl& io, const object_t& oid, ::ObjectOperation *o, bufferlist *pbl);
+  int aio_operate(IoCtxImpl& io, const object_t& oid, ::ObjectOperation *o, AioCompletionImpl *c, bufferlist *pbl);
+
   struct C_aio_Ack : public Context {
     AioCompletionImpl *c;
     void finish(int r) {
@@ -1092,7 +1158,7 @@ write(IoCtxImpl& io, const object_t& oid, bufferlist& bl, size_t len, uint64_t o
   Context *onack = new C_SafeCond(&mylock, &cond, &done, &r);
   eversion_t ver;
 
-  ObjectOperation op, *pop = NULL;
+  ::ObjectOperation op, *pop = NULL;
   if (io.assert_ver) {
     op.assert_version(io.assert_ver);
     io.assert_ver = 0;
@@ -1135,7 +1201,7 @@ append(IoCtxImpl& io, const object_t& oid, bufferlist& bl, size_t len)
   Context *onack = new C_SafeCond(&mylock, &cond, &done, &r);
   eversion_t ver;
 
-  ObjectOperation op, *pop = NULL;
+  ::ObjectOperation op, *pop = NULL;
   if (io.assert_ver) {
     op.assert_version(io.assert_ver);
     io.assert_ver = 0;
@@ -1178,7 +1244,7 @@ write_full(IoCtxImpl& io, const object_t& oid, bufferlist& bl)
   Context *onack = new C_SafeCond(&mylock, &cond, &done, &r);
 
   eversion_t ver;
-  ObjectOperation op, *pop = NULL;
+  ::ObjectOperation op, *pop = NULL;
   if (io.assert_ver) {
     op.assert_version(io.assert_ver);
     io.assert_ver = 0;
@@ -1202,6 +1268,56 @@ write_full(IoCtxImpl& io, const object_t& oid, bufferlist& bl)
 }
 
 int librados::RadosClient::
+operate(IoCtxImpl& io, const object_t& oid, ::ObjectOperation *o, bufferlist *pbl)
+{
+  utime_t ut = g_clock.now();
+
+  /* can't write to a snapshot */
+  if (io.snap_seq != CEPH_NOSNAP)
+    return -EINVAL;
+
+  Mutex mylock("RadosClient::mutate::mylock");
+  Cond cond;
+  bool done;
+  int r;
+  eversion_t ver;
+
+  Context *onack = new C_SafeCond(&mylock, &cond, &done, &r);
+
+  lock.Lock();
+  objecter->mutate(oid, io.oloc,
+	           *o, io.snapc, ut, 0,
+	           onack, NULL, &ver);
+  lock.Unlock();
+
+  mylock.Lock();
+  while (!done)
+    cond.Wait(mylock);
+  mylock.Unlock();
+
+  set_sync_op_version(io, ver);
+
+  return r;
+}
+
+int librados::RadosClient::
+aio_operate(IoCtxImpl& io, const object_t& oid, ::ObjectOperation *o, AioCompletionImpl *c,
+	    bufferlist *pbl)
+{
+  utime_t ut = g_clock.now();
+  Context *onack = new C_aio_Ack(c);
+  Context *oncommit = new C_aio_Safe(c);
+
+  /* can't write to a snapshot */
+  if (io.snap_seq != CEPH_NOSNAP)
+    return -EINVAL;
+
+  objecter->mutate(oid, io.oloc, *o, io.snapc, ut, 0, onack, oncommit, &c->objver);
+
+  return 0;
+}
+
+int librados::RadosClient::
 aio_read(IoCtxImpl& io, const object_t oid, AioCompletionImpl *c,
          bufferlist *pbl, size_t len, uint64_t off)
 {
@@ -1319,7 +1435,7 @@ remove(IoCtxImpl& io, const object_t& oid)
   Context *onack = new C_SafeCond(&mylock, &cond, &done, &r);
   eversion_t ver;
 
-  ObjectOperation op, *pop = NULL;
+  ::ObjectOperation op, *pop = NULL;
   if (io.assert_ver) {
     op.assert_version(io.assert_ver);
     io.assert_ver = 0;
@@ -1359,7 +1475,7 @@ trunc(IoCtxImpl& io, const object_t& oid, uint64_t size)
   Context *onack = new C_SafeCond(&mylock, &cond, &done, &r);
   eversion_t ver;
 
-  ObjectOperation op, *pop = NULL;
+  ::ObjectOperation op, *pop = NULL;
   if (io.assert_ver) {
     op.assert_version(io.assert_ver);
     io.assert_ver = 0;
@@ -1399,7 +1515,7 @@ tmap_update(IoCtxImpl& io, const object_t& oid, bufferlist& cmdbl)
 
   lock.Lock();
   ::SnapContext snapc;
-  ObjectOperation wr;
+  ::ObjectOperation wr;
   if (io.assert_ver) {
     wr.assert_version(io.assert_ver);
     io.assert_ver = 0;
@@ -1434,7 +1550,7 @@ exec(IoCtxImpl& io, const object_t& oid, const char *cls, const char *method,
 
 
   lock.Lock();
-  ObjectOperation rd;
+  ::ObjectOperation rd;
   if (io.assert_ver) {
     rd.assert_version(io.assert_ver);
     io.assert_ver = 0;
@@ -1464,7 +1580,7 @@ RadosClient::read(IoCtxImpl& io, const object_t& oid,
   Context *onack = new C_SafeCond(&mylock, &cond, &done, &r);
   eversion_t ver;
 
-  ObjectOperation op, *pop = NULL;
+  ::ObjectOperation op, *pop = NULL;
   if (io.assert_ver) {
     op.assert_version(io.assert_ver);
     io.assert_ver = 0;
@@ -1576,7 +1692,7 @@ stat(IoCtxImpl& io, const object_t& oid, uint64_t *psize, time_t *pmtime)
   if (!psize)
     psize = &size;
 
-  ObjectOperation op, *pop = NULL;
+  ::ObjectOperation op, *pop = NULL;
   if (io.assert_ver) {
     op.assert_version(io.assert_ver);
     io.assert_ver = 0;
@@ -1613,7 +1729,7 @@ getxattr(IoCtxImpl& io, const object_t& oid, const char *name, bufferlist& bl)
   Context *onack = new C_SafeCond(&mylock, &cond, &done, &r);
   eversion_t ver;
 
-  ObjectOperation op, *pop = NULL;
+  ::ObjectOperation op, *pop = NULL;
   if (io.assert_ver) {
     op.assert_version(io.assert_ver);
     io.assert_ver = 0;
@@ -1656,7 +1772,7 @@ rmxattr(IoCtxImpl& io, const object_t& oid, const char *name)
   Context *onack = new C_SafeCond(&mylock, &cond, &done, &r);
   eversion_t ver;
 
-  ObjectOperation op, *pop = NULL;
+  ::ObjectOperation op, *pop = NULL;
   if (io.assert_ver) {
     op.assert_version(io.assert_ver);
     io.assert_ver = 0;
@@ -1698,7 +1814,7 @@ setxattr(IoCtxImpl& io, const object_t& oid, const char *name, bufferlist& bl)
   Context *onack = new C_SafeCond(&mylock, &cond, &done, &r);
   eversion_t ver;
 
-  ObjectOperation op, *pop = NULL;
+  ::ObjectOperation op, *pop = NULL;
   if (io.assert_ver) {
     op.assert_version(io.assert_ver);
     io.assert_ver = 0;
@@ -1738,7 +1854,7 @@ getxattrs(IoCtxImpl& io, const object_t& oid, map<std::string, bufferlist>& attr
   int r;
   eversion_t ver;
 
-  ObjectOperation op, *pop = NULL;
+  ::ObjectOperation op, *pop = NULL;
   if (io.assert_ver) {
     op.assert_version(io.assert_ver);
     io.assert_ver = 0;
@@ -1792,7 +1908,7 @@ watch(IoCtxImpl& io, const object_t& oid, uint64_t ver,
 {
   utime_t ut = g_clock.now();
 
-  ObjectOperation rd;
+  ::ObjectOperation rd;
   Mutex mylock("RadosClient::watch::mylock");
   Cond cond;
   bool done;
@@ -1841,7 +1957,7 @@ _notify_ack(IoCtxImpl& io, const object_t& oid, uint64_t notify_id, uint64_t ver
   Cond cond;
   eversion_t objver;
 
-  ObjectOperation rd;
+  ::ObjectOperation rd;
   if (io.assert_ver) {
     rd.assert_version(io.assert_ver);
     io.assert_ver = 0;
@@ -1868,7 +1984,7 @@ unwatch(IoCtxImpl& io, const object_t& oid, uint64_t cookie)
 
   unregister_watcher(cookie);
 
-  ObjectOperation rd;
+  ::ObjectOperation rd;
   if (io.assert_ver) {
     rd.assert_version(io.assert_ver);
     io.assert_ver = 0;
@@ -1902,7 +2018,7 @@ notify(IoCtxImpl& io, const object_t& oid, uint64_t ver)
   eversion_t objver;
   uint64_t cookie;
   C_NotifyComplete *ctx = new C_NotifyComplete(&mylock_all, &cond_all, &done_all);
-  ObjectOperation rd;
+  ::ObjectOperation rd;
 
   if (io.assert_ver) {
     rd.assert_version(io.assert_ver);
@@ -2238,6 +2354,19 @@ tmap_update(const std::string& oid, bufferlist& cmdbl)
   return io_ctx_impl->client->tmap_update(*io_ctx_impl, obj, cmdbl);
 }
 
+int librados::IoCtx::operate(const std::string& oid, librados::ObjectOperation *o, bufferlist *pbl)
+{
+  object_t obj(oid);
+  return io_ctx_impl->client->operate(*io_ctx_impl, obj, (::ObjectOperation*)o->impl, pbl);
+}
+
+int librados::IoCtx::aio_operate(const std::string& oid, AioCompletion *c, librados::ObjectOperation *o, bufferlist *pbl)
+{
+  object_t obj(oid);
+  return io_ctx_impl->client->aio_operate(*io_ctx_impl, obj, (::ObjectOperation*)o->impl, c->pc, pbl);
+}
+
+
 void librados::IoCtx::
 snap_set_read(snap_t seq)
 {
@@ -2600,6 +2729,18 @@ aio_create_completion(void *cb_arg, callback_t cb_complete, callback_t cb_safe)
   return new AioCompletion(c);
 }
 
+librados::ObjectOperation *librados::Rados::operation_create()
+{
+  return new librados::ObjectOperation((ObjectOperationImpl *)new ::ObjectOperation);
+}
+
+librados::ObjectOperation::~ObjectOperation()
+{
+  ::ObjectOperation *o = (::ObjectOperation *)impl;
+  delete o;
+}
+
+
 ///////////////////////////// C API //////////////////////////////
 static Mutex rados_init_mutex("rados_init");
 static int rados_initialized = 0;
diff --git a/src/testradospp.cc b/src/testradospp.cc
index 1db8f2f..971549a 100644
--- a/src/testradospp.cc
+++ b/src/testradospp.cc
@@ -203,6 +203,14 @@ int main(int argc, const char **argv)
       cout << s << std::endl;
   }
 
+  cout << "compound operation..." << std::endl;
+  ObjectOperation *o = rados.operation_create();
+  o->write(0, bl);
+  o->setxattr("foo", bl2);
+  r = io_ctx.operate(oid, o, &bl2);
+  cout << "operate result=" << r << std::endl;
+  delete o;
+
   cout << "iterating over objects..." << std::endl;
   int num_objs = 0;
   for (ObjectIterator iter = io_ctx.objects_begin();
-- 
1.7.2.3

