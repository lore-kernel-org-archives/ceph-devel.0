From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 16/33] libceph: introduce decode{,_new}_pg_temp() and switch to them
Date: Thu, 27 Mar 2014 20:18:02 +0200
Message-ID: <1395944299-21970-17-git-send-email-ilya.dryomov@inktank.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:38469 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757116AbaC0STB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 14:19:01 -0400
Received: by mail-ee0-f47.google.com with SMTP id b15so3189374eek.20
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 11:19:00 -0700 (PDT)
Received: from localhost ([109.110.66.7])
        by mx.google.com with ESMTPSA id 44sm5952496eek.30.2014.03.27.11.18.59
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 11:18:59 -0700 (PDT)
In-Reply-To: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Consolidate pg_temp (full map, map<pg_t, vector<u32>>) and new_pg_temp
(inc map, same) decoding logic into a common helper and switch to it.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osdmap.c |  139 ++++++++++++++++++++++++++---------------------------
 1 file changed, 67 insertions(+), 72 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 4565c72fec5c..0134df3639d2 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -732,6 +732,67 @@ static int decode_new_pools(void **p, void *end, struct ceph_osdmap *map)
 	return __decode_pools(p, end, map, true);
 }
 
+static int __decode_pg_temp(void **p, void *end, struct ceph_osdmap *map,
+			    bool incremental)
+{
+	u32 n;
+
+	ceph_decode_32_safe(p, end, n, e_inval);
+	while (n--) {
+		struct ceph_pg pgid;
+		u32 len, i;
+		int ret;
+
+		ret = ceph_decode_pgid(p, end, &pgid);
+		if (ret)
+			return ret;
+
+		ceph_decode_32_safe(p, end, len, e_inval);
+
+		ret = __remove_pg_mapping(&map->pg_temp, pgid);
+		BUG_ON(!incremental && ret != -ENOENT);
+
+		if (!incremental || len > 0) {
+			struct ceph_pg_mapping *pg;
+
+			ceph_decode_need(p, end, len*sizeof(u32), e_inval);
+
+			if (len > (UINT_MAX - sizeof(*pg)) / sizeof(u32))
+				return -EINVAL;
+
+			pg = kzalloc(sizeof(*pg) + len*sizeof(u32), GFP_NOFS);
+			if (!pg)
+				return -ENOMEM;
+
+			pg->pgid = pgid;
+			pg->len = len;
+			for (i = 0; i < len; i++)
+				pg->osds[i] = ceph_decode_32(p);
+
+			ret = __insert_pg_mapping(pg, &map->pg_temp);
+			if (ret) {
+				kfree(pg);
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+
+e_inval:
+	return -EINVAL;
+}
+
+static int decode_pg_temp(void **p, void *end, struct ceph_osdmap *map)
+{
+	return __decode_pg_temp(p, end, map, false);
+}
+
+static int decode_new_pg_temp(void **p, void *end, struct ceph_osdmap *map)
+{
+	return __decode_pg_temp(p, end, map, true);
+}
+
 /*
  * decode a full map.
  */
@@ -804,36 +865,9 @@ static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
 		ceph_decode_addr(&map->osd_addr[i]);
 
 	/* pg_temp */
-	ceph_decode_32_safe(p, end, len, e_inval);
-	for (i = 0; i < len; i++) {
-		int n, j;
-		struct ceph_pg pgid;
-		struct ceph_pg_mapping *pg;
-
-		err = ceph_decode_pgid(p, end, &pgid);
-		if (err)
-			goto bad;
-		ceph_decode_need(p, end, sizeof(u32), e_inval);
-		n = ceph_decode_32(p);
-		if (n > (UINT_MAX - sizeof(*pg)) / sizeof(u32))
-			goto e_inval;
-		ceph_decode_need(p, end, n * sizeof(u32), e_inval);
-		pg = kmalloc(sizeof(*pg) + n*sizeof(u32), GFP_NOFS);
-		if (!pg) {
-			err = -ENOMEM;
-			goto bad;
-		}
-		pg->pgid = pgid;
-		pg->len = n;
-		for (j = 0; j < n; j++)
-			pg->osds[j] = ceph_decode_32(p);
-
-		err = __insert_pg_mapping(pg, &map->pg_temp);
-		if (err)
-			goto bad;
-		dout(" added pg_temp %lld.%x len %d\n", pgid.pool, pgid.seed,
-		     len);
-	}
+	err = decode_pg_temp(p, end, map);
+	if (err)
+		goto bad;
 
 	/* crush */
 	ceph_decode_32_safe(p, end, len, e_inval);
@@ -1032,48 +1066,9 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
 	}
 
 	/* new_pg_temp */
-	ceph_decode_32_safe(p, end, len, e_inval);
-	while (len--) {
-		struct ceph_pg_mapping *pg;
-		int j;
-		struct ceph_pg pgid;
-		u32 pglen;
-
-		err = ceph_decode_pgid(p, end, &pgid);
-		if (err)
-			goto bad;
-		ceph_decode_need(p, end, sizeof(u32), e_inval);
-		pglen = ceph_decode_32(p);
-		if (pglen) {
-			ceph_decode_need(p, end, pglen*sizeof(u32), e_inval);
-
-			/* removing existing (if any) */
-			(void) __remove_pg_mapping(&map->pg_temp, pgid);
-
-			/* insert */
-			if (pglen > (UINT_MAX - sizeof(*pg)) / sizeof(u32))
-				goto e_inval;
-			pg = kmalloc(sizeof(*pg) + sizeof(u32)*pglen, GFP_NOFS);
-			if (!pg) {
-				err = -ENOMEM;
-				goto bad;
-			}
-			pg->pgid = pgid;
-			pg->len = pglen;
-			for (j = 0; j < pglen; j++)
-				pg->osds[j] = ceph_decode_32(p);
-			err = __insert_pg_mapping(pg, &map->pg_temp);
-			if (err) {
-				kfree(pg);
-				goto bad;
-			}
-			dout(" added pg_temp %lld.%x len %d\n", pgid.pool,
-			     pgid.seed, pglen);
-		} else {
-			/* remove */
-			__remove_pg_mapping(&map->pg_temp, pgid);
-		}
-	}
+	err = decode_new_pg_temp(p, end, map);
+	if (err)
+		goto bad;
 
 	/* ignore the rest */
 	*p = end;
-- 
1.7.10.4

