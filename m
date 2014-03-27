From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 11/33] libceph: nuke bogus encoding version check in osdmap_apply_incremental()
Date: Thu, 27 Mar 2014 20:17:57 +0200
Message-ID: <1395944299-21970-12-git-send-email-ilya.dryomov@inktank.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42]:42117 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756966AbaC0SSu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 14:18:50 -0400
Received: by mail-ee0-f42.google.com with SMTP id d17so3232238eek.29
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 11:18:49 -0700 (PDT)
Received: from localhost ([109.110.66.7])
        by mx.google.com with ESMTPSA id u1sm5950276eex.31.2014.03.27.11.18.48
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 11:18:48 -0700 (PDT)
In-Reply-To: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Only version 6 of osdmap encoding is supported, anything other than
version 6 results in an error and halts the decoding process.  Checking
if version is >= 5 is therefore bogus.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osdmap.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 0fc29a930c06..75e192e99173 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -946,11 +946,10 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
 		if (err < 0)
 			goto bad;
 	}
-	if (version >= 5) {
-		err = __decode_pool_names(p, end, map);
-		if (err)
-			goto bad;
-	}
+
+	err = __decode_pool_names(p, end, map);
+	if (err)
+		goto bad;
 
 	/* old_pool */
 	ceph_decode_32_safe(p, end, len, e_inval);
-- 
1.7.10.4

