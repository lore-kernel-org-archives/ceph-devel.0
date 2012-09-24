From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/2] mds: Fix SessionMap::is_any_state()
Date: Mon, 24 Sep 2012 16:37:53 +0800
Message-ID: <1348475874-30464-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27318 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755245Ab2IXIh4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 24 Sep 2012 04:37:56 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

is_any_state() should return false when the by_state list is empty.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 ceph-object-corpus   | 2 +-
 src/mds/SessionMap.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ceph-object-corpus b/ceph-object-corpus
index 7f23ee1..4d64c37 160000
--- a/ceph-object-corpus
+++ b/ceph-object-corpus
@@ -1 +1 @@
-Subproject commit 7f23ee1127101d311ec0c50adb719367a0789fad
+Subproject commit 4d64c3751101141a34beadf74c3e9f013bce550c
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

