From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: add parentheses to object request iterator macros
Date: Fri, 08 Feb 2013 10:18:58 -0600
Message-ID: <51152572.1060602@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:55974 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758646Ab3BHQTH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 11:19:07 -0500
Received: by mail-ia0-f180.google.com with SMTP id f27so4313743iae.25
        for <ceph-devel@vger.kernel.org>; Fri, 08 Feb 2013 08:19:05 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The for_each_obj_request*() macros should parenthesize their uses of
the ireq parameter.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 982963e..6e9e2c2 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -226,11 +226,11 @@ struct rbd_img_request {
 };

 #define for_each_obj_request(ireq, oreq) \
-	list_for_each_entry(oreq, &ireq->obj_requests, links)
+	list_for_each_entry(oreq, &(ireq)->obj_requests, links)
 #define for_each_obj_request_from(ireq, oreq) \
-	list_for_each_entry_from(oreq, &ireq->obj_requests, links)
+	list_for_each_entry_from(oreq, &(ireq)->obj_requests, links)
 #define for_each_obj_request_safe(ireq, oreq, n) \
-	list_for_each_entry_safe_reverse(oreq, n, &ireq->obj_requests, links)
+	list_for_each_entry_safe_reverse(oreq, n, &(ireq)->obj_requests, links)

 struct rbd_snap {
 	struct	device		dev;
-- 
1.7.9.5

