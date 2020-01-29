From: xiubli@redhat.com
Subject: [PATCH resend v5 10/11] ceph: add reset metrics support
Date: Wed, 29 Jan 2020 03:27:14 -0500
Message-ID: <20200129082715.5285-11-xiubli@redhat.com>
References: <20200129082715.5285-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58127 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726314AbgA2I2Z (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jan 2020 03:28:25 -0500
In-Reply-To: <20200129082715.5285-1-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com, zyan@redhat.com
Cc: sage@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

This will reset the most metric counters, except the cap and dentry
total numbers.

Sometimes we need to discard the old metrics and start to get new
metrics.

URL: https://tracker.ceph.com/issues/43215
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/debugfs.c | 53 +++++++++++++++++++++++++++++++++++++++++++++--
 fs/ceph/super.h   |  1 +
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 8aae7ecea54a..37ca1efa6b27 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -217,6 +217,55 @@ static int metric_show(struct seq_file *s, void *p)
 	return 0;
 }
=20
+static ssize_t metric_store(struct file *file, const char __user *user_b=
uf,
+			    size_t count, loff_t *ppos)
+{
+	struct seq_file *s =3D file->private_data;
+	struct ceph_fs_client *fsc =3D s->private;
+	struct ceph_mds_client *mdsc =3D fsc->mdsc;
+	struct ceph_client_metric *metric =3D &mdsc->metric;
+	char buf[8];
+	int i;
+
+	if (copy_from_user(buf, user_buf, 8))
+		return -EFAULT;
+
+	if (strcmp(buf, "reset")) {
+		pr_err("Invalid set value '%s', only 'reset' is valid\n", buf);
+		return -EINVAL;
+	}
+
+	percpu_counter_set(&metric->d_lease_hit, 0);
+	percpu_counter_set(&metric->d_lease_mis, 0);
+
+	percpu_counter_set(&metric->read_latency_sum, 0);
+	percpu_counter_set(&metric->total_reads, 0);
+
+	percpu_counter_set(&metric->write_latency_sum, 0);
+	percpu_counter_set(&metric->total_writes, 0);
+
+	percpu_counter_set(&metric->metadata_latency_sum, 0);
+	percpu_counter_set(&metric->total_metadatas, 0);
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
+CEPH_DEFINE_RW_FUNC(metric)
+
 static int caps_show_cb(struct inode *inode, struct ceph_cap *cap, void =
*p)
 {
 	struct seq_file *s =3D p;
@@ -313,7 +362,6 @@ static int mds_sessions_show(struct seq_file *s, void=
 *ptr)
=20
 CEPH_DEFINE_SHOW_FUNC(mdsmap_show)
 CEPH_DEFINE_SHOW_FUNC(mdsc_show)
-CEPH_DEFINE_SHOW_FUNC(metric_show)
 CEPH_DEFINE_SHOW_FUNC(caps_show)
 CEPH_DEFINE_SHOW_FUNC(mds_sessions_show)
=20
@@ -349,6 +397,7 @@ void ceph_fs_debugfs_cleanup(struct ceph_fs_client *f=
sc)
 	debugfs_remove(fsc->debugfs_caps);
 	debugfs_remove(fsc->debugfs_metric);
 	debugfs_remove(fsc->debugfs_sending_metrics);
+	debugfs_remove(fsc->debugfs_reset_metrics);
 	debugfs_remove(fsc->debugfs_mdsc);
 }
=20
@@ -400,7 +449,7 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 						  0400,
 						  fsc->client->debugfs_dir,
 						  fsc,
-						  &metric_show_fops);
+						  &metric_fops);
=20
 	fsc->debugfs_caps =3D debugfs_create_file("caps",
 						0400,
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index a91431e9bdf7..d24929f1c4bf 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -129,6 +129,7 @@ struct ceph_fs_client {
 	struct dentry *debugfs_bdi;
 	struct dentry *debugfs_mdsc, *debugfs_mdsmap;
 	struct dentry *debugfs_sending_metrics;
+	struct dentry *debugfs_reset_metrics;
 	struct dentry *debugfs_metric;
 	struct dentry *debugfs_mds_sessions;
 #endif
--=20
2.21.0
