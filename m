From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/5] rbd: document rbd_spec structure
Date: Thu, 01 Nov 2012 08:48:09 -0500
Message-ID: <50927D99.6070405@inktank.com>
References: <50927D03.9060900@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:56872 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761448Ab2KANsM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 09:48:12 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3581179iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 06:48:11 -0700 (PDT)
In-Reply-To: <50927D03.9060900@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I promised Josh I would document whether there were any restrictions
needed for accessing fields of an rbd_spec structure.  This adds a
big block of comments that documents the structure and how it is
used--including the fact that we don't attempt to synchronize access
to it.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 842caf4..32ed6e6 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -119,7 +119,26 @@ struct rbd_image_header {
  * An rbd image specification.
  *
  * The tuple (pool_id, image_id, snap_id) is sufficient to uniquely
- * identify an image.
+ * identify an image.  Each rbd_dev structure includes a pointer to
+ * an rbd_spec structure that encapsulates this identity.
+ *
+ * Each of the id's in an rbd_spec has an associated name.  For a
+ * user-mapped image, the names are supplied and the id's associated
+ * with them are looked up.  For a layered image, a parent image is
+ * defined by the tuple, and the names are looked up.
+ *
+ * An rbd_dev structure contains a parent_spec pointer which is
+ * non-null if the image it represents is a child in a layered
+ * image.  This pointer will refer to the rbd_spec structure used
+ * by the parent rbd_dev for its own identity (i.e., the structure
+ * is shared between the parent and child).
+ *
+ * Since these structures are populated once, during the discovery
+ * phase of image construction, they are effectively immutable so
+ * we make no effort to synchronize access to them.
+ *
+ * Note that code herein does not assume the image name is known (it
+ * could be a null pointer).
  */
 struct rbd_spec {
 	u64		pool_id;
-- 
1.7.9.5

