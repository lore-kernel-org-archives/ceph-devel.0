From: Min Chen <minchen@ubuntukylin.com>
Subject: [PATCH 0/2] rbd: copy-on-read for clones, add an option for copy-on-read
Date: Thu, 27 Mar 2014 08:38:16 +0800
Message-ID: <1395880698-20479-1-git-send-email-minchen@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:55817 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291AbaC0Aoq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Mar 2014 20:44:46 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: josh.durgin@inktank.com, Yunchuan Wen <yunchuanwen@ubuntukylin.com>, Li Wang <liwang@ubuntukylin.com>

Add an option rbd_clone_cor to enable copy-on-read

Signed-off-by: Min Chen <minchen@ubuntukylin.com>
Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 src/common/config_opts.h |    1 +
 src/librbd/AioRequest.cc |    1 +
 2 files changed, 2 insertions(+)

diff --git a/src/common/config_opts.h b/src/common/config_opts.h
index 0d03809..99167b0 100644
--- a/src/common/config_opts.h
+++ b/src/common/config_opts.h
@@ -620,6 +620,7 @@ OPTION(rbd_cache_block_writes_upfront, OPT_BOOL, false) // whether to block writ
 OPTION(rbd_concurrent_management_ops, OPT_INT, 10) // how many operations can be in flight for a management operation like deleting or resizing an image
 OPTION(rbd_balance_snap_reads, OPT_BOOL, false)
 OPTION(rbd_localize_snap_reads, OPT_BOOL, false)
+OPTION(rbd_clone_cor, OPT_BOOL, false)//copy-on-read option for rbd clones
 
 /*
  * The following options change the behavior for librbd's image creation methods that
diff --git a/src/librbd/AioRequest.cc b/src/librbd/AioRequest.cc
index 11e111f..e8fb657 100644
--- a/src/librbd/AioRequest.cc
+++ b/src/librbd/AioRequest.cc
@@ -59,6 +59,7 @@ namespace librbd {
     ldout(m_ictx->cct, 20) << "should_complete " << this << " " << m_oid << " " << m_object_off << "~" << m_object_len
 			   << " r = " << r << dendl;
 
+    bool COR = m_ictx->cct->_conf->rbd_clone_cor;
     if (!m_tried_parent && r == -ENOENT) {
       RWLock::RLocker l(m_ictx->snap_lock);
       RWLock::RLocker l2(m_ictx->parent_lock);
-- 
1.7.10.4

