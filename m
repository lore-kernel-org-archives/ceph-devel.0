From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 2/3] ceph: redirty page when writepage_nounlock() skips unwritable page
Date: Tue, 23 May 2017 17:54:38 +0800
Message-ID: <20170523095439.63347-2-zyan@redhat.com>
References: <20170523095439.63347-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933487AbdEWJy7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 May 2017 05:54:59 -0400
In-Reply-To: <20170523095439.63347-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@redhat.com, dan.carpenter@oracle.com, "Yan, Zheng" <zyan@redhat.com>

Ceph needs to flush dirty page in the order in which in which snap
context they belong to. Dirty pages belong to older snap context
should be flushed earlier. writepage_nounlock() can not flush a
page, it should redirty the page.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/addr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index ff25239..1880125 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -551,8 +551,9 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 		dout("writepage %p page %p snapc %p not writeable - noop\n",
 		     inode, page, snapc);
 		/* we should only noop if called by kswapd */
-		WARN_ON((current->flags & PF_MEMALLOC) == 0);
+		WARN_ON(!(current->flags & PF_MEMALLOC));
 		ceph_put_snap_context(oldest);
+		redirty_page_for_writepage(wbc, page);
 		goto out;
 	}
 	ceph_put_snap_context(oldest);
-- 
2.9.4

