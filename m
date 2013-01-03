From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 4/4] rbd: use kmemdup()
Date: Thu, 03 Jan 2013 13:06:37 -0600
Message-ID: <50E5D6BD.4050105@inktank.com>
References: <50E5D641.2010405@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:46106 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707Ab3ACTGk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 14:06:40 -0500
Received: by mail-ie0-f172.google.com with SMTP id c13so18867739ieb.3
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 11:06:39 -0800 (PST)
In-Reply-To: <50E5D641.2010405@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This replaces two kmalloc()/memcpy() combinations with a single
call to kmemdup().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e01dbb1..d97611e 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3151,11 +3151,9 @@ static inline char *dup_token(const char **buf,
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

@@ -3264,10 +3262,9 @@ static int rbd_add_parse_args(const char *buf,
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

