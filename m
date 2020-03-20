From: xiubli@redhat.com
Subject: [PATCH v13 4/4] ceph: add metadata perf metric support
Date: Thu, 19 Mar 2020 23:45:02 -0400
Message-ID: <1584675902-16493-5-git-send-email-xiubli@redhat.com>
References: <1584675902-16493-1-git-send-email-xiubli@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57103 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726658AbgCTDpa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 19 Mar 2020 23:45:30 -0400
In-Reply-To: <1584675902-16493-1-git-send-email-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org
Cc: sage@redhat.com, idryomov@gmail.com, gfarnum@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

Add a new "r_ended" field to struct ceph_mds_request and use that to
maintain the average latency of MDS requests.

URL: https://tracker.ceph.com/issues/43215
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/debugfs.c    | 10 ++++++++++
 fs/ceph/mds_client.c |  7 +++++++
 fs/ceph/mds_client.h |  3 +++
 fs/ceph/metric.c     | 23 +++++++++++++++++++++++
 fs/ceph/metric.h     | 10 ++++++++++
 5 files changed, 53 insertions(+)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 4a96b7f8..eebbce7 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -171,6 +171,16 @@ static int metric_show(struct seq_file *s, void *p)
 	spin_unlock(&m->write_latency_lock);
 	CEPH_METRIC_SHOW("write", total, avg, min, max, sq);
 
+	spin_lock(&m->metadata_latency_lock);
+	total = m->total_metadatas;
+	sum = m->metadata_latency_sum;
+	avg = total > 0 ? DIV64_U64_ROUND_CLOSEST(sum, total) : 0;
+	min = m->metadata_latency_min;
+	max = m->metadata_latency_max;
+	sq = m->metadata_latency_sq_sum;
+	spin_unlock(&m->metadata_latency_lock);
+	CEPH_METRIC_SHOW("metadata", total, avg, min, max, sq);
+
 	seq_printf(s, "\n");
 	seq_printf(s, "item          total           miss            hit\n");
 	seq_printf(s, "-------------------------------------------------\n");
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 1e242d8..acce044 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -10,6 +10,7 @@
 #include <linux/seq_file.h>
 #include <linux/ratelimit.h>
 #include <linux/bits.h>
+#include <linux/ktime.h>
 
 #include "super.h"
 #include "mds_client.h"
@@ -2201,6 +2202,7 @@ struct ceph_mds_request *
 	mutex_init(&req->r_fill_mutex);
 	req->r_mdsc = mdsc;
 	req->r_started = jiffies;
+	req->r_start_latency = ktime_get();
 	req->r_resend_mds = -1;
 	INIT_LIST_HEAD(&req->r_unsafe_dir_item);
 	INIT_LIST_HEAD(&req->r_unsafe_target_item);
@@ -2547,6 +2549,8 @@ static struct ceph_msg *create_request_message(struct ceph_mds_client *mdsc,
 static void complete_request(struct ceph_mds_client *mdsc,
 			     struct ceph_mds_request *req)
 {
+	req->r_end_latency = ktime_get();
+
 	if (req->r_callback)
 		req->r_callback(mdsc, req);
 	complete_all(&req->r_completion);
@@ -3155,6 +3159,9 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 
 	/* kick calling process */
 	complete_request(mdsc, req);
+
+	ceph_update_metadata_latency(&mdsc->metric, req->r_start_latency,
+				     req->r_end_latency, err);
 out:
 	ceph_mdsc_put_request(req);
 	return;
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index ae1d01c..8065863 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -10,6 +10,7 @@
 #include <linux/spinlock.h>
 #include <linux/refcount.h>
 #include <linux/utsname.h>
+#include <linux/ktime.h>
 
 #include <linux/ceph/types.h>
 #include <linux/ceph/messenger.h>
@@ -299,6 +300,8 @@ struct ceph_mds_request {
 
 	unsigned long r_timeout;  /* optional.  jiffies, 0 is "wait forever" */
 	unsigned long r_started;  /* start time to measure timeout against */
+	unsigned long r_start_latency;  /* start time to measure latency */
+	unsigned long r_end_latency;    /* finish time to measure latency */
 	unsigned long r_request_started; /* start time for mds request only,
 					    used to measure lease durations */
 
diff --git a/fs/ceph/metric.c b/fs/ceph/metric.c
index f5cf32e7..9217f35 100644
--- a/fs/ceph/metric.c
+++ b/fs/ceph/metric.c
@@ -44,6 +44,13 @@ int ceph_metric_init(struct ceph_client_metric *m)
 	m->total_writes = 0;
 	m->write_latency_sum = 0;
 
+	spin_lock_init(&m->metadata_latency_lock);
+	m->metadata_latency_sq_sum = 0;
+	m->metadata_latency_min = KTIME_MAX;
+	m->metadata_latency_max = 0;
+	m->total_metadatas = 0;
+	m->metadata_latency_sum = 0;
+
 	return 0;
 
 err_i_caps_mis:
@@ -123,3 +130,19 @@ void ceph_update_write_latency(struct ceph_client_metric *m,
 			 &m->write_latency_sq_sum, lat);
 	spin_unlock(&m->write_latency_lock);
 }
+
+void ceph_update_metadata_latency(struct ceph_client_metric *m,
+				  ktime_t r_start, ktime_t r_end,
+				  int rc)
+{
+	ktime_t lat = ktime_sub(r_end, r_start);
+
+	if (unlikely(rc && rc != -ENOENT))
+		return;
+
+	spin_lock(&m->metadata_latency_lock);
+	__update_latency(&m->total_metadatas, &m->metadata_latency_sum,
+			 &m->metadata_latency_min, &m->metadata_latency_max,
+			 &m->metadata_latency_sq_sum, lat);
+	spin_unlock(&m->metadata_latency_lock);
+}
diff --git a/fs/ceph/metric.h b/fs/ceph/metric.h
index ab1543c..ccd8128 100644
--- a/fs/ceph/metric.h
+++ b/fs/ceph/metric.h
@@ -28,6 +28,13 @@ struct ceph_client_metric {
 	ktime_t write_latency_sq_sum;
 	ktime_t write_latency_min;
 	ktime_t write_latency_max;
+
+	spinlock_t metadata_latency_lock;
+	u64 total_metadatas;
+	ktime_t metadata_latency_sum;
+	ktime_t metadata_latency_sq_sum;
+	ktime_t metadata_latency_min;
+	ktime_t metadata_latency_max;
 };
 
 extern int ceph_metric_init(struct ceph_client_metric *m);
@@ -49,4 +56,7 @@ extern void ceph_update_read_latency(struct ceph_client_metric *m,
 extern void ceph_update_write_latency(struct ceph_client_metric *m,
 				      ktime_t r_start, ktime_t r_end,
 				      int rc);
+extern void ceph_update_metadata_latency(struct ceph_client_metric *m,
+				         ktime_t r_start, ktime_t r_end,
+					 int rc);
 #endif /* _FS_CEPH_MDS_METRIC_H */
-- 
1.8.3.1
