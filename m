From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] rbd: use gfp_flags parameter in rbd_header_from_disk()
Date: Thu, 22 Mar 2012 09:33:09 +0300
Message-ID: <20120322063309.GC7369@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:18891 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837Ab2CVGd0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Mar 2012 02:33:26 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@hq.newdream.net>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, kernel-janitors@vger.kernel.org

We should use the gfp_flags that the caller specified instead of
GFP_KERNEL here.

There is only one caller and it uses GFP_KERNEL, so this change is just
a cleanup and doesn't change how the code works.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a6278e7..fc9341f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -474,11 +474,11 @@ static int rbd_header_from_disk(struct rbd_image_header *header,
 		return -ENOMEM;
 	if (snap_count) {
 		header->snap_names = kmalloc(header->snap_names_len,
-					     GFP_KERNEL);
+					     gfp_flags);
 		if (!header->snap_names)
 			goto err_snapc;
 		header->snap_sizes = kmalloc(snap_count * sizeof(u64),
-					     GFP_KERNEL);
+					     gfp_flags);
 		if (!header->snap_sizes)
 			goto err_names;
 	} else {
