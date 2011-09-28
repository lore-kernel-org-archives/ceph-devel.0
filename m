From: Sage Weil <sage@newdream.net>
Subject: [PATCH 4/5] libceph: fix pg_temp mapping calculation
Date: Wed, 28 Sep 2011 10:26:30 -0700
Message-ID: <1317230791-6642-5-git-send-email-sage@newdream.net>
References: <1317230791-6642-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46495 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549Ab1I1R0i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Sep 2011 13:26:38 -0400
In-Reply-To: <1317230791-6642-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

We need to apply the modulo pg_num calculation before looking up a pgid in
the pg_temp mapping rbtree.  This fixes pg_temp mappings, and fixes
(some) misdirected requests that result in messages like

[WRN] client4104 10.0.1.219:0/275025290 misdirected client4104.1:129 0.1 to osd0 not [1,0] in e11/11

on the server and stall make the client block without getting a reply (at
least until the pg_temp mapping goes way, but that can take a long long
time).

Reorder calc_pg_raw() a bit to make more sense.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 net/ceph/osdmap.c |   34 +++++++++++++++++++++-------------
 1 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index e97c358..eceb8d5 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1046,10 +1046,25 @@ static int *calc_pg_raw(struct ceph_osdmap *osdmap, struct ceph_pg pgid,
 	struct ceph_pg_mapping *pg;
 	struct ceph_pg_pool_info *pool;
 	int ruleno;
-	unsigned poolid, ps, pps;
+	unsigned poolid, ps, pps, t;
 	int preferred;
 
+	poolid = le32_to_cpu(pgid.pool);
+	ps = le16_to_cpu(pgid.ps);
+	preferred = (s16)le16_to_cpu(pgid.preferred);
+
+	pool = __lookup_pg_pool(&osdmap->pg_pools, poolid);
+	if (!pool)
+		return NULL;
+
 	/* pg_temp? */
+	if (preferred >= 0)
+		t = ceph_stable_mod(ps, le32_to_cpu(pool->v.lpg_num),
+				    pool->lpgp_num_mask);
+	else
+		t = ceph_stable_mod(ps, le32_to_cpu(pool->v.pg_num),
+				    pool->pgp_num_mask);
+	pgid.ps = cpu_to_le16(t);
 	pg = __lookup_pg_mapping(&osdmap->pg_temp, pgid);
 	if (pg) {
 		*num = pg->len;
@@ -1057,18 +1072,6 @@ static int *calc_pg_raw(struct ceph_osdmap *osdmap, struct ceph_pg pgid,
 	}
 
 	/* crush */
-	poolid = le32_to_cpu(pgid.pool);
-	ps = le16_to_cpu(pgid.ps);
-	preferred = (s16)le16_to_cpu(pgid.preferred);
-
-	/* don't forcefeed bad device ids to crush */
-	if (preferred >= osdmap->max_osd ||
-	    preferred >= osdmap->crush->max_devices)
-		preferred = -1;
-
-	pool = __lookup_pg_pool(&osdmap->pg_pools, poolid);
-	if (!pool)
-		return NULL;
 	ruleno = crush_find_rule(osdmap->crush, pool->v.crush_ruleset,
 				 pool->v.type, pool->v.size);
 	if (ruleno < 0) {
@@ -1078,6 +1081,11 @@ static int *calc_pg_raw(struct ceph_osdmap *osdmap, struct ceph_pg pgid,
 		return NULL;
 	}
 
+	/* don't forcefeed bad device ids to crush */
+	if (preferred >= osdmap->max_osd ||
+	    preferred >= osdmap->crush->max_devices)
+		preferred = -1;
+
 	if (preferred >= 0)
 		pps = ceph_stable_mod(ps,
 				      le32_to_cpu(pool->v.lpgp_num),
-- 
1.7.0

