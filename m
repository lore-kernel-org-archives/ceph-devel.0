From: xiubli@redhat.com
Subject: [PATCH 2/2] ceph: add standard deviation support for read/write/metadata perf metric
Date: Tue, 10 Mar 2020 22:54:07 -0400
Message-ID: <1583895247-17312-3-git-send-email-xiubli@redhat.com>
References: <1583895247-17312-1-git-send-email-xiubli@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41978 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727685AbgCKCy1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Mar 2020 22:54:27 -0400
In-Reply-To: <1583895247-17312-1-git-send-email-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org
Cc: sage@redhat.com, idryomov@gmail.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

This could help us to understand the perf issue better.

URL: https://tracker.ceph.com/issues/44534
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/debugfs.c | 70 ++++++++++++++++++++++++++++---------------
 fs/ceph/metric.c  | 89 +++++++++++++++++++++++++++++++++++++++----------------
 fs/ceph/metric.h  | 12 ++++++--
 3 files changed, 118 insertions(+), 53 deletions(-)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 9ef0ffe..dca751e 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/ceph/ceph_debug.h>
 
+#include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -129,43 +130,64 @@ static int metric_show(struct seq_file *s, void *p)
 	struct ceph_fs_client *fsc = s->private;
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	int i, nr_caps = 0;
-	s64 total, sum, avg = 0, min, max;
+	s64 total, sum, avg = 0, min, max, sq;
 
-	seq_printf(s, "item          total       sum_lat(us)     avg_lat(us)     min_lat(us)     max_lat(us)\n");
-	seq_printf(s, "-------------------------------------------------------------------------------------\n");
+	seq_printf(s, "item          total       sum_lat(us)     avg_lat(us)     min_lat(us)     max_lat(us)     stdev(us)\n");
+	seq_printf(s, "---------------------------------------------------------------------------------------------------\n");
 
-	total = percpu_counter_sum(&mdsc->metric.total_reads);
-	sum = percpu_counter_sum(&mdsc->metric.read_latency_sum);
-	sum = jiffies_to_usecs(sum);
-	avg = total ? sum / total : 0;
+	spin_lock(&mdsc->metric.read_latency_lock);
+	total = atomic64_read(&mdsc->metric.total_reads);
+	avg = atomic64_read(&mdsc->metric.read_latency_avg);
 	min = atomic64_read(&mdsc->metric.read_latency_min);
-	min = jiffies_to_usecs(min == S64_MAX ? 0 : min);
 	max = atomic64_read(&mdsc->metric.read_latency_max);
-	max = jiffies_to_usecs(max);
-	seq_printf(s, "%-14s%-12lld%-16lld%-16lld%-16lld%lld\n", "read",
-		   total, sum, avg, min, max);
+	spin_unlock(&mdsc->metric.read_latency_lock);
 
-	total = percpu_counter_sum(&mdsc->metric.total_writes);
-	sum = percpu_counter_sum(&mdsc->metric.write_latency_sum);
+	sum = percpu_counter_sum(&mdsc->metric.read_latency_sum);
+	sq = percpu_counter_sum(&mdsc->metric.read_latency_sq_sum);
+
+	avg = jiffies_to_usecs(avg);
+	min = jiffies_to_usecs(min == S64_MAX ? 0 : min);
+	max = jiffies_to_usecs(max);
 	sum = jiffies_to_usecs(sum);
-	avg = total ? sum / total : 0;
+	sq = jiffies_to_usecs(total > 1 ? sq / (total - 1) : 0);
+	seq_printf(s, "%-14s%-12lld%-16lld%-16lld%-16lld%-16lld%u\n",
+		   "read", total, sum, avg, min, max, int_sqrt64(sq));
+
+	spin_lock(&mdsc->metric.write_latency_lock);
+	total = atomic64_read(&mdsc->metric.total_writes);
+	avg = atomic64_read(&mdsc->metric.write_latency_avg);
 	min = atomic64_read(&mdsc->metric.write_latency_min);
-	min = jiffies_to_usecs(min == S64_MAX ? 0 : min);
 	max = atomic64_read(&mdsc->metric.write_latency_max);
-	max = jiffies_to_usecs(max);
-	seq_printf(s, "%-14s%-12lld%-16lld%-16lld%-16lld%lld\n", "write",
-		   total, sum, avg, min, max);
+	spin_unlock(&mdsc->metric.write_latency_lock);
 
-	total = percpu_counter_sum(&mdsc->metric.total_metadatas);
-	sum = percpu_counter_sum(&mdsc->metric.metadata_latency_sum);
+	sum = percpu_counter_sum(&mdsc->metric.write_latency_sum);
+	sq = percpu_counter_sum(&mdsc->metric.write_latency_sq_sum);
+
+	avg = jiffies_to_usecs(avg);
+	min = jiffies_to_usecs(min == S64_MAX ? 0 : min);
+	max = jiffies_to_usecs(max);
 	sum = jiffies_to_usecs(sum);
-	avg = total ? sum / total : 0;
+	sq = jiffies_to_usecs(total > 1 ? sq / (total - 1) : 0);
+	seq_printf(s, "%-14s%-12lld%-16lld%-16lld%-16lld%-16lld%u\n",
+		   "write", total, sum, avg, min, max, int_sqrt64(sq));
+
+	spin_lock(&mdsc->metric.metadata_latency_lock);
+	total = atomic64_read(&mdsc->metric.total_metadatas);
+	avg = atomic64_read(&mdsc->metric.metadata_latency_avg);
 	min = atomic64_read(&mdsc->metric.metadata_latency_min);
-	min = jiffies_to_usecs(min == S64_MAX ? 0 : min);
 	max = atomic64_read(&mdsc->metric.metadata_latency_max);
+	spin_unlock(&mdsc->metric.metadata_latency_lock);
+
+	sum = percpu_counter_sum(&mdsc->metric.metadata_latency_sum);
+	sq = percpu_counter_sum(&mdsc->metric.metadata_latency_sq_sum);
+
+	avg = jiffies_to_usecs(avg);
+	min = jiffies_to_usecs(min == S64_MAX ? 0 : min);
 	max = jiffies_to_usecs(max);
-	seq_printf(s, "%-14s%-12lld%-16lld%-16lld%-16lld%lld\n", "metadata",
-		   total, sum, avg, min, max);
+	sum = jiffies_to_usecs(sum);
+	sq = jiffies_to_usecs(total > 1 ? sq / (total - 1) : 0);
+	seq_printf(s, "%-14s%-12lld%-16lld%-16lld%-16lld%-16lld%u\n",
+		   "metadata", total, sum, avg, min, max, int_sqrt64(sq));
 
 	seq_printf(s, "\n");
 	seq_printf(s, "item          total           miss            hit\n");
diff --git a/fs/ceph/metric.c b/fs/ceph/metric.c
index 4a1bf27..17bf278 100644
--- a/fs/ceph/metric.c
+++ b/fs/ceph/metric.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/kernel.h>
 #include <linux/atomic.h>
 #include <linux/percpu_counter.h>
 #include <linux/spinlock.h>
@@ -27,55 +28,61 @@ int ceph_mdsc_metric_init(struct ceph_client_metric *m)
 	if (ret)
 		goto err_i_caps_mis;
 
-	ret = percpu_counter_init(&m->total_reads, 0, GFP_KERNEL);
-	if (ret)
-		goto err_total_reads;
-
 	ret = percpu_counter_init(&m->read_latency_sum, 0, GFP_KERNEL);
 	if (ret)
 		goto err_read_latency_sum;
 
+	ret = percpu_counter_init(&m->read_latency_sq_sum, 0, GFP_KERNEL);
+	if (ret)
+		goto err_read_latency_sq_sum;
+
 	spin_lock_init(&m->read_latency_lock);
+	atomic64_set(&m->total_reads, 0);
 	atomic64_set(&m->read_latency_min, S64_MAX);
 	atomic64_set(&m->read_latency_max, 0);
-
-	ret = percpu_counter_init(&m->total_writes, 0, GFP_KERNEL);
-	if (ret)
-		goto err_total_writes;
+	atomic64_set(&m->read_latency_avg, 0);
 
 	ret = percpu_counter_init(&m->write_latency_sum, 0, GFP_KERNEL);
 	if (ret)
 		goto err_write_latency_sum;
 
+	ret = percpu_counter_init(&m->write_latency_sq_sum, 0, GFP_KERNEL);
+	if (ret)
+		goto err_write_latency_sq_sum;
+
 	spin_lock_init(&m->write_latency_lock);
+	atomic64_set(&m->total_writes, 0);
 	atomic64_set(&m->write_latency_min, S64_MAX);
 	atomic64_set(&m->write_latency_max, 0);
-
-	ret = percpu_counter_init(&m->total_metadatas, 0, GFP_KERNEL);
-	if (ret)
-		goto err_total_metadatas;
+	atomic64_set(&m->write_latency_avg, 0);
 
 	ret = percpu_counter_init(&m->metadata_latency_sum, 0, GFP_KERNEL);
 	if (ret)
 		goto err_metadata_latency_sum;
 
+	ret = percpu_counter_init(&m->metadata_latency_sq_sum, 0, GFP_KERNEL);
+	if (ret)
+		goto err_metadata_latency_sq_sum;
+
 	spin_lock_init(&m->metadata_latency_lock);
+	atomic64_set(&m->total_metadatas, 0);
 	atomic64_set(&m->metadata_latency_min, S64_MAX);
 	atomic64_set(&m->metadata_latency_max, 0);
+	atomic64_set(&m->metadata_latency_avg, 0);
 
 	return 0;
 
+err_metadata_latency_sq_sum:
+	percpu_counter_destroy(&m->metadata_latency_sum);
 err_metadata_latency_sum:
-	percpu_counter_destroy(&m->total_metadatas);
-err_total_metadatas:
+	percpu_counter_destroy(&m->write_latency_sq_sum);
+err_write_latency_sq_sum:
 	percpu_counter_destroy(&m->write_latency_sum);
 err_write_latency_sum:
-	percpu_counter_destroy(&m->total_writes);
-err_total_writes:
+	percpu_counter_destroy(&m->read_latency_sq_sum);
+err_read_latency_sq_sum:
 	percpu_counter_destroy(&m->read_latency_sum);
 err_read_latency_sum:
-	percpu_counter_destroy(&m->total_reads);
-err_total_reads:
 	percpu_counter_destroy(&m->i_caps_mis);
 err_i_caps_mis:
 	percpu_counter_destroy(&m->i_caps_hit);
@@ -89,12 +96,12 @@ int ceph_mdsc_metric_init(struct ceph_client_metric *m)
 
 void ceph_mdsc_metric_destroy(struct ceph_client_metric *m)
 {
+	percpu_counter_destroy(&m->metadata_latency_sq_sum);
 	percpu_counter_destroy(&m->metadata_latency_sum);
-	percpu_counter_destroy(&m->total_metadatas);
+	percpu_counter_destroy(&m->write_latency_sq_sum);
 	percpu_counter_destroy(&m->write_latency_sum);
-	percpu_counter_destroy(&m->total_writes);
+	percpu_counter_destroy(&m->read_latency_sq_sum);
 	percpu_counter_destroy(&m->read_latency_sum);
-	percpu_counter_destroy(&m->total_reads);
 	percpu_counter_destroy(&m->i_caps_mis);
 	percpu_counter_destroy(&m->i_caps_hit);
 	percpu_counter_destroy(&m->d_lease_mis);
@@ -107,11 +114,21 @@ void ceph_update_read_latency(struct ceph_client_metric *m,
 			      int rc)
 {
 	unsigned long lat = r_end - r_start;
+	s64 sum, avg, sq, tmp;
 
 	if (rc < 0 && rc != -ENOENT && rc != -ETIMEDOUT)
 		return;
 
-	percpu_counter_inc(&m->total_reads);
+	spin_lock(&m->read_latency_lock);
+	sum = atomic64_inc_return(&m->total_reads);
+	avg = atomic64_read(&m->read_latency_avg);
+	sq = lat - avg;
+	tmp = sq > 0 ? sq + (sum - 1) : sq - (sum - 1);
+	avg = atomic64_add_return(tmp / sum, &m->read_latency_avg);
+	spin_unlock(&m->read_latency_lock);
+
+	sq = sq * (lat - avg);
+	percpu_counter_add(&m->read_latency_sq_sum, sq);
 	percpu_counter_add(&m->read_latency_sum, lat);
 
 	if (lat >= atomic64_read(&m->read_latency_min) &&
@@ -132,12 +149,22 @@ void ceph_update_write_latency(struct ceph_client_metric *m,
 			       int rc)
 {
 	unsigned long lat = r_end - r_start;
+	s64 sum, avg, sq, tmp;
 
 	if (rc && rc != -ETIMEDOUT)
 		return;
 
-	percpu_counter_inc(&m->total_writes);
-	percpu_counter_add(&m->write_latency_sum, r_end - r_start);
+	spin_lock(&m->write_latency_lock);
+	sum = atomic64_inc_return(&m->total_writes);
+	avg = atomic64_read(&m->write_latency_avg);
+	sq = lat - avg;
+	tmp = sq > 0 ? sq + (sum - 1) : sq - (sum - 1);
+	avg = atomic64_add_return(tmp / sum, &m->write_latency_avg);
+	spin_unlock(&m->write_latency_lock);
+
+	sq = sq * (lat - avg);
+	percpu_counter_add(&m->write_latency_sq_sum, sq);
+	percpu_counter_add(&m->write_latency_sum, lat);
 
 	if (lat >= atomic64_read(&m->write_latency_min) &&
 	    lat <= atomic64_read(&m->write_latency_max))
@@ -157,12 +184,22 @@ void ceph_update_metadata_latency(struct ceph_client_metric *m,
 				  int rc)
 {
 	unsigned long lat = r_end - r_start;
+	s64 sum, avg, sq, tmp;
 
 	if (rc && rc != -ENOENT)
 		return;
 
-	percpu_counter_inc(&m->total_metadatas);
-	percpu_counter_add(&m->metadata_latency_sum, r_end - r_start);
+	spin_lock(&m->metadata_latency_lock);
+	sum = atomic64_inc_return(&m->total_metadatas);
+	avg = atomic64_read(&m->metadata_latency_avg);
+	sq = lat - avg;
+	tmp = sq > 0 ? sq + (sum - 1) : sq - (sum - 1);
+	avg = atomic64_add_return(tmp / sum, &m->metadata_latency_avg);
+	spin_unlock(&m->metadata_latency_lock);
+
+	sq = sq * (lat - avg);
+	percpu_counter_add(&m->metadata_latency_sq_sum, sq);
+	percpu_counter_add(&m->metadata_latency_sum, lat);
 
 	if (lat >= atomic64_read(&m->metadata_latency_min) &&
 	    lat <= atomic64_read(&m->metadata_latency_max))
diff --git a/fs/ceph/metric.h b/fs/ceph/metric.h
index 493e787..35d26e7 100644
--- a/fs/ceph/metric.h
+++ b/fs/ceph/metric.h
@@ -15,23 +15,29 @@ struct ceph_client_metric {
 	struct percpu_counter i_caps_hit;
 	struct percpu_counter i_caps_mis;
 
-	struct percpu_counter total_reads;
 	struct percpu_counter read_latency_sum;
+	struct percpu_counter read_latency_sq_sum;
 	spinlock_t read_latency_lock;
+	atomic64_t total_reads;
 	atomic64_t read_latency_min;
 	atomic64_t read_latency_max;
+	atomic64_t read_latency_avg;
 
-	struct percpu_counter total_writes;
 	struct percpu_counter write_latency_sum;
+	struct percpu_counter write_latency_sq_sum;
 	spinlock_t write_latency_lock;
+	atomic64_t total_writes;
 	atomic64_t write_latency_min;
 	atomic64_t write_latency_max;
+	atomic64_t write_latency_avg;
 
-	struct percpu_counter total_metadatas;
 	struct percpu_counter metadata_latency_sum;
+	struct percpu_counter metadata_latency_sq_sum;
 	spinlock_t metadata_latency_lock;
+	atomic64_t total_metadatas;
 	atomic64_t metadata_latency_min;
 	atomic64_t metadata_latency_max;
+	atomic64_t metadata_latency_avg;
 };
 
 static inline void ceph_update_cap_hit(struct ceph_client_metric *m)
-- 
1.8.3.1
