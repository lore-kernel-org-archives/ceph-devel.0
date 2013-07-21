From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/2] mds: notify clients about deleted inode
Date: Sun, 21 Jul 2013 10:21:13 +0800
Message-ID: <1374373274-3457-2-git-send-email-zheng.z.yan@intel.com>
References: <1374373274-3457-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:36648 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754220Ab3GUCV1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 20 Jul 2013 22:21:27 -0400
In-Reply-To: <1374373274-3457-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

To make sure clients trim the deleted inode from the their cache
ASAP. After all clients release the inode, we can reclaim space.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index 30e014a..7bbb749 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -1776,6 +1776,10 @@ bool Locker::issue_caps(CInode *in, Capability *only_cap)
       continue;
     }
 
+    // notify clients about deleted inode, to make sure they release caps ASAP.
+    if (in->inode.nlink == 0)
+      wanted |= CEPH_CAP_LINK_SHARED;
+
     // are there caps that the client _wants_ and can have, but aren't pending?
     // or do we need to revoke?
     if (((wanted & allowed) & ~pending) ||  // missing wanted+allowed caps
-- 
1.8.1.4

