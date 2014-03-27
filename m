From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 08/33] libceph: assert length of osdmap osd arrays
Date: Thu, 27 Mar 2014 20:17:54 +0200
Message-ID: <1395944299-21970-9-git-send-email-ilya.dryomov@inktank.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:36305 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756966AbaC0SSn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 14:18:43 -0400
Received: by mail-ee0-f48.google.com with SMTP id b57so3172991eek.21
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 11:18:42 -0700 (PDT)
Received: from localhost ([109.110.66.7])
        by mx.google.com with ESMTPSA id x3sm5971464eep.17.2014.03.27.11.18.41
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 11:18:41 -0700 (PDT)
In-Reply-To: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Assert length of osd_state, osd_weight and osd_addr arrays.  They
should all have exactly max_osd elements after the call to
osdmap_set_max_osd().

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osdmap.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index ec06010657b3..19aca4d3c5dd 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -745,19 +745,19 @@ static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
 	if (err)
 		goto bad;
 
-	/* osds */
+	/* osd_state, osd_weight, osd_addrs->client_addr */
 	ceph_decode_need(p, end, 3*sizeof(u32) +
 			 map->max_osd*(1 + sizeof(*map->osd_weight) +
 				       sizeof(*map->osd_addr)), e_inval);
 
-	*p += 4; /* skip length field (should match max) */
+	BUG_ON(ceph_decode_32(p) != map->max_osd);
 	ceph_decode_copy(p, map->osd_state, map->max_osd);
 
-	*p += 4; /* skip length field (should match max) */
+	BUG_ON(ceph_decode_32(p) != map->max_osd);
 	for (i = 0; i < map->max_osd; i++)
 		map->osd_weight[i] = ceph_decode_32(p);
 
-	*p += 4; /* skip length field (should match max) */
+	BUG_ON(ceph_decode_32(p) != map->max_osd);
 	ceph_decode_copy(p, map->osd_addr, map->max_osd*sizeof(*map->osd_addr));
 	for (i = 0; i < map->max_osd; i++)
 		ceph_decode_addr(&map->osd_addr[i]);
-- 
1.7.10.4

