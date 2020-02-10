From: xiubli@redhat.com
Subject: [PATCH v6 8/9] ceph: add reset metrics support
Date: Mon, 10 Feb 2020 00:34:06 -0500
Message-ID: <20200210053407.37237-9-xiubli@redhat.com>
References: <20200210053407.37237-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49472 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726170AbgBJFey (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Feb 2020 00:34:54 -0500
In-Reply-To: <20200210053407.37237-1-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

Sometimes we need to discard the old perf metrics and start to get
new ones. And this will reset the most metric counters, except the
total numbers for caps and dentries.

URL: https://tracker.ceph.com/issues/43215
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/debugfs.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 60f3e307fca1..6e595a37af5d 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -179,6 +179,43 @@ static int metric_show(struct seq_file *s, void *p)
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
+
+	if (copy_from_user(buf, user_buf, 8))
+		return -EFAULT;
+
+	if (strncmp(buf, "reset", strlen("reset"))) {
+		pr_err("Invalid set value '%s', only 'reset' is valid\n", buf);
+		return -EINVAL;
+	}
+
+	percpu_counter_set(&metric->d_lease_hit, 0);
+	percpu_counter_set(&metric->d_lease_mis, 0);
+
+	percpu_counter_set(&metric->i_caps_hit, 0);
+	percpu_counter_set(&metric->i_caps_mis, 0);
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
+	return count;
+}
+
+CEPH_DEFINE_RW_FUNC(metric);
+
 static int caps_show_cb(struct inode *inode, struct ceph_cap *cap, void =
*p)
 {
 	struct seq_file *s =3D p;
@@ -277,7 +314,6 @@ DEFINE_SHOW_ATTRIBUTE(mdsmap);
 DEFINE_SHOW_ATTRIBUTE(mdsc);
 DEFINE_SHOW_ATTRIBUTE(caps);
 DEFINE_SHOW_ATTRIBUTE(mds_sessions);
-DEFINE_SHOW_ATTRIBUTE(metric);
=20
=20
 /*
--=20
2.21.0
