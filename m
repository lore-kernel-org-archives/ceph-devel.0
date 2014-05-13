From: Min Chen <minchen@ubuntukylin.com>
Subject: [PATCH 1/3] *v2* librbd: copy-on-read for clones, add an option for copy-on-read
Date: Tue, 13 May 2014 17:12:13 +0800
Message-ID: <d96faf1bd10b6f714aba6851fd51f6707d7e85bd.1399970127.git.minchen@ubuntukylin.com>
References: <cover.1399970127.git.minchen@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:60252 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758984AbaEMJUb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 May 2014 05:20:31 -0400
In-Reply-To: <cover.1399970127.git.minchen@ubuntukylin.com>
In-Reply-To: <cover.1399970127.git.minchen@ubuntukylin.com>
References: <cover.1399970127.git.minchen@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: josh.durgin@inktank.com
Cc: ceph-devel@vger.kernel.org

Add an option rbd_clone_cor to enable copy-on-read

Signed-off-by: Min Chen <minchen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
Signed-off-by: Yunchuan Wen Chen <yunchuanwen@ubuntukylin.com>
---
 src/common/config_opts.h |    1 +
 src/librbd/AioRequest.cc |    4 ++++
 2 files changed, 5 insertions(+)

diff --git a/src/common/config_opts.h b/src/common/config_opts.h
index a065a77..15438ce 100644
--- a/src/common/config_opts.h
+++ b/src/common/config_opts.h
@@ -711,6 +711,7 @@ OPTION(rbd_balance_snap_reads, OPT_BOOL, false)
 OPTION(rbd_localize_snap_reads, OPT_BOOL, false)
 OPTION(rbd_balance_parent_reads, OPT_BOOL, false)
 OPTION(rbd_localize_parent_reads, OPT_BOOL, true)
+OPTION(rbd_clone_cor, OPT_BOOL, false)//copy-on-read option for rbd clones
 
 /*
  * The following options change the behavior for librbd's image creation methods that
diff --git a/src/librbd/AioRequest.cc b/src/librbd/AioRequest.cc
index 5cf9a11..4cc6b4e 100644
--- a/src/librbd/AioRequest.cc
+++ b/src/librbd/AioRequest.cc
@@ -59,6 +59,10 @@ namespace librbd {
     ldout(m_ictx->cct, 20) << "should_complete " << this << " " << m_oid << " " << m_object_off << "~" << m_object_len
 			   << " r = " << r << dendl;
 
+    //get copy-on-read option and check image if read_only
+    bool COR = (m_ictx->cct->_conf->rbd_clone_cor) && (!m_ictx->read_only);
+    ldout(m_ictx->cct, 20) << "should_complete COR = " << COR << " read_only = " << m_ictx->read_only << dendl;
+
     if (!m_tried_parent && r == -ENOENT) {
       RWLock::RLocker l(m_ictx->snap_lock);
       RWLock::RLocker l2(m_ictx->parent_lock);
-- 
1.7.10.4

