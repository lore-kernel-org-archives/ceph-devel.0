From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] ceph: make sure write caps are registered with auth MDS
Date: Sat,  8 Mar 2014 10:01:42 +0800
Message-ID: <1394244102-15716-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55868 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751663AbaCHCBq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 7 Mar 2014 21:01:46 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

Only auth MDS can't issue write caps to clients, so don't consider
write caps registered with non-auth MDS as valid.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 1754338..d9ef44e 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -885,7 +885,10 @@ int __ceph_caps_mds_wanted(struct ceph_inode_info *ci)
 		cap = rb_entry(p, struct ceph_cap, ci_node);
 		if (!__cap_is_valid(cap))
 			continue;
-		mds_wanted |= cap->mds_wanted;
+		if (cap == ci->i_auth_cap)
+			mds_wanted |= cap->mds_wanted;
+		else
+			mds_wanted |= (cap->mds_wanted & ~CEPH_CAP_ANY_FILE_WR);
 	}
 	return mds_wanted;
 }
-- 
1.8.5.3

