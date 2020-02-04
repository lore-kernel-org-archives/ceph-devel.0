From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] ceph: don't ClearPageChecked in ceph_invalidatepage
Date: Tue,  4 Feb 2020 12:52:56 -0500
Message-ID: <20200204175256.362163-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727369AbgBDRw6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:52:58 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: dhowells@redhat.com

CephFS doesn't set this bit to begin with, so there should be no need
to clear it.

Reported-by: David Howells <dhowells@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 7ab616601141..6067847bc03b 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -159,8 +159,6 @@ static void ceph_invalidatepage(struct page *page, unsigned int offset,
 	if (!PagePrivate(page))
 		return;
 
-	ClearPageChecked(page);
-
 	dout("%p invalidatepage %p idx %lu full dirty page\n",
 	     inode, page, page->index);
 
-- 
2.24.1
