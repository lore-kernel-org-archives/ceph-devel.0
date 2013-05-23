From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 01/30] mds: journal new subtrees created by rename
Date: Thu, 23 May 2013 16:06:29 +0800
Message-ID: <1369296418-14871-2-git-send-email-zheng.z.yan@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51279 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477Ab3EWINE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 04:13:04 -0400
In-Reply-To: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, sam.lang@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

this avoids creating bare dirfrags during journal replay.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc  | 10 ++++++++++
 src/mds/journal.cc |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index b526b5e..63401e8 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -6306,6 +6306,16 @@ void Server::_rename_prepare(MDRequest *mdr,
       dout(10) << " forced journaling destdn " << *destdn << dendl;
       metablob->add_dir_context(destdn->get_dir());
       metablob->add_primary_dentry(destdn, true, srci);
+      if (srcdn->is_auth() && srci->is_dir()) {
+	// journal new subtrees root dirfrags
+	list<CDir*> ls;
+	srci->get_dirfrags(ls);
+	for (list<CDir*>::iterator p = ls.begin(); p != ls.end(); ++p) {
+	  CDir *dir = *p;
+	  if (dir->is_auth())
+	    metablob->add_dir(dir, true);
+	}
+      }
     }
   }
     
diff --git a/src/mds/journal.cc b/src/mds/journal.cc
index b8139e3..11ce5ac 100644
--- a/src/mds/journal.cc
+++ b/src/mds/journal.cc
@@ -1280,7 +1280,8 @@ void EMetaBlob::replay(MDS *mds, LogSegment *logseg, MDSlaveUpdate *slaveup)
 	list<frag_t> leaves;
 	renamed_diri->dirfragtree.get_leaves(leaves);
 	for (list<frag_t>::iterator p = leaves.begin(); p != leaves.end(); ++p) {
-	  CDir *dir = renamed_diri->get_or_open_dirfrag(mds->mdcache, *p);
+	  CDir *dir = renamed_diri->get_dirfrag(*p);
+	  assert(dir);
 	  // preserve subtree bound until slave commit
 	  if (dir->get_dir_auth() == CDIR_AUTH_UNDEF)
 	    slaveup->olddirs.insert(dir);
-- 
1.8.1.4

