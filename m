From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] ceph: re-enable rados_aio_set_callback
Date: Wed, 5 May 2010 14:40:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005051425180.16467@cobra.newdream.net>
References: <20100505195053.GA50246@ncolin.muc.de>
 <h2oa37615151005051322z8a2c781ajdfe4f31fef78a8a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34714 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758845Ab0EEVh6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 May 2010 17:37:58 -0400
In-Reply-To: <h2oa37615151005051322z8a2c781ajdfe4f31fef78a8a1@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Christian Brunner <chb@muc.de>, ceph-devel@vger.kernel.org

On Wed, 5 May 2010, Yehuda Sadeh Weinraub wrote:
> On Wed, May 5, 2010 at 12:50 PM, Christian Brunner <chb@muc.de> wrote:
> ...
> >
> > To work around this, I?d suggest to re-enable rados_aio_set_callback.
> > This way it would possible to clear (cb=NULL) or change the callback
> > handler.
> 
> 
> Although this would solve that specific problem I'd rather leave this
> function out, as it is racy and could be misused. I think having a
> solution in which we either set different callbacks for the complete
> and for the safe replies, or just set a flag that specifies when to
> use this callback would be better.

I think being able to specify a callback for each would be the most 
flexible.  Also, to be clear, setting adjusting the completions callback 
is safe if it happens prior to the completion being used (before calling 
aio_read or whatever).  After that I don't think we should make any 
promises.

The patch below changes the API a bit.  Since I think kvm-rbd is the only 
aio callback user so far, I'm going to be lazy and skip any compat cruft 
to maintain compatibility.  Does this look okay?

sage


diff --git a/src/include/librados.h b/src/include/librados.h
index 5f20c5a..5418c87 100644
--- a/src/include/librados.h
+++ b/src/include/librados.h
@@ -79,8 +79,8 @@ int rados_exec(rados_pool_t pool, const char *oid, const char *cls, const char *
 typedef void *rados_completion_t;
 typedef void (*rados_callback_t)(rados_completion_t cb, void *arg);
 
-int rados_aio_create_completion(rados_callback_t, void *arg, rados_completion_t *pc);
-int rados_aio_set_callback(rados_completion_t c, rados_callback_t, void *arg);
+int rados_aio_create_completion(void *cb_arg, rados_callback_t cb_ack, rados_callback_t cb_safe,
+				rados_completion_t *pc);
 int rados_aio_wait_for_complete(rados_completion_t c);
 int rados_aio_wait_for_safe(rados_completion_t c);
 int rados_aio_is_complete(rados_completion_t c);
diff --git a/src/include/librados.hpp b/src/include/librados.hpp
index 0e70e30..b9ec3c2 100644
--- a/src/include/librados.hpp
+++ b/src/include/librados.hpp
@@ -100,7 +100,8 @@ public:
   struct AioCompletion {
     void *pc;
     AioCompletion(void *_pc) : pc(_pc) {}
-    int set_callback(callback_t cb, void *cba);
+    int set_ack_callback(void *cba, callback_t cb);
+    int set_safe_callback(void *cba, callback_t cb);
     int wait_for_complete();
     int wait_for_safe();
     bool is_complete();
@@ -114,7 +115,7 @@ public:
   int aio_write(pool_t pool, const std::string& oid, off_t off, const bufferlist& bl, size_t len,
 		AioCompletion *c);
   AioCompletion *aio_create_completion();
-  AioCompletion *aio_create_completion(callback_t cb, void *cba);
+  AioCompletion *aio_create_completion(void *cb_arg, callback_t cb_ack, callback_t cb_safe);
 };
 
 }
diff --git a/src/librados.cc b/src/librados.cc
index 76d4a53..1135a42 100644
--- a/src/librados.cc
+++ b/src/librados.cc
@@ -147,7 +147,7 @@ public:
     bool released;
     bool ack, safe;
 
-    rados_callback_t callback;
+    rados_callback_t callback_ack, callback_safe;
     void *callback_arg;
 
     // for read
@@ -157,12 +157,19 @@ public:
 
     AioCompletion() : lock("RadosClient::AioCompletion::lock"),
 		      ref(1), rval(0), released(false), ack(false), safe(false), 
-		      callback(0), callback_arg(0),
+		      callback_ack(0), callback_safe(0), callback_arg(0),
 		      pbl(0), buf(0), maxlen(0) { }
 
-    int set_callback(rados_callback_t cb, void *cba) {
+    int set_ack_callback(void *cba, rados_callback_t cb) {
       lock.Lock();
-      callback = cb;
+      callback_ack = cb;
+      callback_arg = cba;
+      lock.Unlock();
+      return 0;
+    }
+    int set_safe_callback(void *cba, rados_callback_t cb) {
+      lock.Lock();
+      callback_safe = cb;
       callback_arg = cba;
       lock.Unlock();
       return 0;
@@ -242,8 +249,8 @@ public:
 	*c->pbl = c->bl;
       }
 
-      if (c->callback) {
-	rados_callback_t cb = c->callback;
+      if (c->callback_ack) {
+	rados_callback_t cb = c->callback_ack;
 	void *cba = c->callback_arg;
 	c->lock.Unlock();
 	cb(c, cba);
@@ -268,8 +275,8 @@ public:
       c->safe = true;
       c->cond.Signal();
 
-      if (c->callback) {
-	rados_callback_t cb = c->callback;
+      if (c->callback_safe) {
+	rados_callback_t cb = c->callback_safe;
 	void *cba = c->callback_arg;
 	c->lock.Unlock();
 	cb(c, cba);
@@ -294,9 +301,12 @@ public:
   AioCompletion *aio_create_completion() {
     return new AioCompletion;
   }
-  AioCompletion *aio_create_completion(rados_callback_t cb, void *cba) {
+  AioCompletion *aio_create_completion(void *cb_arg, rados_callback_t cb_ack, rados_callback_t cb_safe) {
     AioCompletion *c = new AioCompletion;
-    c->set_callback(cb, cba);
+    if (cb_ack)
+      c->set_ack_callback(cb_arg, cb_ack);
+    if (cb_safe)
+      c->set_safe_callback(cb_arg, cb_safe);
     return c;
   }
 };
@@ -1454,16 +1464,21 @@ Rados::AioCompletion *Rados::aio_create_completion()
   return new AioCompletion(c);
 }
 
-Rados::AioCompletion *Rados::aio_create_completion(callback_t cb, void *cba)
+Rados::AioCompletion *Rados::aio_create_completion(void *cb_arg, callback_t cb_ack, callback_t cb_safe)
 {
-  RadosClient::AioCompletion *c = ((RadosClient *)client)->aio_create_completion(cb, cba);
+  RadosClient::AioCompletion *c = ((RadosClient *)client)->aio_create_completion(cb_arg, cb_ack, cb_safe);
   return new AioCompletion(c);
 }
 
-int Rados::AioCompletion::set_callback(rados_callback_t cb, void *cba)
+int Rados::AioCompletion::set_ack_callback(void *cba, rados_callback_t cb)
+{
+  RadosClient::AioCompletion *c = (RadosClient::AioCompletion *)pc;
+  return c->set_ack_callback(cba, cb);
+}
+int Rados::AioCompletion::set_safe_callback(void *cba, rados_callback_t cb)
 {
   RadosClient::AioCompletion *c = (RadosClient::AioCompletion *)pc;
-  return c->set_callback(cb, cba);
+  return c->set_safe_callback(cba, cb);
 }
 int Rados::AioCompletion::wait_for_complete()
 {
@@ -1805,9 +1820,9 @@ extern "C" int rados_list_objects_next(rados_list_ctx_t listctx, const char **en
 // -------------------------
 // aio
 
-extern "C" int rados_aio_create_completion(rados_callback_t cb, void *cba, rados_completion_t *pc)
+extern "C" int rados_aio_create_completion(void *cb_arg, rados_callback_t cb_ack, rados_callback_t cb_safe, rados_completion_t *pc)
 {
-  *pc = radosp->aio_create_completion(cb, cba);
+  *pc = radosp->aio_create_completion(cb_arg, cb_ack, cb_safe);
   return 0;
 }
 

