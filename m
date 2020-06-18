From: xiubli@redhat.com
Subject: [PATCH v2 3/5] ceph: check the METRIC_COLLECT feature before sending metrics
Date: Thu, 18 Jun 2020 07:59:57 -0400
Message-ID: <1592481599-7851-4-git-send-email-xiubli@redhat.com>
References: <1592481599-7851-1-git-send-email-xiubli@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33024 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725944AbgFRMBE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:01:04 -0400
In-Reply-To: <1592481599-7851-1-git-send-email-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com
Cc: zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

Skip the MDS sessions if they don't support the metric collection,
or the MDSs will close the socket connections directly when it get
an unknown type message.

URL: https://tracker.ceph.com/issues/43215
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/mds_client.h | 4 +++-
 fs/ceph/metric.c     | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index bcb3892..3c65ac1 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -28,8 +28,9 @@ enum ceph_feature_type {
 	CEPHFS_FEATURE_LAZY_CAP_WANTED,
 	CEPHFS_FEATURE_MULTI_RECONNECT,
 	CEPHFS_FEATURE_DELEG_INO,
+	CEPHFS_FEATURE_METRIC_COLLECT,
 
-	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_DELEG_INO,
+	CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_METRIC_COLLECT,
 };
 
 /*
@@ -43,6 +44,7 @@ enum ceph_feature_type {
 	CEPHFS_FEATURE_LAZY_CAP_WANTED,		\
 	CEPHFS_FEATURE_MULTI_RECONNECT,		\
 	CEPHFS_FEATURE_DELEG_INO,		\
+	CEPHFS_FEATURE_METRIC_COLLECT,		\
 						\
 	CEPHFS_FEATURE_MAX,			\
 }
diff --git a/fs/ceph/metric.c b/fs/ceph/metric.c
index 27cb541..4267b46 100644
--- a/fs/ceph/metric.c
+++ b/fs/ceph/metric.c
@@ -127,6 +127,14 @@ static void metric_delayed_work(struct work_struct *work)
 			continue;
 		}
 
+		/*
+		 * Skip it if MDS doesn't support the metric collection,
+		 * or the MDS will close the session's socket connection
+		 * directly when it get this message.
+		 */
+		if (!test_bit(CEPHFS_FEATURE_METRIC_COLLECT, &s->s_features))
+			continue;
+
 		/* Only send the metric once in any available session */
 		ret = ceph_mdsc_send_metrics(mdsc, s, nr_caps);
 		ceph_put_mds_session(s);
-- 
1.8.3.1
