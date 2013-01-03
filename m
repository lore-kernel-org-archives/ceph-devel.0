From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 2/4] rbd: add warning messages for missing arguments
Date: Thu, 03 Jan 2013 13:11:55 -0600
Message-ID: <50E5D7FB.9040906@inktank.com>
References: <50E5D7A9.6040101@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34034 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838Ab3ACTL5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 14:11:57 -0500
Received: by mail-ie0-f176.google.com with SMTP id 13so18453889iea.7
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 11:11:57 -0800 (PST)
In-Reply-To: <50E5D7A9.6040101@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Tell the user (via dmesg) what was wrong with the arguments provided
via /sys/bus/rbd/add.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 635b81d..31da8c5 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3244,8 +3244,10 @@ static int rbd_add_parse_args(const char *buf,
 	/* The first four tokens are required */

 	len = next_token(&buf);
-	if (!len)
-		return -EINVAL;	/* Missing monitor address(es) */
+	if (!len) {
+		rbd_warn(NULL, "no monitor address(es) provided");
+		return -EINVAL;
+	}
 	mon_addrs = buf;
 	mon_addrs_size = len + 1;
 	buf += len;
@@ -3254,8 +3256,10 @@ static int rbd_add_parse_args(const char *buf,
 	options = dup_token(&buf, NULL);
 	if (!options)
 		return -ENOMEM;
-	if (!*options)
-		goto out_err;	/* Missing options */
+	if (!*options) {
+		rbd_warn(NULL, "no options provided");
+		goto out_err;
+	}

 	spec = rbd_spec_alloc();
 	if (!spec)
@@ -3264,14 +3268,18 @@ static int rbd_add_parse_args(const char *buf,
 	spec->pool_name = dup_token(&buf, NULL);
 	if (!spec->pool_name)
 		goto out_mem;
-	if (!*spec->pool_name)
-		goto out_err;	/* Missing pool name */
+	if (!*spec->pool_name) {
+		rbd_warn(NULL, "no pool name provided");
+		goto out_err;
+	}

 	spec->image_name = dup_token(&buf, NULL);
 	if (!spec->image_name)
 		goto out_mem;
-	if (!*spec->image_name)
-		goto out_err;	/* Missing image name */
+	if (!*spec->image_name) {
+		rbd_warn(NULL, "no image name provided");
+		goto out_err;
+	}

 	/*
 	 * Snapshot name is optional; default is to use "-"
-- 
1.7.9.5

