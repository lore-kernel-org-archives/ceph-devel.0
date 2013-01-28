From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 5/6] mds: mark export bounds for cross authority directory rename
Date: Mon, 28 Jan 2013 10:28:25 +0800
Message-ID: <1359340106-24257-6-git-send-email-zheng.z.yan@intel.com>
References: <1359340106-24257-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52188 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751977Ab3A1C2e (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 27 Jan 2013 21:28:34 -0500
In-Reply-To: <1359340106-24257-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

this guarantees that the importing MDS gets directory fragment's
up-to-date fragstat/rstat.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 520d389..6dc3b9c 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -6322,11 +6322,22 @@ void Server::_logged_slave_rename(MDRequest *mdr,
 
   // export srci?
   if (srcdn->is_auth() && srcdnl->is_primary()) {
-    list<Context*> finished;
+    // set export bounds for CInode::encode_export()
+    list<CDir*> bounds;
+    if (srcdnl->get_inode()->is_dir()) {
+      srcdnl->get_inode()->get_dirfrags(bounds);
+      for (list<CDir*>::iterator p = bounds.begin(); p != bounds.end(); p++)
+	(*p)->state_set(CDir::STATE_EXPORTBOUND);
+    }
+
     map<client_t,entity_inst_t> exported_client_map;
     bufferlist inodebl;
     mdcache->migrator->encode_export_inode(srcdnl->get_inode(), inodebl, 
 					   exported_client_map);
+
+    for (list<CDir*>::iterator p = bounds.begin(); p != bounds.end(); ++p)
+      (*p)->state_clear(CDir::STATE_EXPORTBOUND);
+
     ::encode(exported_client_map, reply->inode_export);
     reply->inode_export.claim_append(inodebl);
     reply->inode_export_v = srcdnl->get_inode()->inode.version;
-- 
1.7.11.7

