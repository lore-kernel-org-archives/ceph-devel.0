From: Wu Bo <wubo40@huawei.com>
Subject: [PATCH] fs/ceph:fix double unlock in handle_cap_export()
Date: Tue, 28 Apr 2020 20:46:02 +0800
Message-ID: <1588077962-353994-1-git-send-email-wubo40@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jlayton@kernel.org, sage@redhat.com, idryomov@gmail.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com, linfeilong@huawei.com, wubo40@huawei.com
List-Id: ceph-devel.vger.kernel.org

If the ceph_mdsc_open_export_target_session() return fails,
should add a lock to avoid twice unlocking.
Because the lock will be released at the retry or out_unlock tag. 

Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 fs/ceph/caps.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 185db76..b5a62a8 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3731,22 +3731,24 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 
 	/* open target session */
 	tsession = ceph_mdsc_open_export_target_session(mdsc, target);
-	if (!IS_ERR(tsession)) {
-		if (mds > target) {
-			mutex_lock(&session->s_mutex);
-			mutex_lock_nested(&tsession->s_mutex,
-					  SINGLE_DEPTH_NESTING);
-		} else {
-			mutex_lock(&tsession->s_mutex);
-			mutex_lock_nested(&session->s_mutex,
-					  SINGLE_DEPTH_NESTING);
-		}
-		new_cap = ceph_get_cap(mdsc, NULL);
-	} else {
+	if (IS_ERR(tsession)) {
 		WARN_ON(1);
 		tsession = NULL;
 		target = -1;
+		mutex_lock(&session->s_mutex);
+		goto out_unlock;
+	}
+
+	if (mds > target) {
+		mutex_lock(&session->s_mutex);
+		mutex_lock_nested(&tsession->s_mutex,
+					SINGLE_DEPTH_NESTING);
+	} else {
+		mutex_lock(&tsession->s_mutex);
+		mutex_lock_nested(&session->s_mutex,
+					SINGLE_DEPTH_NESTING);
 	}
+	new_cap = ceph_get_cap(mdsc, NULL);
 	goto retry;
 
 out_unlock:
-- 
1.8.3.1
