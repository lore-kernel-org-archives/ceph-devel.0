From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/5] rbd: use kmemdup()
Date: Thu, 01 Nov 2012 08:57:45 -0500
Message-ID: <50927FD9.2060001@inktank.com>
References: <50927D03.9060900@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:57063 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758235Ab2KAN55 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 09:57:57 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so1923935iag.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 06:57:57 -0700 (PDT)
In-Reply-To: <50927D03.9060900@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This replaces two kmalloc()/memcpy() combinations with a single
call to kmemdup().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 3378963..cf7b405 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3153,11 +3153,9 @@ static inline char *dup_token(const char **buf,
size_t *lenp)
 	size_t len;

 	len = next_token(buf);
-	dup = kmalloc(len + 1, GFP_KERNEL);
+	dup = kmemdup(*buf, len + 1, GFP_KERNEL);
 	if (!dup)
 		return NULL;
-
-	memcpy(dup, *buf, len);
 	*(dup + len) = '\0';
 	*buf += len;

@@ -3266,10 +3264,9 @@ static int rbd_add_parse_args(const char *buf,
 		ret = -ENAMETOOLONG;
 		goto out_err;
 	}
-	spec->snap_name = kmalloc(len + 1, GFP_KERNEL);
+	spec->snap_name = kmemdup(buf, len + 1, GFP_KERNEL);
 	if (!spec->snap_name)
 		goto out_mem;
-	memcpy(spec->snap_name, buf, len);
 	*(spec->snap_name + len) = '\0';

 	/* Initialize all rbd options to the defaults */
-- 
1.7.9.5

