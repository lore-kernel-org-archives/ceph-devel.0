From: Sage Weil <sage@newdream.net>
Subject: [PATCH 09/11] crush: fix tree node weight lookup
Date: Fri,  4 May 2012 15:54:06 -0700
Message-ID: <1336172048-6848-10-git-send-email-sage@newdream.net>
References: <1336172048-6848-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37655 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760493Ab2EDWyX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 May 2012 18:54:23 -0400
In-Reply-To: <1336172048-6848-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

Fix the node weight lookup for tree buckets by using a correct accessor.

Reflects ceph.git commit d287ade5bcbdca82a3aef145b92924cf1e856733.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 include/linux/crush/crush.h |    5 +++++
 net/ceph/crush/crush.c      |    4 +---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/crush/crush.h b/include/linux/crush/crush.h
index 158a4d2..7c47508 100644
--- a/include/linux/crush/crush.h
+++ b/include/linux/crush/crush.h
@@ -166,4 +166,9 @@ extern void crush_destroy_bucket_straw(struct crush_bucket_straw *b);
 extern void crush_destroy_bucket(struct crush_bucket *b);
 extern void crush_destroy(struct crush_map *map);
 
+static inline int crush_calc_tree_node(int i)
+{
+	return ((i+1) << 1)-1;
+}
+
 #endif
diff --git a/net/ceph/crush/crush.c b/net/ceph/crush/crush.c
index bab3eac..568adac 100644
--- a/net/ceph/crush/crush.c
+++ b/net/ceph/crush/crush.c
@@ -37,9 +37,7 @@ int crush_get_bucket_item_weight(const struct crush_bucket *b, int p)
 	case CRUSH_BUCKET_LIST:
 		return ((struct crush_bucket_list *)b)->item_weights[p];
 	case CRUSH_BUCKET_TREE:
-		if (p & 1)
-			return ((struct crush_bucket_tree *)b)->node_weights[p];
-		return 0;
+		return ((struct crush_bucket_tree *)b)->node_weights[crush_calc_tree_node(p)];
 	case CRUSH_BUCKET_STRAW:
 		return ((struct crush_bucket_straw *)b)->item_weights[p];
 	}
-- 
1.7.9

