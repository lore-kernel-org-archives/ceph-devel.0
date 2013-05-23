From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 15/30] mds: notify auth MDS when cap_wanted changes
Date: Thu, 23 May 2013 16:06:43 +0800
Message-ID: <1369296418-14871-16-git-send-email-zheng.z.yan@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39281 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440Ab3EWINM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 04:13:12 -0400
In-Reply-To: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, sam.lang@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

So the auth MDS can choose locks' states base on our cap_wanted.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index 63862f8..781704c 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -2200,8 +2200,11 @@ void Locker::adjust_cap_wanted(Capability *cap, int wanted, int issue_seq)
   }
 
   CInode *cur = cap->get_inode();
-  if (!cur->is_auth())
+  if (!cur->is_auth()) {
+    request_inode_file_caps(cur);
     return;
+  }
+
   if (cap->wanted() == 0) {
     if (cur->item_open_file.is_on_list() &&
 	!cur->is_any_caps_wanted()) {
@@ -2220,7 +2223,6 @@ void Locker::adjust_cap_wanted(Capability *cap, int wanted, int issue_seq)
       mds->mdlog->submit_entry(le);
     }
   }
-
 }
 
 
-- 
1.8.1.4

