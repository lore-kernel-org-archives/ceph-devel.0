From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 05/29] mds: don't journal null dentry for overwrited remote linkage
Date: Fri,  4 Jan 2013 17:01:56 +0800
Message-ID: <1357290140-17044-6-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47205 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752091Ab3ADJCb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:31 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Server::_rename_prepare() adds null dest dentry to the EMetaBlob if
the rename operation overwrites a remote linkage. This is incorrect
because null dentry are processed after primary and remote dentries
during journal replay. The erroneous null dentry makes the dentry of
rename destination disappear.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 064733c..23739ea 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -5794,10 +5794,6 @@ void Server::_rename_prepare(MDRequest *mdr,
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

