From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 03/30] mds: don't stop at export bounds when journaling dir context
Date: Thu, 23 May 2013 16:06:31 +0800
Message-ID: <1369296418-14871-4-git-send-email-zheng.z.yan@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39281 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751556Ab3EWINF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 04:13:05 -0400
In-Reply-To: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, sam.lang@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

We only journal the finish of exporting subtree, so we shouldn't
consider export bounds as subtree root.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/journal.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/mds/journal.cc b/src/mds/journal.cc
index 11ce5ac..559eb63 100644
--- a/src/mds/journal.cc
+++ b/src/mds/journal.cc
@@ -406,7 +406,7 @@ void EMetaBlob::add_dir_context(CDir *dir, int mode)
 
     if (mode == TO_AUTH_SUBTREE_ROOT) {
       // subtree root?
-      if (dir->is_subtree_root()) {
+      if (dir->is_subtree_root() && !dir->state_test(CDir::STATE_EXPORTBOUND)) {
 	if (dir->is_auth() && !dir->is_ambiguous_auth()) {
 	  // it's an auth subtree, we don't need maybe (if any), and we're done.
 	  dout(20) << "EMetaBlob::add_dir_context(" << dir << ") reached unambig auth subtree, don't need " << maybe
-- 
1.8.1.4

