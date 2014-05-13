From: Min Chen <minchen@ubuntukylin.com>
Subject: [PATCH 3/3] *v2* librbd: copy-on-read for clones, write entire object into child asychronously
Date: Tue, 13 May 2014 17:12:15 +0800
Message-ID: <340013e3255fc81cffa351129037d4b5ff3833cc.1399970127.git.minchen@ubuntukylin.com>
References: <cover.1399970127.git.minchen@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:60233 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758786AbaEMJUb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 May 2014 05:20:31 -0400
In-Reply-To: <cover.1399970127.git.minchen@ubuntukylin.com>
In-Reply-To: <cover.1399970127.git.minchen@ubuntukylin.com>
References: <cover.1399970127.git.minchen@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: josh.durgin@inktank.com
Cc: ceph-devel@vger.kernel.org

The object has been already saved in m_entire_object bufferlist.
Send "copyup" to osd with m_entire_object, then cls_rbd copyup will write the object to child.
Put AioCompletion in xlist, and remove it after write request finished.
Add a function  xlist::iterator:: item *get_cur() {return cur;} in include/xlist.h to support removing item in xlist.

Signed-off-by: Min Chen <minchen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
Signed-off-by: Yunchuan Wen Chen <yunchuanwen@ubuntukylin.com>
---
 src/include/xlist.h      |    1 +
 src/librbd/AioRequest.cc |   33 ++++++++++++++++++++++
 src/librbd/AioRequest.h  |    1 +
 src/librbd/ImageCtx.cc   |   68 ++++++++++++++++++++++++++++++++++++++++++++++
 src/librbd/ImageCtx.h    |    6 ++++
 src/librbd/internal.cc   |    4 +++
 6 files changed, 113 insertions(+)

diff --git a/src/include/xlist.h b/src/include/xlist.h
index 5384561..3932c40 100644
--- a/src/include/xlist.h
+++ b/src/include/xlist.h
@@ -157,6 +157,7 @@ public:
       return *this;
     }
     bool end() const { return cur == 0; }
+    item *get_cur() const { return cur; }
   };
 
   iterator begin() { return iterator(_front); }
diff --git a/src/librbd/AioRequest.cc b/src/librbd/AioRequest.cc
index 1a372aa..89b7c3b 100644
--- a/src/librbd/AioRequest.cc
+++ b/src/librbd/AioRequest.cc
@@ -71,6 +71,38 @@ namespace librbd {
 
   /** read **/
 
+  //copy-on-read: after read entire object, just write it into child
+  ssize_t AioRead::write_COR()
+  {
+    ldout(m_ictx->cct, 20) << "write_COR" << dendl;
+    int ret = 0;
+
+    m_ictx->snap_lock.get_read();
+    ::SnapContext snapc = m_ictx->snapc;
+    m_ictx->snap_lock.put_read();
+
+    librados::ObjectWriteOperation copyup_cor;
+    copyup_cor.exec("rbd", "copyup", m_entire_object);
+
+    std::vector<librados::snap_t> m_snaps;
+    for (std::vector<snapid_t>::const_iterator it = snapc.snaps.begin();
+                it != snapc.snaps.end(); ++it) {
+      m_snaps.push_back(it->val);
+    }
+
+    librados::AioCompletion *cor_completion =
+        librados::Rados::aio_create_completion(m_ictx, librbd::cor_completion_callback, NULL);
+
+    xlist<librados::AioCompletion *>::item *comp =
+       new xlist<librados::AioCompletion *>::item(cor_completion);
+
+    m_ictx->add_cor_completion(comp);//add cor_completion to xlist
+    //asynchronously write object
+    ret = m_ictx->md_ctx.aio_operate(m_oid, cor_completion, &copyup_cor, snapc.seq.val, m_snaps);
+
+    return ret;
+  }
+
   bool AioRead::should_complete(int r)
   {
     ldout(m_ictx->cct, 20) << "should_complete " << this << " " << m_oid << " " << m_object_off << "~" << m_object_len
@@ -128,6 +160,7 @@ namespace librbd {
 	m_ictx->prune_parent_extents(image_extents, image_overlap);
         // copy the read range to m_read_data
         m_read_data.substr_of(m_entire_object, m_object_off, m_object_len);
+	write_COR();
       }
     }
 
diff --git a/src/librbd/AioRequest.h b/src/librbd/AioRequest.h
index 00349b2..f5daada 100644
--- a/src/librbd/AioRequest.h
+++ b/src/librbd/AioRequest.h
@@ -75,6 +75,7 @@ namespace librbd {
 	m_tried_parent(false), m_sparse(sparse) {
     }
     virtual ~AioRead() {}
+    ssize_t write_COR();
     virtual bool should_complete(int r);
     virtual int send();
 
diff --git a/src/librbd/ImageCtx.cc b/src/librbd/ImageCtx.cc
index 6477e8d..f74eafb 100644
--- a/src/librbd/ImageCtx.cc
+++ b/src/librbd/ImageCtx.cc
@@ -45,6 +45,7 @@ namespace librbd {
       snap_lock("librbd::ImageCtx::snap_lock"),
       parent_lock("librbd::ImageCtx::parent_lock"),
       refresh_lock("librbd::ImageCtx::refresh_lock"),
+      cor_lock("librbd::ImageCtx::cor_lock"),
       extra_read_flags(0),
       old_format(true),
       order(0), size(0), features(0),
@@ -96,6 +97,7 @@ namespace librbd {
       object_set->return_enoent = true;
       object_cacher->start();
     }
+    cor_completions = new xlist<librados::AioCompletion*>();
   }
 
   ImageCtx::~ImageCtx() {
@@ -112,6 +114,10 @@ namespace librbd {
       delete object_set;
       object_set = NULL;
     }
+    if (cor_completions) {
+      delete cor_completions;
+      cor_completions = NULL;
+    }
     delete[] format_string;
   }
 
@@ -648,4 +654,66 @@ namespace librbd {
 		   << " from image extents " << objectx << dendl;
     return len;
  }
+
+  void ImageCtx::add_cor_completion(xlist<librados::AioCompletion*>::item *comp)
+  {
+    if(!comp)
+      return;
+
+    cor_lock.Lock();
+    cor_completions->push_back(comp);
+    cor_lock.Unlock();
+
+    ldout(cct, 10) << "add_cor_completion:: size = "<< cor_completions->size() << dendl;
+  }
+
+  void ImageCtx::wait_last_completions()
+  {
+    ldout(cct, 10) << "wait_last_completions:: cor_completions = " << cor_completions  << " size = " << cor_completions->size()  << dendl;
+    xlist<librados::AioCompletion*>::iterator itr;
+    xlist<librados::AioCompletion*>::item *ptr;
+
+    while (!cor_completions->empty()){
+      cor_lock.Lock();
+      librados::AioCompletion *comp = cor_completions->front();
+      comp->wait_for_complete();
+      itr = cor_completions->begin();
+      ptr = itr.get_cur();
+      cor_completions->pop_front();
+      delete ptr;
+      ptr = NULL;
+      cor_lock.Unlock();
+    }
+    ldout(cct, 10) << "wait_last_completions:: after clear cor_completions = " << cor_completions  << " size = " << cor_completions->size() << dendl;
+  }
+
+  void cor_completion_callback(librados::completion_t aio_completion_impl, void *arg)
+  {
+    librbd::ImageCtx * ictx = (librbd::ImageCtx *)arg;
+
+    ictx->cor_lock.Lock();
+    xlist<librados::AioCompletion*> *completions = ictx->cor_completions; 
+    ictx->cor_lock.Unlock();
+
+    ldout(ictx->cct, 10) << "cor_completion_callback:: cor_completions = " << completions << " size = "<< completions->size() << dendl;
+    if (!completions) 
+      return;
+
+    //find current AioCompletion item in xlist, and remove it
+    for (xlist<librados::AioCompletion*>::iterator itr = completions->begin(); !(itr.end()); ++itr) {
+       if (aio_completion_impl == (*itr)->pc){
+         xlist<librados::AioCompletion*>::item *ptr = itr.get_cur();
+
+         ictx->cor_lock.Lock();
+         completions->remove(ptr);
+         ictx->cor_lock.Unlock();
+
+         delete ptr;//delete xlist<librados::AioCompletion*>::item *
+         ptr = NULL;
+         break;
+       }
+    }
+    ldout(ictx->cct, 10) << "cor_completion_callback:: after remove item, size = " << completions->size() << dendl;
+  }
+
 }
diff --git a/src/librbd/ImageCtx.h b/src/librbd/ImageCtx.h
index 026a3e0..e1d08c9 100644
--- a/src/librbd/ImageCtx.h
+++ b/src/librbd/ImageCtx.h
@@ -68,6 +68,7 @@ namespace librbd {
     RWLock snap_lock; // protects snapshot-related member variables:
     RWLock parent_lock; // protects parent_md and parent
     Mutex refresh_lock; // protects refresh_seq and last_refresh
+    Mutex cor_lock; //protects cor_completions for copy-on-read
 
     unsigned extra_read_flags;
 
@@ -89,6 +90,8 @@ namespace librbd {
     LibrbdWriteback *writeback_handler;
     ObjectCacher::ObjectSet *object_set;
 
+    xlist<librados::AioCompletion*> *cor_completions; //copy-on-read AioCompletions
+
     /**
      * Either image_name or image_id must be set.
      * If id is not known, pass the empty std::string,
@@ -148,7 +151,10 @@ namespace librbd {
     uint64_t prune_parent_extents(vector<pair<uint64_t,uint64_t> >& objectx,
 				  uint64_t overlap);
 
+    void add_cor_completion(xlist<librados::AioCompletion*>::item *comp);
+    void wait_last_completions();//wait for uncompleted asynchronous write which is still in xlist
   };
+  void cor_completion_callback(librados::completion_t aio_completion_impl, void *arg);
 }
 
 #endif
diff --git a/src/librbd/internal.cc b/src/librbd/internal.cc
index 127be38..defbb46 100644
--- a/src/librbd/internal.cc
+++ b/src/librbd/internal.cc
@@ -2101,6 +2101,10 @@ reprotect_and_return_err:
   void close_image(ImageCtx *ictx)
   {
     ldout(ictx->cct, 20) << "close_image " << ictx << dendl;
+
+    if(ictx->cor_completions)
+      ictx->wait_last_completions();//copy-on-read: wait for unfinished AioCompletion requests
+
     if (ictx->object_cacher)
       ictx->shutdown_cache(); // implicitly flushes
     else
-- 
1.7.10.4

