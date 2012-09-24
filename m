From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH V2 1/2] mds: Fix SessionMap::is_any_state()
Date: Mon, 24 Sep 2012 19:27:08 +0800
Message-ID: <1348486029-1125-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:24645 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753376Ab2IXL1M (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 24 Sep 2012 07:27:12 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

is_any_state() should return false when the by_state list is empty.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/SessionMap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/mds/SessionMap.h b/src/mds/SessionMap.h
index fcd0b47..6bca361 100644
--- a/src/mds/SessionMap.h
+++ b/src/mds/SessionMap.h
@@ -248,7 +248,7 @@ public:
 
   bool is_any_state(int state) {
     map<int,xlist<Session*>* >::iterator p = by_state.find(state);
-    if (p == by_state.end())
+    if (p == by_state.end() || p->second->empty())
       return false;
     return true;
   }
-- 
1.7.11.4

