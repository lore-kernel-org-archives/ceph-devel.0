From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: librbd discard bug problems -> i got it
Date: Tue, 20 Nov 2012 10:50:59 +0100
Message-ID: <50AB5283.4040408@profihost.ag>
References: <50AAA25F.9040908@profihost.ag> <50AAB4D6.3030304@inktank.com> <50AABDD1.5050802@profihost.ag> <50AAC1B1.9070701@inktank.com> <50AAC3CB.9090309@profihost.ag> <50AAC51C.1090904@inktank.com> <50AAC835.908@profihost.ag> <50AACE9D.8080905@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000608020201090904050105"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:34974 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786Ab2KTJvE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Nov 2012 04:51:04 -0500
In-Reply-To: <50AACE9D.8080905@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------000608020201090904050105
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

here is the patch. In the log is nothing interesting.

Stefan
Am 20.11.2012 01:28, schrieb Josh Durgin:
> On 11/19/2012 04:00 PM, Stefan Priebe wrote:
>> Hi Josh,
>>
>> i don't get it. Every debug line i print is a prositive fine value. BUt
>> rbd_aio_bh_cb get's called with these values. As you can see that are
>> not much values i copied all values < 0 from log for discarding a whole
>> 30GB device.
>
> Could you post the patch of the debug prints you added and the log?

--------------000608020201090904050105
Content-Type: text/x-patch;
 name="rdebug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="rdebug.patch"

diff --git a/src/librbd/AioCompletion.cc b/src/librbd/AioCompletion.cc
index 082a08e..021da03 100644
--- a/src/librbd/AioCompletion.cc
+++ b/src/librbd/AioCompletion.cc
@@ -19,7 +19,7 @@ namespace librbd {
 
   void AioCompletion::finish_adding_requests(CephContext *cct)
   {
-    ldout(cct, 20) << "AioCompletion::finish_adding_requests " << (void*)this << " pending " << pending_count << dendl;
+    ldout(cct, 20) << "AioCompletion::finish_adding_requests " << (void*)this << " pending " << pending_count << " rval: " << rval << dendl;
     lock.Lock();
     assert(building);
     building = false;
@@ -58,14 +58,20 @@ namespace librbd {
   {
     ldout(cct, 20) << "AioCompletion::complete_request() "
 		   << (void *)this << " complete_cb=" << (void *)complete_cb
-		   << " pending " << pending_count << dendl;
+		   << " pending " << pending_count << " r: " << r << " rval: " << rval << dendl;
     lock.Lock();
     if (rval >= 0) {
       if (r < 0 && r != -EEXIST)
 	rval = r;
-      else if (r > 0)
+      else if (r > 0) {
 	rval += r;
+      }
     }
+
+    ldout(cct, 20) << "AioCompletion::complete_request()22 "
+		   << (void *)this << " complete_cb=" << (void *)complete_cb
+		   << " pending " << pending_count << " r: " << r << " rval: " << rval << dendl;
+
     assert(pending_count);
     int count = --pending_count;
     if (!count && !building) {
@@ -75,6 +81,12 @@ namespace librbd {
     put_unlock();
   }
 
+  void C_AioWrite::finish(int r)
+  {
+      ldout(m_cct, 10) << "C_AioWrite::finish() " << this << " r = " << r << dendl;
+      m_completion->complete_request(m_cct, r);
+  }
+
   void C_AioRead::finish(int r)
   {
     ldout(m_cct, 10) << "C_AioRead::finish() " << this << " r = " << r << dendl;
@@ -94,11 +106,13 @@ namespace librbd {
 							m_req->m_buffer_extents);
       r = m_req->m_object_len;
     }
+    ldout(m_cct, 10) << "C_AioRead::finish22() " << this << " r = " << r << dendl;
     m_completion->complete_request(m_cct, r);
   }
 
   void C_CacheRead::finish(int r)
   {
+    fprintf(stdout, "C_CacheRead::finish r: %d\n", r);
     m_req->complete(r);
   }
 }
diff --git a/src/librbd/AioCompletion.h b/src/librbd/AioCompletion.h
index 7d3f336..d174140 100644
--- a/src/librbd/AioCompletion.h
+++ b/src/librbd/AioCompletion.h
@@ -178,9 +178,7 @@ namespace librbd {
     C_AioWrite(CephContext *cct, AioCompletion *completion)
       : m_cct(cct), m_completion(completion) {}
     virtual ~C_AioWrite() {}
-    virtual void finish(int r) {
-      m_completion->complete_request(m_cct, r);
-    }
+    virtual void finish(int r);
   private:
     CephContext *m_cct;
     AioCompletion *m_completion;
diff --git a/src/librbd/AioRequest.cc b/src/librbd/AioRequest.cc
index 63424e3..7460799 100644
--- a/src/librbd/AioRequest.cc
+++ b/src/librbd/AioRequest.cc
@@ -47,6 +47,18 @@ namespace librbd {
     }
   }
 
+   void AioRequest::complete(int r)
+    {
+    ldout(m_ictx->cct, 20) << "AioRequest::complete " << this << " r = " << r << dendl;
+      if (should_complete(r)) {
+        if (m_hide_enoent && r == -ENOENT)
+          r = 0;
+        ldout(m_ictx->cct, 20) << "AioRequest::complete22 " << this << " r = " << r << dendl;
+        m_completion->complete(r);
+        delete this;
+      }
+    }
+
   void AioRequest::read_from_parent(vector<pair<uint64_t,uint64_t> >& image_extents)
   {
     assert(!m_parent_completion);
@@ -82,6 +94,11 @@ namespace librbd {
       if (r < 0) {
 	assert(0 == "FIXME");
       }
+
+    ldout(m_ictx->cct, 20) << "should_complete22 " << this << " " << m_oid << " " << m_object_off << "~" << m_object_len
+			   << " r = " << r << dendl;
+
+
       uint64_t object_overlap = m_ictx->prune_parent_extents(image_extents, image_overlap);
       if (object_overlap) {
 	m_tried_parent = true;
diff --git a/src/librbd/AioRequest.h b/src/librbd/AioRequest.h
index 259af88..a33038c 100644
--- a/src/librbd/AioRequest.h
+++ b/src/librbd/AioRequest.h
@@ -32,23 +32,14 @@ namespace librbd {
 	       bool hide_enoent);
     virtual ~AioRequest();
 
-    void complete(int r)
-    {
-      if (should_complete(r)) {
-	if (m_hide_enoent && r == -ENOENT)
-	  r = 0;
-	m_completion->complete(r);
-	delete this;
-      }
-    }
-
+    virtual void complete(int r);
     virtual bool should_complete(int r) = 0;
     virtual int send() = 0;
+    ImageCtx *m_ictx;
 
   protected:
     void read_from_parent(vector<pair<uint64_t,uint64_t> >& image_extents);
 
-    ImageCtx *m_ictx;
     librados::IoCtx m_ioctx;
     std::string m_oid;
     uint64_t m_object_no, m_object_off, m_object_len;
diff --git a/src/librbd/ImageCtx.cc b/src/librbd/ImageCtx.cc
index b29a2ca..825a6a3 100644
--- a/src/librbd/ImageCtx.cc
+++ b/src/librbd/ImageCtx.cc
@@ -472,8 +472,10 @@ namespace librbd {
     cache_lock.Lock();
     int r = object_cacher->readx(rd, object_set, onfinish);
     cache_lock.Unlock();
-    if (r != 0)
+    if (r != 0) {
+      ldout(cct, 20) << "ImageCtx::aio_read_from_cache: r: " << r << dendl;
       onfinish->complete(r);
+    }
   }
 
   void ImageCtx::write_to_cache(object_t o, bufferlist& bl, size_t len,
diff --git a/src/librbd/LibrbdWriteback.cc b/src/librbd/LibrbdWriteback.cc
index 6d69a82..e3ac5ce 100644
--- a/src/librbd/LibrbdWriteback.cc
+++ b/src/librbd/LibrbdWriteback.cc
@@ -32,7 +32,9 @@ namespace librbd {
   void context_cb(rados_completion_t c, void *arg)
   {
     Context *con = reinterpret_cast<Context *>(arg);
-    con->finish(rados_aio_get_return_value(c));
+    int r = rados_aio_get_return_value(c);
+    fprintf(stdout, "context_cb completing r: %d\n", r);
+    con->finish(r);
     delete con;
   }
 
@@ -50,9 +52,10 @@ namespace librbd {
     virtual ~C_Request() {}
     void set_req(AioRequest *req);
     virtual void finish(int r) {
-      ldout(m_cct, 20) << "aio_cb completing " << dendl;
+      ldout(m_cct, 20) << "aio_cb completing" << dendl;
       {
 	Mutex::Locker l(*m_lock);
+        ldout(m_cct, 20) << "aio_cb completing r: " << r << dendl;
 	m_ctx->complete(r);
       }
       ldout(m_cct, 20) << "aio_cb finished" << dendl;
diff --git a/src/librbd/internal.cc b/src/librbd/internal.cc
index 501a63d..99f6f05 100644
--- a/src/librbd/internal.cc
+++ b/src/librbd/internal.cc
@@ -2087,7 +2087,9 @@ reprotect_and_return_err:
   {
     Context *ctx = reinterpret_cast<Context *>(arg);
     AioCompletion *comp = reinterpret_cast<AioCompletion *>(cb);
-    ctx->complete(comp->get_return_value());
+    int r = comp->get_return_value();
+    ldout(comp->ictx->cct, 20) << "rbd_ctx_cb() r:" << r << dendl;
+    ctx->complete(r);
   }
 
   int64_t read_iterate(ImageCtx *ictx, uint64_t off, size_t len,
@@ -2275,7 +2277,8 @@ reprotect_and_return_err:
     ictx->perfcounter->inc(l_librbd_discard_latency, elapsed);
     ictx->perfcounter->inc(l_librbd_discard);
     ictx->perfcounter->inc(l_librbd_discard_bytes, len);
-    return len;
+    // return len;
+    return 0;
   }
 
   ssize_t handle_sparse_read(CephContext *cct,
@@ -2342,7 +2345,9 @@ reprotect_and_return_err:
   void rados_req_cb(rados_completion_t c, void *arg)
   {
     AioRequest *req = reinterpret_cast<AioRequest *>(arg);
-    req->complete(rados_aio_get_return_value(c));
+    int r = rados_aio_get_return_value(c);
+    ldout(req->m_ictx->cct, 20) << "rados_req_cb() r:" << r << dendl;
+    req->complete(r);
   }
 
   // validate extent against image size; clip to image size if necessary
@@ -2534,13 +2539,23 @@ reprotect_and_return_err:
 	object_overlap = ictx->prune_parent_extents(objectx, overlap);
       }
 
+
+// STEFAN
       if (p->offset == 0 && p->length == ictx->layout.fl_object_size) {
+//      ldout(cct, 20) << " oid " << p->oid << " " << p->offset << "~" << p->length
+//		     << " from " << p->buffer_extents << " STEFAN AioRemove" << dendl;
 	req = new AioRemove(ictx, p->oid.name, p->objectno, objectx, object_overlap,
 			    snapc, snap_id, req_comp);
-      } else if (p->offset + p->length == ictx->layout.fl_object_size) {
+      } else if ((p->offset + p->length) == ictx->layout.fl_object_size) {
+      ldout(cct, 20) << " oid " << p->oid << " " << p->offset << "~" << p->length << "==" << ictx->layout.fl_object_size <<
+                      " lap " << object_overlap << " off " << off << "<" << overlap
+		     << " from " << p->buffer_extents << " STEFAN AioTruncate" << dendl;
 	req = new AioTruncate(ictx, p->oid.name, p->objectno, p->offset, objectx, object_overlap,
 			      snapc, snap_id, req_comp);
       } else {
+      ldout(cct, 20) << " oid " << p->oid << " " << p->offset << "~" << p->length << "<" << ictx->layout.fl_object_size <<
+                      " lap " << object_overlap << " off " << off << "<" << overlap
+		     << " from " << p->buffer_extents << " STEFAN AioZero" << dendl;
 	req = new AioZero(ictx, p->oid.name, p->objectno, p->offset, p->length,
 			  objectx, object_overlap,
 			  snapc, snap_id, req_comp);
@@ -2557,6 +2572,7 @@ reprotect_and_return_err:
       ictx->object_cacher->discard_set(ictx->object_set, extents);
     }
 
+//S STEFAN
     c->finish_adding_requests(ictx->cct);
     c->put();
 
@@ -2571,7 +2587,9 @@ reprotect_and_return_err:
   {
     AioRequest *req = reinterpret_cast<AioRequest *>(arg);
     AioCompletion *comp = reinterpret_cast<AioCompletion *>(cb);
-    req->complete(comp->get_return_value());
+    int r = comp->get_return_value();
+    ldout(comp->ictx->cct, 20) << "rbd_req_cb() r:" << r << dendl;
+    req->complete(r);
   }
 
   int aio_read(ImageCtx *ictx, uint64_t off, size_t len,
diff --git a/src/librbd/librbd.cc b/src/librbd/librbd.cc
index e819455..f763b41 100644
--- a/src/librbd/librbd.cc
+++ b/src/librbd/librbd.cc
@@ -171,7 +171,9 @@ namespace librbd {
   int RBD::AioCompletion::wait_for_complete()
   {
     librbd::AioCompletion *c = (librbd::AioCompletion *)pc;
-    return c->wait_for_complete();
+    int r = c->wait_for_complete();
+    ldout(c->ictx->cct, 10) << "RBD::AioCompletion::wait_for_complete() r: " << r << dendl;
+    return r;
   }
 
   ssize_t RBD::AioCompletion::get_return_value()
@@ -1037,7 +1039,9 @@ extern "C" int rbd_flush(rbd_image_t image)
 extern "C" int rbd_aio_wait_for_complete(rbd_completion_t c)
 {
   librbd::RBD::AioCompletion *comp = (librbd::RBD::AioCompletion *)c;
-  return comp->wait_for_complete();
+  int r = comp->wait_for_complete();
+  fprintf(stdout, "rbd_aio_wait_for_complete() r: %d\n", r);
+  return r;
 }
 
 extern "C" ssize_t rbd_aio_get_return_value(rbd_completion_t c)

--------------000608020201090904050105--
