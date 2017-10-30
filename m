From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] ceph: remove the bump of i_version
Date: Mon, 30 Oct 2017 10:54:23 -0400
Message-ID: <20171030145423.32159-1-jlayton@kernel.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751894AbdJ3Oyb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 30 Oct 2017 10:54:31 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

Eventually, we'll want to wire cephfs up to use the change attribute
that the cluster tracks instead, but for now this is unneeded.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 373dab5173ca..8aae7200a425 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -785,7 +785,6 @@ static int fill_inode(struct inode *inode, struct page *locked_page,
 
 	/* update inode */
 	ci->i_version = le64_to_cpu(info->version);
-	inode->i_version++;
 	inode->i_rdev = le32_to_cpu(info->rdev);
 	inode->i_blkbits = fls(le32_to_cpu(info->layout.fl_stripe_unit)) - 1;
 
-- 
2.13.6

