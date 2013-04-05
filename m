From: Alex Elder <elder@inktank.com>
Subject: [PATCH 01/20] rbd: define inbound data size for method ops
Date: Fri, 05 Apr 2013 09:01:14 -0500
Message-ID: <515ED92A.2010301@inktank.com>
References: <515ED849.9060901@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:42961 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161475Ab3DEOBQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Apr 2013 10:01:16 -0400
Received: by mail-ie0-f175.google.com with SMTP id c12so4251291ieb.6
        for <ceph-devel@vger.kernel.org>; Fri, 05 Apr 2013 07:01:16 -0700 (PDT)
In-Reply-To: <515ED849.9060901@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

When rbd creates an object request containing an object method call
operation it is passing 0 for the size.  I originally thought this
was because the length was not needed for method calls, but I think
it really should be supplied, to describe how much space is
available to receive response data.  So provide the supplied length.

This resolves:
    http://tracker.ceph.com/issues/4659

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 9fb51b5..5e579fa 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1839,12 +1839,11 @@ static int rbd_obj_method_sync(struct rbd_device
*rbd_dev,
 	int ret;

 	/*
-	 * Method calls are ultimately read operations but they
-	 * don't involve object data (so no offset or length).
-	 * The result should placed into the inbound buffer
-	 * provided.  They also supply outbound data--parameters for
-	 * the object method.  Currently if this is present it will
-	 * be a snapshot id.
+	 * Method calls are ultimately read operations.  The result
+	 * should placed into the inbound buffer provided.  They
+	 * also supply outbound data--parameters for the object
+	 * method.  Currently if this is present it will be a
+	 * snapshot id.
 	 */
 	page_count = (u32) calc_pages_for(0, inbound_size);
 	pages = ceph_alloc_page_vector(page_count, GFP_KERNEL);
@@ -1852,7 +1851,7 @@ static int rbd_obj_method_sync(struct rbd_device
*rbd_dev,
 		return PTR_ERR(pages);

 	ret = -ENOMEM;
-	obj_request = rbd_obj_request_create(object_name, 0, 0,
+	obj_request = rbd_obj_request_create(object_name, 0, inbound_size,
 							OBJ_REQUEST_PAGES);
 	if (!obj_request)
 		goto out;
-- 
1.7.9.5

