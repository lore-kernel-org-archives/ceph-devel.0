From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 9/9] ceph: move inode to proper flushing list when auth MDS changes
Date: Tue,  4 Jun 2013 11:19:58 +0800
Message-ID: <1370315998-10418-10-git-send-email-zheng.z.yan@intel.com>
References: <1370315998-10418-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14086 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757489Ab3FDDVM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 3 Jun 2013 23:21:12 -0400
In-Reply-To: <1370315998-10418-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, elder@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 790f88b..458a66e 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1982,8 +1982,14 @@ static void kick_flushing_inode_caps(struct ceph_mds_client *mdsc,
 	cap = ci->i_auth_cap;
 	dout("kick_flushing_inode_caps %p flushing %s flush_seq %lld\n", inode,
 	     ceph_cap_string(ci->i_flushing_caps), ci->i_cap_flush_seq);
+
 	__ceph_flush_snaps(ci, &session, 1);
+
 	if (ci->i_flushing_caps) {
+		spin_lock(&mdsc->cap_dirty_lock);
+		list_move_tail(&ci->i_flushing_item, &session->s_cap_flushing);
+		spin_unlock(&mdsc->cap_dirty_lock);
+
 		delayed = __send_cap(mdsc, cap, CEPH_CAP_OP_FLUSH,
 				     __ceph_caps_used(ci),
 				     __ceph_caps_wanted(ci),
-- 
1.8.1.4

