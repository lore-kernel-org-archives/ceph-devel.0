From: Min Chen <minchen@ubuntukylin.com>
Subject: [PATCH 1/3] librbd: v3 copy-on-read for clones, add an option for copy-on-read
Date: Tue, 29 Jul 2014 10:29:09 +0800
Message-ID: <62be66cf7fd23723e0fcc1cc45538ce7e95212e0.1406594913.git.minchen@ubuntukylin.com>
References: <cover.1406594913.git.minchen@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:59498 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328AbaG2Cez (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jul 2014 22:34:55 -0400
In-Reply-To: <cover.1406594913.git.minchen@ubuntukylin.com>
In-Reply-To: <cover.1406594913.git.minchen@ubuntukylin.com>
References: <cover.1406594913.git.minchen@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: josh.durgin@inktank.com
Cc: sage@inktank.com, ceph-devel@vger.kernel.org

  Add an option rbd_clone_copy_on_read to enable copy-on-read

Signed-off-by: Min Chen <minchen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
---
 src/common/config_opts.h |    1 +
 src/librbd/AioRequest.cc |    4 ++++
 2 files changed, 5 insertions(+)

diff --git a/src/common/config_opts.h b/src/common/config_opts.h
index a065a77..82430be 100644
--- a/src/common/config_opts.h
+++ b/src/common/config_opts.h
@@ -711,6 +711,7 @@ OPTION(rbd_balance_snap_reads, OPT_BOOL, false)
 OPTION(rbd_localize_snap_reads, OPT_BOOL, false)
 OPTION(rbd_balance_parent_reads, OPT_BOOL, false)
 OPTION(rbd_localize_parent_reads, OPT_BOOL, true)
+OPTION(rbd_clone_copy_on_read, OPT_BOOL, false)//copy-on-read option for rbd clones
 
 /*
  * The following options change the behavior for librbd's image creation methods that
diff --git a/src/librbd/AioRequest.cc b/src/librbd/AioRequest.cc
index 5cf9a11..4b4b08c 100644
--- a/src/librbd/AioRequest.cc
+++ b/src/librbd/AioRequest.cc
@@ -59,6 +59,10 @@ namespace librbd {
     ldout(m_ictx->cct, 20) << "should_complete " << this << " " << m_oid << " " << m_object_off << "~" << m_object_len
 			   << " r = " << r << dendl;
 
+    //get copy-on-read option and check image if read_only
+    bool cor = (m_ictx->cct->_conf->rbd_clone_copy_on_read) && (!m_ictx->read_only);
+    ldout(m_ictx->cct, 20) << "should_complete cor = " << cor << " read_only = " << m_ictx->read_only << dendl;
+
     if (!m_tried_parent && r == -ENOENT) {
       RWLock::RLocker l(m_ictx->snap_lock);
       RWLock::RLocker l2(m_ictx->parent_lock);
-- 
1.7.10.4

