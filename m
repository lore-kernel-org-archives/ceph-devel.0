From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 6/6] mds: clear inode dirty after slave rename finishes.
Date: Mon, 28 Jan 2013 10:28:26 +0800
Message-ID: <1359340106-24257-7-git-send-email-zheng.z.yan@intel.com>
References: <1359340106-24257-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52188 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752143Ab3A1C2e (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 27 Jan 2013 21:28:34 -0500
In-Reply-To: <1359340106-24257-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The inode is linked to a non-auth directory, so remove it from LogSegment's
dirty inode list.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 6dc3b9c..8080650 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -6345,7 +6345,10 @@ void Server::_logged_slave_rename(MDRequest *mdr,
     // remove mdr auth pin
     mdr->auth_unpin(srcdnl->get_inode());
     mdr->more()->is_inode_exporter = true;
-    
+
+    if (srcdnl->get_inode()->is_dirty())
+      srcdnl->get_inode()->mark_clean();
+
     dout(10) << " exported srci " << *srcdnl->get_inode() << dendl;
   }
 
-- 
1.7.11.7

