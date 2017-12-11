From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH] ceph: don't set st_dev to 0 for stat(2)
Date: Mon, 11 Dec 2017 16:47:58 +0800
Message-ID: <20171211084758.3225-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751307AbdLKIsE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 11 Dec 2017 03:48:04 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D1318C00F7F5
        for <ceph-devel@vger.kernel.org>; Mon, 11 Dec 2017 08:48:04 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@redhat.com, "Yan, Zheng" <zyan@redhat.com>

Zero st_dev confuses ls(1) code. it make 'ls -l' not print '+' sign
for file/directory with ACL.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index c6ec5aa46100..b5529b0b77a6 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2244,7 +2244,7 @@ int ceph_getattr(const struct path *path, struct kstat *stat,
 		if (ceph_snap(inode) != CEPH_NOSNAP)
 			stat->dev = ceph_snap(inode);
 		else
-			stat->dev = 0;
+			stat->dev = 1; /* the smallest snapid is 2 */
 		if (S_ISDIR(inode->i_mode)) {
 			if (ceph_test_mount_opt(ceph_sb_to_client(inode->i_sb),
 						RBYTES))
-- 
2.13.6

