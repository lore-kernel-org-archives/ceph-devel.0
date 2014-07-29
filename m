From: Min Chen <minchen@ubuntukylin.com>
Subject: [PATCH 2/3] librbd: v3 copy-on-read for clones, read entire object from parent
Date: Tue, 29 Jul 2014 10:29:10 +0800
Message-ID: <c9e35f29f907aac19498e7cd02f13eb0592b393a.1406594913.git.minchen@ubuntukylin.com>
References: <cover.1406594913.git.minchen@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:59554 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328AbaG2Ce5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jul 2014 22:34:57 -0400
In-Reply-To: <cover.1406594913.git.minchen@ubuntukylin.com>
In-Reply-To: <cover.1406594913.git.minchen@ubuntukylin.com>
References: <cover.1406594913.git.minchen@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: josh.durgin@inktank.com
Cc: sage@inktank.com, ceph-devel@vger.kernel.org

  Rbd copy-on-read is implmented in AioRequest. If object extent doesn't exist in clone, then read
the entire range of object from parent. Bufferlist m_entire_data is added to AioRequest to save object
instead of m_read_data which just keeps data read

Signed-off-by: Min Chen <minchen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
---
 src/librbd/AioRequest.cc |   51 +++++++++++++++++++++++++++++++++++++++++++---
 src/librbd/AioRequest.h  |    3 +++
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/src/librbd/AioRequest.cc b/src/librbd/AioRequest.cc
index 4b4b08c..767fa75 100644
--- a/src/librbd/AioRequest.cc
+++ b/src/librbd/AioRequest.cc
@@ -22,7 +22,7 @@ namespace librbd {
     m_ictx(NULL), m_ioctx(NULL),
     m_object_no(0), m_object_off(0), m_object_len(0),
     m_snap_id(CEPH_NOSNAP), m_completion(NULL), m_parent_completion(NULL),
-    m_hide_enoent(false) {}
+    m_hide_enoent(false), m_parent_completion_cor(NULL){}
   AioRequest::AioRequest(ImageCtx *ictx, const std::string &oid,
 			 uint64_t objectno, uint64_t off, uint64_t len,
 			 librados::snap_t snap_id,
@@ -31,13 +31,17 @@ namespace librbd {
     m_ictx(ictx), m_ioctx(&ictx->data_ctx), m_oid(oid), m_object_no(objectno),
     m_object_off(off), m_object_len(len), m_snap_id(snap_id),
     m_completion(completion), m_parent_completion(NULL),
-    m_hide_enoent(hide_enoent) {}
+    m_hide_enoent(hide_enoent), m_parent_completion_cor(NULL) {}
 
   AioRequest::~AioRequest() {
     if (m_parent_completion) {
       m_parent_completion->release();
       m_parent_completion = NULL;
     }
+    if (m_parent_completion_cor) {
+      m_parent_completion_cor->release();
+      m_parent_completion_cor = NULL;
+    }
   }
 
   void AioRequest::read_from_parent(vector<pair<uint64_t,uint64_t> >& image_extents)
@@ -52,6 +56,19 @@ namespace librbd {
 	     m_parent_completion);
   }
 
+  //copy-on-read : read the entire object from parent, using bufferlist m_entire_object
+  void AioRequest::read_from_parent_cor(vector<pair<uint64_t,uint64_t> >& image_extents)
+  {
+    assert(!m_parent_completion_cor);
+    m_parent_completion_cor = aio_create_completion_internal(this, rbd_req_cb);
+    ldout(m_ictx->cct, 20) << "read_from_parent_cor this = " << this
+                          << " parent completion cor " << m_parent_completion_cor
+                          << " extents " << image_extents
+                          << dendl;
+    aio_read(m_ictx->parent, image_extents, NULL, &m_entire_object,
+            m_parent_completion_cor);
+  }
+
   /** read **/
 
   bool AioRead::should_complete(int r)
@@ -81,11 +98,39 @@ namespace librbd {
       uint64_t object_overlap = m_ictx->prune_parent_extents(image_extents, image_overlap);
       if (object_overlap) {
 	m_tried_parent = true;
-	read_from_parent(image_extents);
+       if (cor) {//copy-on-read option  
+           vector<pair<uint64_t,uint64_t> > extend_image_extents;
+           //extend range to entire object
+           Striper::extent_to_file(m_ictx->cct, &m_ictx->layout,
+                           m_object_no, 0, m_ictx->layout.fl_object_size,
+                           extend_image_extents);
+           //read entire object from parent , and put it in m_entire_object
+           read_from_parent_cor(extend_image_extents);
+       } else {
+           read_from_parent(image_extents);
+       }
 	return false;
       }
     }
 
+    if (cor) {//copy-on-read option
+      //if read entire object from parent success
+      if (m_tried_parent && r > 0) {
+        vector<pair<uint64_t,uint64_t> > image_extents;
+        Striper::extent_to_file(m_ictx->cct, &m_ictx->layout,
+                            m_object_no, m_object_off, m_object_len,
+                            image_extents);
+        uint64_t image_overlap = 0;
+        int r = m_ictx->get_parent_overlap(m_snap_id, &image_overlap);
+        if (r < 0) {
+          assert(0 == "FIXME");
+        }
+	m_ictx->prune_parent_extents(image_extents, image_overlap);
+	// copy the read range to m_read_data
+	m_read_data.substr_of(m_entire_object, m_object_off, m_object_len);
+      }
+    }
+
     return true;
   }
 
diff --git a/src/librbd/AioRequest.h b/src/librbd/AioRequest.h
index d6103f9..42301a5 100644
--- a/src/librbd/AioRequest.h
+++ b/src/librbd/AioRequest.h
@@ -47,6 +47,7 @@ namespace librbd {
 
   protected:
     void read_from_parent(vector<pair<uint64_t,uint64_t> >& image_extents);
+    void read_from_parent_cor(vector<pair<uint64_t,uint64_t> >& image_extents);
 
     ImageCtx *m_ictx;
     librados::IoCtx *m_ioctx;
@@ -57,6 +58,8 @@ namespace librbd {
     AioCompletion *m_parent_completion;
     ceph::bufferlist m_read_data;
     bool m_hide_enoent;
+    ceph::bufferlist m_entire_object;//copy-on-read : store the entire object
+    AioCompletion *m_parent_completion_cor;//copy-on-read : AioCompletion for read from parent
   };
 
   class AioRead : public AioRequest {
-- 
1.7.10.4

