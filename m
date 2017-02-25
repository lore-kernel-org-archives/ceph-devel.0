From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v5 5/6] Revert "ceph: SetPageError() for writeback pages if writepages fails"
Date: Sat, 25 Feb 2017 12:43:22 -0500
Message-ID: <20170225174323.20289-6-jlayton@redhat.com>
References: <20170225174323.20289-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751692AbdBYRn3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 25 Feb 2017 12:43:29 -0500
In-Reply-To: <20170225174323.20289-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com
Cc: jspray@redhat.com, ceph-devel@vger.kernel.org

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
 fs/ceph/addr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 4b9da6ee5c7f..be3aa84188a5 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -702,9 +702,6 @@ static void writepages_finish(struct ceph_osd_request *req)
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

