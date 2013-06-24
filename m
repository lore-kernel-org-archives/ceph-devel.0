From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 2/3] mds: fix cap revoke race
Date: Mon, 24 Jun 2013 16:00:09 +0800
Message-ID: <51C7FC89.2040404@intel.com>
References: <1372056089-11603-1-git-send-email-zheng.z.yan@intel.com> <1372056089-11603-2-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:27248 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752786Ab3FXIAY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 24 Jun 2013 04:00:24 -0400
In-Reply-To: <1372056089-11603-2-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, alex.elder@linaro.org

From d3954de9c471c996c807b61fc37acbb84726da37 Mon Sep 17 00:00:00 2001
From: "Yan, Zheng" <zheng.z.yan@intel.com>
Date: Mon, 17 Jun 2013 09:15:33 +0800
Subject: [PATCH 2/3] ceph: fix cap revoke race

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

