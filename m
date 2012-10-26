From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] mds: Fix SnapRealm differ check in CInode::encode_inodestat()
Date: Fri, 26 Oct 2012 14:26:35 +0800
Message-ID: <1351232795-22534-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27579 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756501Ab2JZG47 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 26 Oct 2012 02:56:59 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

When checking if inode's SnapRealm is different from readdir
SnapRealm, we should use find_snaprealm() to get inode's SnapRealm.
Without this fix, I got lots of "ceph_add_cap: couldn't find snap
realm 100" from kernel client.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CInode.cc | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
index 8566e55..c129308 100644
--- a/src/mds/CInode.cc
+++ b/src/mds/CInode.cc
@@ -2554,7 +2554,7 @@ void CInode::replicate_relax_locks()
 // =============================================
 
 int CInode::encode_inodestat(bufferlist& bl, Session *session,
-			      SnapRealm *realm,
+			      SnapRealm *dir_realm,
 			      snapid_t snapid, unsigned max_bytes)
 {
   int client = session->inst.name.num();
@@ -2565,7 +2565,8 @@ int CInode::encode_inodestat(bufferlist& bl, Session *session,
   bool valid = true;
 
   // do not issue caps if inode differs from readdir snaprealm
-  bool no_caps = (realm && snaprealm && realm != snaprealm);
+  SnapRealm *realm = find_snaprealm();
+  bool no_caps = (realm && dir_realm && realm != dir_realm);
   if (no_caps)
     dout(20) << "encode_inodestat realm=" << realm << " snaprealm " << snaprealm
 	     << " no_caps=" << no_caps << dendl;
@@ -2724,7 +2725,7 @@ int CInode::encode_inodestat(bufferlist& bl, Session *session,
   } else {
     if (!no_caps && valid && !cap) {
       // add a new cap
-      cap = add_client_cap(client, session, find_snaprealm());
+      cap = add_client_cap(client, session, realm);
       if (is_auth()) {
 	if (choose_ideal_loner() >= 0)
 	  try_set_loner();
@@ -2747,7 +2748,7 @@ int CInode::encode_inodestat(bufferlist& bl, Session *session,
       e.cap.seq = cap->get_last_seq();
       dout(10) << "encode_inodestat issueing " << ccap_string(issue) << " seq " << cap->get_last_seq() << dendl;
       e.cap.mseq = cap->get_mseq();
-      e.cap.realm = find_snaprealm()->inode->ino();
+      e.cap.realm = realm->inode->ino();
     } else {
       e.cap.cap_id = 0;
       e.cap.caps = 0;
-- 
1.7.11.7

