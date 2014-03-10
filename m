From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] ceph: update i_max_size even if inode version does not change
Date: Mon, 10 Mar 2014 11:11:56 +0800
Message-ID: <1394421116-7276-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13726 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752831AbaCJDME (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 9 Mar 2014 23:12:04 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

handle following sequence of events:
 - client releases a inode with i_max_size > 0. The release message
   is queued. (is not sent to the auth MDS)
 - a 'lookup' request reply from non-auth MDS returns the same inode.
 - client opens the inode in write mode. The version of inode trace
   in 'open' request reply is equal to the cached inode's version.
 - client requests new max size. The MDS ignores the request because
   it does not affect client's write range

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/inode.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 91d6c9d..1a37ee7 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -659,14 +659,6 @@ static int fill_inode(struct inode *inode,
 			    le32_to_cpu(info->time_warp_seq),
 			    &ctime, &mtime, &atime);
 
-	/* only update max_size on auth cap */
-	if ((info->cap.flags & CEPH_CAP_FLAG_AUTH) &&
-	    ci->i_max_size != le64_to_cpu(info->max_size)) {
-		dout("max_size %lld -> %llu\n", ci->i_max_size,
-		     le64_to_cpu(info->max_size));
-		ci->i_max_size = le64_to_cpu(info->max_size);
-	}
-
 	ci->i_layout = info->layout;
 	inode->i_blkbits = fls(le32_to_cpu(info->layout.fl_stripe_unit)) - 1;
 
@@ -755,6 +747,14 @@ static int fill_inode(struct inode *inode,
 		ci->i_max_offset = 2;
 	}
 no_change:
+	/* only update max_size on auth cap */
+	if ((info->cap.flags & CEPH_CAP_FLAG_AUTH) &&
+	    ci->i_max_size != le64_to_cpu(info->max_size)) {
+		dout("max_size %lld -> %llu\n", ci->i_max_size,
+		     le64_to_cpu(info->max_size));
+		ci->i_max_size = le64_to_cpu(info->max_size);
+	}
+
 	spin_unlock(&ci->i_ceph_lock);
 
 	/* queue truncate if we saw i_size decrease */
-- 
1.8.5.3

