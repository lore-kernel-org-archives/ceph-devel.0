From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 5/5] crush: support chooseleaf_vary_r tunable (tunables3) by default
Date: Wed, 19 Mar 2014 18:09:09 +0200
Message-ID: <1395245349-4513-6-git-send-email-ilya.dryomov@inktank.com>
References: <1395245349-4513-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:49948 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965696AbaCSQJ1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Mar 2014 12:09:27 -0400
Received: by mail-ee0-f48.google.com with SMTP id b57so6111634eek.35
        for <ceph-devel@vger.kernel.org>; Wed, 19 Mar 2014 09:09:26 -0700 (PDT)
Received: from localhost ([109.110.66.126])
        by mx.google.com with ESMTPSA id o7sm43260440eew.25.2014.03.19.09.09.24
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Mar 2014 09:09:25 -0700 (PDT)
In-Reply-To: <1395245349-4513-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Add TUNABLES3 feature (chooseleaf_vary_r tunable) to a set of features
supported by default.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/ceph_features.h |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
index 138448f766b4..77c097fe9ea9 100644
--- a/include/linux/ceph/ceph_features.h
+++ b/include/linux/ceph/ceph_features.h
@@ -43,6 +43,13 @@
 #define CEPH_FEATURE_CRUSH_V2      (1ULL<<36)  /* new indep; SET_* steps */
 #define CEPH_FEATURE_EXPORT_PEER   (1ULL<<37)
 #define CEPH_FEATURE_OSD_ERASURE_CODES (1ULL<<38)
+#define CEPH_FEATURE_OSD_TMAP2OMAP (1ULL<<38)   /* overlap with EC */
+/* The process supports new-style OSDMap encoding. Monitors also use
+   this bit to determine if peers support NAK messages. */
+#define CEPH_FEATURE_OSDMAP_ENC    (1ULL<<39)
+#define CEPH_FEATURE_MDS_INLINE_DATA     (1ULL<<40)
+#define CEPH_FEATURE_CRUSH_TUNABLES3     (1ULL<<41)
+#define CEPH_FEATURE_OSD_PRIMARY_AFFINITY (1ULL<<41)  /* overlap w/ tunables3 */
 
 /*
  * The introduction of CEPH_FEATURE_OSD_SNAPMAPPER caused the feature
@@ -82,7 +89,8 @@ static inline u64 ceph_sanitize_features(u64 features)
 	 CEPH_FEATURE_OSDHASHPSPOOL |		\
 	 CEPH_FEATURE_OSD_CACHEPOOL |		\
 	 CEPH_FEATURE_CRUSH_V2 |		\
-	 CEPH_FEATURE_EXPORT_PEER)
+	 CEPH_FEATURE_EXPORT_PEER |		\
+	 CEPH_FEATURE_CRUSH_TUNABLES3)
 
 #define CEPH_FEATURES_REQUIRED_DEFAULT   \
 	(CEPH_FEATURE_NOSRCADDR |	 \
-- 
1.7.10.4

