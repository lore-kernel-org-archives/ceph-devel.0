From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 28/29] mds: don't issue caps while inode is exporting caps
Date: Fri,  4 Jan 2013 17:02:19 +0800
Message-ID: <1357290140-17044-29-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53494 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753814Ab3ADJC5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:57 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

If issue caps while inode is exporting caps, the client will drop the
caps soon when it receives the CAP_OP_EXPORT message, but the client
will not receive corresponding CAP_OP_IMPORT message.

Except open file request, it's OK to not issue caps for client requests.
If an non-auth MDS receives open file request but it can't issue caps,
forward the request to auth MDS.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CInode.cc | 10 ++++++----
 src/mds/Server.cc | 22 +++++++++++++++-------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
index 4314ab5..3009f0c 100644
--- a/src/mds/CInode.cc
+++ b/src/mds/CInode.cc
@@ -2604,17 +2604,19 @@ int CInode::encode_inodestat(bufferlist& bl, Session *session,
 {
   int client = session->inst.name.num();
   assert(snapid);
-
   assert(session->connection);
   
   bool valid = true;
 
   // do not issue caps if inode differs from readdir snaprealm
   SnapRealm *realm = find_snaprealm();
-  bool no_caps = (realm && dir_realm && realm != dir_realm);
+  bool no_caps = (realm && dir_realm && realm != dir_realm) ||
+		 is_frozen() || state_test(CInode::STATE_EXPORTINGCAPS);
   if (no_caps)
-    dout(20) << "encode_inodestat realm=" << realm << " snaprealm " << snaprealm
-	     << " no_caps=" << no_caps << dendl;
+    dout(20) << "encode_inodestat no caps"
+	     << ((realm && dir_realm && realm != dir_realm)?", snaprealm differs ":"")
+	     << (state_test(CInode::STATE_EXPORTINGCAPS)?", exporting caps":"")
+	     << (is_frozen()?", frozen inode":"") << dendl;
 
   // pick a version!
   inode_t *oi = &inode;
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 1557b30..b70445e 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -1936,14 +1936,14 @@ CInode* Server::rdlock_path_pin_ref(MDRequest *mdr, int n,
     want_auth = true;
 
   if (want_auth) {
+    if (ref->is_ambiguous_auth()) {
+      dout(10) << "waiting for single auth on " << *ref << dendl;
+      ref->add_waiter(CInode::WAIT_SINGLEAUTH, new C_MDS_RetryRequest(mdcache, mdr));
+      return 0;
+    }
     if (!ref->is_auth()) {
-      if (ref->is_ambiguous_auth()) {
-	dout(10) << "waiting for single auth on " << *ref << dendl;
-	ref->add_waiter(CInode::WAIT_SINGLEAUTH, new C_MDS_RetryRequest(mdcache, mdr));
-      } else {
-	dout(10) << "fw to auth for " << *ref << dendl;
-	mdcache->request_forward(mdr, ref->authority().first);
-      }
+      dout(10) << "fw to auth for " << *ref << dendl;
+      mdcache->request_forward(mdr, ref->authority().first);
       return 0;
     }
 
@@ -2435,6 +2435,14 @@ void Server::handle_client_open(MDRequest *mdr)
   if (!cur)
     return;
 
+  if (cur->is_frozen() || cur->state_test(CInode::STATE_EXPORTINGCAPS)) {
+    assert(!need_auth);
+    mdr->done_locking = false;
+    CInode *cur = rdlock_path_pin_ref(mdr, 0, rdlocks, true);
+    if (!cur)
+      return;
+  }
+
   if (mdr->snapid != CEPH_NOSNAP && mdr->client_request->may_write()) {
     reply_request(mdr, -EROFS);
     return;
-- 
1.7.11.7

