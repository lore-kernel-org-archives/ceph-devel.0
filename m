From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] ceph: Fix oops when handling mdsmap that decreases max_mds
Date: Thu, 20 Sep 2012 17:42:25 +0800
Message-ID: <1348134145-4646-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50871 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753772Ab2ITJm1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 20 Sep 2012 05:42:27 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

When i >= newmap->m_max_mds, ceph_mdsmap_get_addr(newmap, i) return
NULL. Passing NULL to memcmp() triggers oops.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/mds_client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index a5a7354..1bcf712 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2625,7 +2625,8 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 		     ceph_mdsmap_is_laggy(newmap, i) ? " (laggy)" : "",
 		     session_state_name(s->s_state));
 
-		if (memcmp(ceph_mdsmap_get_addr(oldmap, i),
+		if (i >= newmap->m_max_mds ||
+		    memcmp(ceph_mdsmap_get_addr(oldmap, i),
 			   ceph_mdsmap_get_addr(newmap, i),
 			   sizeof(struct ceph_entity_addr))) {
 			if (s->s_state == CEPH_MDS_SESSION_OPENING) {
-- 
1.7.11.4

