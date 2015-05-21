From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4/5] ceph: simplify two mount_timeout sites
Date: Thu, 21 May 2015 15:35:05 +0300
Message-ID: <1432211706-10473-5-git-send-email-idryomov@gmail.com>
References: <1432211706-10473-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:35585 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755284AbbEUMff (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 08:35:35 -0400
Received: by wgfl8 with SMTP id l8so84172652wgf.2
        for <ceph-devel@vger.kernel.org>; Thu, 21 May 2015 05:35:34 -0700 (PDT)
In-Reply-To: <1432211706-10473-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Zheng Yan <zyan@redhat.com>

No need to bifurcate wait now that we've got ceph_timeout_jiffies().

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 fs/ceph/dir.c        | 14 ++++----------
 fs/ceph/mds_client.c | 18 ++++++++++--------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 173dd4b58c71..3dec27e36417 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1257,17 +1257,11 @@ static int ceph_dir_fsync(struct file *file, loff_t start, loff_t end,
 
 		dout("dir_fsync %p wait on tid %llu (until %llu)\n",
 		     inode, req->r_tid, last_tid);
-		if (req->r_timeout) {
-			unsigned long time_left = wait_for_completion_timeout(
-					&req->r_safe_completion,
+		ret = !wait_for_completion_timeout(&req->r_safe_completion,
 					ceph_timeout_jiffies(req->r_timeout));
-			if (time_left > 0)
-				ret = 0;
-			else
-				ret = -EIO;  /* timed out */
-		} else {
-			wait_for_completion(&req->r_safe_completion);
-		}
+		if (ret)
+			ret = -EIO;  /* timed out */
+
 		ceph_mdsc_put_request(req);
 
 		spin_lock(&ci->i_unsafe_lock);
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 0b0e0a9a81c0..5be2d287a26c 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2266,16 +2266,18 @@ int ceph_mdsc_do_request(struct ceph_mds_client *mdsc,
 	/* wait */
 	mutex_unlock(&mdsc->mutex);
 	dout("do_request waiting\n");
-	if (req->r_timeout) {
-		err = (long)wait_for_completion_killable_timeout(
-					&req->r_completion,
-					ceph_timeout_jiffies(req->r_timeout));
-		if (err == 0)
-			err = -EIO;
-	} else if (req->r_wait_for_completion) {
+	if (!req->r_timeout && req->r_wait_for_completion) {
 		err = req->r_wait_for_completion(mdsc, req);
 	} else {
-		err = wait_for_completion_killable(&req->r_completion);
+		long timeleft = wait_for_completion_killable_timeout(
+					&req->r_completion,
+					ceph_timeout_jiffies(req->r_timeout));
+		if (timeleft > 0)
+			err = 0;
+		else if (!timeleft)
+			err = -EIO;  /* timed out */
+		else
+			err = timeleft;  /* killed */
 	}
 	dout("do_request waited, got %d\n", err);
 	mutex_lock(&mdsc->mutex);
-- 
1.9.3

