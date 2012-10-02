From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 05/12] mds: Fix xlock imports
Date: Tue,  2 Oct 2012 16:55:45 +0800
Message-ID: <1349168152-13281-5-git-send-email-zheng.z.yan@intel.com>
References: <1349168152-13281-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:51424 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754782Ab2JBI4J (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 2 Oct 2012 04:56:09 -0400
In-Reply-To: <1349168152-13281-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Xlock imports and capability imports are uncorrelated, we should call
xlock_import() even there is no capability import.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 8584e60..7659b23 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -5838,16 +5838,16 @@ void Server::_rename_apply(MDRequest *mdr, CDentry *srcdn, CDentry *destdn, CDen
       if (mdr->more()->cap_imports.count(destdnl->get_inode())) {
 	mds->mdcache->migrator->finish_import_inode_caps(destdnl->get_inode(), srcdn->authority().first, 
 							 mdr->more()->cap_imports[destdnl->get_inode()]);
-	/* hack: add an auth pin for each xlock we hold. These were
-	 * remote xlocks previously but now they're local and
-	 * we're going to try and unpin when we xlock_finish. */
-	for (set<SimpleLock *>::iterator i = mdr->xlocks.begin();
-	    i !=  mdr->xlocks.end();
-	    ++i)
-	  if ((*i)->get_parent() == destdnl->get_inode() &&
-	      !(*i)->is_locallock())
-	    mds->locker->xlock_import(*i, mdr);
       }
+      /* hack: add an auth pin for each xlock we hold. These were
+       * remote xlocks previously but now they're local and
+       * we're going to try and unpin when we xlock_finish. */
+      for (set<SimpleLock *>::iterator i = mdr->xlocks.begin();
+	  i !=  mdr->xlocks.end();
+	  ++i)
+	if ((*i)->get_parent() == destdnl->get_inode() &&
+	    !(*i)->is_locallock())
+	  mds->locker->xlock_import(*i, mdr);
       
       // hack: fix auth bit
       in->state_set(CInode::STATE_AUTH);
-- 
1.7.11.4

