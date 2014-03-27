From: Min Chen <minchen@ubuntukylin.com>
Subject: [PATCH 1/2] rbd: copy-on-read for clones, read entire object from parent
Date: Thu, 27 Mar 2014 08:38:17 +0800
Message-ID: <1395880698-20479-2-git-send-email-minchen@ubuntukylin.com>
References: <1395880698-20479-1-git-send-email-minchen@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:55933 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256AbaC0Aou (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Mar 2014 20:44:50 -0400
In-Reply-To: <1395880698-20479-1-git-send-email-minchen@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: josh.durgin@inktank.com, Yunchuan Wen <yunchuanwen@ubuntukylin.com>, Li Wang <liwang@ubuntukylin.com>

rbd copy-on-read is implmented in AioRequest. If object extent doesn't exist in clone, then read
the entire range of object from parent. Bufferlist m_entire_data is added to AioRequest to save object
instead of m_read_data which just keeps data read, and copy read range to m_read_data from m_entire_data

Signed-off-by: Min Chen <minchen@ubuntukylin.com>
Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 src/librbd/AioRequest.cc |   36 ++++++++++++++++++++++++++++++++++--
 src/librbd/AioRequest.h  |    2 ++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/src/librbd/AioRequest.cc b/src/librbd/AioRequest.cc
index e8fb657..268999c 100644
--- a/src/librbd/AioRequest.cc
+++ b/src/librbd/AioRequest.cc
@@ -52,6 +52,19 @@ namespace librbd {
 	     m_parent_completion);
   }
 
+  //copy-on-read : read the entire object from parent, using bufferlist m_entire_object
+  void AioRequest::read_from_parent_COR(vector<pair<uint64_t,uint64_t> >& image_extents)
+  {
+    assert(!m_parent_completion);
+    m_parent_completion = aio_create_completion_internal(this, rbd_req_cb);
+    ldout(m_ictx->cct, 20) << "read_from_parent_COR this = " << this
+			   << " parent completion " << m_parent_completion
+			   << " extents " << image_extents
+			   << dendl;
+    aio_read(m_ictx->parent, image_extents, NULL, &m_entire_object,
+	     m_parent_completion);
+  }
+
   /** read **/
 
   bool AioRead::should_complete(int r)
@@ -78,11 +91,30 @@ namespace librbd {
       uint64_t object_overlap = m_ictx->prune_parent_extents(image_extents, image_overlap);
       if (object_overlap) {
 	m_tried_parent = true;
-	read_from_parent(image_extents);
+	if(COR)//copy-on-read option
+	{
+	    vector<pair<uint64_t,uint64_t> > extend_image_extents;
+	    //extend range to entire object
+	    Striper::extent_to_file(m_ictx->cct, &m_ictx->layout,
+			    m_object_no, 0, m_ictx->layout.fl_object_size,
+			    extend_image_extents);
+	    //read entire object from parent , and put it in m_entire_object
+	    read_from_parent_COR(extend_image_extents);
+	}
+	else
+	    read_from_parent(image_extents);
 	return false;
       }
     }
-
+    if(COR) //copy-on-read option
+    {
+      //if read entire object from parent success
+      if(m_tried_parent && r>0)
+	{
+	  // copy the read range to m_read_data
+	  m_read_data.substr_of(m_entire_object, m_object_off, m_object_len);
+	}
+    }
     return true;
   }
 
diff --git a/src/librbd/AioRequest.h b/src/librbd/AioRequest.h
index cf50ee2..4081c4c 100644
--- a/src/librbd/AioRequest.h
+++ b/src/librbd/AioRequest.h
@@ -47,6 +47,7 @@ namespace librbd {
 
   protected:
     void read_from_parent(vector<pair<uint64_t,uint64_t> >& image_extents);
+    void read_from_parent_COR(vector<pair<uint64_t,uint64_t> >& image_extents);
 
     ImageCtx *m_ictx;
     librados::IoCtx *m_ioctx;
@@ -57,6 +58,7 @@ namespace librbd {
     AioCompletion *m_parent_completion;
     ceph::bufferlist m_read_data;
     bool m_hide_enoent;
+    ceph::bufferlist m_entire_object;
   };
 
   class AioRead : public AioRequest {
-- 
1.7.10.4

