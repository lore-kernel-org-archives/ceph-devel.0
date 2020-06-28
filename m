From: xiubli@redhat.com
Subject: [PATCH v4 5/5] ceph: send client provided metric flags in client metadata
Date: Sun, 28 Jun 2020 04:42:14 -0400
Message-ID: <1593333734-27480-6-git-send-email-xiubli@redhat.com>
References: <1593333734-27480-1-git-send-email-xiubli@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46366 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726038AbgF1Imq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 28 Jun 2020 04:42:46 -0400
In-Reply-To: <1593333734-27480-1-git-send-email-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com
Cc: zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

Will send the metric flags to MDS, currently it supports the cap,
read latency, write latency and metadata latency.

URL: https://tracker.ceph.com/issues/43435
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/mds_client.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 fs/ceph/metric.h     | 13 ++++++++++++
 2 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index eda788b..a3f75d8 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1195,6 +1195,48 @@ static int encode_supported_features(void **p, void *end)
 	return 0;
 }
 
+static const unsigned char metric_bits[] = CEPHFS_METRIC_SPEC_CLIENT_SUPPORTED;
+#define METRIC_BYTES(cnt) (DIV_ROUND_UP((size_t)metric_bits[cnt - 1] + 1, 64) * 8)
+static int encode_metric_spec(void **p, void *end)
+{
+	static const size_t count = ARRAY_SIZE(metric_bits);
+
+	/* header */
+	if (WARN_ON_ONCE(*p + 2 > end))
+		return -ERANGE;
+
+	ceph_encode_8(p, 1); /* version */
+	ceph_encode_8(p, 1); /* compat */
+
+	if (count > 0) {
+		size_t i;
+		size_t size = METRIC_BYTES(count);
+
+		if (WARN_ON_ONCE(*p + 4 + 4 + size > end))
+			return -ERANGE;
+
+		/* metric spec info length */
+		ceph_encode_32(p, 4 + size);
+
+		/* metric spec */
+		ceph_encode_32(p, size);
+		memset(*p, 0, size);
+		for (i = 0; i < count; i++)
+			((unsigned char *)(*p))[i / 8] |= BIT(metric_bits[i] % 8);
+		*p += size;
+	} else {
+		if (WARN_ON_ONCE(*p + 4 + 4 > end))
+			return -ERANGE;
+
+		/* metric spec info length */
+		ceph_encode_32(p, 4);
+		/* metric spec */
+		ceph_encode_32(p, 0);
+	}
+
+	return 0;
+}
+
 /*
  * session message, specialization for CEPH_SESSION_REQUEST_OPEN
  * to include additional client metadata fields.
@@ -1235,6 +1277,13 @@ static struct ceph_msg *create_session_open_msg(struct ceph_mds_client *mdsc, u6
 		size = FEATURE_BYTES(count);
 	extra_bytes += 4 + size;
 
+	/* metric spec */
+	size = 0;
+	count = ARRAY_SIZE(metric_bits);
+	if (count > 0)
+		size = METRIC_BYTES(count);
+	extra_bytes += 2 + 4 + 4 + size;
+
 	/* Allocate the message */
 	msg = ceph_msg_new(CEPH_MSG_CLIENT_SESSION, sizeof(*h) + extra_bytes,
 			   GFP_NOFS, false);
@@ -1253,9 +1302,9 @@ static struct ceph_msg *create_session_open_msg(struct ceph_mds_client *mdsc, u6
 	 * Serialize client metadata into waiting buffer space, using
 	 * the format that userspace expects for map<string, string>
 	 *
-	 * ClientSession messages with metadata are v3
+	 * ClientSession messages with metadata are v4
 	 */
-	msg->hdr.version = cpu_to_le16(3);
+	msg->hdr.version = cpu_to_le16(4);
 	msg->hdr.compat_version = cpu_to_le16(1);
 
 	/* The write pointer, following the session_head structure */
@@ -1284,6 +1333,13 @@ static struct ceph_msg *create_session_open_msg(struct ceph_mds_client *mdsc, u6
 		return ERR_PTR(ret);
 	}
 
+	ret = encode_metric_spec(&p, end);
+	if (ret) {
+		pr_err("encode_metric_spec failed!\n");
+		ceph_msg_put(msg);
+		return ERR_PTR(ret);
+	}
+
 	msg->front.iov_len = p - msg->front.iov_base;
 	msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
 
diff --git a/fs/ceph/metric.h b/fs/ceph/metric.h
index 1a7e3fb..6de86d3 100644
--- a/fs/ceph/metric.h
+++ b/fs/ceph/metric.h
@@ -21,6 +21,19 @@ enum ceph_metric_type {
 	CLIENT_METRIC_TYPE_MAX = CLIENT_METRIC_TYPE_DENTRY_LEASE,
 };
 
+/*
+ * This will always have the highest metric bit value
+ * as the last element of the array.
+ */
+#define CEPHFS_METRIC_SPEC_CLIENT_SUPPORTED {	\
+	CLIENT_METRIC_TYPE_CAP_INFO,		\
+	CLIENT_METRIC_TYPE_READ_LATENCY,	\
+	CLIENT_METRIC_TYPE_WRITE_LATENCY,	\
+	CLIENT_METRIC_TYPE_METADATA_LATENCY,	\
+						\
+	CLIENT_METRIC_TYPE_MAX,			\
+}
+
 /* metric caps header */
 struct ceph_metric_cap {
 	__le32 type;     /* ceph metric type */
-- 
1.8.3.1
