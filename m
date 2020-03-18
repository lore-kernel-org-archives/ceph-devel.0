From: xiubli@redhat.com
Subject: [PATCH v10 4/6] ceph: add metadata perf metric support
Date: Wed, 18 Mar 2020 10:05:54 -0400
Message-ID: <1584540356-5885-5-git-send-email-xiubli@redhat.com>
References: <1584540356-5885-1-git-send-email-xiubli@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56373 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727114AbgCROGl (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 18 Mar 2020 10:06:41 -0400
In-Reply-To: <1584540356-5885-1-git-send-email-xiubli@redhat.com>
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
 fs/ceph/debugfs.c    |  6 ++++++
 fs/ceph/mds_client.c |  5 +++++
 fs/ceph/mds_client.h |  3 ++-
 fs/ceph/metric.c     | 14 ++++++++++++++
 fs/ceph/metric.h     | 15 +++++++++++++++
 5 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index f2bb997..b04344e 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -147,6 +147,12 @@ static int metric_show(struct seq_file *s, void *p)
 	avg = jiffies_to_usecs(avg);
 	seq_printf(s, "%-14s%-12lld%lld\n", "write", total, avg);
 
+	total = percpu_counter_sum(&m->total_metadatas);
+	sum = percpu_counter_sum(&m->metadata_latency_sum);
+	avg = total ? DIV64_U64_ROUND_CLOSEST(sum, total) : 0;
+	avg = jiffies_to_usecs(avg);
+	seq_printf(s, "%-14s%-12lld%lld\n", "metadata", total, avg);
+
 	seq_printf(s, "\n");
 	seq_printf(s, "item          total           miss            hit\n");
 	seq_printf(s, "-------------------------------------------------\n");
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 1e242d8..b3f985a 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2547,6 +2547,8 @@ static struct ceph_msg *create_request_message(struct ceph_mds_client *mdsc,
 static void complete_request(struct ceph_mds_client *mdsc,
 			     struct ceph_mds_request *req)
 {
+	req->r_ended = jiffies;
+
 	if (req->r_callback)
 		req->r_callback(mdsc, req);
 	complete_all(&req->r_completion);
@@ -3155,6 +3157,9 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 
 	/* kick calling process */
 	complete_request(mdsc, req);
+
+	ceph_update_metadata_latency(&mdsc->metric, req->r_started,
+				     req->r_ended, err);
 out:
 	ceph_mdsc_put_request(req);
 	return;
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index ae1d01c..9018fa7 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -298,7 +298,8 @@ struct ceph_mds_request {
 	u32               r_readdir_offset;
 
 	unsigned long r_timeout;  /* optional.  jiffies, 0 is "wait forever" */
-	unsigned long r_started;  /* start time to measure timeout against */
+	unsigned long r_started;  /* start time to measure timeout against and latency */
+	unsigned long r_ended;    /* finish time to measure latency */
 	unsigned long r_request_started; /* start time for mds request only,
 					    used to measure lease durations */
 
diff --git a/fs/ceph/metric.c b/fs/ceph/metric.c
index 1d34d8c..629a328 100644
--- a/fs/ceph/metric.c
+++ b/fs/ceph/metric.c
@@ -45,8 +45,20 @@ int ceph_metric_init(struct ceph_client_metric *m)
 	if (ret)
 		goto err_write_latency_sum;
 
+	ret = percpu_counter_init(&m->total_metadatas, 0, GFP_KERNEL);
+	if (ret)
+		goto err_total_metadatas;
+
+	ret = percpu_counter_init(&m->metadata_latency_sum, 0, GFP_KERNEL);
+	if (ret)
+		goto err_metadata_latency_sum;
+
 	return 0;
 
+err_metadata_latency_sum:
+	percpu_counter_destroy(&m->total_metadatas);
+err_total_metadatas:
+	percpu_counter_destroy(&m->write_latency_sum);
 err_write_latency_sum:
 	percpu_counter_destroy(&m->total_writes);
 err_total_writes:
@@ -70,6 +82,8 @@ void ceph_metric_destroy(struct ceph_client_metric *m)
 	if (!m)
 		return;
 
+	percpu_counter_destroy(&m->metadata_latency_sum);
+	percpu_counter_destroy(&m->total_metadatas);
 	percpu_counter_destroy(&m->write_latency_sum);
 	percpu_counter_destroy(&m->total_writes);
 	percpu_counter_destroy(&m->read_latency_sum);
diff --git a/fs/ceph/metric.h b/fs/ceph/metric.h
index b1b45b0..aaf9979 100644
--- a/fs/ceph/metric.h
+++ b/fs/ceph/metric.h
@@ -19,6 +19,9 @@ struct ceph_client_metric {
 
 	struct percpu_counter total_writes;
 	struct percpu_counter write_latency_sum;
+
+	struct percpu_counter total_metadatas;
+	struct percpu_counter metadata_latency_sum;
 };
 
 extern int ceph_metric_init(struct ceph_client_metric *m);
@@ -57,4 +60,16 @@ static inline void ceph_update_write_latency(struct ceph_client_metric *m,
 	percpu_counter_inc(&m->total_writes);
 	percpu_counter_add(&m->write_latency_sum, r_end - r_start);
 }
+
+static inline void ceph_update_metadata_latency(struct ceph_client_metric *m,
+						unsigned long r_start,
+						unsigned long r_end,
+						int rc)
+{
+	if (rc && rc != -ENOENT)
+		return;
+
+	percpu_counter_inc(&m->total_metadatas);
+	percpu_counter_add(&m->metadata_latency_sum, r_end - r_start);
+}
 #endif /* _FS_CEPH_MDS_METRIC_H */
-- 
1.8.3.1
