From: xiubli@redhat.com
Subject: [PATCH v2 7/8] ceph: add reset metrics support
Date: Wed,  8 Jan 2020 05:41:51 -0500
Message-ID: <20200108104152.28468-8-xiubli@redhat.com>
References: <20200108104152.28468-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32880 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727889AbgAHKmi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Jan 2020 05:42:38 -0500
In-Reply-To: <20200108104152.28468-1-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com, zyan@redhat.com
Cc: sage@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

This will reset the most metric counters, except the cap and dentry
total numbers.

Sometimes we need to discard the old metrics and start to get new
metrics.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/debugfs.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/super.h   |  1 +
 2 files changed, 58 insertions(+)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index bb96fb4d04c4..c24a704d4e99 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -158,6 +158,55 @@ static int sending_metrics_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(sending_metrics_fops, sending_metrics_get,
 			sending_metrics_set, "%llu\n");
=20
+static int reset_metrics_set(void *data, u64 val)
+{
+	struct ceph_fs_client *fsc =3D (struct ceph_fs_client *)data;
+	struct ceph_mds_client *mdsc =3D fsc->mdsc;
+	struct ceph_client_metric *metric =3D &mdsc->metric;
+	int i;
+
+	if (val !=3D 1) {
+		pr_err("Invalid reset metrics set value %llu\n", val);
+		return -EINVAL;
+	}
+
+	percpu_counter_set(&metric->d_lease_hit, 0);
+	percpu_counter_set(&metric->d_lease_mis, 0);
+
+	spin_lock(&metric->read_lock);
+	memset(&metric->read_latency_sum, 0, sizeof(struct timespec64));
+	atomic64_set(&metric->total_reads, 0),
+	spin_unlock(&metric->read_lock);
+
+	spin_lock(&metric->write_lock);
+	memset(&metric->write_latency_sum, 0, sizeof(struct timespec64));
+	atomic64_set(&metric->total_writes, 0),
+	spin_unlock(&metric->write_lock);
+
+	spin_lock(&metric->metadata_lock);
+	memset(&metric->metadata_latency_sum, 0, sizeof(struct timespec64));
+	atomic64_set(&metric->total_metadatas, 0),
+	spin_unlock(&metric->metadata_lock);
+
+	mutex_lock(&mdsc->mutex);
+	for (i =3D 0; i < mdsc->max_sessions; i++) {
+		struct ceph_mds_session *session;
+
+		session =3D __ceph_lookup_mds_session(mdsc, i);
+		if (!session)
+			continue;
+		percpu_counter_set(&session->i_caps_hit, 0);
+		percpu_counter_set(&session->i_caps_mis, 0);
+		ceph_put_mds_session(session);
+	}
+
+	mutex_unlock(&mdsc->mutex);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(reset_metrics_fops, NULL, reset_metrics_set, "%l=
lu\n");
+
 static int metric_show(struct seq_file *s, void *p)
 {
 	struct ceph_fs_client *fsc =3D s->private;
@@ -355,6 +404,7 @@ void ceph_fs_debugfs_cleanup(struct ceph_fs_client *f=
sc)
 	debugfs_remove(fsc->debugfs_caps);
 	debugfs_remove(fsc->debugfs_metric);
 	debugfs_remove(fsc->debugfs_sending_metrics);
+	debugfs_remove(fsc->debugfs_reset_metrics);
 	debugfs_remove(fsc->debugfs_mdsc);
 }
=20
@@ -402,6 +452,13 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc=
)
 					    fsc,
 					    &sending_metrics_fops);
=20
+	fsc->debugfs_reset_metrics =3D
+			debugfs_create_file("reset_metrics",
+					    0600,
+					    fsc->client->debugfs_dir,
+					    fsc,
+					    &reset_metrics_fops);
+
 	fsc->debugfs_metric =3D debugfs_create_file("metrics",
 						  0400,
 						  fsc->client->debugfs_dir,
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 9d2a5f1ce418..c2f8baf6043d 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -124,6 +124,7 @@ struct ceph_fs_client {
 	struct dentry *debugfs_bdi;
 	struct dentry *debugfs_mdsc, *debugfs_mdsmap;
 	struct dentry *debugfs_sending_metrics;
+	struct dentry *debugfs_reset_metrics;
 	struct dentry *debugfs_metric;
 	struct dentry *debugfs_mds_sessions;
 #endif
--=20
2.21.0
