From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 3/5] mds: alllow handle_client_readdir() fetching freezing dir.
Date: Fri, 30 Nov 2012 10:36:52 +0800
Message-ID: <1354243014-21072-4-git-send-email-zheng.z.yan@intel.com>
References: <1354243014-21072-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8401 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755237Ab2K3ChC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 Nov 2012 21:37:02 -0500
In-Reply-To: <1354243014-21072-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

At that point, the request already auth pins some objects.
So CDir::fetch() should ignore can_auth_pin check.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 59d7d3c..2c59f25 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -2741,9 +2741,14 @@ void Server::handle_client_readdir(MDRequest *mdr)
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

