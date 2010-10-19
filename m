From: Takuya ASADA <syuu@dokukino.com>
Subject: Re: read/write on RADOS using external buffer
Date: Wed, 20 Oct 2010 07:27:27 +0900
Message-ID: <20101019222727.GA1737@enoki.dokukino.com>
References: <AANLkTikRnvWbsD5OD7a88hpHsm5N3hJteaisYkfjdY2H@mail.gmail.com>
 <Pine.LNX.4.64.1009141142250.8559@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45180 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756327Ab0JSW1f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Oct 2010 18:27:35 -0400
Received: by gyg13 with SMTP id 13so201867gyg.19
        for <ceph-devel@vger.kernel.org>; Tue, 19 Oct 2010 15:27:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1009141142250.8559@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi,

I just implemented the patch to support external buffer on Rados::read() and Rados::write().

diff --git a/src/include/librados.hpp b/src/include/librados.hpp
index 06fa3b2..bfb0f5b 100644
--- a/src/include/librados.hpp
+++ b/src/include/librados.hpp
@@ -63,8 +63,10 @@ public:
   int create(pool_t pool, const std::string& oid, bool exclusive);
 
   int write(pool_t pool, const std::string& oid, off_t off, bufferlist& bl, size_t len);
+  int write(pool_t pool, const std::string& oid, off_t off, void *buf, size_t len);
   int write_full(pool_t pool, const std::string& oid, bufferlist& bl);
   int read(pool_t pool, const std::string& oid, off_t off, bufferlist& bl, size_t len);
+  int read(pool_t pool, const std::string& oid, off_t off, void *buf, size_t len);
   int remove(pool_t pool, const std::string& oid);
   int trunc(pool_t pool, const std::string& oid, size_t size);
 
@@ -135,4 +137,3 @@ public:
 }
 
 #endif
-
diff --git a/src/librados.cc b/src/librados.cc
index 4c8a464..91e6a27 100644
--- a/src/librados.cc
+++ b/src/librados.cc
@@ -72,11 +72,12 @@ class RadosClient : public Dispatcher
 
   Mutex lock;
   Cond cond;
+  static hash_map<tid_t, bufferptr*> buffer_map;
+  static bufferptr* fetch_buffer_func(tid_t tid);
 
- 
 public:
   RadosClient() : messenger(NULL), lock("radosclient") {
-    messenger = new SimpleMessenger();
+    messenger = new SimpleMessenger(&RadosClient::fetch_buffer_func);
   }
 
   ~RadosClient();
@@ -132,8 +133,10 @@ public:
   // io
   int create(PoolCtx& pool, const object_t& oid, bool exclusive);
   int write(PoolCtx& pool, const object_t& oid, off_t off, bufferlist& bl, size_t len);
+  int write(PoolCtx& pool, const object_t& oid, off_t off, void *buf, size_t len);
   int write_full(PoolCtx& pool, const object_t& oid, bufferlist& bl);
   int read(PoolCtx& pool, const object_t& oid, off_t off, bufferlist& bl, size_t len);
+  int read(PoolCtx& pool, const object_t& oid, off_t off, void *buf, size_t len);
   int remove(PoolCtx& pool, const object_t& oid);
   int stat(PoolCtx& pool, const object_t& oid, uint64_t *psize, time_t *pmtime);
   int trunc(PoolCtx& pool, const object_t& oid, size_t size);
@@ -870,6 +873,15 @@ int RadosClient::write(PoolCtx& pool, const object_t& oid, off_t off, bufferlist
   return len;
 }
 
+int RadosClient::write(PoolCtx& pool, const object_t& oid, off_t off, void *buf, size_t len)
+{
+  bufferptr bp = buffer::create_static(len, static_cast<char *>(buf));
+  bufferlist bl;
+
+  bl.push_back(bp);
+  return write(pool, oid, off, bl, len);
+}
+
 int RadosClient::write_full(PoolCtx& pool, const object_t& oid, bufferlist& bl)
 {
   utime_t ut = g_clock.now();
@@ -1116,6 +1128,46 @@ int RadosClient::read(PoolCtx& pool, const object_t& oid, off_t off, bufferlist&
   return bl.length();
 }
 
+int RadosClient::read(PoolCtx& pool, const object_t& oid, off_t off, void *buf, size_t len)
+{
+  SnapContext snapc;
+
+  Mutex mylock("RadosClient::read::mylock");
+  Cond cond;
+  bool done;
+  int r;
+  Context *onack = new C_SafeCond(&mylock, &cond, &done, &r);
+  bufferptr bp = buffer::create_static(len, static_cast<char *>(buf));
+  bufferlist bl;
+
+  bl.push_back(bp);
+  lock.Lock();
+  ceph_object_layout layout = objecter->osdmap->make_object_layout(oid, pool.poolid);
+  tid_t tid = objecter->get_tid();
+  buffer_map[tid] = &bp;
+  objecter->read_with_tid(oid, layout,
+	      off, len, pool.snap_seq, &bl, 0,
+	      onack, tid);
+  lock.Unlock();
+
+  mylock.Lock();
+  while (!done)
+    cond.Wait(mylock);
+  mylock.Unlock();
+  buffer_map.erase(tid);
+  dout(10) << "Objecter returned from read r=" << r << dendl;
+
+  if (r < 0)
+    return r;
+
+  if (bl.length() < len) {
+    dout(10) << "Returned length " << bl.length()
+	     << " less than original length "<< len << dendl;
+  }
+
+  return bl.length();
+}
+
 int RadosClient::stat(PoolCtx& pool, const object_t& oid, uint64_t *psize, time_t *pmtime)
 {
   SnapContext snapc;
@@ -1251,6 +1303,13 @@ int RadosClient::getxattrs(PoolCtx& pool, const object_t& oid, map<std::string,
   return r;
 }
 
+hash_map<tid_t, bufferptr*> RadosClient::buffer_map;
+
+bufferptr* RadosClient::fetch_buffer_func(tid_t tid)
+{
+  return buffer_map[tid];
+}
+
 // ---------------------------------------------
 
 namespace librados {
@@ -1401,6 +1460,14 @@ int Rados::write(rados_pool_t pool, const string& o, off_t off, bufferlist& bl,
   return ((RadosClient *)client)->write(*(RadosClient::PoolCtx *)pool, oid, off, bl, len);
 }
 
+int Rados::write(rados_pool_t pool, const string& o, off_t off, void *buf, size_t len)
+{
+  if (!client)
+    return -EINVAL;
+  object_t oid(o);
+  return ((RadosClient *)client)->write(*(RadosClient::PoolCtx *)pool, oid, off, buf, len);
+}
+
 int Rados::write_full(rados_pool_t pool, const string& o, bufferlist& bl)
 {
   if (!client)
@@ -1433,6 +1500,14 @@ int Rados::read(rados_pool_t pool, const string& o, off_t off, bufferlist& bl, s
   return ((RadosClient *)client)->read(*(RadosClient::PoolCtx *)pool, oid, off, bl, len);
 }
 
+int Rados::read(rados_pool_t pool, const string& o, off_t off, void *buf, size_t len)
+{
+  if (!client)
+    return -EINVAL;
+  object_t oid(o);
+  return ((RadosClient *)client)->read(*(RadosClient::PoolCtx *)pool, oid, off, buf, len);
+}
+
 int Rados::getxattr(rados_pool_t pool, const string& o, const char *name, bufferlist& bl)
 {
   if (!client)
diff --git a/src/msg/SimpleMessenger.cc b/src/msg/SimpleMessenger.cc
index 4632267..75b4576 100644
--- a/src/msg/SimpleMessenger.cc
+++ b/src/msg/SimpleMessenger.cc
@@ -51,7 +51,7 @@ static ostream& _prefix(SimpleMessenger *messenger) {
 #define closed_socket() //dout(20) << "closed_socket " << --sockopen << dendl;
 #define opened_socket() //dout(20) << "opened_socket " << ++sockopen << dendl;
 
-
+SimpleMessenger::fetch_buffer_callback_t SimpleMessenger::fetch_buffer_callback = 0;
 
 /********************************************
  * Accepter
@@ -1786,36 +1786,47 @@ int SimpleMessenger::Pipe::read_message(Message **pm)
   data_len = le32_to_cpu(header.data_len);
   data_off = le32_to_cpu(header.data_off);
   if (data_len) {
-    int left = data_len;
-    if (data_off & ~PAGE_MASK) {
-      // head
-      int head = MIN(PAGE_SIZE - (data_off & ~PAGE_MASK),
-		     (unsigned)left);
-      bufferptr bp = buffer::create(head);
-      if (tcp_read( sd, bp.c_str(), head, messenger->timeout ) < 0)
+    if (fetch_buffer_callback) {
+      bufferptr *bpp = fetch_buffer_callback(header.tid);
+      if (!bpp)
+	goto allocate_buffer;
+      if (tcp_read( sd, bpp->c_str(), data_len, messenger->timeout ) < 0)
 	goto out_dethrottle;
-      data.push_back(bp);
-      left -= head;
-      dout(20) << "reader got data head " << head << dendl;
-    }
+      data.push_back(*bpp);
+      dout(20) << "reader got data " << data_len << dendl;
+    }else{
+    allocate_buffer:
+      int left = data_len;
+      if (data_off & ~PAGE_MASK) {
+	// head
+	int head = MIN(PAGE_SIZE - (data_off & ~PAGE_MASK),
+		       (unsigned)left);
+	bufferptr bp = buffer::create(head);
+	if (tcp_read( sd, bp.c_str(), head, messenger->timeout ) < 0)
+	  goto out_dethrottle;
+	data.push_back(bp);
+	left -= head;
+	dout(20) << "reader got data head " << head << dendl;
+      }
 
-    // middle
-    int middle = left & PAGE_MASK;
-    if (middle > 0) {
-      bufferptr bp = buffer::create_page_aligned(middle);
-      if (tcp_read( sd, bp.c_str(), middle, messenger->timeout ) < 0)
-	goto out_dethrottle;
-      data.push_back(bp);
-      left -= middle;
-      dout(20) << "reader got data page-aligned middle " << middle << dendl;
-    }
+      // middle
+      int middle = left & PAGE_MASK;
+      if (middle > 0) {
+	bufferptr bp = buffer::create_page_aligned(middle);
+	if (tcp_read( sd, bp.c_str(), middle, messenger->timeout ) < 0)
+	  goto out_dethrottle;
+	data.push_back(bp);
+	left -= middle;
+	dout(20) << "reader got data page-aligned middle " << middle << dendl;
+      }
 
-    if (left) {
-      bufferptr bp = buffer::create(left);
-      if (tcp_read( sd, bp.c_str(), left, messenger->timeout ) < 0)
-	goto out_dethrottle;
-      data.push_back(bp);
-      dout(20) << "reader got data tail " << left << dendl;
+      if (left) {
+	bufferptr bp = buffer::create(left);
+	if (tcp_read( sd, bp.c_str(), left, messenger->timeout ) < 0)
+	  goto out_dethrottle;
+	data.push_back(bp);
+	dout(20) << "reader got data tail " << left << dendl;
+      }
     }
   }
 
diff --git a/src/msg/SimpleMessenger.h b/src/msg/SimpleMessenger.h
index b4a0ef3..72a5a1b 100644
--- a/src/msg/SimpleMessenger.h
+++ b/src/msg/SimpleMessenger.h
@@ -567,6 +567,9 @@ private:
   SimpleMessenger *messenger; //hack to make dout macro work, will fix
   int timeout;
 
+  typedef bufferptr* (*fetch_buffer_callback_t) (tid_t);
+  static fetch_buffer_callback_t fetch_buffer_callback;
+
 public:
   SimpleMessenger() :
     Messenger(entity_name_t()),
@@ -580,6 +583,20 @@ public:
     // for local dmsg delivery
     dispatch_queue.local_pipe = new Pipe(this, Pipe::STATE_OPEN);
   }
+
+  SimpleMessenger(fetch_buffer_callback_t callback) :
+    Messenger(entity_name_t()),
+    accepter(this),
+    lock("SimpleMessenger::lock"), started(false), did_bind(false),
+    dispatch_throttler(g_conf.ms_dispatch_throttle_bytes), need_addr(true),
+    destination_stopped(true), my_type(-1),
+    global_seq_lock("SimpleMessenger::global_seq_lock"), global_seq(0),
+    reaper_thread(this), reaper_started(false), reaper_stop(false), 
+    dispatch_thread(this), messenger(this) {
+    fetch_buffer_callback = callback;
+    // for local dmsg delivery
+    dispatch_queue.local_pipe = new Pipe(this, Pipe::STATE_OPEN);
+  }
   ~SimpleMessenger() {
     delete dispatch_queue.local_pipe;
   }
diff --git a/src/osdc/Objecter.h b/src/osdc/Objecter.h
index a34c0a9..fd43795 100644
--- a/src/osdc/Objecter.h
+++ b/src/osdc/Objecter.h
@@ -530,6 +530,21 @@ private:
     o->outbl = pbl;
     return op_submit(o);
   }
+  tid_t read_with_tid(const object_t& oid, ceph_object_layout ol, 
+	     uint64_t off, uint64_t len, snapid_t snap, bufferlist *pbl, int flags,
+	     Context *onfinish, tid_t tid) {
+    vector<OSDOp> ops(1);
+    ops[0].op.op = CEPH_OSD_OP_READ;
+    ops[0].op.extent.offset = off;
+    ops[0].op.extent.length = len;
+    ops[0].op.extent.truncate_size = 0;
+    ops[0].op.extent.truncate_seq = 0;
+    Op *o = new Op(oid, ol, ops, flags, onfinish, 0);
+    o->snapid = snap;
+    o->outbl = pbl;
+    o->tid = tid;
+    return op_submit(o);
+  }
   tid_t read_trunc(const object_t& oid, ceph_object_layout ol, 
 	     uint64_t off, uint64_t len, snapid_t snap, bufferlist *pbl, int flags,
 	     uint64_t trunc_size, __u32 trunc_seq,
@@ -725,6 +740,8 @@ private:
 
   void list_objects(ListContext *p, Context *onfinish);
 
+  tid_t get_tid(void) { return ++last_tid; }
+
   // -------------------------
   // pool ops
 private:
