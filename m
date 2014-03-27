From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 09/33] libceph: fix crush_decode() call site in osdmap_decode()
Date: Thu, 27 Mar 2014 20:17:55 +0200
Message-ID: <1395944299-21970-10-git-send-email-ilya.dryomov@inktank.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:65228 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756966AbaC0SSp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 14:18:45 -0400
Received: by mail-ee0-f50.google.com with SMTP id c13so3272629eek.9
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 11:18:44 -0700 (PDT)
Received: from localhost ([109.110.66.7])
        by mx.google.com with ESMTPSA id o7sm5962702eew.25.2014.03.27.11.18.43
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 11:18:44 -0700 (PDT)
In-Reply-To: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The size of the memory area feeded to crush_decode() should be limited
not only by osdmap end, but also by the crush map length.  Also, drop
unnecessary dout() (dout() in crush_decode() conveys the same info) and
step past crush map only if it is decoded successfully.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osdmap.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 19aca4d3c5dd..b70357adbdc0 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -796,16 +796,13 @@ static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
 
 	/* crush */
 	ceph_decode_32_safe(p, end, len, e_inval);
-	dout("osdmap_decode crush len %d from off 0x%x\n", len,
-	     (int)(*p - start));
-	ceph_decode_need(p, end, len, e_inval);
-	map->crush = crush_decode(*p, end);
-	*p += len;
+	map->crush = crush_decode(*p, min(*p + len, end));
 	if (IS_ERR(map->crush)) {
 		err = PTR_ERR(map->crush);
 		map->crush = NULL;
 		goto bad;
 	}
+	*p += len;
 
 	/* ignore the rest */
 	*p = end;
-- 
1.7.10.4

