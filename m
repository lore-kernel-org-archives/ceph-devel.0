From: Jeff Layton <jlayton@kernel.org>
Subject: [nfs-ganesha]{PATCH] FSAL_CEPH: do an inode lookup vs. MDS when the Inode is not in cache
Date: Thu,  9 Nov 2017 11:03:16 -0500
Message-ID: <20171109160316.24766-1-jlayton@kernel.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752563AbdKIQDT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 9 Nov 2017 11:03:19 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: nfs-ganesha-devel@lists.sourceforge.net

From: Jeff Layton <jlayton@redhat.com>

FSAL_CEPH just does a ceph_ll_get_inode when asked to create a
filehandle today, which only does a query of the local Ceph client
cache. This means, it can only find Inodes that were previously found
via name lookup.

When ganesha is restarted, we have a blank-slate Client, and the Inode
will not be in cache. That ends up with the NFS client getting back an
ESTALE.

We must be able to find Inodes that may not be in the cache. When
ceph_ll_get_inode can't find an Inode, try a lookup vs. the MDS for it.

The only problem is that we currently have no way to look up a snapped
inode from scratch. I think we'll probably need to add that ability to
libcephfs, but for now the best we can do is just bail out with an
ESTALE in that case.

While we're in there, remove the comment about ceph_ll_connectable_m.
There is no such function in libcephfs and never has been. The ds
code does seem to refer to such a call, but it's not clear to me
what it's supposed to do.

Change-Id: I2d0e362ef8f28ba78575b60f3fb2890096d98fc6
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---

I sent this up through git-review to ganesha's gerrit, but I'd
like some cephfs folks to have a look too. This patch is basically
a workaround for the FSAL_CEPH code for now.

Do we need to worry about inodes that are not CEPH_NOSNAP? It
seems like we might need for libcephfs to grow an interface that
can look up snapped inodes as well?

Either that, or teach ceph_ll_get_inode how to look up inodes
that are not in its cache. Would that be a better fix here?

 src/FSAL/FSAL_CEPH/export.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/src/FSAL/FSAL_CEPH/export.c b/src/FSAL/FSAL_CEPH/export.c
index 3de25fdfaf41..a31e3bb3ebef 100644
--- a/src/FSAL/FSAL_CEPH/export.c
+++ b/src/FSAL/FSAL_CEPH/export.c
@@ -234,12 +234,23 @@ static fsal_status_t create_handle(struct fsal_export *export_pub,
 		return status;
 	}
 
+	/* Check our local cache first */
 	i = ceph_ll_get_inode(export->cmount, *vi);
-	if (!i)
-		return ceph2fsal_error(-ESTALE);
+	if (!i) {
+		/*
+		 * Try the slow way, may not be in cache now.
+		 *
+		 * Currently, there is no interface for looking up a snapped
+		 * inode, so we just bail here in that case.
+		 */
+		if (vi->snapid.val != CEPH_NOSNAP)
+			return ceph2fsal_error(-ESTALE);
+
+		rc = ceph_ll_lookup_inode(export->cmount, vi->ino, &i);
+		if (rc)
+			return ceph2fsal_error(rc);
+	}
 
-	/* The ceph_ll_connectable_m should have populated libceph's
-	   cache with all this anyway */
 	rc = fsal_ceph_ll_getattr(export->cmount, i, &stx,
 		attrs_out ? CEPH_STATX_ATTR_MASK : CEPH_STATX_HANDLE_MASK,
 		op_ctx->creds);
-- 
2.13.6

