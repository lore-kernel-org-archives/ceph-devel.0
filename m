From: David Disseldorp <ddiss@suse.de>
Subject: [PATCH] rbd: use GFP_NOIO consistently for request allocations
Date: Tue,  5 Apr 2016 11:13:39 +0200
Message-ID: <1459847619-27819-1-git-send-email-ddiss@suse.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50510 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757524AbcDEJNz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 5 Apr 2016 05:13:55 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 8BC47ABB4
	for <ceph-devel@vger.kernel.org>; Tue,  5 Apr 2016 09:13:52 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: David Disseldorp <ddiss@suse.de>

As of 5a60e87603c4c533492c515b7f62578189b03c9c, RBD object request
allocations are made via rbd_obj_request_create() with GFP_NOIO.
However, subsequent OSD request allocations in rbd_osd_req_create*()
use GFP_ATOMIC.

With heavy page cache usage (e.g. OSDs running on same host as krbd
client), rbd_osd_req_create() order-1 GFP_ATOMIC allocations have been
observed to fail, where direct reclaim would have allowed GFP_NOIO
allocations to succeed.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Suggested-by: Neil Brown <neilb@suse.com>
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 drivers/block/rbd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 9c62344..94a1843 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1953,7 +1953,7 @@ static struct ceph_osd_request *rbd_osd_req_create(
 
 	osdc = &rbd_dev->rbd_client->client->osdc;
 	osd_req = ceph_osdc_alloc_request(osdc, snapc, num_ops, false,
-					  GFP_ATOMIC);
+					  GFP_NOIO);
 	if (!osd_req)
 		return NULL;	/* ENOMEM */
 
@@ -2002,7 +2002,7 @@ rbd_osd_req_create_copyup(struct rbd_obj_request *obj_request)
 	rbd_dev = img_request->rbd_dev;
 	osdc = &rbd_dev->rbd_client->client->osdc;
 	osd_req = ceph_osdc_alloc_request(osdc, snapc, num_osd_ops,
-						false, GFP_ATOMIC);
+						false, GFP_NOIO);
 	if (!osd_req)
 		return NULL;	/* ENOMEM */
 
@@ -2504,7 +2504,7 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 					bio_chain_clone_range(&bio_list,
 								&bio_offset,
 								clone_size,
-								GFP_ATOMIC);
+								GFP_NOIO);
 			if (!obj_request->bio_list)
 				goto out_unwind;
 		} else if (type == OBJ_REQUEST_PAGES) {
-- 
2.6.2

