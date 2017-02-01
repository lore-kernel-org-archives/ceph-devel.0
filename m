From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v2 10/13] ceph: don't update_dentry_lease unless we actually got one
Date: Wed,  1 Feb 2017 06:49:11 -0500
Message-ID: <20170201114914.20808-11-jlayton@redhat.com>
References: <20170130161942.16537-1-jlayton@redhat.com>
 <20170201114914.20808-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751486AbdBALtX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 1 Feb 2017 06:49:23 -0500
In-Reply-To: <20170201114914.20808-1-jlayton@redhat.com>
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
index cb94ec7961d2..da6e222dff84 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1288,8 +1288,8 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
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

