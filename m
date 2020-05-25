From: Yanhu Cao <gmayyyha@gmail.com>
Subject: [v2] ceph: show max caps in debugfs caps file
Date: Mon, 25 May 2020 10:50:49 +0800
Message-ID: <20200525025049.4292-1-gmayyyha@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jlayton@kernel.org
Cc: idryomov@gmail.com, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Yanhu Cao <gmayyyha@gmail.com>, Yanhu Cao <jrcaoyanhu@jd.com>, kbuild test robot <lkp@intel.com>
List-Id: ceph-devel.vger.kernel.org

before
------
total		1286
avail		1005
used		281
reserved	0
min		1024

after
-----
total		1286
avail		1005
used		281
limit		261
reserved	0
min		1024

Signed-off-by: Yanhu Cao <gmayyyha@gmail.com>
Signed-off-by: Yanhu Cao <jrcaoyanhu@jd.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 fs/ceph/caps.c       | 6 ++++--
 fs/ceph/debugfs.c    | 8 +++++---
 fs/ceph/mds_client.c | 1 +
 fs/ceph/mds_client.h | 4 +++-
 fs/ceph/super.h      | 2 +-
 5 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 5f3aa4d607de..17191d6cd3b5 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -404,8 +404,8 @@ void ceph_put_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap)
 }
 
 void ceph_reservation_status(struct ceph_fs_client *fsc,
-			     int *total, int *avail, int *used, int *reserved,
-			     int *min)
+			     int *total, int *avail, int *used, int *limit,
+			     int *reserved, int *min)
 {
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 
@@ -417,6 +417,8 @@ void ceph_reservation_status(struct ceph_fs_client *fsc,
 		*avail = mdsc->caps_avail_count;
 	if (used)
 		*used = mdsc->caps_use_count;
+	if (limit)
+		*limit = mdsc->caps_limit;
 	if (reserved)
 		*reserved = mdsc->caps_reserve_count;
 	if (min)
diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 481ac97b4d25..617020261902 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -138,16 +138,18 @@ static int caps_show(struct seq_file *s, void *p)
 {
 	struct ceph_fs_client *fsc = s->private;
 	struct ceph_mds_client *mdsc = fsc->mdsc;
-	int total, avail, used, reserved, min, i;
+	int total, avail, used, limit, reserved, min, i;
 	struct cap_wait	*cw;
 
-	ceph_reservation_status(fsc, &total, &avail, &used, &reserved, &min);
+	ceph_reservation_status(fsc, &total, &avail, &used,
+				&limit, &reserved, &min);
 	seq_printf(s, "total\t\t%d\n"
 		   "avail\t\t%d\n"
 		   "used\t\t%d\n"
+		   "limit\t\t%d\n"
 		   "reserved\t%d\n"
 		   "min\t\t%d\n\n",
-		   total, avail, used, reserved, min);
+		   total, avail, used, limit, reserved, min);
 	seq_printf(s, "ino                issued           implemented\n");
 	seq_printf(s, "-----------------------------------------------\n");
 
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 7c63abf5bea9..d26bc065f5f5 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1920,6 +1920,7 @@ int ceph_trim_caps(struct ceph_mds_client *mdsc,
 		   int max_caps)
 {
 	int trim_caps = session->s_nr_caps - max_caps;
+	mdsc->caps_limit = max_caps;
 
 	dout("trim_caps mds%d start: %d / %d, trim %d\n",
 	     session->s_mds, session->s_nr_caps, max_caps, trim_caps);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 903d9edfd4bf..840d47976dbb 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -445,7 +445,9 @@ struct ceph_mds_client {
 	struct		list_head cap_wait_list;
 	int		caps_total_count;    /* total caps allocated */
 	int		caps_use_count;      /* in use */
-	int		caps_use_max;	     /* max used caps */
+	int		caps_use_max;	     /* max used caps,
+						limited by client */
+	int		caps_limit;          /* limited by mds */
 	int		caps_reserve_count;  /* unused, reserved */
 	int		caps_avail_count;    /* unused, unreserved */
 	int		caps_min_count;      /* keep at least this many
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 60aac3aee055..052d7725761d 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -700,7 +700,7 @@ extern void ceph_unreserve_caps(struct ceph_mds_client *mdsc,
 			       struct ceph_cap_reservation *ctx);
 extern void ceph_reservation_status(struct ceph_fs_client *client,
 				    int *total, int *avail, int *used,
-				    int *reserved, int *min);
+				    int *limit, int *reserved, int *min);
 
 
 
-- 
2.24.3 (Apple Git-128)
