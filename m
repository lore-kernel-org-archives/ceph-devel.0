From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 29/39] mds: avoid double auth pin for file recovery
Date: Sun, 17 Mar 2013 22:51:32 +0800
Message-ID: <1363531902-24909-30-git-send-email-zheng.z.yan@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:30053 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932679Ab3CQOxk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Mar 2013 10:53:40 -0400
In-Reply-To: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 973a4d0..e9a79cd 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -5502,8 +5502,10 @@ void MDCache::_queue_file_recover(CInode *in)
   dout(15) << "_queue_file_recover " << *in << dendl;
   assert(in->is_auth());
   in->state_clear(CInode::STATE_NEEDSRECOVER);
-  in->state_set(CInode::STATE_RECOVERING);
-  in->auth_pin(this);
+  if (!in->state_test(CInode::STATE_RECOVERING)) {
+    in->state_set(CInode::STATE_RECOVERING);
+    in->auth_pin(this);
+  }
   file_recover_queue.insert(in);
 }
 
-- 
1.7.11.7

