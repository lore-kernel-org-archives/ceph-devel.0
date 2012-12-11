From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 02/14] mds: alllow handle_client_readdir() fetching freezing dir.
Date: Tue, 11 Dec 2012 16:30:48 +0800
Message-ID: <1355214660-26354-3-git-send-email-zheng.z.yan@intel.com>
References: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59907 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821Ab2LKIbH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Dec 2012 03:31:07 -0500
In-Reply-To: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

At that point, the request already auth pins and locks some objects.
So CDir::fetch() should ignore the can_auth_pin check and continue
to fetch freezing dir.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index ba43656..c8c52e1 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -2733,9 +2733,14 @@ void Server::handle_client_readdir(MDRequest *mdr)
   assert(dir->is_auth());
 
   if (!dir->is_complete()) {
+    if (dir->is_frozen()) {
+      dout(7) << "dir is frozen " << *dir << dendl;
+      dir->add_waiter(CDir::WAIT_UNFREEZE, new C_MDS_RetryRequest(mdcache, mdr));
+      return;
+    }
     // fetch
     dout(10) << " incomplete dir contents for readdir on " << *dir << ", fetching" << dendl;
-    dir->fetch(new C_MDS_RetryRequest(mdcache, mdr));
+    dir->fetch(new C_MDS_RetryRequest(mdcache, mdr), true);
     return;
   }
 
-- 
1.7.11.7

