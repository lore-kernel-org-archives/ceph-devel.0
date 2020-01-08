From: xiubli@redhat.com
Subject: [PATCH v2 5/8] ceph: add global metadata perf metric support
Date: Wed,  8 Jan 2020 05:41:49 -0500
Message-ID: <20200108104152.28468-6-xiubli@redhat.com>
References: <20200108104152.28468-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29224 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727878AbgAHKmc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Jan 2020 05:42:32 -0500
In-Reply-To: <20200108104152.28468-1-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com, zyan@redhat.com
Cc: sage@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

item          total       sum_lat(us)     avg_lat(us)
-----------------------------------------------------
write         756         9225615920      12418192

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/debugfs.c    |  8 ++++++++
 fs/ceph/mds_client.c | 25 +++++++++++++++++++++++++
 fs/ceph/mds_client.h |  6 ++++++
 3 files changed, 39 insertions(+)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 3fdb15af0a83..df8c1cc685d9 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -150,6 +150,14 @@ static int metric_show(struct seq_file *s, void *p)
 	seq_printf(s, "%-14s%-12lld%-16lld%lld\n", "write",
 		   total, sum / NSEC_PER_USEC, avg / NSEC_PER_USEC);
=20
+	spin_lock(&mdsc->metric.metadata_lock);
+	total =3D atomic64_read(&mdsc->metric.total_metadatas),
+	sum =3D timespec64_to_ns(&mdsc->metric.metadata_latency_sum);
+	spin_unlock(&mdsc->metric.metadata_lock);
+	avg =3D total ? sum / total : 0;
+	seq_printf(s, "%-14s%-12lld%-16lld%lld\n", "metadata",
+		   total, sum / NSEC_PER_USEC, avg / NSEC_PER_USEC);
+
 	seq_printf(s, "\n");
 	seq_printf(s, "item          total           miss            hit\n");
 	seq_printf(s, "-------------------------------------------------\n");
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 865ff33aac0b..ae2fe0277c6c 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2894,6 +2894,11 @@ static void handle_reply(struct ceph_mds_session *=
session, struct ceph_msg *msg)
=20
 	result =3D le32_to_cpu(head->result);
=20
+	if (!result || result =3D=3D -ESTALE || result =3D=3D -ENOENT) {
+		s64 latency =3D jiffies - req->r_started;
+		ceph_mdsc_update_metadata_latency(&mdsc->metric, latency);
+	}
+
 	/*
 	 * Handle an ESTALE
 	 * if we're not talking to the authority, send to them
@@ -4127,6 +4132,22 @@ void ceph_mdsc_update_write_latency(struct ceph_cl=
ient_metric *m,
 	spin_unlock(&m->write_lock);
 }
=20
+void ceph_mdsc_update_metadata_latency(struct ceph_client_metric *m,
+				       s64 latency)
+{
+	struct timespec64 ts;
+
+	if (!m)
+		return;
+
+	jiffies_to_timespec64(latency, &ts);
+
+	spin_lock(&m->metadata_lock);
+	atomic64_inc(&m->total_metadatas);
+	m->metadata_latency_sum =3D timespec64_add(m->metadata_latency_sum, ts)=
;
+	spin_unlock(&m->metadata_lock);
+}
+
 /*
  * delayed work -- periodically trim expired leases, renew caps with mds
  */
@@ -4231,6 +4252,10 @@ static int ceph_mdsc_metric_init(struct ceph_clien=
t_metric *metric)
 	memset(&metric->write_latency_sum, 0, sizeof(struct timespec64));
 	atomic64_set(&metric->total_writes, 0);
=20
+	spin_lock_init(&metric->metadata_lock);
+	memset(&metric->metadata_latency_sum, 0, sizeof(struct timespec64));
+	atomic64_set(&metric->total_metadatas, 0);
+
 	return 0;
 }
=20
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 1c8c446fb7bb..ee36ab87e5f6 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -374,6 +374,10 @@ struct ceph_client_metric {
 	spinlock_t              write_lock;
 	atomic64_t		total_writes;
 	struct timespec64	write_latency_sum;
+
+	spinlock_t              metadata_lock;
+	atomic64_t		total_metadatas;
+	struct timespec64	metadata_latency_sum;
 };
=20
 /*
@@ -562,4 +566,6 @@ extern void ceph_mdsc_update_read_latency(struct ceph=
_client_metric *m,
 					  s64 latency);
 extern void ceph_mdsc_update_write_latency(struct ceph_client_metric *m,
 					   s64 latency);
+extern void ceph_mdsc_update_metadata_latency(struct ceph_client_metric =
*m,
+					      s64 latency);
 #endif
--=20
2.21.0
