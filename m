From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH v2 1/3] libceph: fix overflow in __decode_pool_names()
Date: Sun, 29 Apr 2012 03:07:12 -0400
Message-ID: <4F9CE8A0.80306@gmail.com>
References: <1335682765-1643-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58898 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682Ab2D2HHQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 Apr 2012 03:07:16 -0400
Received: by iadi9 with SMTP id i9so2816223iad.19
        for <ceph-devel@vger.kernel.org>; Sun, 29 Apr 2012 00:07:15 -0700 (PDT)
In-Reply-To: <1335682765-1643-1-git-send-email-xi.wang@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, Xi Wang <xi.wang@gmail.com>

`len' is read from network and thus needs validation.  Otherwise a
large `len' would cause out-of-bounds access via the memcpy() call.
In addition, len = 0xffffffff would overflow the kmalloc() size,
leading to out-of-bounds write.

This patch adds a check of `len' via ceph_decode_need().  Also use
kstrndup rather than kmalloc/memcpy.

Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
Subject corrected.  Sorry, my bad.
---
 net/ceph/osdmap.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 29ad46e..f80afc3 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -495,15 +495,12 @@ static int __decode_pool_names(void **p, void *end, struct ceph_osdmap *map)
 		ceph_decode_32_safe(p, end, pool, bad);
 		ceph_decode_32_safe(p, end, len, bad);
 		dout("  pool %d len %d\n", pool, len);
+		ceph_decode_need(p, end, len, bad);
 		pi = __lookup_pg_pool(&map->pg_pools, pool);
 		if (pi) {
 			kfree(pi->name);
-			pi->name = kmalloc(len + 1, GFP_NOFS);
-			if (pi->name) {
-				memcpy(pi->name, *p, len);
-				pi->name[len] = '\0';
-				dout("  name is %s\n", pi->name);
-			}
+			pi->name = kstrndup(*p, len, GFP_NOFS);
+			dout("  name is %s\n", pi->name);
 		}
 		*p += len;
 	}
-- 
1.7.5.4


