From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/3] rbd: use sizeof (object) instead of sizeof (type)
Date: Mon, 06 Aug 2012 11:03:42 -0700
Message-ID: <502006FE.1080406@inktank.com>
References: <50200691.3040006@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39424 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685Ab2HFSDo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Aug 2012 14:03:44 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so2904653pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 06 Aug 2012 11:03:44 -0700 (PDT)
In-Reply-To: <50200691.3040006@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Fix a few spots in rbd_header_from_disk() to use sizeof (object)
rather than sizeof (type).  Use a local variable to record sizes
to shorten some lines and improve readability.

Signed-off-by: Alex Elder <elder@inktank.com>
---
  drivers/block/rbd.c |   28 +++++++++++++++-------------
  1 file changed, 15 insertions(+), 13 deletions(-)

Index: b/drivers/block/rbd.c
===================================================================
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -495,17 +495,21 @@ static int rbd_header_from_disk(struct r
  				 u32 allocated_snaps)
  {
  	u32 snap_count;
+	size_t size;

  	if (!rbd_dev_ondisk_valid(ondisk))
  		return -ENXIO;

  	snap_count = le32_to_cpu(ondisk->snap_count);
-	if (snap_count > (SIZE_MAX - sizeof(struct ceph_snap_context))
-				 / sizeof (u64))
+
+	/* Make sure we don't overflow below */
+	size = SIZE_MAX - sizeof (struct ceph_snap_context);
+	if (snap_count > size / sizeof (header->snapc->snaps[0]))
  		return -EINVAL;
-	header->snapc = kmalloc(sizeof(struct ceph_snap_context) +
-				snap_count * sizeof(u64),
-				GFP_KERNEL);
+
+	size = sizeof (struct ceph_snap_context);
+	size += snap_count * sizeof (header->snapc->snaps[0]);
+	header->snapc = kmalloc(size, GFP_KERNEL);
  	if (!header->snapc)
  		return -ENOMEM;

@@ -516,8 +520,8 @@ static int rbd_header_from_disk(struct r
  					     GFP_KERNEL);
  		if (!header->snap_names)
  			goto err_snapc;
-		header->snap_sizes = kmalloc(snap_count * sizeof(u64),
-					     GFP_KERNEL);
+		size = snap_count * sizeof (*header->snap_sizes);
+		header->snap_sizes = kmalloc(size, GFP_KERNEL);
  		if (!header->snap_sizes)
  			goto err_names;
  	} else {
@@ -527,14 +531,12 @@ static int rbd_header_from_disk(struct r
  		header->snap_sizes = NULL;
  	}

-	header->object_prefix = kmalloc(sizeof (ondisk->block_name) + 1,
-					GFP_KERNEL);
+	size = sizeof (ondisk->block_name) + 1;
+	header->object_prefix = kmalloc(size, GFP_KERNEL);
  	if (!header->object_prefix)
  		goto err_sizes;
-
-	memcpy(header->object_prefix, ondisk->block_name,
-	       sizeof(ondisk->block_name));
-	header->object_prefix[sizeof (ondisk->block_name)] = '\0';
+	memcpy(header->object_prefix, ondisk->block_name, size - 1);
+	header->object_prefix[size - 1] = '\0';

  	header->image_size = le64_to_cpu(ondisk->image_size);
  	header->obj_order = ondisk->options.order;
