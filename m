From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 4/5] mds: call eval() after cap is imported
Date: Fri, 30 Nov 2012 10:36:53 +0800
Message-ID: <1354243014-21072-5-git-send-email-zheng.z.yan@intel.com>
References: <1354243014-21072-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8401 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754991Ab2K3ChD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 Nov 2012 21:37:03 -0500
In-Reply-To: <1354243014-21072-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The migrator calls eval() for imported caps after importing a
directory tree. We should do the same thing after importing a
inode.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Migrator.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
index 41d97e9..fcc06cd 100644
--- a/src/mds/Migrator.cc
+++ b/src/mds/Migrator.cc
@@ -2613,6 +2613,7 @@ void Migrator::logged_import_caps(CInode *in,
 
   assert(cap_imports.count(in));
   finish_import_inode_caps(in, from, cap_imports[in]);  
+  mds->locker->eval(in, CEPH_CAP_LOCKS);
 
   mds->send_message_mds(new MExportCapsAck(in->ino()), from);
 }
-- 
1.7.11.7

