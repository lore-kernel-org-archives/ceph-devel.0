From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/5] rbd: prevent bytes transferred overflow
Date: Fri, 08 Feb 2013 10:32:53 -0600
Message-ID: <511528B5.5090607@inktank.com>
References: <51152847.2030305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:65139 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759956Ab3BHQc4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 11:32:56 -0500
Received: by mail-ie0-f181.google.com with SMTP id 17so5289440iea.12
        for <ceph-devel@vger.kernel.org>; Fri, 08 Feb 2013 08:32:56 -0800 (PST)
In-Reply-To: <51152847.2030305@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

In rbd_obj_read_sync(), verify the number of bytes transferred won't
exceed what can be represented by a size_t before using it to
indicate the number of bytes to copy to the result buffer.

(The real motivation for this is to prepare for the next patch.)

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 37361bd..99f1a29 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2048,6 +2048,7 @@ static int rbd_obj_read_sync(struct rbd_device
*rbd_dev,
 	struct ceph_osd_client *osdc;
 	struct page **pages = NULL;
 	u32 page_count;
+	size_t size;
 	int ret;

 	page_count = (u32) calc_pages_for(offset, length);
@@ -2084,7 +2085,10 @@ static int rbd_obj_read_sync(struct rbd_device
*rbd_dev,
 	ret = obj_request->result;
 	if (ret < 0)
 		goto out;
-	ret = ceph_copy_from_page_vector(pages, buf, 0, obj_request->xferred);
+
+	rbd_assert(obj_request->xferred <= (u64) SIZE_MAX);
+	size = (size_t) obj_request->xferred;
+	ret = ceph_copy_from_page_vector(pages, buf, 0, size);
 	if (version)
 		*version = obj_request->version;
 out:
-- 
1.7.9.5

