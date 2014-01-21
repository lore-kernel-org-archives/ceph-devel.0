From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 11/11] libceph: support CEPH_FEATURE_EXPORT_PEER
Date: Tue, 21 Jan 2014 12:15:45 +0800
Message-ID: <1390277745-20142-11-git-send-email-zheng.z.yan@intel.com>
References: <1390277745-20142-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:35339 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753464AbaAUEQC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 20 Jan 2014 23:16:02 -0500
In-Reply-To: <1390277745-20142-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 include/linux/ceph/ceph_features.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
index 5f42e44..d21b34d 100644
--- a/include/linux/ceph/ceph_features.h
+++ b/include/linux/ceph/ceph_features.h
@@ -80,7 +80,8 @@ static inline u64 ceph_sanitize_features(u64 features)
 	 CEPH_FEATURE_CRUSH_TUNABLES2 |		\
 	 CEPH_FEATURE_REPLY_CREATE_INODE |	\
 	 CEPH_FEATURE_OSDHASHPSPOOL |		\
-	 CEPH_FEATURE_CRUSH_V2)
+	 CEPH_FEATURE_CRUSH_V2 |		\
+	 CEPH_FEATURE_EXPORT_PEER)
 
 #define CEPH_FEATURES_REQUIRED_DEFAULT   \
 	(CEPH_FEATURE_NOSRCADDR |	 \
-- 
1.8.4.2

