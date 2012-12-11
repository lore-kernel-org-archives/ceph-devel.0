From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 11/14] mds: delay processing cache expire when state >= EXPORT_EXPORTING
Date: Tue, 11 Dec 2012 16:30:57 +0800
Message-ID: <1355214660-26354-12-git-send-email-zheng.z.yan@intel.com>
References: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16602 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173Ab2LKIbO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Dec 2012 03:31:14 -0500
In-Reply-To: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

It's possible that MDS receives cache expire in EXPORT_LOGGINGFINISH
and EXPORT_NOTIFYING states.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 326e9d7..fe100f9 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -5924,7 +5924,7 @@ void MDCache::handle_cache_expire(MCacheExpire *m)
 	  (parent_dir->is_auth() && parent_dir->is_exporting() &&
 	   ((migrator->get_export_state(parent_dir) == Migrator::EXPORT_WARNING &&
 	     migrator->export_has_warned(parent_dir,from)) ||
-	    migrator->get_export_state(parent_dir) == Migrator::EXPORT_EXPORTING))) {
+	    migrator->get_export_state(parent_dir) >= Migrator::EXPORT_EXPORTING))) {
 	// not auth.
 	dout(7) << "delaying nonauth|warned expires for " << *parent_dir << dendl;
 	assert(parent_dir->is_frozen_tree_root());
-- 
1.7.11.7

