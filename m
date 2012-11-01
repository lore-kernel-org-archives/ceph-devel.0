From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/4] rbd: add warning messages for missing arguments
Date: Thu, 01 Nov 2012 10:26:18 -0500
Message-ID: <5092949A.3000900@inktank.com>
References: <50929419.6020302@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:52102 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762000Ab2KAP0e (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 11:26:34 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3724548iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 08:26:34 -0700 (PDT)
In-Reply-To: <50929419.6020302@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Tell the user (via dmesg) what was wrong with the arguments provided
via /sys/bus/rbd/add.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 85a5164..de1d3b1 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3246,8 +3246,10 @@ static int rbd_add_parse_args(const char *buf,
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
@@ -3256,8 +3258,10 @@ static int rbd_add_parse_args(const char *buf,
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
@@ -3266,14 +3270,18 @@ static int rbd_add_parse_args(const char *buf,
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

