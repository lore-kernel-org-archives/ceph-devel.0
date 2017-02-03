From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v3 8/8] ceph: do a LOOKUP in d_revalidate instead of GETATTR
Date: Fri,  3 Feb 2017 13:04:04 -0500
Message-ID: <20170203180404.31930-9-jlayton@redhat.com>
References: <20170201114914.20808-1-jlayton@redhat.com>
 <20170203180404.31930-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751321AbdBCSEL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 3 Feb 2017 13:04:11 -0500
In-Reply-To: <20170203180404.31930-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com

In commit c3f4688a08f (ceph: don't set req->r_locked_dir in
ceph_d_revalidate), we changed the code to do a GETATTR instead of a
LOOKUP as the parent info isn't strictly necessary to revalidate the
dentry. What we missed there though is that in order to update the lease
on the dentry after revalidating it, we _do_ need parent info.

Change ceph_d_revalidate back to doing a LOOKUP instead of a GETATTR so
that we can get the parent info in order to update the lease from
ceph_fill_trace. Note that we set req->r_parent here, but we cannot set
the CEPH_MDS_R_PARENT_LOCKED flag as we can't guarantee that it is.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/dir.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index c8562b8a8c7e..3e9ad501addf 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1244,11 +1244,12 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 			return -ECHILD;
 
 		op = ceph_snap(dir) == CEPH_SNAPDIR ?
-			CEPH_MDS_OP_LOOKUPSNAP : CEPH_MDS_OP_GETATTR;
+			CEPH_MDS_OP_LOOKUPSNAP : CEPH_MDS_OP_LOOKUP;
 		req = ceph_mdsc_create_request(mdsc, op, USE_ANY_MDS);
 		if (!IS_ERR(req)) {
 			req->r_dentry = dget(dentry);
-			req->r_num_caps = op == CEPH_MDS_OP_GETATTR ? 1 : 2;
+			req->r_num_caps = 2;
+			req->r_parent = dir;
 
 			mask = CEPH_STAT_CAP_INODE | CEPH_CAP_AUTH_SHARED;
 			if (ceph_security_xattr_wanted(dir))
-- 
2.9.3

