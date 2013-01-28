From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/6] mds: fix for MDCache::disambiguate_imports
Date: Mon, 28 Jan 2013 10:28:21 +0800
Message-ID: <1359340106-24257-2-git-send-email-zheng.z.yan@intel.com>
References: <1359340106-24257-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58841 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924Ab3A1C2a (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 27 Jan 2013 21:28:30 -0500
In-Reply-To: <1359340106-24257-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

In the resolve stage, if no MDS claims other MDS's disambiguous subtree
import, the subtree's dir_auth is undefined.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index e951a39..0be6a8f 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -3077,7 +3077,8 @@ void MDCache::disambiguate_imports()
       CDir *dir = get_force_dirfrag(q->first);
       if (!dir) continue;
       
-      if (dir->is_ambiguous_auth()) {     // works for me_ambig or if i am a surviving bystander
+      if (dir->is_ambiguous_auth() ||	// works for me_ambig or if i am a surviving bystander
+	  dir->authority() == CDIR_AUTH_UNDEF) { // resolving
 	dout(10) << "  mds." << who << " did import " << *dir << dendl;
 	adjust_bounded_subtree_auth(dir, q->second, who);
 	try_subtree_merge(dir);
-- 
1.7.11.7

