From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH] ceph: fix freeing inode vs removing session caps race
Date: Wed, 24 Jul 2013 14:38:23 +0800
Message-ID: <51EF765F.3000800@intel.com>
References: <1374644894-9817-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:56821 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800Ab3GXGiZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 24 Jul 2013 02:38:25 -0400
In-Reply-To: <1374644894-9817-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com

previous patch is buggy, please ignore it. here is updated version.

---
From dfe2517bcb40046dbd0c8993558fc3e083d028d5 Mon Sep 17 00:00:00 2001
From: "Yan, Zheng" <zheng.z.yan@intel.com>
Date: Wed, 24 Jul 2013 12:22:11 +0800
Subject: [PATCH] ceph: fix freeing inode vs removing session caps race

remove_session_caps() uses iterate_session_caps() to remove caps,
but iterate_session_caps() skips inodes that are being deleted.
So session->s_nr_caps can be non-zero after iterate_session_caps()
return.

We can fix the issue by waiting until deletions are complete.
__wait_on_freeing_inode() is designed for the job, but it is not
exported, so we use lookup inode function to access it.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/inode.c      |  8 ++++++++
 fs/ceph/mds_client.c | 31 +++++++++++++++++++++++++++++++
 fs/ceph/super.h      |  2 ++
 3 files changed, 41 insertions(+)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 5437e76..de839f4 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -61,6 +61,14 @@ struct inode *ceph_get_inode(struct super_block *sb, struct ceph_vino vino)
 	return inode;
 }
 
+struct inode *ceph_lookup_inode(struct super_block *sb, struct ceph_vino vino)
+{
+	struct inode *inode;
+	ino_t t = ceph_vino_to_ino(vino);
+	inode = ilookup5_nowait(sb, t, ceph_ino_compare, &vino);
+	return inode;
+}
+
 /*
  * get/constuct snapdir inode for a given directory
  */
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 3eb1b44..40e9856 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1028,6 +1028,37 @@ static void remove_session_caps(struct ceph_mds_session *session)
 {
 	dout("remove_session_caps on %p\n", session);
 	iterate_session_caps(session, remove_session_caps_cb, NULL);
+
+	spin_lock(&session->s_cap_lock);
+	if (session->s_nr_caps > 0) {
+		struct super_block *sb = session->s_mdsc->fsc->sb;
+		struct inode *inode;
+		struct ceph_cap *cap, *prev = NULL;
+		struct ceph_vino vino;
+		/*
+		 * iterate_session_caps() skips inodes that are being
+		 * deleted, we need to wait until deletions are complete.
+		 * __wait_on_freeing_inode() is designed for the job,
+		 * but it is not exported, so use lookup inode function
+		 * to access it.
+		 */
+		while (!list_empty(&session->s_caps)) {
+			cap = list_entry(session->s_caps.next,
+					 struct ceph_cap, session_caps);
+			if (cap == prev)
+				break;
+			prev = cap;
+			vino = cap->ci->i_vino;
+			spin_unlock(&session->s_cap_lock);
+
+			inode = ceph_lookup_inode(sb, vino);
+			iput(inode);
+
+			spin_lock(&session->s_cap_lock);
+		}
+	}
+	spin_unlock(&session->s_cap_lock);
+
 	BUG_ON(session->s_nr_caps > 0);
 	BUG_ON(!list_empty(&session->s_cap_flushing));
 	cleanup_cap_releases(session);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index e81c0b6..f1e4e47 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -678,6 +678,8 @@ extern void ceph_destroy_inode(struct inode *inode);
 
 extern struct inode *ceph_get_inode(struct super_block *sb,
 				    struct ceph_vino vino);
+extern struct inode *ceph_lookup_inode(struct super_block *sb,
+				       struct ceph_vino vino);
 extern struct inode *ceph_get_snapdir(struct inode *parent);
 extern int ceph_fill_file_size(struct inode *inode, int issued,
 			       u32 truncate_seq, u64 truncate_size, u64 size);
-- 
1.8.1.4

