From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 03/12] mds: Add finish callback to waiting_for_base_ino wait queue
Date: Tue,  2 Oct 2012 16:55:43 +0800
Message-ID: <1349168152-13281-3-git-send-email-zheng.z.yan@intel.com>
References: <1349168152-13281-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:51424 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754674Ab2JBI4F (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 2 Oct 2012 04:56:05 -0400
In-Reply-To: <1349168152-13281-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 1a93d9b..1348b3e 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -8341,8 +8341,8 @@ void MDCache::discover_base_ino(inodeno_t want_ino,
     discover_info_t& d = _create_discover(from);
     d.ino = want_ino;
     _send_discover(d);
-    waiting_for_base_ino[from][want_ino].push_back(onfinish);
   }
+  waiting_for_base_ino[from][want_ino].push_back(onfinish);
 }
 
 
-- 
1.7.11.4

