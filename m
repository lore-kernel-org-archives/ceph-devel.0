From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH v3 22/24] fs: ceph: Replace current_fs_time for request stamp
Date: Sat, 25 Jun 2016 14:37:46 -0700
Message-ID: <1466890668-23400-23-git-send-email-deepa.kernel@gmail.com>
References: <1466890668-23400-1-git-send-email-deepa.kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466890668-23400-1-git-send-email-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, tglx@linutronix.de, torvalds@linux-foundation.org, tytso@mit.edu, viro@zeniv.linux.org.uk, y2038@lists.linaro.org, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

The current_fs_time() api is being changed to use vfs
struct inode* as an argument instead of struct super_block*.

Set the new mds client request r_stamp field using
ktime_get_real_ts() instead of using current_fs_time().

Also, since r_stamp is used as mtime on the server, use
timespec_trunc() to truncate the timestamp, using the right
granularity from the superblock.

This api will be transitioned to be y2038 safe along
with vfs.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>
Cc: Sage Weil <sage@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
---
 fs/ceph/mds_client.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 2103b82..c6cae7a 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1697,6 +1697,7 @@ struct ceph_mds_request *
 ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
 {
 	struct ceph_mds_request *req = kzalloc(sizeof(*req), GFP_NOFS);
+	struct timespec ts;
 
 	if (!req)
 		return ERR_PTR(-ENOMEM);
@@ -1715,7 +1716,8 @@ ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
 	init_completion(&req->r_safe_completion);
 	INIT_LIST_HEAD(&req->r_unsafe_item);
 
-	req->r_stamp = current_fs_time(mdsc->fsc->sb);
+	ktime_get_real_ts(&ts);
+	req->r_stamp = timespec_trunc(ts, mdsc->fsc->sb->s_time_gran);
 
 	req->r_op = op;
 	req->r_direct_mode = mode;
-- 
1.9.1
