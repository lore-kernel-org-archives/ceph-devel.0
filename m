From: Seraphime Kirkovski <kirkseraph@gmail.com>
Subject: [PATCH] ceph: cleanup ACCESS_ONCE -> READ_ONCE
Date: Mon, 26 Dec 2016 10:26:34 +0100
Message-ID: <20161226092634.8206-1-kirkseraph@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:33756 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbcLZJ0q (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Dec 2016 04:26:46 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: ceph-devel@vger.kernel.org, zyan@redhat.com, Seraphime Kirkovski <kirkseraph@gmail.com>

This removes the uses of ACCESS_ONCE in favor of READ_ONCE

Signed-off-by: Seraphime Kirkovski <kirkseraph@gmail.com>
---
 fs/ceph/addr.c       |  4 ++--
 fs/ceph/caps.c       |  2 +-
 fs/ceph/dir.c        |  2 +-
 fs/ceph/inode.c      |  2 +-
 fs/ceph/mds_client.c | 10 +++++-----
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 9cd0c0e..e61bc3f 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -771,7 +771,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 	     wbc->sync_mode == WB_SYNC_NONE ? "NONE" :
 	     (wbc->sync_mode == WB_SYNC_ALL ? "ALL" : "HOLD"));
 
-	if (ACCESS_ONCE(fsc->mount_state) == CEPH_MOUNT_SHUTDOWN) {
+	if (READ_ONCE(fsc->mount_state) == CEPH_MOUNT_SHUTDOWN) {
 		if (ci->i_wrbuffer_ref > 0) {
 			pr_warn_ratelimited(
 				"writepage_start %p %lld forced umount\n",
@@ -1194,7 +1194,7 @@ static int ceph_update_writeable_page(struct file *file,
 	int r;
 	struct ceph_snap_context *snapc, *oldest;
 
-	if (ACCESS_ONCE(fsc->mount_state) == CEPH_MOUNT_SHUTDOWN) {
+	if (READ_ONCE(fsc->mount_state) == CEPH_MOUNT_SHUTDOWN) {
 		dout(" page %p forced umount\n", page);
 		unlock_page(page);
 		return -EIO;
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index baea866..193ba82 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2477,7 +2477,7 @@ static int try_get_cap_refs(struct ceph_inode_info *ci, int need, int want,
 
 		if (ci->i_ceph_flags & CEPH_I_CAP_DROPPED) {
 			int mds_wanted;
-			if (ACCESS_ONCE(mdsc->fsc->mount_state) ==
+			if (READ_ONCE(mdsc->fsc->mount_state) ==
 			    CEPH_MOUNT_SHUTDOWN) {
 				dout("get_cap_refs %p forced umount\n", inode);
 				*err = -EIO;
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index d7a9369..cd99b26 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1194,7 +1194,7 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 	struct inode *dir;
 
 	if (flags & LOOKUP_RCU) {
-		parent = ACCESS_ONCE(dentry->d_parent);
+		parent = READ_ONCE(dentry->d_parent);
 		dir = d_inode_rcu(parent);
 		if (!dir)
 			return -ECHILD;
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 398e532..1476f54 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1719,7 +1719,7 @@ static void ceph_invalidate_work(struct work_struct *work)
 
 	mutex_lock(&ci->i_truncate_mutex);
 
-	if (ACCESS_ONCE(fsc->mount_state) == CEPH_MOUNT_SHUTDOWN) {
+	if (READ_ONCE(fsc->mount_state) == CEPH_MOUNT_SHUTDOWN) {
 		pr_warn_ratelimited("invalidate_pages %p %lld forced umount\n",
 				    inode, ceph_ino(inode));
 		mapping_set_error(inode->i_mapping, -EIO);
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 4f49253..df90794 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1145,7 +1145,7 @@ static int remove_session_caps_cb(struct inode *inode, struct ceph_cap *cap,
 		ci->i_ceph_flags |= CEPH_I_CAP_DROPPED;
 
 		if (ci->i_wrbuffer_ref > 0 &&
-		    ACCESS_ONCE(fsc->mount_state) == CEPH_MOUNT_SHUTDOWN)
+		    READ_ONCE(fsc->mount_state) == CEPH_MOUNT_SHUTDOWN)
 			invalidate = true;
 
 		while (!list_empty(&ci->i_cap_flush_list)) {
@@ -2095,12 +2095,12 @@ static int __do_request(struct ceph_mds_client *mdsc,
 		err = -EIO;
 		goto finish;
 	}
-	if (ACCESS_ONCE(mdsc->fsc->mount_state) == CEPH_MOUNT_SHUTDOWN) {
+	if (READ_ONCE(mdsc->fsc->mount_state) == CEPH_MOUNT_SHUTDOWN) {
 		dout("do_request forced umount\n");
 		err = -EIO;
 		goto finish;
 	}
-	if (ACCESS_ONCE(mdsc->fsc->mount_state) == CEPH_MOUNT_MOUNTING) {
+	if (READ_ONCE(mdsc->fsc->mount_state) == CEPH_MOUNT_MOUNTING) {
 		if (mdsc->mdsmap_err) {
 			err = mdsc->mdsmap_err;
 			dout("do_request mdsmap err %d\n", err);
@@ -3550,7 +3550,7 @@ void ceph_mdsc_sync(struct ceph_mds_client *mdsc)
 {
 	u64 want_tid, want_flush;
 
-	if (ACCESS_ONCE(mdsc->fsc->mount_state) == CEPH_MOUNT_SHUTDOWN)
+	if (READ_ONCE(mdsc->fsc->mount_state) == CEPH_MOUNT_SHUTDOWN)
 		return;
 
 	dout("sync\n");
@@ -3581,7 +3581,7 @@ void ceph_mdsc_sync(struct ceph_mds_client *mdsc)
  */
 static bool done_closing_sessions(struct ceph_mds_client *mdsc, int skipped)
 {
-	if (ACCESS_ONCE(mdsc->fsc->mount_state) == CEPH_MOUNT_SHUTDOWN)
+	if (READ_ONCE(mdsc->fsc->mount_state) == CEPH_MOUNT_SHUTDOWN)
 		return true;
 	return atomic_read(&mdsc->num_sessions) <= skipped;
 }
-- 
2.10.2

