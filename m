From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] libceph: don't allow bidirectional swap of pg-upmap-items
Date: Tue, 19 Sep 2017 20:02:27 +0200
Message-ID: <1505844147-17221-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38506 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdISSDH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Sep 2017 14:03:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id x17so334244wmd.5
        for <ceph-devel@vger.kernel.org>; Tue, 19 Sep 2017 11:03:07 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q140sm1753311wmd.17.2017.09.19.11.03.04
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Sep 2017 11:03:04 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This reverts most of commit f53b7665c8ce ("libceph: upmap semantic
changes").

We need to prevent duplicates in the final result.  For example, we
can currently take

  [1,2,3] and apply [(1,2)] and get [2,2,3]

or

  [1,2,3] and apply [(3,2)] and get [1,2,2]

The rest of the system is not prepared to handle duplicates in the
result set like this.

The reverted piece was intended to allow

  [1,2,3] and [(1,2),(2,1)] to get [2,1,3]

to reorder primaries.  First, this bidirectional swap is hard to
implement in a way that also prevents dups.  For example, [1,2,3] and
[(1,4),(2,3),(3,4)] would give [4,3,4] but would we just drop the last
step we'd have [4,3,3] which is also invalid, etc.  Simpler to just not
handle bidirectional swaps.  In practice, they are not needed: if you
just want to choose a different primary then use primary_affinity, or
pg_upmap (not pg_upmap_items).

Cc: stable@vger.kernel.org # 4.13
Link: http://tracker.ceph.com/issues/21410
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/osdmap.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index f358d0bfa76b..79d14d70b7ea 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -2445,19 +2445,34 @@ static void apply_upmap(struct ceph_osdmap *osdmap,
 
 	pg = lookup_pg_mapping(&osdmap->pg_upmap_items, pgid);
 	if (pg) {
-		for (i = 0; i < raw->size; i++) {
-			for (j = 0; j < pg->pg_upmap_items.len; j++) {
-				int from = pg->pg_upmap_items.from_to[j][0];
-				int to = pg->pg_upmap_items.from_to[j][1];
-
-				if (from == raw->osds[i]) {
-					if (!(to != CRUSH_ITEM_NONE &&
-					      to < osdmap->max_osd &&
-					      osdmap->osd_weight[to] == 0))
-						raw->osds[i] = to;
+		/*
+		 * Note: this approach does not allow a bidirectional swap,
+		 * e.g., [[1,2],[2,1]] applied to [0,1,2] -> [0,2,1].
+		 */
+		for (i = 0; i < pg->pg_upmap_items.len; i++) {
+			int from = pg->pg_upmap_items.from_to[i][0];
+			int to = pg->pg_upmap_items.from_to[i][1];
+			int pos = -1;
+			bool exists = false;
+
+			/* make sure replacement doesn't already appear */
+			for (j = 0; j < raw->size; j++) {
+				int osd = raw->osds[j];
+
+				if (osd == to) {
+					exists = true;
 					break;
 				}
+				/* ignore mapping if target is marked out */
+				if (osd == from && pos < 0 &&
+				    !(to != CRUSH_ITEM_NONE &&
+				      to < osdmap->max_osd &&
+				      osdmap->osd_weight[to] == 0)) {
+					pos = j;
+				}
 			}
+			if (!exists && pos >= 0)
+				raw->osds[pos] = to;
 		}
 	}
 }
-- 
2.4.3

