From: xiubli@redhat.com
Subject: [PATCH v4 2/4] ceph: add min/max latency support for read/write/metadata metrics
Date: Wed, 18 Mar 2020 01:45:53 -0400
Message-ID: <1584510355-6936-3-git-send-email-xiubli@redhat.com>
References: <1584510355-6936-1-git-send-email-xiubli@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:32501 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726478AbgCRFqS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 18 Mar 2020 01:46:18 -0400
In-Reply-To: <1584510355-6936-1-git-send-email-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org
Cc: sage@redhat.com, idryomov@gmail.com, gfarnum@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

These will be very useful help diagnose problems.

URL: https://tracker.ceph.com/issues/44533
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/debugfs.c    | 27 +++++++++++++++++++++------
 fs/ceph/mds_client.c |  9 +++++++++
 fs/ceph/metric.h     | 51 ++++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 95e8693..01b95fe 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -129,28 +129,43 @@ static int metric_show(struct seq_file *s, void *p)
 	struct ceph_fs_client *fsc = s->private;
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	int i, nr_caps = 0;
-	s64 total, sum, avg = 0;
+	s64 total, sum, avg = 0, min, max;
 
-	seq_printf(s, "item          total       sum_lat(us)     avg_lat(us)\n");
-	seq_printf(s, "-----------------------------------------------------\n");
+	seq_printf(s, "item          total       sum_lat(us)     avg_lat(us)     min_lat(us)     max_lat(us)\n");
+	seq_printf(s, "-------------------------------------------------------------------------------------\n");
 
 	total = percpu_counter_sum(&mdsc->metric.total_reads);
 	sum = percpu_counter_sum(&mdsc->metric.read_latency_sum);
 	sum = jiffies_to_usecs(sum);
 	avg = total ? DIV64_U64_ROUND_CLOSEST(sum, total) : 0;
-	seq_printf(s, "%-14s%-12lld%-16lld%lld\n", "read", total, sum, avg);
+	min = atomic64_read(&mdsc->metric.read_latency_min);
+	min = jiffies_to_usecs(min == S64_MAX ? 0 : min);
+	max = atomic64_read(&mdsc->metric.read_latency_max);
+	max = jiffies_to_usecs(max);
+	seq_printf(s, "%-14s%-12lld%-16lld%-16lld%-16lld%lld\n", "read",
+		   total, sum, avg, min, max);
 
 	total = percpu_counter_sum(&mdsc->metric.total_writes);
 	sum = percpu_counter_sum(&mdsc->metric.write_latency_sum);
 	sum = jiffies_to_usecs(sum);
 	avg = total ? DIV64_U64_ROUND_CLOSEST(sum, total) : 0;
-	seq_printf(s, "%-14s%-12lld%-16lld%lld\n", "write", total, sum, avg);
+	min = atomic64_read(&mdsc->metric.write_latency_min);
+	min = jiffies_to_usecs(min == S64_MAX ? 0 : min);
+	max = atomic64_read(&mdsc->metric.write_latency_max);
+	max = jiffies_to_usecs(max);
+	seq_printf(s, "%-14s%-12lld%-16lld%-16lld%-16lld%lld\n", "write",
+		   total, sum, avg, min, max);
 
 	total = percpu_counter_sum(&mdsc->metric.total_metadatas);
 	sum = percpu_counter_sum(&mdsc->metric.metadata_latency_sum);
 	sum = jiffies_to_usecs(sum);
 	avg = total ? DIV64_U64_ROUND_CLOSEST(sum, total) : 0;
-	seq_printf(s, "%-14s%-12lld%-16lld%lld\n", "metadata", total, sum, avg);
+	min = atomic64_read(&mdsc->metric.metadata_latency_min);
+	min = jiffies_to_usecs(min == S64_MAX ? 0 : min);
+	max = atomic64_read(&mdsc->metric.metadata_latency_max);
+	max = jiffies_to_usecs(max);
+	seq_printf(s, "%-14s%-12lld%-16lld%-16lld%-16lld%lld\n", "metadata",
+		   total, sum, avg, min, max);
 
 	seq_printf(s, "\n");
 	seq_printf(s, "item          total           miss            hit\n");
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 5c03ed3..a3b2810 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4358,6 +4358,9 @@ static int ceph_mdsc_metric_init(struct ceph_client_metric *metric)
 	if (ret)
 		goto err_read_latency_sum;
 
+	atomic64_set(&metric->read_latency_min, S64_MAX);
+	atomic64_set(&metric->read_latency_max, 0);
+
 	ret = percpu_counter_init(&metric->total_writes, 0, GFP_KERNEL);
 	if (ret)
 		goto err_total_writes;
@@ -4366,6 +4369,9 @@ static int ceph_mdsc_metric_init(struct ceph_client_metric *metric)
 	if (ret)
 		goto err_write_latency_sum;
 
+	atomic64_set(&metric->write_latency_min, S64_MAX);
+	atomic64_set(&metric->write_latency_max, 0);
+
 	ret = percpu_counter_init(&metric->total_metadatas, 0, GFP_KERNEL);
 	if (ret)
 		goto err_total_metadatas;
@@ -4374,6 +4380,9 @@ static int ceph_mdsc_metric_init(struct ceph_client_metric *metric)
 	if (ret)
 		goto err_metadata_latency_sum;
 
+	atomic64_set(&metric->metadata_latency_min, S64_MAX);
+	atomic64_set(&metric->metadata_latency_max, 0);
+
 	return 0;
 
 err_metadata_latency_sum:
diff --git a/fs/ceph/metric.h b/fs/ceph/metric.h
index faba142..b36f7f9 100644
--- a/fs/ceph/metric.h
+++ b/fs/ceph/metric.h
@@ -2,6 +2,9 @@
 #ifndef _FS_CEPH_MDS_METRIC_H
 #define _FS_CEPH_MDS_METRIC_H
 
+#include <linux/atomic.h>
+#include <linux/percpu.h>
+
 /* This is the global metrics */
 struct ceph_client_metric {
 	atomic64_t            total_dentries;
@@ -13,12 +16,18 @@ struct ceph_client_metric {
 
 	struct percpu_counter total_reads;
 	struct percpu_counter read_latency_sum;
+	atomic64_t read_latency_min;
+	atomic64_t read_latency_max;
 
 	struct percpu_counter total_writes;
 	struct percpu_counter write_latency_sum;
+	atomic64_t write_latency_min;
+	atomic64_t write_latency_max;
 
 	struct percpu_counter total_metadatas;
 	struct percpu_counter metadata_latency_sum;
+	atomic64_t metadata_latency_min;
+	atomic64_t metadata_latency_max;
 };
 
 static inline void ceph_update_cap_hit(struct ceph_client_metric *m)
@@ -31,16 +40,44 @@ static inline void ceph_update_cap_mis(struct ceph_client_metric *m)
 	percpu_counter_inc(&m->i_caps_mis);
 }
 
+static inline void __update_min_latency(atomic64_t *min, unsigned long lat)
+{
+	unsigned long cur, old;
+
+	cur = atomic64_read(min);
+	do {
+		old = cur;
+		if (likely(lat >= old))
+			break;
+	} while (unlikely((cur = atomic64_cmpxchg(min, old, lat)) != old));
+}
+
+static inline void __update_max_latency(atomic64_t *max, unsigned long lat)
+{
+	unsigned long cur, old;
+
+	cur = atomic64_read(max);
+	do {
+		old = cur;
+		if (likely(lat <= old))
+			break;
+	} while (unlikely((cur = atomic64_cmpxchg(max, old, lat)) != old));
+}
+
 static inline void ceph_update_read_latency(struct ceph_client_metric *m,
 					    unsigned long r_start,
 					    unsigned long r_end,
 					    int rc)
 {
+	unsigned long lat = r_end - r_start;
+
 	if (rc < 0 && rc != -ENOENT && rc != -ETIMEDOUT)
 		return;
 
 	percpu_counter_inc(&m->total_reads);
-	percpu_counter_add(&m->read_latency_sum, r_end - r_start);
+	percpu_counter_add(&m->read_latency_sum, lat);
+	__update_min_latency(&m->read_latency_min, lat);
+	__update_max_latency(&m->read_latency_max, lat);
 }
 
 static inline void ceph_update_write_latency(struct ceph_client_metric *m,
@@ -48,11 +85,15 @@ static inline void ceph_update_write_latency(struct ceph_client_metric *m,
 					     unsigned long r_end,
 					     int rc)
 {
+	unsigned long lat = r_end - r_start;
+
 	if (rc && rc != -ETIMEDOUT)
 		return;
 
 	percpu_counter_inc(&m->total_writes);
-	percpu_counter_add(&m->write_latency_sum, r_end - r_start);
+	percpu_counter_add(&m->write_latency_sum, lat);
+	__update_min_latency(&m->write_latency_min, lat);
+	__update_max_latency(&m->write_latency_max, lat);
 }
 
 static inline void ceph_update_metadata_latency(struct ceph_client_metric *m,
@@ -60,10 +101,14 @@ static inline void ceph_update_metadata_latency(struct ceph_client_metric *m,
 						unsigned long r_end,
 						int rc)
 {
+	unsigned long lat = r_end - r_start;
+
 	if (rc && rc != -ENOENT)
 		return;
 
 	percpu_counter_inc(&m->total_metadatas);
-	percpu_counter_add(&m->metadata_latency_sum, r_end - r_start);
+	percpu_counter_add(&m->metadata_latency_sum, lat);
+	__update_min_latency(&m->metadata_latency_min, lat);
+	__update_max_latency(&m->metadata_latency_max, lat);
 }
 #endif /* _FS_CEPH_MDS_METRIC_H */
-- 
1.8.3.1
