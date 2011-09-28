From: Sage Weil <sage@newdream.net>
Subject: [PATCH 5/5] libceph: fix pg_temp mapping update
Date: Wed, 28 Sep 2011 10:26:31 -0700
Message-ID: <1317230791-6642-6-git-send-email-sage@newdream.net>
References: <1317230791-6642-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46498 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585Ab1I1R0i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Sep 2011 13:26:38 -0400
In-Reply-To: <1317230791-6642-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

The incremental map updates have a record for each pg_temp mapping that is
to be add/updated (len > 0) or removed (len == 0).  The old code was
written as if the updates were a complete enumeration; that was just wrong.
Update the code to remove 0-length entries and drop the rbtree traversal.

This avoids misdirected (and hung) requests that manifest as server
errors like

[WRN] client4104 10.0.1.219:0/275025290 misdirected client4104.1:129 0.1 to osd0 not [1,0] in e11/11

Signed-off-by: Sage Weil <sage@newdream.net>
---
 net/ceph/osdmap.c |   50 ++++++++++++++++++++++++--------------------------
 1 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index eceb8d5..fd863fe 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -339,6 +339,7 @@ static int __insert_pg_mapping(struct ceph_pg_mapping *new,
 	struct ceph_pg_mapping *pg = NULL;
 	int c;
 
+	dout("__insert_pg_mapping %llx %p\n", *(u64 *)&new->pgid, new);
 	while (*p) {
 		parent = *p;
 		pg = rb_entry(parent, struct ceph_pg_mapping, node);
@@ -366,16 +367,33 @@ static struct ceph_pg_mapping *__lookup_pg_mapping(struct rb_root *root,
 	while (n) {
 		pg = rb_entry(n, struct ceph_pg_mapping, node);
 		c = pgid_cmp(pgid, pg->pgid);
-		if (c < 0)
+		if (c < 0) {
 			n = n->rb_left;
-		else if (c > 0)
+		} else if (c > 0) {
 			n = n->rb_right;
-		else
+		} else {
+			dout("__lookup_pg_mapping %llx got %p\n",
+			     *(u64 *)&pgid, pg);
 			return pg;
+		}
 	}
 	return NULL;
 }
 
+static int __remove_pg_mapping(struct rb_root *root, struct ceph_pg pgid)
+{
+	struct ceph_pg_mapping *pg = __lookup_pg_mapping(root, pgid);
+
+	if (pg) {
+		dout("__remove_pg_mapping %llx %p\n", *(u64 *)&pgid, pg);
+		rb_erase(&pg->node, root);
+		kfree(pg);
+		return 0;
+	}
+	dout("__remove_pg_mapping %llx dne\n", *(u64 *)&pgid);
+	return -ENOENT;
+}
+
 /*
  * rbtree of pg pool info
  */
@@ -711,7 +729,6 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
 	void *start = *p;
 	int err = -EINVAL;
 	u16 version;
-	struct rb_node *rbp;
 
 	ceph_decode_16_safe(p, end, version, bad);
 	if (version > CEPH_OSDMAP_INC_VERSION) {
@@ -861,7 +878,6 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
 	}
 
 	/* new_pg_temp */
-	rbp = rb_first(&map->pg_temp);
 	ceph_decode_32_safe(p, end, len, bad);
 	while (len--) {
 		struct ceph_pg_mapping *pg;
@@ -872,18 +888,6 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
 		ceph_decode_copy(p, &pgid, sizeof(pgid));
 		pglen = ceph_decode_32(p);
 
-		/* remove any? */
-		while (rbp && pgid_cmp(rb_entry(rbp, struct ceph_pg_mapping,
-						node)->pgid, pgid) <= 0) {
-			struct ceph_pg_mapping *cur =
-				rb_entry(rbp, struct ceph_pg_mapping, node);
-
-			rbp = rb_next(rbp);
-			dout(" removed pg_temp %llx\n", *(u64 *)&cur->pgid);
-			rb_erase(&cur->node, &map->pg_temp);
-			kfree(cur);
-		}
-
 		if (pglen) {
 			/* insert */
 			ceph_decode_need(p, end, pglen*sizeof(u32), bad);
@@ -903,17 +907,11 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
 			}
 			dout(" added pg_temp %llx len %d\n", *(u64 *)&pgid,
 			     pglen);
+		} else {
+			/* remove */
+			__remove_pg_mapping(&map->pg_temp, pgid);
 		}
 	}
-	while (rbp) {
-		struct ceph_pg_mapping *cur =
-			rb_entry(rbp, struct ceph_pg_mapping, node);
-
-		rbp = rb_next(rbp);
-		dout(" removed pg_temp %llx\n", *(u64 *)&cur->pgid);
-		rb_erase(&cur->node, &map->pg_temp);
-		kfree(cur);
-	}
 
 	/* ignore the rest */
 	*p = end;
-- 
1.7.0

