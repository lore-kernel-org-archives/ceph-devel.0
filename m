From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/3] ceph: fix cap revoke race
Date: Tue,  2 Jul 2013 12:40:20 +0800
Message-ID: <1372740021-7980-2-git-send-email-zheng.z.yan@intel.com>
References: <1372740021-7980-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50682 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751268Ab3GBEk1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 2 Jul 2013 00:40:27 -0400
In-Reply-To: <1372740021-7980-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

If caps are been revoking by the auth MDS, don't consider them as
issued even they are still issued by non-auth MDS. The non-auth
MDS should also be revoking/exporting these caps, the client just
hasn't received the cap revoke/export message.

The race I encountered is: When caps are exporting to new MDS, the
client receives cap import message and cap revoke message from the
new MDS, then receives cap export message from the old MDS. When
the client receives cap revoke message from the new MDS, the revoking
caps are still issued by the old MDS, so the client does nothing.
Later when the cap export message is received, the client removes
the caps issued by the old MDS. (Another way to fix the race is
calling ceph_check_caps() in handle_cap_export())

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 16266f3..7045a8d 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -690,6 +690,15 @@ int __ceph_caps_issued(struct ceph_inode_info *ci, int *implemented)
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

