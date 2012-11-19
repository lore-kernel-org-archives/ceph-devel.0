From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 07/16] mds: call eval() after caps are exported
Date: Mon, 19 Nov 2012 10:43:39 +0800
Message-ID: <1353293028-15238-8-git-send-email-zheng.z.yan@intel.com>
References: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17039 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752899Ab2KSCn7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 18 Nov 2012 21:43:59 -0500
In-Reply-To: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

For an inode just changed authority, if the new auth MDS want to
change a lock in the inode from 'sync' to 'lock' state before caps
are exported. The lock in replica can be in 'sync->lock' state
because client caps prevent it from transitting to 'lock' state.
So we should call eval() after clearing client caps.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Migrator.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
index 9829d68..41d97e9 100644
--- a/src/mds/Migrator.cc
+++ b/src/mds/Migrator.cc
@@ -1052,6 +1052,7 @@ void Migrator::finish_export_inode_caps(CInode *in)
     mds->send_message_client_counted(m, it->first);
   }
   in->clear_client_caps_after_export();
+  mds->locker->eval(in, CEPH_CAP_LOCKS);
 }
 
 void Migrator::finish_export_inode(CInode *in, utime_t now, list<Context*>& finished)
-- 
1.7.11.7

