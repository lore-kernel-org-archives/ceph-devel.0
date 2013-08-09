From: Milosz Tanski <milosz@adfin.com>
Subject: [PATCH 1/2] ceph: Remove bogus check in invalidatepage
Date: Fri, 9 Aug 2013 12:59:39 -0400
Message-ID: <ecd121eb7e3da41d7ff9074d38357ba509281ed7.1375686804.git.milosz@adfin.com>
References: <cover.1375686804.git.milosz@adfin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:56139 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967981Ab3HIQ7j (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Aug 2013 12:59:39 -0400
Received: by mail-qc0-f172.google.com with SMTP id a1so2339140qcx.3
        for <ceph-devel@vger.kernel.org>; Fri, 09 Aug 2013 09:59:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1375686804.git.milosz@adfin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, sage@inktank.com, zheng.z.yan@intel.com

The early bug checks are moot because the VMA layer ensures those things.

1. It will not call invalidatepage unless PagePrivate (or PagePrivate2) are set
2. It will not call invalidatepage without taking a PageLock first.
3. Guantrees that the inode page is mapped.

Signed-off-by: Milosz Tanski <milosz@adfin.com>
---
 fs/ceph/addr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index afb2fc2..f1d6c60 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -149,10 +149,6 @@ static void ceph_invalidatepage(struct page *page, unsigned long offset)
 	struct ceph_inode_info *ci;
 	struct ceph_snap_context *snapc = page_snap_context(page);
 
-	BUG_ON(!PageLocked(page));
-	BUG_ON(!PagePrivate(page));
-	BUG_ON(!page->mapping);
-
 	inode = page->mapping->host;
 
 	/*
-- 
1.8.1.2

