From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] libceph: fix oops in ceph_msg_data_{pages,pagelist}_advance()
Date: Sun, 23 Mar 2014 07:37:03 +0800
Message-ID: <1395531423-27046-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56851 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866AbaCVXhH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 22 Mar 2014 19:37:07 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

When there is no more data, ceph_msg_data_{pages,pagelist}_advance()
should not move on to the next page.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 net/ceph/messenger.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 30efc5c..4f55f9c 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -919,6 +919,9 @@ static bool ceph_msg_data_pages_advance(struct ceph_msg_data_cursor *cursor,
 	if (!bytes || cursor->page_offset)
 		return false;	/* more bytes to process in the current page */
 
+	if (!cursor->resid)
+		return false;   /* no more data */
+
 	/* Move on to the next page; offset is already at 0 */
 
 	BUG_ON(cursor->page_index >= cursor->page_count);
@@ -1004,6 +1007,9 @@ static bool ceph_msg_data_pagelist_advance(struct ceph_msg_data_cursor *cursor,
 	if (!bytes || cursor->offset & ~PAGE_MASK)
 		return false;	/* more bytes to process in the current page */
 
+	if (!cursor->resid)
+		return false;   /* no more data */
+
 	/* Move on to the next page */
 
 	BUG_ON(list_is_last(&cursor->page->lru, &pagelist->head));
-- 
1.8.5.3

