From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH 2/2] rbd: use the correct length for format 2 object names
Date: Wed, 12 Jun 2013 20:10:46 -0700
Message-ID: <1371093046-5814-2-git-send-email-josh.durgin@inktank.com>
References: <1371093046-5814-1-git-send-email-josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:43449 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758233Ab3FMDkj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Jun 2013 23:40:39 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id A92D6260A1
	for <ceph-devel@vger.kernel.org>; Wed, 12 Jun 2013 20:41:45 -0700 (PDT)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id A68BF2609D
	for <ceph-devel@vger.kernel.org>; Wed, 12 Jun 2013 20:41:45 -0700 (PDT)
In-Reply-To: <1371093046-5814-1-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Format 2 objects use 16 characters for the object name suffix to be
able to express the full 64-bit range of object numbers. Format 1
images only use 12 characters for this. Using 12-character names for
format 2 caused userspace and kernel rbd clients to read differently
named objects, which made an image written by one client look empty to
the other client.

Reported-by: Chris Dunlop <chris@onthe.net.au>
Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 9f72125..39ee017 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1028,12 +1028,16 @@ static const char *rbd_segment_name(struct rbd_device *rbd_dev, u64 offset)
 	char *name;
 	u64 segment;
 	int ret;
+	char *name_format;
 
 	name = kmem_cache_alloc(rbd_segment_name_cache, GFP_NOIO);
 	if (!name)
 		return NULL;
 	segment = offset >> rbd_dev->header.obj_order;
-	ret = snprintf(name, MAX_OBJ_NAME_SIZE + 1, "%s.%012llx",
+	name_format = "%s.%012llx";
+	if (rbd_dev->image_format == 2)
+		name_format = "%s.%016llx";
+	ret = snprintf(name, MAX_OBJ_NAME_SIZE + 1, name_format,
 			rbd_dev->header.object_prefix, segment);
 	if (ret < 0 || ret > MAX_OBJ_NAME_SIZE) {
 		pr_err("error formatting segment name for #%llu (%d)\n",
-- 
1.7.2.5

