From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v3 5/8] ceph: don't update_dentry_lease unless we actually got one
Date: Fri,  3 Feb 2017 13:04:01 -0500
Message-ID: <20170203180404.31930-6-jlayton@redhat.com>
References: <20170201114914.20808-1-jlayton@redhat.com>
 <20170203180404.31930-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751252AbdBCSEJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 3 Feb 2017 13:04:09 -0500
In-Reply-To: <20170203180404.31930-1-jlayton@redhat.com>
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
index b4b61da03dbf..e5c1ca02dbe3 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1289,8 +1289,8 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
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

