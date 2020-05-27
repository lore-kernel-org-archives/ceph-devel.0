From: xiubli@redhat.com
Subject: [PATCH] ceph: always try to flush the snaps in ceph_check_caps
Date: Tue, 26 May 2020 23:34:30 -0400
Message-ID: <1590550470-31278-1-git-send-email-xiubli@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48773 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725893AbgE0Dek (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 26 May 2020 23:34:40 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com, zyan@redhat.com
Cc: pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

The ceph_flush_snaps() will never have a change to be called and
we can do it in the ceph_check_caps().

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/caps.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 27c2e60..62a066e 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3019,7 +3019,7 @@ static int ceph_try_drop_cap_snap(struct ceph_inode_info *ci,
 void ceph_put_cap_refs(struct ceph_inode_info *ci, int had)
 {
 	struct inode *inode = &ci->vfs_inode;
-	int last = 0, put = 0, flushsnaps = 0, wake = 0;
+	int last = 0, put = 0, wake = 0;
 
 	spin_lock(&ci->i_ceph_lock);
 	if (had & CEPH_CAP_PIN)
@@ -3052,8 +3052,8 @@ void ceph_put_cap_refs(struct ceph_inode_info *ci, int had)
 				capsnap->writing = 0;
 				if (ceph_try_drop_cap_snap(ci, capsnap))
 					put++;
-				else if (__ceph_finish_cap_snap(ci, capsnap))
-					flushsnaps = 1;
+				else
+				       __ceph_finish_cap_snap(ci, capsnap);
 				wake = 1;
 			}
 			if (ci->i_wrbuffer_ref_head == 0 &&
@@ -3074,8 +3074,6 @@ void ceph_put_cap_refs(struct ceph_inode_info *ci, int had)
 
 	if (last)
 		ceph_check_caps(ci, 0, NULL);
-	else if (flushsnaps)
-		ceph_flush_snaps(ci, NULL);
 	if (wake)
 		wake_up_all(&ci->i_cap_wq);
 	while (put-- > 0)
-- 
1.8.3.1
