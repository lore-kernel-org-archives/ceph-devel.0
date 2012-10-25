From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/4] mds: fix stray migration/reintegration check in handle_client_rename
Date: Thu, 25 Oct 2012 20:26:49 +0800
Message-ID: <1351168012-4981-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:50693 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755424Ab2JYM05 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 25 Oct 2012 08:26:57 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The stray migration/reintegration generates a source path that will
be rooted in a (possibly remote) MDS's MDSDIR; adjust the check in
handle_client_rename()

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/leveldb       | 2 +-
 src/mds/Server.cc | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/leveldb b/src/leveldb
index c79c270..f2d406b 160000
--- a/src/leveldb
+++ b/src/leveldb
@@ -1 +1 @@
-Subproject commit c79c270174307411819ddfdd8c9b671ec4fb69c9
+Subproject commit f2d406b4213a22bfed3acfdb071fbec9ca9205cc
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 8f36b02..0a141d4 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -5135,7 +5135,7 @@ void Server::handle_client_rename(MDRequest *mdr)
 
   // is this a stray migration, reintegration or merge? (sanity checks!)
   if (mdr->reqid.name.is_mds() &&
-      !(MDS_INO_IS_STRAY(srcpath.get_ino()) &&
+      !(MDS_INO_IS_MDSDIR(srcpath.get_ino()) &&
 	MDS_INO_IS_STRAY(destpath.get_ino())) &&
       !(destdnl->is_remote() &&
 	destdnl->get_remote_ino() == srci->ino())) {
-- 
1.7.11.7

