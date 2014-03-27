From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 15/33] libceph: switch osdmap_set_max_osd() to krealloc()
Date: Thu, 27 Mar 2014 20:18:01 +0200
Message-ID: <1395944299-21970-16-git-send-email-ilya.dryomov@inktank.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:39486 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757100AbaC0SS7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 14:18:59 -0400
Received: by mail-ee0-f47.google.com with SMTP id b15so3189344eek.20
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 11:18:58 -0700 (PDT)
Received: from localhost ([109.110.66.7])
        by mx.google.com with ESMTPSA id 48sm5964803eei.24.2014.03.27.11.18.56
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 11:18:57 -0700 (PDT)
In-Reply-To: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Use krealloc() instead of rolling our own.  (krealloc() with a NULL
first argument acts as a kmalloc()).  Properly initalize the new array
elements.  This is needed to make future additions to osdmap easier.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osdmap.c |   32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index d6a569c5508f..4565c72fec5c 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -646,38 +646,40 @@ void ceph_osdmap_destroy(struct ceph_osdmap *map)
 }
 
 /*
- * adjust max osd value.  reallocate arrays.
+ * Adjust max_osd value, (re)allocate arrays.
+ *
+ * The new elements are properly initialized.
  */
 static int osdmap_set_max_osd(struct ceph_osdmap *map, int max)
 {
 	u8 *state;
-	struct ceph_entity_addr *addr;
 	u32 *weight;
+	struct ceph_entity_addr *addr;
+	int i;
 
-	state = kcalloc(max, sizeof(*state), GFP_NOFS);
-	addr = kcalloc(max, sizeof(*addr), GFP_NOFS);
-	weight = kcalloc(max, sizeof(*weight), GFP_NOFS);
-	if (state == NULL || addr == NULL || weight == NULL) {
+	state = krealloc(map->osd_state, max*sizeof(*state), GFP_NOFS);
+	weight = krealloc(map->osd_weight, max*sizeof(*weight), GFP_NOFS);
+	addr = krealloc(map->osd_addr, max*sizeof(*addr), GFP_NOFS);
+	if (!state || !weight || !addr) {
 		kfree(state);
-		kfree(addr);
 		kfree(weight);
+		kfree(addr);
+
 		return -ENOMEM;
 	}
 
-	/* copy old? */
-	if (map->osd_state) {
-		memcpy(state, map->osd_state, map->max_osd*sizeof(*state));
-		memcpy(addr, map->osd_addr, map->max_osd*sizeof(*addr));
-		memcpy(weight, map->osd_weight, map->max_osd*sizeof(*weight));
-		kfree(map->osd_state);
-		kfree(map->osd_addr);
-		kfree(map->osd_weight);
+	for (i = map->max_osd; i < max; i++) {
+		state[i] = 0;
+		weight[i] = CEPH_OSD_OUT;
+		memset(addr + i, 0, sizeof(*addr));
 	}
 
 	map->osd_state = state;
 	map->osd_weight = weight;
 	map->osd_addr = addr;
+
 	map->max_osd = max;
+
 	return 0;
 }
 
-- 
1.7.10.4

