From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 06/33] libceph: fixup error handling in osdmap_decode()
Date: Thu, 27 Mar 2014 20:17:52 +0200
Message-ID: <1395944299-21970-7-git-send-email-ilya.dryomov@inktank.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:38468 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754922AbaC0SSj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 14:18:39 -0400
Received: by mail-ee0-f43.google.com with SMTP id e53so3216243eek.2
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 11:18:38 -0700 (PDT)
Received: from localhost ([109.110.66.7])
        by mx.google.com with ESMTPSA id h47sm5977835eey.13.2014.03.27.11.18.36
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 11:18:37 -0700 (PDT)
In-Reply-To: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The existing error handling scheme requires resetting err to -EINVAL
prior to calling any ceph_decode_* macro.  This is ugly and fragile,
and there already are a few places where we would return 0 on error,
due to a missing reset.  Fix this by adding a special e_inval label to
be used by all ceph_decode_* macros.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osdmap.c |   53 +++++++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index a82df6ea0749..298d076eee89 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -688,36 +688,37 @@ static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
 {
 	u16 version;
 	u32 len, max, i;
-	int err = -EINVAL;
 	u32 epoch = 0;
 	void *start = *p;
+	int err;
 	struct ceph_pg_pool_info *pi;
 
 	dout("%s %p to %p len %d\n", __func__, *p, end, (int)(end - *p));
 
-	ceph_decode_16_safe(p, end, version, bad);
+	ceph_decode_16_safe(p, end, version, e_inval);
 	if (version > 6) {
 		pr_warning("got unknown v %d > 6 of osdmap\n", version);
-		goto bad;
+		goto e_inval;
 	}
 	if (version < 6) {
 		pr_warning("got old v %d < 6 of osdmap\n", version);
-		goto bad;
+		goto e_inval;
 	}
 
-	ceph_decode_need(p, end, 2*sizeof(u64)+6*sizeof(u32), bad);
+	ceph_decode_need(p, end, 2*sizeof(u64)+6*sizeof(u32), e_inval);
 	ceph_decode_copy(p, &map->fsid, sizeof(map->fsid));
 	epoch = map->epoch = ceph_decode_32(p);
 	ceph_decode_copy(p, &map->created, sizeof(map->created));
 	ceph_decode_copy(p, &map->modified, sizeof(map->modified));
 
-	ceph_decode_32_safe(p, end, max, bad);
+	ceph_decode_32_safe(p, end, max, e_inval);
 	while (max--) {
-		ceph_decode_need(p, end, 8 + 2, bad);
-		err = -ENOMEM;
+		ceph_decode_need(p, end, 8 + 2, e_inval);
 		pi = kzalloc(sizeof(*pi), GFP_NOFS);
-		if (!pi)
+		if (!pi) {
+			err = -ENOMEM;
 			goto bad;
+		}
 		pi->id = ceph_decode_64(p);
 		err = __decode_pool(p, end, pi);
 		if (err < 0) {
@@ -728,27 +729,25 @@ static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
 	}
 
 	err = __decode_pool_names(p, end, map);
-	if (err < 0) {
-		dout("fail to decode pool names");
+	if (err)
 		goto bad;
-	}
 
-	ceph_decode_32_safe(p, end, map->pool_max, bad);
+	ceph_decode_32_safe(p, end, map->pool_max, e_inval);
 
-	ceph_decode_32_safe(p, end, map->flags, bad);
+	ceph_decode_32_safe(p, end, map->flags, e_inval);
 
 	max = ceph_decode_32(p);
 
 	/* (re)alloc osd arrays */
 	err = osdmap_set_max_osd(map, max);
-	if (err < 0)
+	if (err)
 		goto bad;
 
 	/* osds */
-	err = -EINVAL;
 	ceph_decode_need(p, end, 3*sizeof(u32) +
 			 map->max_osd*(1 + sizeof(*map->osd_weight) +
-				       sizeof(*map->osd_addr)), bad);
+				       sizeof(*map->osd_addr)), e_inval);
+
 	*p += 4; /* skip length field (should match max) */
 	ceph_decode_copy(p, map->osd_state, map->max_osd);
 
@@ -762,7 +761,7 @@ static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
 		ceph_decode_addr(&map->osd_addr[i]);
 
 	/* pg_temp */
-	ceph_decode_32_safe(p, end, len, bad);
+	ceph_decode_32_safe(p, end, len, e_inval);
 	for (i = 0; i < len; i++) {
 		int n, j;
 		struct ceph_pg pgid;
@@ -771,16 +770,16 @@ static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
 		err = ceph_decode_pgid(p, end, &pgid);
 		if (err)
 			goto bad;
-		ceph_decode_need(p, end, sizeof(u32), bad);
+		ceph_decode_need(p, end, sizeof(u32), e_inval);
 		n = ceph_decode_32(p);
-		err = -EINVAL;
 		if (n > (UINT_MAX - sizeof(*pg)) / sizeof(u32))
-			goto bad;
-		ceph_decode_need(p, end, n * sizeof(u32), bad);
-		err = -ENOMEM;
+			goto e_inval;
+		ceph_decode_need(p, end, n * sizeof(u32), e_inval);
 		pg = kmalloc(sizeof(*pg) + n*sizeof(u32), GFP_NOFS);
-		if (!pg)
+		if (!pg) {
+			err = -ENOMEM;
 			goto bad;
+		}
 		pg->pgid = pgid;
 		pg->len = n;
 		for (j = 0; j < n; j++)
@@ -794,10 +793,10 @@ static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
 	}
 
 	/* crush */
-	ceph_decode_32_safe(p, end, len, bad);
+	ceph_decode_32_safe(p, end, len, e_inval);
 	dout("osdmap_decode crush len %d from off 0x%x\n", len,
 	     (int)(*p - start));
-	ceph_decode_need(p, end, len, bad);
+	ceph_decode_need(p, end, len, e_inval);
 	map->crush = crush_decode(*p, end);
 	*p += len;
 	if (IS_ERR(map->crush)) {
@@ -812,6 +811,8 @@ static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
 	dout("full osdmap epoch %d max_osd %d\n", map->epoch, map->max_osd);
 	return 0;
 
+e_inval:
+	err = -EINVAL;
 bad:
 	pr_err("corrupt full osdmap (%d) epoch %d off %d (%p of %p-%p)\n",
 	       err, epoch, (int)(*p - start), *p, start, end);
-- 
1.7.10.4

