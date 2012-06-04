From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] rbd: Fix ceph_snap_context size calculation
Date: Mon,  4 Jun 2012 16:11:09 +0800
Message-ID: <1338797469-23314-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63893 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753406Ab2FDILL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 4 Jun 2012 04:11:11 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: "Yan, Zheng" <zheng.z.yan@intel.com>

ceph_snap_context->snaps is an u64 array

Signed-off-by: Zheng Yan <zheng.z.yan@intel.com>
---
 drivers/block/rbd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 65665c9..8b9c173 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -499,7 +499,7 @@ static int rbd_header_from_disk(struct rbd_image_header *header,
 			 / sizeof (*ondisk))
 		return -EINVAL;
 	header->snapc = kmalloc(sizeof(struct ceph_snap_context) +
-				snap_count * sizeof (*ondisk),
+				snap_count * sizeof(u64),
 				gfp_flags);
 	if (!header->snapc)
 		return -ENOMEM;
-- 
1.7.7.6

