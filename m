From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 07/29] mds: don't trim ambiguous imports in MDCache::trim_non_auth_subtree
Date: Fri,  4 Jan 2013 17:01:58 +0800
Message-ID: <1357290140-17044-8-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2808 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752920Ab3ADJCe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:34 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Trimming ambiguous imports in MDCache::trim_non_auth_subtree() confuses
MDCache::disambiguate_imports() and causes infinite loop.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 5014b5d..da0c7f1 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -5802,7 +5802,7 @@ bool MDCache::trim_non_auth_subtree(CDir *dir)
         for (list<CDir*>::iterator subdir = subdirs.begin();
             subdir != subdirs.end();
             ++subdir) {
-          if ((*subdir)->is_subtree_root()) {
+          if ((*subdir)->is_subtree_root() || my_ambiguous_imports.count((*subdir)->dirfrag())) {
             keep_inode = true;
             dout(10) << "trim_non_auth_subtree(" << dir << ") subdir " << *subdir << "is kept!" << dendl;
           }
-- 
1.7.11.7

