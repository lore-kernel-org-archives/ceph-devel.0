From: Sage Weil <sage@newdream.net>
Subject: [PATCH 16/23] ceph: set dir complete frag after adding capability
Date: Fri, 22 Jul 2011 17:02:55 -0700
Message-ID: <1311379382-9218-17-git-send-email-sage@newdream.net>
References: <1311379382-9218-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44311 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031Ab1GWAFz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jul 2011 20:05:55 -0400
In-Reply-To: <1311379382-9218-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

Curretly ceph_add_cap clears the complete bit if we are newly issued the
FILE_SHARED cap, which is normally the case for a newly issue cap on a new
directory.  That means we clear the just-set bit.  Move the check that sets
the flag to after the cap is added/updated.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/ceph/inode.c |   30 +++++++++++++++++-------------
 1 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index f51e873..2717dc4 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -560,7 +560,8 @@ static int fill_inode(struct inode *inode,
 	struct ceph_mds_reply_inode *info = iinfo->in;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int i;
-	int issued, implemented;
+	int issued = 0, implemented;
+	int updating_inode = 0;
 	struct timespec mtime, atime, ctime;
 	u32 nsplits;
 	struct ceph_buffer *xattr_blob = NULL;
@@ -599,7 +600,8 @@ static int fill_inode(struct inode *inode,
 	if (le64_to_cpu(info->version) > 0 &&
 	    (ci->i_version & ~1) >= le64_to_cpu(info->version))
 		goto no_change;
-
+	
+	updating_inode = 1;
 	issued = __ceph_caps_issued(ci, &implemented);
 	issued |= implemented | __ceph_caps_dirty(ci);
 
@@ -707,17 +709,6 @@ static int fill_inode(struct inode *inode,
 		ci->i_rfiles = le64_to_cpu(info->rfiles);
 		ci->i_rsubdirs = le64_to_cpu(info->rsubdirs);
 		ceph_decode_timespec(&ci->i_rctime, &info->rctime);
-
-		/* set dir completion flag? */
-		if (ci->i_files == 0 && ci->i_subdirs == 0 &&
-		    ceph_snap(inode) == CEPH_NOSNAP &&
-		    (le32_to_cpu(info->cap.caps) & CEPH_CAP_FILE_SHARED) &&
-		    (issued & CEPH_CAP_FILE_EXCL) == 0 &&
-		    (ci->i_ceph_flags & CEPH_I_COMPLETE) == 0) {
-			dout(" marking %p complete (empty)\n", inode);
-			/* ci->i_ceph_flags |= CEPH_I_COMPLETE; */
-			ci->i_max_offset = 2;
-		}
 		break;
 	default:
 		pr_err("fill_inode %llx.%llx BAD mode 0%o\n",
@@ -774,6 +765,19 @@ no_change:
 		__ceph_get_fmode(ci, cap_fmode);
 	}
 
+	/* set dir completion flag? */
+	if (S_ISDIR(inode->i_mode) &&
+	    updating_inode &&                 /* didn't jump to no_change */
+	    ci->i_files == 0 && ci->i_subdirs == 0 &&
+	    ceph_snap(inode) == CEPH_NOSNAP &&
+	    (le32_to_cpu(info->cap.caps) & CEPH_CAP_FILE_SHARED) &&
+	    (issued & CEPH_CAP_FILE_EXCL) == 0 &&
+	    (ci->i_ceph_flags & CEPH_I_COMPLETE) == 0) {
+		dout(" marking %p complete (empty)\n", inode);
+		/* ci->i_ceph_flags |= CEPH_I_COMPLETE; */
+		ci->i_max_offset = 2;
+	}
+
 	/* update delegation info? */
 	if (dirinfo)
 		ceph_fill_dirfrag(inode, dirinfo);
-- 
1.7.0

