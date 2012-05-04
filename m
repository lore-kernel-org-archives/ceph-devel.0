From: Sage Weil <sage@newdream.net>
Subject: [PATCH 11/11] crush: warn on do_rule failure
Date: Fri,  4 May 2012 15:54:08 -0700
Message-ID: <1336172048-6848-12-git-send-email-sage@newdream.net>
References: <1336172048-6848-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37659 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760565Ab2EDWyX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 May 2012 18:54:23 -0400
In-Reply-To: <1336172048-6848-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

If we get an error code from crush_do_rule(), print an error to the
console.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 net/ceph/osdmap.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index dac448b..2592f3c 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1027,7 +1027,7 @@ static int *calc_pg_raw(struct ceph_osdmap *osdmap, struct ceph_pg pgid,
 	struct ceph_pg_mapping *pg;
 	struct ceph_pg_pool_info *pool;
 	int ruleno;
-	unsigned poolid, ps, pps, t;
+	unsigned poolid, ps, pps, t, r;
 
 	poolid = le32_to_cpu(pgid.pool);
 	ps = le16_to_cpu(pgid.ps);
@@ -1060,9 +1060,16 @@ static int *calc_pg_raw(struct ceph_osdmap *osdmap, struct ceph_pg pgid,
 			      le32_to_cpu(pool->v.pgp_num),
 			      pool->pgp_num_mask);
 	pps += poolid;
-	*num = crush_do_rule(osdmap->crush, ruleno, pps, osds,
-			     min_t(int, pool->v.size, *num),
-			     osdmap->osd_weight);
+	r = crush_do_rule(osdmap->crush, ruleno, pps, osds,
+			  min_t(int, pool->v.size, *num),
+			  osdmap->osd_weight);
+	if (r < 0) {
+		pr_err("error %d from crush rule: pool %d ruleset %d type %d"
+		       " size %d\n", r, poolid, pool->v.crush_ruleset,
+		       pool->v.type, pool->v.size);
+		return NULL;
+	}
+	*num = r;
 	return osds;
 }
 
-- 
1.7.9

