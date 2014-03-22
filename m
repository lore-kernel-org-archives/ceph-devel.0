From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] libceph: fix oops in ceph_msg_data_pagelist_advance()
Date: Sun, 23 Mar 2014 06:54:57 +0800
Message-ID: <1395528897-26031-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41434 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751501AbaCVWzC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 22 Mar 2014 18:55:02 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

When there is no more data, ceph_msg_data_pagelist_advance() should
not move on to the next page.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 net/ceph/messenger.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 30efc5c..8859f2e 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1004,6 +1004,9 @@ static bool ceph_msg_data_pagelist_advance(struct ceph_msg_data_cursor *cursor,
 	if (!bytes || cursor->offset & ~PAGE_MASK)
 		return false;	/* more bytes to process in the current page */
 
+	if (!cursor->resid)
+		return false;   /* no more data */
+
 	/* Move on to the next page */
 
 	BUG_ON(list_is_last(&cursor->page->lru, &pagelist->head));
-- 
1.8.5.3

