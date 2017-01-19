From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH] ceph: update readpages osd request according to size of pages.
Date: Thu, 19 Jan 2017 16:24:23 +0800
Message-ID: <20170119082423.44545-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750765AbdASIdI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 19 Jan 2017 03:33:08 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, jlayton@redhat.com, "Yan, Zheng" <zyan@redhat.com>

add_to_page_cache_lru() can fails, so the actual pages to read
can be smaller than the initial size of osd request. We need to
update osd request size in that case.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/addr.c        | 1 +
 net/ceph/osd_client.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 3985256..4547bbf 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -391,6 +391,7 @@ static int start_read(struct inode *inode, struct list_head *page_list, int max)
 			nr_pages = i;
 			if (nr_pages > 0) {
 				len = nr_pages << PAGE_SHIFT;
+				osd_req_op_extent_update(req, 0, len);
 				break;
 			}
 			goto out_pages;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 842f049..3a2417b 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -672,7 +672,8 @@ void osd_req_op_extent_update(struct ceph_osd_request *osd_req,
 	BUG_ON(length > previous);
 
 	op->extent.length = length;
-	op->indata_len -= previous - length;
+	if (op->op == CEPH_OSD_OP_WRITE || op->op == CEPH_OSD_OP_WRITEFULL)
+		op->indata_len -= previous - length;
 }
 EXPORT_SYMBOL(osd_req_op_extent_update);
 
-- 
2.7.4

