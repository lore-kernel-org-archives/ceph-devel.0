From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 26/33] libceph: introduce pg_to_raw_osds() and raw_to_up_osds() helpers
Date: Thu, 27 Mar 2014 20:18:12 +0200
Message-ID: <1395944299-21970-27-git-send-email-ilya.dryomov@inktank.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42]:53957 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757156AbaC0STZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 14:19:25 -0400
Received: by mail-ee0-f42.google.com with SMTP id d17so3238219eek.1
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 11:19:24 -0700 (PDT)
Received: from localhost ([109.110.66.7])
        by mx.google.com with ESMTPSA id w12sm5942975eez.36.2014.03.27.11.19.22
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 11:19:23 -0700 (PDT)
In-Reply-To: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

pg_to_raw_osds() helper for computing a raw (crush) set, which can
contain non-existant and down osds.

raw_to_up_osds() helper for pruning non-existant and down osds from the
raw set, therefore transforming it into an up set, and determining up
primary.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osdmap.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 3ac2098972ea..ee095e07cf98 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1514,6 +1514,82 @@ static int *calc_pg_raw(struct ceph_osdmap *osdmap, struct ceph_pg pgid,
 }
 
 /*
+ * Calculate raw (crush) set for given pgid.
+ *
+ * Return raw set length, or error.
+ */
+static int pg_to_raw_osds(struct ceph_osdmap *osdmap,
+			  struct ceph_pg_pool_info *pool,
+			  struct ceph_pg pgid, u32 pps, int *osds)
+{
+	int ruleno;
+	int len;
+
+	/* crush */
+	ruleno = crush_find_rule(osdmap->crush, pool->crush_ruleset,
+				 pool->type, pool->size);
+	if (ruleno < 0) {
+		pr_err("no crush rule: pool %lld ruleset %d type %d size %d\n",
+		       pgid.pool, pool->crush_ruleset, pool->type,
+		       pool->size);
+		return -ENOENT;
+	}
+
+	len = do_crush(osdmap, ruleno, pps, osds,
+		       min_t(int, pool->size, CEPH_PG_MAX_SIZE),
+		       osdmap->osd_weight, osdmap->max_osd);
+	if (len < 0) {
+		pr_err("error %d from crush rule %d: pool %lld ruleset %d type %d size %d\n",
+		       len, ruleno, pgid.pool, pool->crush_ruleset,
+		       pool->type, pool->size);
+		return len;
+	}
+
+	return len;
+}
+
+/*
+ * Given raw set, calculate up set and up primary.
+ *
+ * Return up set length.  *primary is set to up primary osd id, or -1
+ * if up set is empty.
+ */
+static int raw_to_up_osds(struct ceph_osdmap *osdmap,
+			  struct ceph_pg_pool_info *pool,
+			  int *osds, int len, int *primary)
+{
+	int up_primary = -1;
+	int i;
+
+	if (ceph_can_shift_osds(pool)) {
+		int removed = 0;
+
+		for (i = 0; i < len; i++) {
+			if (ceph_osd_is_down(osdmap, osds[i])) {
+				removed++;
+				continue;
+			}
+			if (removed)
+				osds[i - removed] = osds[i];
+		}
+
+		len -= removed;
+		if (len > 0)
+			up_primary = osds[0];
+	} else {
+		for (i = len - 1; i >= 0; i--) {
+			if (ceph_osd_is_down(osdmap, osds[i]))
+				osds[i] = CRUSH_ITEM_NONE;
+			else
+				up_primary = osds[i];
+		}
+	}
+
+	*primary = up_primary;
+	return len;
+}
+
+/*
  * Return acting set for given pgid.
  */
 int ceph_calc_pg_acting(struct ceph_osdmap *osdmap, struct ceph_pg pgid,
-- 
1.7.10.4

