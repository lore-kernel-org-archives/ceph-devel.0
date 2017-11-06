From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: use GFP_NOIO for parent stat and data requests
Date: Mon,  6 Nov 2017 16:51:20 +0100
Message-ID: <1509983480-2051-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:47155 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753877AbdKFPvd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Nov 2017 10:51:33 -0500
Received: by mail-wr0-f196.google.com with SMTP id k61so3210840wrc.4
        for <ceph-devel@vger.kernel.org>; Mon, 06 Nov 2017 07:51:32 -0800 (PST)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 31sm8274329wrm.0.2017.11.06.07.51.30
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Nov 2017 07:51:31 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

rbd_img_obj_exists_submit() and rbd_img_obj_parent_read_full() are on
the writeback path for cloned images -- we attempt a stat on the parent
object to see if it exists and potentially read it in to call copyup.
GFP_NOIO should be used instead of GFP_KERNEL here.

Cc: stable@vger.kernel.org
Link: http://tracker.ceph.com/issues/22014
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index fd3b9af610d2..57275298d9fc 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2666,7 +2666,7 @@ static int rbd_img_obj_parent_read_full(struct rbd_obj_request *obj_request)
 	 * from the parent.
 	 */
 	page_count = (u32)calc_pages_for(0, length);
-	pages = ceph_alloc_page_vector(page_count, GFP_KERNEL);
+	pages = ceph_alloc_page_vector(page_count, GFP_NOIO);
 	if (IS_ERR(pages)) {
 		result = PTR_ERR(pages);
 		pages = NULL;
@@ -2801,7 +2801,7 @@ static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
 	 */
 	size = sizeof (__le64) + sizeof (__le32) + sizeof (__le32);
 	page_count = (u32)calc_pages_for(0, size);
-	pages = ceph_alloc_page_vector(page_count, GFP_KERNEL);
+	pages = ceph_alloc_page_vector(page_count, GFP_NOIO);
 	if (IS_ERR(pages)) {
 		ret = PTR_ERR(pages);
 		goto fail_stat_request;
-- 
2.4.3

