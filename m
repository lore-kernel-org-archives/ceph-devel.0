From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 04/29] mds: xlock stray dentry when handling rename or unlink
Date: Fri,  4 Jan 2013 17:01:55 +0800
Message-ID: <1357290140-17044-5-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51114 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752727Ab3ADJCa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:30 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

This prevents MDS from reintegrating stray before rename/unlink finishes

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index dc14bbe..064733c 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -4536,6 +4536,7 @@ void Server::handle_client_unlink(MDRequest *mdr)
   if (straydn) {
     wrlocks.insert(&straydn->get_dir()->inode->filelock);
     wrlocks.insert(&straydn->get_dir()->inode->nestlock);
+    xlocks.insert(&straydn->lock);
   }
   if (in->is_dir())
     rdlocks.insert(&in->filelock);   // to verify it's empty
@@ -5300,6 +5301,7 @@ void Server::handle_client_rename(MDRequest *mdr)
   if (straydn) {
     wrlocks.insert(&straydn->get_dir()->inode->filelock);
     wrlocks.insert(&straydn->get_dir()->inode->nestlock);
+    xlocks.insert(&straydn->lock);
   }
 
   // xlock versionlock on dentries if there are witnesses.
-- 
1.7.11.7

