From: Alex Elder <elder@inktank.com>
Subject: [PATCH 02/11] rbd: don't over-allocate space for object prefix
Date: Fri, 24 Aug 2012 11:32:37 -0500
Message-ID: <5037ACA5.5060203@inktank.com>
References: <5037AB20.4000103@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58290 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759622Ab2HXQcn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Aug 2012 12:32:43 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so4590607obb.19
        for <ceph-devel@vger.kernel.org>; Fri, 24 Aug 2012 09:32:43 -0700 (PDT)
In-Reply-To: <5037AB20.4000103@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In rbd_header_from_disk() the object prefix buffer is sized based on
the maximum size it's block_name equivalent on disk could be.

Instead, only allocate enough to hold NUL-terminated string from
the on-disk header--or the maximum size of no NUL is found.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 81b5344..a8a4cba 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -519,18 +519,19 @@ static int rbd_header_from_disk(struct
rbd_image_header *header,
 				 struct rbd_image_header_ondisk *ondisk)
 {
 	u32 snap_count;
+	size_t len;
 	size_t size;

 	memset(header, 0, sizeof (*header));

 	snap_count = le32_to_cpu(ondisk->snap_count);

-	size = sizeof (ondisk->block_name) + 1;
-	header->object_prefix = kmalloc(size, GFP_KERNEL);
+	len = strnlen(ondisk->block_name, sizeof (ondisk->block_name));
+	header->object_prefix = kmalloc(len + 1, GFP_KERNEL);
 	if (!header->object_prefix)
 		return -ENOMEM;
-	memcpy(header->object_prefix, ondisk->block_name, size - 1);
-	header->object_prefix[size - 1] = '\0';
+	memcpy(header->object_prefix, ondisk->block_name, len);
+	header->object_prefix[len] = '\0';

 	if (snap_count) {
 		header->snap_names_len = le64_to_cpu(ondisk->snap_names_len);
-- 
1.7.9.5

