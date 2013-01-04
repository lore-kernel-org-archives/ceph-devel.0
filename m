From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 18/29] mds: fix rename inode exportor check
Date: Fri,  4 Jan 2013 17:02:09 +0800
Message-ID: <1357290140-17044-19-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28255 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753454Ab3ADJCr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:47 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Use "srcdn->is_auth() && destdnl->is_primary()" to check if the MDS is
inode exportor of rename operation is not reliable, This is because
OP_FINISH slave request may race with subtree import. The fix is use
a variable in MDRequest to indicate if the MDS is inode exportor.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Mutation.h | 4 ++--
 src/mds/Server.cc  | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/mds/Mutation.h b/src/mds/Mutation.h
index bf59dba..d0d3eca 100644
--- a/src/mds/Mutation.h
+++ b/src/mds/Mutation.h
@@ -213,7 +213,7 @@ struct MDRequest : public Mutation {
     bufferlist inode_import;
     version_t inode_import_v;
     CInode* destdn_was_remote_inode;
-    bool was_link_merge;
+    bool was_inode_exportor;
     int prepared_inode_exporter; // has asked auth of srci to mark srci as ambiguous auth
 
     map<client_t,entity_inst_t> imported_client_map;
@@ -233,7 +233,7 @@ struct MDRequest : public Mutation {
 
     More() : 
       src_reanchor_atid(0), dst_reanchor_atid(0), inode_import_v(0),
-      destdn_was_remote_inode(0), was_link_merge(false),
+      destdn_was_remote_inode(0), was_inode_exportor(false),
       prepared_inode_exporter(-1), flock_was_waiting(false),
       stid(0),
       slave_commit(0) { }
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 6097552..c5793e5 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -6261,6 +6261,7 @@ void Server::_logged_slave_rename(MDRequest *mdr,
 
     // remove mdr auth pin
     mdr->auth_unpin(srcdnl->get_inode());
+    mdr->more()->was_inode_exportor = true;
     
     dout(10) << " exported srci " << *srcdnl->get_inode() << dendl;
   }
@@ -6299,7 +6300,7 @@ void Server::_commit_slave_rename(MDRequest *mdr, int r,
 
     // unfreeze+singleauth inode
     //  hmm, do i really need to delay this?
-    if (srcdn->is_auth() && destdnl->is_primary()) {
+    if (mdr->more()->was_inode_exportor) {
 
       CInode *in = destdnl->get_inode();
 
-- 
1.7.11.7

