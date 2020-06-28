From: xiubli@redhat.com
Subject: [PATCH v4 2/5] ceph: add global total_caps to count the mdsc's total caps number
Date: Sun, 28 Jun 2020 04:42:11 -0400
Message-ID: <1593333734-27480-3-git-send-email-xiubli@redhat.com>
References: <1593333734-27480-1-git-send-email-xiubli@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43546 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726105AbgF1Ime (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 28 Jun 2020 04:42:34 -0400
In-Reply-To: <1593333734-27480-1-git-send-email-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com
Cc: zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

This will help to reduce using the global mdsc->metux lock in many
places.

URL: https://tracker.ceph.com/issues/43215
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/caps.c       |  2 ++
 fs/ceph/debugfs.c    | 14 ++------------
 fs/ceph/mds_client.c |  1 +
 fs/ceph/metric.c     |  1 +
 fs/ceph/metric.h     |  1 +
 5 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 972c13a..5f48940 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -668,6 +668,7 @@ void ceph_add_cap(struct inode *inode,
 		spin_lock(&session->s_cap_lock);
 		list_add_tail(&cap->session_caps, &session->s_caps);
 		session->s_nr_caps++;
+		atomic64_inc(&mdsc->metric.total_caps);
 		spin_unlock(&session->s_cap_lock);
 	} else {
 		spin_lock(&session->s_cap_lock);
@@ -1161,6 +1162,7 @@ void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 	} else {
 		list_del_init(&cap->session_caps);
 		session->s_nr_caps--;
+		atomic64_dec(&mdsc->metric.total_caps);
 		cap->session = NULL;
 		removed = 1;
 	}
diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 070ed84..3030f55 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -145,7 +145,7 @@ static int metric_show(struct seq_file *s, void *p)
 	struct ceph_fs_client *fsc = s->private;
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_client_metric *m = &mdsc->metric;
-	int i, nr_caps = 0;
+	int nr_caps = 0;
 	s64 total, sum, avg, min, max, sq;
 
 	seq_printf(s, "item          total       avg_lat(us)     min_lat(us)     max_lat(us)     stdev(us)\n");
@@ -190,17 +190,7 @@ static int metric_show(struct seq_file *s, void *p)
 		   percpu_counter_sum(&m->d_lease_mis),
 		   percpu_counter_sum(&m->d_lease_hit));
 
-	mutex_lock(&mdsc->mutex);
-	for (i = 0; i < mdsc->max_sessions; i++) {
-		struct ceph_mds_session *s;
-
-		s = __ceph_lookup_mds_session(mdsc, i);
-		if (!s)
-			continue;
-		nr_caps += s->s_nr_caps;
-		ceph_put_mds_session(s);
-	}
-	mutex_unlock(&mdsc->mutex);
+	nr_caps = atomic64_read(&m->total_caps);
 	seq_printf(s, "%-14s%-16d%-16lld%lld\n", "caps", nr_caps,
 		   percpu_counter_sum(&m->i_caps_mis),
 		   percpu_counter_sum(&m->i_caps_hit));
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 608fb5c..2eeab10 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1485,6 +1485,7 @@ int ceph_iterate_session_caps(struct ceph_mds_session *session,
 			cap->session = NULL;
 			list_del_init(&cap->session_caps);
 			session->s_nr_caps--;
+			atomic64_dec(&session->s_mdsc->metric.total_caps);
 			if (cap->queue_release)
 				__ceph_queue_cap_release(session, cap);
 			else
diff --git a/fs/ceph/metric.c b/fs/ceph/metric.c
index 9217f35..269eacb 100644
--- a/fs/ceph/metric.c
+++ b/fs/ceph/metric.c
@@ -22,6 +22,7 @@ int ceph_metric_init(struct ceph_client_metric *m)
 	if (ret)
 		goto err_d_lease_mis;
 
+	atomic64_set(&m->total_caps, 0);
 	ret = percpu_counter_init(&m->i_caps_hit, 0, GFP_KERNEL);
 	if (ret)
 		goto err_i_caps_hit;
diff --git a/fs/ceph/metric.h b/fs/ceph/metric.h
index ccd8128..23a3373 100644
--- a/fs/ceph/metric.h
+++ b/fs/ceph/metric.h
@@ -12,6 +12,7 @@ struct ceph_client_metric {
 	struct percpu_counter d_lease_hit;
 	struct percpu_counter d_lease_mis;
 
+	atomic64_t            total_caps;
 	struct percpu_counter i_caps_hit;
 	struct percpu_counter i_caps_mis;
 
-- 
1.8.3.1
