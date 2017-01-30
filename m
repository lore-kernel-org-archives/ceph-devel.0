From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH 1/5] ceph: don't update_dentry_lease unless we actually got one
Date: Mon, 30 Jan 2017 11:19:38 -0500
Message-ID: <20170130161942.16537-2-jlayton@redhat.com>
References: <20170130161942.16537-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932165AbdA3QTo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 30 Jan 2017 11:19:44 -0500
In-Reply-To: <20170130161942.16537-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com

This if block updates the dentry lease even in the case where
the MDS didn't grant one.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 4926265f4223..ad1ca46a058d 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1319,8 +1319,8 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
 				ceph_dir_clear_ordered(dir);
 				dout("d_delete %p\n", dn);
 				d_delete(dn);
-			} else {
-				if (have_lease && d_unhashed(dn))
+			} else if (have_lease) {
+				if (d_unhashed(dn))
 					d_add(dn, NULL);
 				update_dentry_lease(dn, rinfo->dlease,
 						    session,
-- 
2.9.3

