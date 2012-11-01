From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/2] ceph: Don't update i_max_size when handling non-auth cap
Date: Thu,  1 Nov 2012 17:03:35 +0800
Message-ID: <1351760618-19874-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13445 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756415Ab2KAJDl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 1 Nov 2012 05:03:41 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The cap from non-auth mds doesn't have a meaningful max_size value.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 3251e9c..c633d1d 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2388,7 +2388,7 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 			    &atime);
 
 	/* max size increase? */
-	if (max_size != ci->i_max_size) {
+	if (ci->i_auth_cap == cap && max_size != ci->i_max_size) {
 		dout("max_size %lld -> %llu\n", ci->i_max_size, max_size);
 		ci->i_max_size = max_size;
 		if (max_size >= ci->i_wanted_max_size) {
-- 
1.7.11.7

