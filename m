From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: get rid of RBD_MAX_SEG_NAME_LEN
Date: Fri, 09 Nov 2012 21:54:47 -0600
Message-ID: <509DD007.4060803@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:52596 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022Ab2KJDyp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 22:54:45 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so6911377iea.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Nov 2012 19:54:45 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

RBD_MAX_SEG_NAME_LEN represents the maximum length of an rbd object
name (i.e., one of the objects providing storage backing an rbd
image).

Another symbol, MAX_OBJ_NAME_SIZE, is used in the osd client code to
define the maximum length of any object name in an osd request.

Right now they disagree, with RBD_MAX_SEG_NAME_LEN being too big.

There's no real benefit at this point to defining the rbd object
name length limit separate from any other object name, so just
get rid of RBD_MAX_SEG_NAME_LEN and use MAX_OBJ_NAME_SIZE in its
place.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c       |    6 +++---
 drivers/block/rbd_types.h |    2 --
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index cd51216..9dc1d5f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -777,13 +777,13 @@ static char *rbd_segment_name(struct rbd_device
*rbd_dev, u64 offset)
 	u64 segment;
 	int ret;

-	name = kmalloc(RBD_MAX_SEG_NAME_LEN + 1, GFP_NOIO);
+	name = kmalloc(MAX_OBJ_NAME_SIZE + 1, GFP_NOIO);
 	if (!name)
 		return NULL;
 	segment = offset >> rbd_dev->header.obj_order;
-	ret = snprintf(name, RBD_MAX_SEG_NAME_LEN, "%s.%012llx",
+	ret = snprintf(name, MAX_OBJ_NAME_SIZE + 1, "%s.%012llx",
 			rbd_dev->header.object_prefix, segment);
-	if (ret < 0 || ret >= RBD_MAX_SEG_NAME_LEN) {
+	if (ret < 0 || ret > MAX_OBJ_NAME_SIZE) {
 		pr_err("error formatting segment name for #%llu (%d)\n",
 			segment, ret);
 		kfree(name);
diff --git a/drivers/block/rbd_types.h b/drivers/block/rbd_types.h
index cbe77fa..49d77cb 100644
--- a/drivers/block/rbd_types.h
+++ b/drivers/block/rbd_types.h
@@ -46,8 +46,6 @@
 #define RBD_MIN_OBJ_ORDER       16
 #define RBD_MAX_OBJ_ORDER       30

-#define RBD_MAX_SEG_NAME_LEN	128
-
 #define RBD_COMP_NONE		0
 #define RBD_CRYPT_NONE		0

-- 
1.7.9.5

