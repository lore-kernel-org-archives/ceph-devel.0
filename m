From: xiubli@redhat.com
Subject: [PATCH v7 5/5] ceph: add global metadata perf metric support
Date: Tue, 18 Feb 2020 22:38:51 -0500
Message-ID: <20200219033851.6548-6-xiubli@redhat.com>
References: <20200219033851.6548-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20094 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726403AbgBSDkd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Feb 2020 22:40:33 -0500
In-Reply-To: <20200219033851.6548-1-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

It will calculate the latency for the metedata requests, which only
include the time cousumed by network and the ceph.

item          total       sum_lat(us)     avg_lat(us)
-----------------------------------------------------
metadata      113         220000          1946

URL: https://tracker.ceph.com/issues/43215
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/debugfs.c    |  6 ++++++
 fs/ceph/mds_client.c | 20 ++++++++++++++++++++
 fs/ceph/metric.h     | 13 +++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 464bfbdb970d..60f3e307fca1 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -146,6 +146,12 @@ static int metric_show(struct seq_file *s, void *p)
 	avg =3D total ? sum / total : 0;
 	seq_printf(s, "%-14s%-12lld%-16lld%lld\n", "write", total, sum, avg);
=20
+	total =3D percpu_counter_sum(&mdsc->metric.total_metadatas);
+	sum =3D percpu_counter_sum(&mdsc->metric.metadata_latency_sum);
+	sum =3D jiffies_to_usecs(sum);
+	avg =3D total ? sum / total : 0;
+	seq_printf(s, "%-14s%-12lld%-16lld%lld\n", "metadata", total, sum, avg)=
;
+
 	seq_printf(s, "\n");
 	seq_printf(s, "item          total           miss            hit\n");
 	seq_printf(s, "-------------------------------------------------\n");
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 58e97ac004d6..eb494f1aa137 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3021,6 +3021,12 @@ static void handle_reply(struct ceph_mds_session *=
session, struct ceph_msg *msg)
=20
 	/* kick calling process */
 	complete_request(mdsc, req);
+
+	if (!result || result =3D=3D -ENOENT) {
+		s64 latency =3D jiffies - req->r_started;
+
+		ceph_update_metadata_latency(&mdsc->metric, latency);
+	}
 out:
 	ceph_mdsc_put_request(req);
 	return;
@@ -4200,8 +4206,20 @@ static int ceph_mdsc_metric_init(struct ceph_clien=
t_metric *metric)
 	if (ret)
 		goto err_write_latency_sum;
=20
+	ret =3D percpu_counter_init(&metric->total_metadatas, 0, GFP_KERNEL);
+	if (ret)
+		goto err_total_metadatas;
+
+	ret =3D percpu_counter_init(&metric->metadata_latency_sum, 0, GFP_KERNE=
L);
+	if (ret)
+		goto err_metadata_latency_sum;
+
 	return 0;
=20
+err_metadata_latency_sum:
+	percpu_counter_destroy(&metric->total_metadatas);
+err_total_metadatas:
+	percpu_counter_destroy(&metric->write_latency_sum);
 err_write_latency_sum:
 	percpu_counter_destroy(&metric->total_writes);
 err_total_writes:
@@ -4557,6 +4575,8 @@ void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
=20
 	ceph_mdsc_stop(mdsc);
=20
+	percpu_counter_destroy(&mdsc->metric.metadata_latency_sum);
+	percpu_counter_destroy(&mdsc->metric.total_metadatas);
 	percpu_counter_destroy(&mdsc->metric.write_latency_sum);
 	percpu_counter_destroy(&mdsc->metric.total_writes);
 	percpu_counter_destroy(&mdsc->metric.read_latency_sum);
diff --git a/fs/ceph/metric.h b/fs/ceph/metric.h
index a87197f3e915..9de8beb436c7 100644
--- a/fs/ceph/metric.h
+++ b/fs/ceph/metric.h
@@ -18,6 +18,9 @@ struct ceph_client_metric {
=20
 	struct percpu_counter total_writes;
 	struct percpu_counter write_latency_sum;
+
+	struct percpu_counter total_metadatas;
+	struct percpu_counter metadata_latency_sum;
 };
=20
 static inline void ceph_update_read_latency(struct ceph_client_metric *m=
,
@@ -49,4 +52,14 @@ static inline void ceph_update_write_latency(struct ce=
ph_client_metric *m,
 		percpu_counter_add(&m->write_latency_sum, latency);
 	}
 }
+
+static inline void ceph_update_metadata_latency(struct ceph_client_metri=
c *m,
+						s64 latency)
+{
+	if (!m)
+		return;
+
+	percpu_counter_inc(&m->total_metadatas);
+	percpu_counter_add(&m->metadata_latency_sum, latency);
+}
 #endif /* _FS_CEPH_MDS_METRIC_H */
--=20
2.21.0
