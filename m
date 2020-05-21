From: Yanhu Cao <gmayyyha@gmail.com>
Subject: [PATCH] ceph: show max caps in debugfs caps file
Date: Thu, 21 May 2020 17:38:45 +0800
Message-ID: <20200521093845.15101-1-gmayyyha@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jlayton@kernel.org
Cc: idryomov@gmail.com, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Yanhu Cao <gmayyyha@gmail.com>
List-Id: ceph-devel.vger.kernel.org

        before
        ------
        total           1026
        avail           1024
        used            2
        reserved        0
        min             1024

        after
        ------
        total           1026
        avail           1024
        used            2
        max             2048
        reserved        0
        min             1024

Signed-off-by: Yanhu Cao <gmayyyha@gmail.com>
---
 fs/ceph/caps.c    | 6 ++++--
 fs/ceph/debugfs.c | 7 ++++---
 fs/ceph/super.h   | 2 +-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 5f3aa4d607de..e2c759a2ef35 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -404,8 +404,8 @@ void ceph_put_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap)
 }
 
 void ceph_reservation_status(struct ceph_fs_client *fsc,
-			     int *total, int *avail, int *used, int *reserved,
-			     int *min)
+			     int *total, int *avail, int *used, int *max,
+			     int *reserved, int *min)
 {
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 
@@ -417,6 +417,8 @@ void ceph_reservation_status(struct ceph_fs_client *fsc,
 		*avail = mdsc->caps_avail_count;
 	if (used)
 		*used = mdsc->caps_use_count;
+	if (max)
+		*max = mdsc->caps_use_max;
 	if (reserved)
 		*reserved = mdsc->caps_reserve_count;
 	if (min)
diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 481ac97b4d25..942004376588 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -138,16 +138,17 @@ static int caps_show(struct seq_file *s, void *p)
 {
 	struct ceph_fs_client *fsc = s->private;
 	struct ceph_mds_client *mdsc = fsc->mdsc;
-	int total, avail, used, reserved, min, i;
+	int total, avail, used, max, reserved, min, i;
 	struct cap_wait	*cw;
 
-	ceph_reservation_status(fsc, &total, &avail, &used, &reserved, &min);
+	ceph_reservation_status(fsc, &total, &avail, &used, &max,
+				&reserved, &min);
 	seq_printf(s, "total\t\t%d\n"
 		   "avail\t\t%d\n"
 		   "used\t\t%d\n"
 		   "reserved\t%d\n"
 		   "min\t\t%d\n\n",
-		   total, avail, used, reserved, min);
+		   total, avail, used, max, reserved, min);
 	seq_printf(s, "ino                issued           implemented\n");
 	seq_printf(s, "-----------------------------------------------\n");
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 60aac3aee055..79aa42d9336c 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -700,7 +700,7 @@ extern void ceph_unreserve_caps(struct ceph_mds_client *mdsc,
 			       struct ceph_cap_reservation *ctx);
 extern void ceph_reservation_status(struct ceph_fs_client *client,
 				    int *total, int *avail, int *used,
-				    int *reserved, int *min);
+				    int *max, int *reserved, int *min);
 
 
 
-- 
2.24.2 (Apple Git-127)
