From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5/6] libceph: upmap semantic changes
Date: Fri, 28 Jul 2017 14:41:29 +0200
Message-ID: <1501245690-2362-6-git-send-email-idryomov@gmail.com>
References: <1501245690-2362-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36741 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbdG1Mlo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Jul 2017 08:41:44 -0400
Received: by mail-wm0-f68.google.com with SMTP id 184so27285809wmo.3
        for <ceph-devel@vger.kernel.org>; Fri, 28 Jul 2017 05:41:43 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c13sm8263773wrc.7.2017.07.28.05.41.41
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jul 2017 05:41:42 -0700 (PDT)
In-Reply-To: <1501245690-2362-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

- apply both pg_upmap and pg_upmap_items
- allow bidirectional swap of pg-upmap-items

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/osdmap.c | 39 +++++++++++----------------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 2586e5546143..0bec71fa712e 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -2437,40 +2437,23 @@ static void apply_upmap(struct ceph_osdmap *osdmap,
 		for (i = 0; i < pg->pg_upmap.len; i++)
 			raw->osds[i] = pg->pg_upmap.osds[i];
 		raw->size = pg->pg_upmap.len;
-		return;
+		/* check and apply pg_upmap_items, if any */
 	}
 
 	pg = lookup_pg_mapping(&osdmap->pg_upmap_items, pgid);
 	if (pg) {
-		/*
-		 * Note: this approach does not allow a bidirectional swap,
-		 * e.g., [[1,2],[2,1]] applied to [0,1,2] -> [0,2,1].
-		 */
-		for (i = 0; i < pg->pg_upmap_items.len; i++) {
-			int from = pg->pg_upmap_items.from_to[i][0];
-			int to = pg->pg_upmap_items.from_to[i][1];
-			int pos = -1;
-			bool exists = false;
-
-			/* make sure replacement doesn't already appear */
-			for (j = 0; j < raw->size; j++) {
-				int osd = raw->osds[j];
-
-				if (osd == to) {
-					exists = true;
+		for (i = 0; i < raw->size; i++) {
+			for (j = 0; j < pg->pg_upmap_items.len; j++) {
+				int from = pg->pg_upmap_items.from_to[j][0];
+				int to = pg->pg_upmap_items.from_to[j][1];
+
+				if (from == raw->osds[i]) {
+					if (!(to != CRUSH_ITEM_NONE &&
+					      to < osdmap->max_osd &&
+					      osdmap->osd_weight[to] == 0))
+						raw->osds[i] = to;
 					break;
 				}
-				/* ignore mapping if target is marked out */
-				if (osd == from && pos < 0 &&
-				    !(to != CRUSH_ITEM_NONE &&
-				      to < osdmap->max_osd &&
-				      osdmap->osd_weight[to] == 0)) {
-					pos = j;
-				}
-			}
-			if (!exists && pos >= 0) {
-				raw->osds[pos] = to;
-				return;
 			}
 		}
 	}
-- 
2.4.3

