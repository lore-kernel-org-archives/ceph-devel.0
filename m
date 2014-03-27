From: Min Chen <minchen@ubuntukylin.com>
Subject: [PATCH 2/2] rbd: copy-on-read for clones, write entire object into child by cls_rbd copyup
Date: Thu, 27 Mar 2014 08:38:18 +0800
Message-ID: <1395880698-20479-3-git-send-email-minchen@ubuntukylin.com>
References: <1395880698-20479-1-git-send-email-minchen@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:55916 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291AbaC0Aot (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Mar 2014 20:44:49 -0400
In-Reply-To: <1395880698-20479-1-git-send-email-minchen@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: josh.durgin@inktank.com, Yunchuan Wen <yunchuanwen@ubuntukylin.com>, Li Wang <liwang@ubuntukylin.com>

The object has been already saved in m_entire_object bufferlist
Send "copyup" to osd with m_entire_object, then cls_rbd copyup will write the object to child.

Signed-off-by: Min Chen <minchen@ubuntukylin.com>
Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 src/librbd/AioRequest.cc |   36 ++++++++++++++++++++++++++++++++++++
 src/librbd/AioRequest.h  |    1 +
 2 files changed, 37 insertions(+)

diff --git a/src/librbd/AioRequest.cc b/src/librbd/AioRequest.cc
index 268999c..525d376 100644
--- a/src/librbd/AioRequest.cc
+++ b/src/librbd/AioRequest.cc
@@ -66,6 +66,41 @@ namespace librbd {
   }
 
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
+    copyup_cor.exec("rbd","copyup",m_entire_object);
+
+    std::vector<librados::snap_t> m_snaps;
+    for (std::vector<snapid_t>::const_iterator it = snapc.snaps.begin();
+        	it != snapc.snaps.end(); ++it) {
+      m_snaps.push_back(it->val);
+    }
+	
+    librados::AioCompletion *rados_completion =
+       	librados::Rados::aio_create_completion(NULL, NULL, NULL);
+    m_ictx->md_ctx.aio_operate(m_oid, rados_completion, &copyup_cor,
+			       snapc.seq.val, m_snaps);
+    rados_completion->wait_for_complete();
+    ret = rados_completion->get_return_value();
+    ldout(m_ictx->cct, 20) << "ret = " << ret <<dendl;
+    rados_completion->release();
+	
+    if (ret < 0) {
+      ldout(m_ictx->cct, 20) << "couldn't write object! error " << ret << dendl;
+      ret = -EIO;
+    } 
+    return ret;
+  }
+
 
   bool AioRead::should_complete(int r)
   {
@@ -113,6 +148,7 @@ namespace librbd {
 	{
 	  // copy the read range to m_read_data
 	  m_read_data.substr_of(m_entire_object, m_object_off, m_object_len);
+	  write_COR();
 	}
     }
     return true;
diff --git a/src/librbd/AioRequest.h b/src/librbd/AioRequest.h
index 4081c4c..ed307d4 100644
--- a/src/librbd/AioRequest.h
+++ b/src/librbd/AioRequest.h
@@ -74,6 +74,7 @@ namespace librbd {
 	m_tried_parent(false), m_sparse(sparse) {
     }
     virtual ~AioRead() {}
+    ssize_t write_COR();
     virtual bool should_complete(int r);
     virtual int send();
 
-- 
1.7.10.4

