From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 01/18] ceph: Add inline data feature
Date: Wed, 27 Nov 2013 21:40:40 +0800
Message-ID: <b777abbe69564d3a711964ba25493111175bd5fd.1385558324.git.liwang@ubuntukylin.com>
References: <cover.1385558324.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:48400 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654Ab3K0NlV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Nov 2013 08:41:21 -0500
In-Reply-To: <cover.1385558324.git.liwang@ubuntukylin.com>
In-Reply-To: <cover.1385558324.git.liwang@ubuntukylin.com>
References: <cover.1385558324.git.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Li Wang <liwang@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 src/ceph_mds.cc             |    1 +
 src/include/ceph_features.h |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/src/ceph_mds.cc b/src/ceph_mds.cc
index 88b807b..dac676f 100644
--- a/src/ceph_mds.cc
+++ b/src/ceph_mds.cc
@@ -243,6 +243,7 @@ int main(int argc, const char **argv)
     CEPH_FEATURE_UID |
     CEPH_FEATURE_NOSRCADDR |
     CEPH_FEATURE_DIRLAYOUTHASH |
+    CEPH_FEATURE_MDS_INLINE_DATA |
     CEPH_FEATURE_PGID64 |
     CEPH_FEATURE_MSG_AUTH;
   uint64_t required =
diff --git a/src/include/ceph_features.h b/src/include/ceph_features.h
index c0f01cc..70ee921 100644
--- a/src/include/ceph_features.h
+++ b/src/include/ceph_features.h
@@ -40,6 +40,7 @@
 #define CEPH_FEATURE_MON_SCRUB      (1ULL<<33)
 #define CEPH_FEATURE_OSD_PACKED_RECOVERY (1ULL<<34)
 #define CEPH_FEATURE_OSD_CACHEPOOL (1ULL<<35)
+#define CEPH_FEATURE_MDS_INLINE_DATA     (1ULL<<36)
 
 /*
  * The introduction of CEPH_FEATURE_OSD_SNAPMAPPER caused the feature
@@ -103,6 +104,7 @@ static inline unsigned long long ceph_sanitize_features(unsigned long long f) {
 	 CEPH_FEATURE_MON_SCRUB	|	    \
 	 CEPH_FEATURE_OSD_PACKED_RECOVERY | \
 	 CEPH_FEATURE_OSD_CACHEPOOL | \
+	 CEPH_FEATURE_MDS_INLINE_DATA | \
 	 0ULL)
 
 #define CEPH_FEATURES_SUPPORTED_DEFAULT  CEPH_FEATURES_ALL
-- 
1.7.9.5

