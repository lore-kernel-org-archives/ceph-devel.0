From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 27/29] mds: check if stray dentry is needed
Date: Fri,  4 Jan 2013 17:02:18 +0800
Message-ID: <1357290140-17044-28-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53494 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754085Ab3ADJCz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:55 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The necessity of stray dentry can change before the request acquires
all locks.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 2531005..1557b30 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -4531,11 +4531,14 @@ void Server::handle_client_unlink(MDRequest *mdr)
 
   // -- create stray dentry? --
   CDentry *straydn = mdr->straydn;
-  if (dnl->is_primary() && !straydn) {
-    straydn = mdcache->get_or_create_stray_dentry(dnl->get_inode());
-    mdr->pin(straydn);
-    mdr->straydn = straydn;
-  }
+  if (dnl->is_primary()) {
+    if (!straydn) {
+      straydn = mdcache->get_or_create_stray_dentry(dnl->get_inode());
+      mdr->pin(straydn);
+      mdr->straydn = straydn;
+    }
+  } else if (straydn)
+    straydn = NULL;
   if (straydn)
     dout(10) << " straydn is " << *straydn << dendl;
 
@@ -5274,11 +5277,14 @@ void Server::handle_client_rename(MDRequest *mdr)
 
   // -- create stray dentry? --
   CDentry *straydn = mdr->straydn;
-  if (destdnl->is_primary() && !linkmerge && !straydn) {
-    straydn = mdcache->get_or_create_stray_dentry(destdnl->get_inode());
-    mdr->pin(straydn);
-    mdr->straydn = straydn;
-  }
+  if (destdnl->is_primary() && !linkmerge) {
+    if (!straydn) {
+      straydn = mdcache->get_or_create_stray_dentry(destdnl->get_inode());
+      mdr->pin(straydn);
+      mdr->straydn = straydn;
+    }
+  } else if (straydn)
+    straydn = NULL;
   if (straydn)
     dout(10) << " straydn is " << *straydn << dendl;
 
-- 
1.7.11.7

