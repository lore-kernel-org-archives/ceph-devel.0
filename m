From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 4/8] mds: try purging stray inode after storing backtrace
Date: Mon, 17 Jun 2013 20:10:25 +0800
Message-ID: <1371471029-10589-5-git-send-email-zheng.z.yan@intel.com>
References: <1371471029-10589-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1943 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932834Ab3FQMLo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Jun 2013 08:11:44 -0400
In-Reply-To: <1371471029-10589-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Inode is auth pinned and can't be purged while storing backtrace,
so we should try purging stray inode after storing backtrace.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CInode.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
index 0e14293..4a592bc 100644
--- a/src/mds/CInode.cc
+++ b/src/mds/CInode.cc
@@ -1069,11 +1069,12 @@ void CInode::_stored_backtrace(version_t v, Context *fin)
 {
   dout(10) << "_stored_backtrace" << dendl;
 
+  auth_unpin(this);
   if (v == inode.backtrace_version)
     clear_dirty_parent();
-  auth_unpin(this);
   if (fin)
     fin->complete(0);
+  mdcache->maybe_eval_stray(this);
 }
 
 void CInode::_mark_dirty_parent(LogSegment *ls, bool dirty_pool)
-- 
1.8.1.4

