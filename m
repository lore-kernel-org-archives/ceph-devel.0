From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 12/12] libceph: add CEPH_FEATURE_EXPORT_PEER
Date: Fri,  6 Dec 2013 16:46:43 +0800
Message-ID: <1386319603-2610-13-git-send-email-zheng.z.yan@intel.com>
References: <1386319603-2610-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23374 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757172Ab3LFIq5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 Dec 2013 03:46:57 -0500
In-Reply-To: <1386319603-2610-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 include/linux/ceph/ceph_features.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
index bd11e55..f75ee0e 100644
--- a/include/linux/ceph/ceph_features.h
+++ b/include/linux/ceph/ceph_features.h
@@ -40,6 +40,7 @@
 #define CEPH_FEATURE_MON_SCRUB      (1ULL<<33)
 #define CEPH_FEATURE_OSD_PACKED_RECOVERY (1ULL<<34)
 #define CEPH_FEATURE_OSD_CACHEPOOL (1ULL<<35)
+#define CEPH_FEATURE_EXPORT_PEER  (1ULL<<36)
 
 /*
  * Features supported.
@@ -53,7 +54,8 @@
 	 CEPH_FEATURE_CRUSH_TUNABLES |		\
 	 CEPH_FEATURE_CRUSH_TUNABLES2 |		\
 	 CEPH_FEATURE_REPLY_CREATE_INODE |	\
-	 CEPH_FEATURE_OSDHASHPSPOOL)
+	 CEPH_FEATURE_OSDHASHPSPOOL |		\
+	 CEPH_FEATURE_EXPORT_PEER)
 
 #define CEPH_FEATURES_REQUIRED_DEFAULT   \
 	(CEPH_FEATURE_NOSRCADDR |	 \
-- 
1.8.1.4

