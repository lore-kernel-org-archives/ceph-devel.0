From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 31/33] libceph: add support for osd primary affinity
Date: Thu, 27 Mar 2014 20:18:17 +0200
Message-ID: <1395944299-21970-32-git-send-email-ilya.dryomov@inktank.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:54290 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757188AbaC0STh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 14:19:37 -0400
Received: by mail-ee0-f52.google.com with SMTP id e49so3139954eek.25
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 11:19:35 -0700 (PDT)
Received: from localhost ([109.110.66.7])
        by mx.google.com with ESMTPSA id bc51sm5969760eeb.22.2014.03.27.11.19.34
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 11:19:35 -0700 (PDT)
In-Reply-To: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Respond to non-default primary_affinity values accordingly.  (Primary
affinity allows the admin to shift 'primary responsibility' away from
specific osds, effectively shifting around the read side of the
workload and whatever overhead is incurred by peering and writes by
virtue of being the primary).

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osdmap.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index ed52b47d0ddb..8c596a13c60f 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1589,6 +1589,72 @@ static int raw_to_up_osds(struct ceph_osdmap *osdmap,
 	return len;
 }
 
+static void apply_primary_affinity(struct ceph_osdmap *osdmap, u32 pps,
+				   struct ceph_pg_pool_info *pool,
+				   int *osds, int len, int *primary)
+{
+	int i;
+	int pos = -1;
+
+	/*
+	 * Do we have any non-default primary_affinity values for these
+	 * osds?
+	 */
+	if (!osdmap->osd_primary_affinity)
+		return;
+
+	for (i = 0; i < len; i++) {
+		if (osds[i] != CRUSH_ITEM_NONE &&
+		    osdmap->osd_primary_affinity[i] !=
+					CEPH_OSD_DEFAULT_PRIMARY_AFFINITY) {
+			break;
+		}
+	}
+	if (i == len)
+		return;
+
+	/*
+	 * Pick the primary.  Feed both the seed (for the pg) and the
+	 * osd into the hash/rng so that a proportional fraction of an
+	 * osd's pgs get rejected as primary.
+	 */
+	for (i = 0; i < len; i++) {
+		int o;
+		u32 a;
+
+		o = osds[i];
+		if (o == CRUSH_ITEM_NONE)
+			continue;
+
+		a = osdmap->osd_primary_affinity[o];
+		if (a < CEPH_OSD_MAX_PRIMARY_AFFINITY &&
+		    (crush_hash32_2(CRUSH_HASH_RJENKINS1,
+				    pps, o) >> 16) >= a) {
+			/*
+			 * We chose not to use this primary.  Note it
+			 * anyway as a fallback in case we don't pick
+			 * anyone else, but keep looking.
+			 */
+			if (pos < 0)
+				pos = i;
+		} else {
+			pos = i;
+			break;
+		}
+	}
+	if (pos < 0)
+		return;
+
+	*primary = osds[pos];
+
+	if (ceph_can_shift_osds(pool) && pos > 0) {
+		/* move the new primary to the front */
+		for (i = pos; i > 0; i--)
+			osds[i] = osds[i - 1];
+		osds[0] = *primary;
+	}
+}
+
 /*
  * Given up set, apply pg_temp and primary_temp mappings.
  *
@@ -1691,6 +1757,8 @@ int ceph_calc_pg_acting(struct ceph_osdmap *osdmap, struct ceph_pg pgid,
 
 	len = raw_to_up_osds(osdmap, pool, osds, len, primary);
 
+	apply_primary_affinity(osdmap, pps, pool, osds, len, primary);
+
 	len = apply_temps(osdmap, pool, pgid, osds, len, primary);
 
 	return len;
-- 
1.7.10.4

