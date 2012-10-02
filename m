From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 11/12] mds: Properly re-calculate mdsdir inode's auth bit
Date: Tue,  2 Oct 2012 16:55:51 +0800
Message-ID: <1349168152-13281-11-git-send-email-zheng.z.yan@intel.com>
References: <1349168152-13281-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:51424 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754894Ab2JBI4V (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 2 Oct 2012 04:56:21 -0400
In-Reply-To: <1349168152-13281-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 397b991..8b02b8b 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -3132,6 +3132,11 @@ void MDCache::recalc_auth_bits()
   for (map<CDir*,set<CDir*> >::iterator p = subtrees.begin();
        p != subtrees.end();
        ++p) {
+
+    CInode *inode = p->first->get_inode();
+    if (inode->is_mdsdir() && inode->ino() != MDS_INO_MDSDIR(mds->get_nodeid()))
+      inode->state_clear(CInode::STATE_AUTH);
+
     list<CDir*> dfq;  // dirfrag queue
     dfq.push_back(p->first);
 
-- 
1.7.11.4

