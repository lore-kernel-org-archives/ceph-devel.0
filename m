From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 03/25] mds: lock remote inode's primary dentry during rename
Date: Wed, 23 Jan 2013 11:08:39 +0800
Message-ID: <1358910541-15535-4-git-send-email-zheng.z.yan@intel.com>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60335 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752769Ab3AWDJH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jan 2013 22:09:07 -0500
In-Reply-To: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

commit 1203cd2110 (mds: allow open_remote_ino() to open xlocked dentry)
makes Server::handle_client_rename() xlocks remote inodes' primary
dentry so witness MDS can open xlocked dentry. But I added remote inodes'
projected primary dentries to the xlock list. This is wrong because
projected dentries are invisible for path traverse.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index ebdbfe4..eced76f 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -5351,9 +5351,9 @@ void Server::handle_client_rename(MDRequest *mdr)
     // open_remote_ino() with 'want_locked=true' when the srcdn or destdn
     // is traversed.
     if (srcdnl->is_remote())
-      xlocks.insert(&srci->get_projected_parent_dn()->lock);
+      xlocks.insert(&srci->get_parent_dn()->lock);
     if (destdnl->is_remote())
-      xlocks.insert(&oldin->get_projected_parent_dn()->lock);
+      xlocks.insert(&oldin->get_parent_dn()->lock);
   }
 
   // we need to update srci's ctime.  xlock its least contended lock to do that...
-- 
1.7.11.7

