From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/4] rbd: rearrange rbd_header_from_disk()
Date: Mon, 06 Aug 2012 11:17:35 -0700
Message-ID: <50200A3F.60802@inktank.com>
References: <502009D1.7090005@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53282 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932114Ab2HFSRi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Aug 2012 14:17:38 -0400
Received: by pbbrr13 with SMTP id rr13so2921462pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 06 Aug 2012 11:17:37 -0700 (PDT)
In-Reply-To: <502009D1.7090005@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This just moves code around for the most part.  It was pulled out as
a separate patch to avoid cluttering up some upcoming patches which
are more substantive.  The point is basically to group everything
related to initializing the snapshot context together.

The only functional change is that rbd_header_from_disk() now
ensures the (in-core) header it is passed is zero-filled.  This
allows a simpler error handling path in rbd_header_from_disk().

Signed-off-by: Alex Elder <elder@inktank.com>
---
  drivers/block/rbd.c |   41 ++++++++++++++++++++++-------------------
  1 file changed, 22 insertions(+), 19 deletions(-)

Index: b/drivers/block/rbd.c
===================================================================
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -507,11 +507,14 @@ static int rbd_header_from_disk(struct r
  	if (snap_count > size / sizeof (header->snapc->snaps[0]))
  		return -EINVAL;

-	size = sizeof (struct ceph_snap_context);
-	size += snap_count * sizeof (header->snapc->snaps[0]);
-	header->snapc = kmalloc(size, GFP_KERNEL);
-	if (!header->snapc)
+	memset(header, 0, sizeof (*header));
+
+	size = sizeof (ondisk->block_name) + 1;
+	header->object_prefix = kmalloc(size, GFP_KERNEL);
+	if (!header->object_prefix)
  		return -ENOMEM;
+	memcpy(header->object_prefix, ondisk->block_name, size - 1);
+	header->object_prefix[size - 1] = '\0';

  	if (snap_count) {
  		header->snap_names_len = le64_to_cpu(ondisk->snap_names_len);
@@ -519,11 +522,12 @@ static int rbd_header_from_disk(struct r
  		header->snap_names = kmalloc(header->snap_names_len,
  					     GFP_KERNEL);
  		if (!header->snap_names)
-			goto err_snapc;
+			goto out_err;
+
  		size = snap_count * sizeof (*header->snap_sizes);
  		header->snap_sizes = kmalloc(size, GFP_KERNEL);
  		if (!header->snap_sizes)
-			goto err_names;
+			goto out_err;
  	} else {
  		WARN_ON(ondisk->snap_names_len);
  		header->snap_names_len = 0;
@@ -531,22 +535,23 @@ static int rbd_header_from_disk(struct r
  		header->snap_sizes = NULL;
  	}

-	size = sizeof (ondisk->block_name) + 1;
-	header->object_prefix = kmalloc(size, GFP_KERNEL);
-	if (!header->object_prefix)
-		goto err_sizes;
-	memcpy(header->object_prefix, ondisk->block_name, size - 1);
-	header->object_prefix[size - 1] = '\0';
-
  	header->image_size = le64_to_cpu(ondisk->image_size);
  	header->obj_order = ondisk->options.order;
  	header->crypt_type = ondisk->options.crypt_type;
  	header->comp_type = ondisk->options.comp_type;
+	header->total_snaps = snap_count;
+
+	/* Set up the snapshot context */
+
+	size = sizeof (struct ceph_snap_context);
+	size += snap_count * sizeof (header->snapc->snaps[0]);
+	header->snapc = kzalloc(size, GFP_KERNEL);
+	if (!header->snapc)
+		goto out_err;

  	atomic_set(&header->snapc->nref, 1);
  	header->snapc->seq = le64_to_cpu(ondisk->snap_seq);
  	header->snapc->num_snaps = snap_count;
-	header->total_snaps = snap_count;

  	if (snap_count && allocated_snaps == snap_count) {
  		int i;
@@ -565,16 +570,14 @@ static int rbd_header_from_disk(struct r

  	return 0;

-err_sizes:
+out_err:
  	kfree(header->snap_sizes);
  	header->snap_sizes = NULL;
-err_names:
  	kfree(header->snap_names);
  	header->snap_names = NULL;
  	header->snap_names_len = 0;
-err_snapc:
-	kfree(header->snapc);
-	header->snapc = NULL;
+	kfree(header->object_prefix);
+	header->object_prefix = NULL;

  	return -ENOMEM;
  }
