From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v8 6/7] Revert "ceph: SetPageError() for writeback pages if writepages fails"
Date: Mon, 17 Apr 2017 12:42:57 -0400
Message-ID: <20170417164258.31527-7-jlayton@redhat.com>
References: <20170417164258.31527-1-jlayton@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57308 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754725AbdDQQnN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 17 Apr 2017 12:43:13 -0400
In-Reply-To: <20170417164258.31527-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com
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

Reviewed-by: "Yan, Zheng” <zyan@redhat.com>
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/addr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 7e3fae334620..6cdf94459ac4 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -703,9 +703,6 @@ static void writepages_finish(struct ceph_osd_request *req)
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

