From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] ceph: reorganize fields in ceph_mds_request
Date: Tue, 18 Feb 2020 09:11:08 -0500
Message-ID: <20200218141108.26421-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbgBROLK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:11:10 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, sage@redhat.com, zyan@redhat.com

This shrinks the struct size by 16 bytes.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/mds_client.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 27a7446e10d3..a0918d00117c 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -263,6 +263,7 @@ struct ceph_mds_request {
 	int r_fmode;        /* file mode, if expecting cap */
 	kuid_t r_uid;
 	kgid_t r_gid;
+	int r_request_release_offset;
 	struct timespec64 r_stamp;
 
 	/* for choosing which mds to send this request to */
@@ -280,11 +281,12 @@ struct ceph_mds_request {
 	int r_old_inode_drop, r_old_inode_unless;
 
 	struct ceph_msg  *r_request;  /* original request */
-	int r_request_release_offset;
 	struct ceph_msg  *r_reply;
 	struct ceph_mds_reply_info_parsed r_reply_info;
 	struct page *r_locked_page;
 	int r_err;
+	int r_num_caps;
+	u32               r_readdir_offset;
 
 	unsigned long r_timeout;  /* optional.  jiffies, 0 is "wait forever" */
 	unsigned long r_started;  /* start time to measure timeout against */
@@ -315,10 +317,8 @@ struct ceph_mds_request {
 	long long	  r_dir_release_cnt;
 	long long	  r_dir_ordered_cnt;
 	int		  r_readdir_cache_idx;
-	u32               r_readdir_offset;
 
 	struct ceph_cap_reservation r_caps_reservation;
-	int r_num_caps;
 };
 
 struct ceph_pool_perm {
-- 
2.24.1
