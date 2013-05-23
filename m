From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 02/30] mds: fix underwater dentry cleanup
Date: Thu, 23 May 2013 16:06:30 +0800
Message-ID: <1369296418-14871-3-git-send-email-zheng.z.yan@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51287 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751386Ab3EWINF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 04:13:05 -0400
In-Reply-To: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, sam.lang@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

If the underwater dentry is a remove link, we shouldn't mark the
inode clean

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CDir.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/mds/CDir.cc b/src/mds/CDir.cc
index 4ef6e8f..9b49c10 100644
--- a/src/mds/CDir.cc
+++ b/src/mds/CDir.cc
@@ -1651,7 +1651,7 @@ void CDir::_fetched(bufferlist &bl, const string& want_dn)
       dout(10) << "_fetched  had underwater dentry " << *dn << ", marking clean" << dendl;
       dn->mark_clean();
 
-      if (dn->get_linkage()->get_inode()) {
+      if (dn->get_linkage()->is_primary()) {
 	assert(dn->get_linkage()->get_inode()->get_version() <= got_fnode.version);
 	dout(10) << "_fetched  had underwater inode " << *dn->get_linkage()->get_inode() << ", marking clean" << dendl;
 	dn->get_linkage()->get_inode()->mark_clean();
-- 
1.8.1.4

