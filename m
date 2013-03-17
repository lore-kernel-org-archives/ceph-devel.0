From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 34/39] mds: don't open dirfrag while subtree is frozen
Date: Sun, 17 Mar 2013 22:51:37 +0800
Message-ID: <1363531902-24909-35-git-send-email-zheng.z.yan@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:30053 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932663Ab3CQOx5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Mar 2013 10:53:57 -0400
In-Reply-To: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index e9a79cd..30687ec 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -7101,9 +7101,9 @@ int MDCache::path_traverse(MDRequest *mdr, Message *req, Context *fin,     // wh
     if (!curdir) {
       if (cur->is_auth()) {
         // parent dir frozen_dir?
-        if (cur->is_frozen_dir()) {
-          dout(7) << "traverse: " << *cur->get_parent_dir() << " is frozen_dir, waiting" << dendl;
-          cur->get_parent_dn()->get_dir()->add_waiter(CDir::WAIT_UNFREEZE, _get_waiter(mdr, req, fin));
+        if (cur->is_frozen()) {
+          dout(7) << "traverse: " << *cur << " is frozen, waiting" << dendl;
+          cur->add_waiter(CDir::WAIT_UNFREEZE, _get_waiter(mdr, req, fin));
           return 1;
         }
         curdir = cur->get_or_open_dirfrag(this, fg);
-- 
1.7.11.7

