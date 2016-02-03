From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5/5] libceph: advertise support for TUNABLES5
Date: Wed,  3 Feb 2016 15:23:21 +0100
Message-ID: <1454509401-19734-6-git-send-email-idryomov@gmail.com>
References: <1454509401-19734-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38419 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753809AbcBCOXd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Feb 2016 09:23:33 -0500
Received: by mail-wm0-f52.google.com with SMTP id p63so72743405wmp.1
        for <ceph-devel@vger.kernel.org>; Wed, 03 Feb 2016 06:23:33 -0800 (PST)
In-Reply-To: <1454509401-19734-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sweil@redhat.com>

Add TUNABLES5 feature (chooseleaf_stable tunable) to a set of features
supported by default.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 include/linux/ceph/ceph_features.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
index fa3f82aae3be..6b4b059c158f 100644
--- a/include/linux/ceph/ceph_features.h
+++ b/include/linux/ceph/ceph_features.h
@@ -63,6 +63,16 @@
 #define CEPH_FEATURE_OSD_MIN_SIZE_RECOVERY (1ULL<<49)
 // duplicated since it was introduced at the same time as MIN_SIZE_RECOVERY
 #define CEPH_FEATURE_OSD_PROXY_FEATURES (1ULL<<49)  /* overlap w/ above */
+#define CEPH_FEATURE_MON_METADATA (1ULL<<50)
+#define CEPH_FEATURE_OSD_BITWISE_HOBJ_SORT (1ULL<<51) /* can sort objs bitwise */
+#define CEPH_FEATURE_OSD_PROXY_WRITE_FEATURES (1ULL<<52)
+#define CEPH_FEATURE_ERASURE_CODE_PLUGINS_V3 (1ULL<<53)
+#define CEPH_FEATURE_OSD_HITSET_GMT (1ULL<<54)
+#define CEPH_FEATURE_HAMMER_0_94_4 (1ULL<<55)
+#define CEPH_FEATURE_NEW_OSDOP_ENCODING   (1ULL<<56) /* New, v7 encoding */
+#define CEPH_FEATURE_MON_STATEFUL_SUB (1ULL<<57) /* stateful mon subscription */
+#define CEPH_FEATURE_MON_ROUTE_OSDMAP (1ULL<<57) /* peon sends osdmaps */
+#define CEPH_FEATURE_CRUSH_TUNABLES5	(1ULL<<58) /* chooseleaf stable mode */
 
 /*
  * The introduction of CEPH_FEATURE_OSD_SNAPMAPPER caused the feature
@@ -109,7 +119,8 @@ static inline u64 ceph_sanitize_features(u64 features)
 	 CEPH_FEATURE_CRUSH_TUNABLES3 |		\
 	 CEPH_FEATURE_OSD_PRIMARY_AFFINITY |	\
 	 CEPH_FEATURE_MSGR_KEEPALIVE2 |		\
-	 CEPH_FEATURE_CRUSH_V4)
+	 CEPH_FEATURE_CRUSH_V4 |		\
+	 CEPH_FEATURE_CRUSH_TUNABLES5)
 
 #define CEPH_FEATURES_REQUIRED_DEFAULT   \
 	(CEPH_FEATURE_NOSRCADDR |	 \
-- 
2.4.3

