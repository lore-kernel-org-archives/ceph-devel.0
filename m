From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v4 5/6] Revert "ceph: SetPageError() for writeback pages if writepages fails"
Date: Thu,  9 Feb 2017 09:48:35 -0500
Message-ID: <20170209144836.12525-6-jlayton@redhat.com>
References: <20170209144836.12525-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752764AbdBIOsq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 9 Feb 2017 09:48:46 -0500
In-Reply-To: <20170209144836.12525-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, jspray@redhat.com

This reverts commit b109eec6f4332bd517e2f41e207037c4b9065094.

If I'm filling up a filesystem with this sort of command:

    $ dd if=/dev/urandom of=/mnt/cephfs/fillfile bs=2M oflag=sync

...then I'll eventually get back EIO on a write. Further calls
will give us ENOSPC.

I'm not sure what prompted this change, but I don't think it's what we
want to do. If writepages failed, we will have already set the mapping
error appropriately, and that's what gets reported by fsync() or
close().

__filemap_fdatawait_range however, does this:

	wait_on_page_writeback(page);
	if (TestClearPageError(page))
		ret = -EIO;

...and that -EIO ends up trumping the mapping's error if one exists.

When writepages fails, we only want to set the error in the mapping,
and not flag the individual pages.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/addr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 308787eeee2c..040d05c8f4a2 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -668,6 +668,7 @@ static void writepages_finish(struct ceph_osd_request *req)
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
 	bool remove_page;
 
+
 	dout("writepages_finish %p rc %d\n", inode, rc);
 	if (rc < 0)
 		mapping_set_error(mapping, rc);
@@ -702,9 +703,6 @@ static void writepages_finish(struct ceph_osd_request *req)
 				clear_bdi_congested(&fsc->backing_dev_info,
 						    BLK_RW_ASYNC);
 
-			if (rc < 0)
-				SetPageError(page);
-
 			ceph_put_snap_context(page_snap_context(page));
 			page->private = 0;
 			ClearPagePrivate(page);
-- 
2.9.3

