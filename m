From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 6/6] mds: don't issue caps while session is stale
Date: Mon,  5 Aug 2013 14:10:27 +0800
Message-ID: <1375683030-28305-7-git-send-email-zheng.z.yan@intel.com>
References: <1375683030-28305-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:33276 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754595Ab3HEGKk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 5 Aug 2013 02:10:40 -0400
In-Reply-To: <1375683030-28305-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Locker::issue_caps() does not issue new caps to stale client,
CInode::encode_inodestat() should have the same logical.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CInode.cc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
index d215d18..dd48326 100644
--- a/src/mds/CInode.cc
+++ b/src/mds/CInode.cc
@@ -2733,10 +2733,12 @@ int CInode::encode_inodestat(bufferlist& bl, Session *session,
 
   // do not issue caps if inode differs from readdir snaprealm
   SnapRealm *realm = find_snaprealm();
-  bool no_caps = (realm && dir_realm && realm != dir_realm) ||
+  bool no_caps = session->is_stale() ||
+		 (realm && dir_realm && realm != dir_realm) ||
 		 is_frozen() || state_test(CInode::STATE_EXPORTINGCAPS);
   if (no_caps)
     dout(20) << "encode_inodestat no caps"
+	     << (session->is_stale()?", session stale ":"")
 	     << ((realm && dir_realm && realm != dir_realm)?", snaprealm differs ":"")
 	     << (state_test(CInode::STATE_EXPORTINGCAPS)?", exporting caps":"")
 	     << (is_frozen()?", frozen inode":"") << dendl;
-- 
1.8.1.4

