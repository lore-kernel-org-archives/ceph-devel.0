From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 4/9] ceph: fix cap release race
Date: Tue,  4 Jun 2013 11:19:53 +0800
Message-ID: <1370315998-10418-5-git-send-email-zheng.z.yan@intel.com>
References: <1370315998-10418-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58772 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758005Ab3FDDVL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 3 Jun 2013 23:21:11 -0400
In-Reply-To: <1370315998-10418-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, elder@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

ceph_encode_inode_release() can race with ceph_open() and release
caps wanted by open files. So it should call __ceph_caps_wanted()
to get the wanted caps.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index da0f9b8..54c290b 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3042,21 +3042,19 @@ int ceph_encode_inode_release(void **p, struct inode *inode,
 		     (cap->issued & unless) == 0)) {
 			if ((cap->issued & drop) &&
 			    (cap->issued & unless) == 0) {
-				dout("encode_inode_release %p cap %p %s -> "
-				     "%s\n", inode, cap,
+				int wanted = __ceph_caps_wanted(ci);
+				if ((ci->i_ceph_flags & CEPH_I_NODELAY) == 0)
+					wanted |= cap->mds_wanted;
+				dout("encode_inode_release %p cap %p "
+				     "%s -> %s, wanted %s -> %s\n", inode, cap,
 				     ceph_cap_string(cap->issued),
-				     ceph_cap_string(cap->issued & ~drop));
+				     ceph_cap_string(cap->issued & ~drop),
+				     ceph_cap_string(cap->mds_wanted),
+				     ceph_cap_string(wanted));
+
 				cap->issued &= ~drop;
 				cap->implemented &= ~drop;
-				if (ci->i_ceph_flags & CEPH_I_NODELAY) {
-					int wanted = __ceph_caps_wanted(ci);
-					dout("  wanted %s -> %s (act %s)\n",
-					     ceph_cap_string(cap->mds_wanted),
-					     ceph_cap_string(cap->mds_wanted &
-							     ~wanted),
-					     ceph_cap_string(wanted));
-					cap->mds_wanted &= wanted;
-				}
+				cap->mds_wanted = wanted;
 			} else {
 				dout("encode_inode_release %p cap %p %s"
 				     " (force)\n", inode, cap,
-- 
1.8.1.4

