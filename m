From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] mds: don't journal null dentry for overwrited remote linkage.
Date: Mon, 17 Dec 2012 17:08:19 +0800
Message-ID: <1355735299-20401-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:42523 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751798Ab2LQJIX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Dec 2012 04:08:23 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Server::_rename_prepare() adds null dest dentry to the EMetaBlob if
the rename operation is overwriting remote linkage. This is incorrect
because null dentry are processed after primary and remote dentries
during journal replay. The erroneous null dentry makes rename dest
file disappear. The bug can causes undeletable directory.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index ba43656..d354adb 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -5709,10 +5709,6 @@ void Server::_rename_prepare(MDRequest *mdr,
 				    CEPH_NOSNAP, 0, destdnl);
 	metablob->add_primary_dentry(oldin->get_projected_parent_dn(), true, oldin);
       }
-      if (destdn->is_auth()) {
-	// auth for dn, not targeti
-	metablob->add_null_dentry(destdn, true);
-      }
     }
   }
 
-- 
1.7.11.7

