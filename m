From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/3] mds: fix cap revoke race
Date: Mon, 17 Jun 2013 10:48:15 +0800
Message-ID: <1371437296-10561-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:12173 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755103Ab3FQCsT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 16 Jun 2013 22:48:19 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

If caps are been revoking by the auth MDS, don't consider them as
issued even they are still issued by non-auth MDS. The non-auth
MDS should also be revoking/exporting these caps, we just haven't
received the cap revoke/export message.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 9a5ccc9..a8c616b 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -697,6 +697,15 @@ int __ceph_caps_issued(struct ceph_inode_info *ci, int *implemented)
 		if (implemented)
 			*implemented |= cap->implemented;
 	}
+	/*
+	 * exclude caps issued by non-auth MDS, but are been revoking
+	 * by the auth MDS. The non-auth MDS should be revoking/exporting
+	 * these caps, but the message is delayed.
+	 */
+	if (ci->i_auth_cap) {
+		cap = ci->i_auth_cap;
+		have &= ~cap->implemented | cap->issued;
+	}
 	return have;
 }
 
-- 
1.8.1.4

