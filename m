From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH] ceph: avoid accessing freeing inode in ceph_check_delayed_caps()
Date: Tue, 27 Jun 2017 21:43:44 +0800
Message-ID: <20170627134344.80072-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752998AbdF0Nnf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 27 Jun 2017 09:43:35 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6CE357F3FF
        for <ceph-devel@vger.kernel.org>; Tue, 27 Jun 2017 13:43:34 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@redhat.com, "Yan, Zheng" <zyan@redhat.com>

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/caps.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index f555245..7007ae2 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3809,6 +3809,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
  */
 void ceph_check_delayed_caps(struct ceph_mds_client *mdsc)
 {
+	struct inode *inode;
 	struct ceph_inode_info *ci;
 	int flags = CHECK_CAPS_NODELAY;
 
@@ -3824,9 +3825,15 @@ void ceph_check_delayed_caps(struct ceph_mds_client *mdsc)
 		    time_before(jiffies, ci->i_hold_caps_max))
 			break;
 		list_del_init(&ci->i_cap_delay_list);
+
+		inode = igrab(&ci->vfs_inode);
 		spin_unlock(&mdsc->cap_delay_lock);
-		dout("check_delayed_caps on %p\n", &ci->vfs_inode);
-		ceph_check_caps(ci, flags, NULL);
+
+		if (inode) {
+			dout("check_delayed_caps on %p\n", inode);
+			ceph_check_caps(ci, flags, NULL);
+			iput(inode);
+		}
 	}
 	spin_unlock(&mdsc->cap_delay_lock);
 }
-- 
2.9.4

