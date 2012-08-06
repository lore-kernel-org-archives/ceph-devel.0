From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/3] rbd: ensure invalid pointers are made null
Date: Mon, 06 Aug 2012 11:03:38 -0700
Message-ID: <502006FA.3000801@inktank.com>
References: <50200691.3040006@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39424 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685Ab2HFSDk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Aug 2012 14:03:40 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so2904653pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 06 Aug 2012 11:03:40 -0700 (PDT)
In-Reply-To: <50200691.3040006@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Fix a number of spots where a pointer value that is known to
have become invalid but was not reset to null.

Also, toss in a change so we use sizeof (object) rather than
sizeof (type).

Signed-off-by: Alex Elder <elder@inktank.com>
---
  drivers/block/rbd.c |   10 ++++++++++
  1 file changed, 10 insertions(+)

Index: b/drivers/block/rbd.c
===================================================================
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -569,6 +569,7 @@ err_sizes:
  err_names:
  	kfree(header->snap_names);
  	header->snap_names = NULL;
+	header->snap_names_len = 0;
  err_snapc:
  	kfree(header->snapc);
  	header->snapc = NULL;
@@ -632,9 +633,14 @@ done:
  static void rbd_header_free(struct rbd_image_header *header)
  {
  	kfree(header->object_prefix);
+	header->object_prefix = NULL;
  	kfree(header->snap_sizes);
+	header->snap_sizes = NULL;
  	kfree(header->snap_names);
+	header->snap_names = NULL;
+	header->snap_names_len = 0;
  	ceph_put_snap_context(header->snapc);
+	header->snapc = NULL;
  }

  /*
@@ -2444,7 +2450,10 @@ static int rbd_add_parse_args(struct rbd

  out_err:
  	kfree(rbd_dev->header_name);
+	rbd_dev->header_name = NULL;
  	kfree(rbd_dev->image_name);
+	rbd_dev->image_name = NULL;
+	rbd_dev->image_name_len = 0;
  	kfree(rbd_dev->pool_name);
  	rbd_dev->pool_name = NULL;

@@ -2496,6 +2505,7 @@ static ssize_t rbd_add(struct bus_type *
  						options);
  	if (IS_ERR(rbd_dev->rbd_client)) {
  		rc = PTR_ERR(rbd_dev->rbd_client);
+		rbd_dev->rbd_client = NULL;
  		goto err_put_id;
  	}

