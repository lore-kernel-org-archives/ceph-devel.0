From: roy.qing.li@gmail.com
Subject: [PATCH] libceph: fix a use after free issue in osdmap_set_max_osd
Date: Sun,  7 Sep 2014 18:10:51 +0800
Message-ID: <1410084652-23031-1-git-send-email-roy.qing.li@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:55880 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbaIGKKz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 7 Sep 2014 06:10:55 -0400
Received: by mail-pa0-f41.google.com with SMTP id lf10so3314987pab.14
        for <ceph-devel@vger.kernel.org>; Sun, 07 Sep 2014 03:10:54 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com

From: Li RongQing <roy.qing.li@gmail.com>

If the state variable is krealloced successfully, map->osd_state will be
freed, once following two reallocation failed, and exit the function
without resetting map->osd_state, map->osd_state become a wild pointer.

fix it by resetting them after krealloc successfully.

Signed-off-by: Li RongQing <roy.qing.li@gmail.com>
---
 net/ceph/osdmap.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index c547e46..81e9c66 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -671,15 +671,19 @@ static int osdmap_set_max_osd(struct ceph_osdmap *map, int max)
 	int i;
 
 	state = krealloc(map->osd_state, max*sizeof(*state), GFP_NOFS);
+	if (!state)
+		return -ENOMEM;
+	map->osd_state = state;
+
 	weight = krealloc(map->osd_weight, max*sizeof(*weight), GFP_NOFS);
-	addr = krealloc(map->osd_addr, max*sizeof(*addr), GFP_NOFS);
-	if (!state || !weight || !addr) {
-		kfree(state);
-		kfree(weight);
-		kfree(addr);
+	if (!weight)
+		return -ENOMEM;
+	map->osd_weight = weight;
 
+	addr = krealloc(map->osd_addr, max*sizeof(*addr), GFP_NOFS);
+	if (!addr)
 		return -ENOMEM;
-	}
+	map->osd_addr = addr;
 
 	for (i = map->max_osd; i < max; i++) {
 		state[i] = 0;
@@ -687,10 +691,6 @@ static int osdmap_set_max_osd(struct ceph_osdmap *map, int max)
 		memset(addr + i, 0, sizeof(*addr));
 	}
 
-	map->osd_state = state;
-	map->osd_weight = weight;
-	map->osd_addr = addr;
-
 	if (map->osd_primary_affinity) {
 		u32 *affinity;
 
-- 
1.7.10.4

