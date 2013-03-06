From: Sage Weil <sage@inktank.com>
Subject: [PATCH] libceph: fix decoding of pgids
Date: Wed,  6 Mar 2013 14:15:24 -0800
Message-ID: <1362608124-7567-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49989 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756567Ab3CFWP3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Mar 2013 17:15:29 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

In 4f6a7e5ee1393ec4b243b39dac9f36992d161540 we effectively dropped support
for the legacy encoding for the OSDMap and incremental.  However, we didn't
fix the decoding for the pgid.

Signed-off-by: Sage Weil <sage@inktank.com>
---
 net/ceph/osdmap.c |   40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index a47ee06..6975102 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -654,6 +654,24 @@ static int osdmap_set_max_osd(struct ceph_osdmap *map, int max)
 	return 0;
 }
 
+static int __decode_pgid(void **p, void *end, struct ceph_pg *pg)
+{
+	u8 v;
+
+	ceph_decode_need(p, end, 1+8+4+4, bad);
+	v = ceph_decode_8(p);
+	if (v != 1)
+		goto bad;
+	pg->pool = ceph_decode_64(p);
+	pg->seed = ceph_decode_32(p);
+	*p += 4; /* skip preferred */
+	return 0;
+
+bad:
+	dout("error decoding pgid\n");
+	return -EINVAL;
+}
+
 /*
  * decode a full map.
  */
@@ -745,13 +763,11 @@ struct ceph_osdmap *osdmap_decode(void **p, void *end)
 	for (i = 0; i < len; i++) {
 		int n, j;
 		struct ceph_pg pgid;
-		struct ceph_pg_v1 pgid_v1;
 		struct ceph_pg_mapping *pg;
 
-		ceph_decode_need(p, end, sizeof(u32) + sizeof(u64), bad);
-		ceph_decode_copy(p, &pgid_v1, sizeof(pgid_v1));
-		pgid.pool = le32_to_cpu(pgid_v1.pool);
-		pgid.seed = le16_to_cpu(pgid_v1.ps);
+		err = __decode_pgid(p, end, &pgid);
+		if (err)
+			goto bad;
 		n = ceph_decode_32(p);
 		err = -EINVAL;
 		if (n > (UINT_MAX - sizeof(*pg)) / sizeof(u32))
@@ -818,8 +834,8 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
 	u16 version;
 
 	ceph_decode_16_safe(p, end, version, bad);
-	if (version > 6) {
-		pr_warning("got unknown v %d > %d of inc osdmap\n", version, 6);
+	if (version != 6) {
+		pr_warning("got unknown v %d != 6 of inc osdmap\n", version);
 		goto bad;
 	}
 
@@ -963,15 +979,13 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
 	while (len--) {
 		struct ceph_pg_mapping *pg;
 		int j;
-		struct ceph_pg_v1 pgid_v1;
 		struct ceph_pg pgid;
 		u32 pglen;
-		ceph_decode_need(p, end, sizeof(u64) + sizeof(u32), bad);
-		ceph_decode_copy(p, &pgid_v1, sizeof(pgid_v1));
-		pgid.pool = le32_to_cpu(pgid_v1.pool);
-		pgid.seed = le16_to_cpu(pgid_v1.ps);
-		pglen = ceph_decode_32(p);
 
+		err = __decode_pgid(p, end, &pgid);
+		if (err)
+			goto bad;
+		pglen = ceph_decode_32(p);
 		if (pglen) {
 			ceph_decode_need(p, end, pglen*sizeof(u32), bad);
 
-- 
1.7.9.5

