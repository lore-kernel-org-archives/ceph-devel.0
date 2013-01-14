From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/2] mds: fix end check in Server::handle_client_readdir()
Date: Mon, 14 Jan 2013 20:28:13 +0800
Message-ID: <1358166493-21891-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:37986 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755533Ab3ANM2T (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 14 Jan 2013 07:28:19 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

commit 1174dd3188 (don't retry readdir request after issuing caps)
introduced an bug that wrongly marks 'end' in the the readdir reply.
The code that touches existing dentries re-uses an iterator, and the
iterator is used for checking if readdir is end.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index eb0682e..328d025 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -2895,11 +2895,9 @@ void Server::handle_client_readdir(MDRequest *mdr)
 	continue;
       } else {
 	// touch everything i _do_ have
-	for (it = dir->begin(); 
-	     it != dir->end(); 
-	     it++) 
-	  if (!it->second->get_linkage()->is_null())
-	    mdcache->lru.lru_touch(it->second);
+	for (CDir::map_t::iterator p = dir->begin(); p != dir->end(); p++)
+	  if (!p->second->get_linkage()->is_null())
+	    mdcache->lru.lru_touch(p->second);
 
 	// already issued caps and leases, reply immediately.
 	if (dnbl.length() > 0) {
-- 
1.7.11.7

