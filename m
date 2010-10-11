From: Dan Carpenter <error27@gmail.com>
Subject: [patch 1/2 -next] rbd: null vs ERR_PTR
Date: Mon, 11 Oct 2010 21:14:23 +0200
Message-ID: <20101011191423.GI5851@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46175 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755315Ab0JKTOn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Oct 2010 15:14:43 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@hq.newdream.net>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, kernel-janitors@vger.kernel.org

ceph_alloc_page_vector() returns ERR_PTR(-ENOMEM) on errors.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 1ac87f1..52f9420 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -826,8 +826,8 @@ static int rbd_req_sync_op(struct rbd_device *dev,
 
 	num_pages = calc_pages_for(ofs , len);
 	pages = ceph_alloc_page_vector(num_pages, GFP_KERNEL);
-	if (!pages)
-		return -ENOMEM;
+	if (IS_ERR(pages))
+		return PTR_ERR(pages);
 
 	if (!orig_ops) {
 		payload_len = (flags & CEPH_OSD_FLAG_WRITE ? len : 0);
