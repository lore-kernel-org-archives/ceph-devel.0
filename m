From: Jeff Layton <jlayton@redhat.com>
Subject: [RFC PATCH 04/10] ceph: save off btime and change_attr when we get an InodeStat
Date: Fri,  4 Nov 2016 07:34:27 -0400
Message-ID: <1478259273-3471-5-git-send-email-jlayton@redhat.com>
References: <1478259273-3471-1-git-send-email-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761368AbcKDLei (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 4 Nov 2016 07:34:38 -0400
In-Reply-To: <1478259273-3471-1-git-send-email-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com

Needed so we can send the proper values in cap flushes.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/inode.c                    |  9 ++++++++-
 fs/ceph/mds_client.c               | 10 ++++++++++
 fs/ceph/mds_client.h               |  2 ++
 fs/ceph/super.h                    |  2 ++
 include/linux/ceph/ceph_features.h |  2 ++
 5 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index f03dc579e0ec..f7a3ec6d7152 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -436,6 +436,9 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	ci->i_inline_version = 0;
 	ci->i_time_warp_seq = 0;
 	ci->i_ceph_flags = 0;
+
+	memset(&ci->i_btime, 0, sizeof(ci->i_btime));
+
 	atomic64_set(&ci->i_ordered_count, 1);
 	atomic64_set(&ci->i_release_count, 1);
 	atomic64_set(&ci->i_complete_seq[0], 0);
@@ -798,7 +801,10 @@ static int fill_inode(struct inode *inode, struct page *locked_page,
 
 	/* update inode */
 	ci->i_version = le64_to_cpu(info->version);
-	inode->i_version++;
+
+	/* Always take a larger change attr */
+	inode->i_version = max(inode->i_version, iinfo->change_attr);
+
 	inode->i_rdev = le32_to_cpu(info->rdev);
 	inode->i_blkbits = fls(le32_to_cpu(info->layout.fl_stripe_unit)) - 1;
 
@@ -807,6 +813,7 @@ static int fill_inode(struct inode *inode, struct page *locked_page,
 		inode->i_mode = le32_to_cpu(info->mode);
 		inode->i_uid = make_kuid(&init_user_ns, le32_to_cpu(info->uid));
 		inode->i_gid = make_kgid(&init_user_ns, le32_to_cpu(info->gid));
+		ci->i_btime = iinfo->btime;
 		dout("%p mode 0%o uid.gid %d.%d\n", inode, inode->i_mode,
 		     from_kuid(&init_user_ns, inode->i_uid),
 		     from_kgid(&init_user_ns, inode->i_gid));
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 815acd1a56d4..7217404f0f7c 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -111,6 +111,16 @@ static int parse_reply_info_in(void **p, void *end,
 		}
 	}
 
+	if (features & CEPH_FEATURE_FS_BTIME) {
+		ceph_decode_need(p, end, sizeof(struct ceph_timespec), bad);
+		ceph_decode_timespec(&info->btime, *p);
+		*p += sizeof(struct ceph_timespec);
+		ceph_decode_64_safe(p, end, info->change_attr, bad);
+	} else {
+		memset(&info->btime, 0, sizeof(info->btime));
+		info->change_attr = 0;
+	}
+
 	return 0;
 bad:
 	return err;
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 3c6f77b7bb02..e217a3dd3f19 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -46,6 +46,8 @@ struct ceph_mds_reply_info_in {
 	char *inline_data;
 	u32 pool_ns_len;
 	char *pool_ns_data;
+	struct timespec btime;
+	u64 change_attr;
 };
 
 struct ceph_mds_reply_dir_entry {
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 3e3fa9163059..244fd8dbff31 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -288,6 +288,8 @@ struct ceph_inode_info {
 	struct ceph_file_layout i_layout;
 	char *i_symlink;
 
+	struct timespec i_btime;
+
 	/* for dirs */
 	struct timespec i_rctime;
 	u64 i_rbytes, i_rfiles, i_rsubdirs;
diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
index ae2f66833762..95b174a676d5 100644
--- a/include/linux/ceph/ceph_features.h
+++ b/include/linux/ceph/ceph_features.h
@@ -76,6 +76,8 @@
 // duplicated since it was introduced at the same time as CEPH_FEATURE_CRUSH_TUNABLES5
 #define CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING   (1ULL<<58) /* New, v7 encoding */
 #define CEPH_FEATURE_FS_FILE_LAYOUT_V2       (1ULL<<58) /* file_layout_t */
+#define CEPH_FEATURE_FS_BTIME			(1ULL<<59) /* btime */
+#define CEPH_FEATURE_FS_CHANGE_ATTR		(1ULL<<59) /* change_attr */
 
 /*
  * The introduction of CEPH_FEATURE_OSD_SNAPMAPPER caused the feature
-- 
2.7.4

