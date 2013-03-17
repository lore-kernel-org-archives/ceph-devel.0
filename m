From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 08/39] mds: consider MDS as recovered when it reaches clientreply state.
Date: Sun, 17 Mar 2013 22:51:11 +0800
Message-ID: <1363531902-24909-9-git-send-email-zheng.z.yan@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:34328 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932476Ab3CQOwP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Mar 2013 10:52:15 -0400
In-Reply-To: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

MDS in clientreply state already start servering requests. It also
make MDS::handle_mds_recovery() and MDS::recovery_done() match.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDS.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/mds/MDS.cc b/src/mds/MDS.cc
index 282fa64..b91dcbd 100644
--- a/src/mds/MDS.cc
+++ b/src/mds/MDS.cc
@@ -1032,7 +1032,9 @@ void MDS::handle_mds_map(MMDSMap *m)
 
     set<int> oldactive, active;
     oldmap->get_mds_set(oldactive, MDSMap::STATE_ACTIVE);
+    oldmap->get_mds_set(oldactive, MDSMap::STATE_CLIENTREPLAY);
     mdsmap->get_mds_set(active, MDSMap::STATE_ACTIVE);
+    mdsmap->get_mds_set(active, MDSMap::STATE_CLIENTREPLAY);
     for (set<int>::iterator p = active.begin(); p != active.end(); ++p) 
       if (*p != whoami &&            // not me
 	  oldactive.count(*p) == 0)  // newly so?
-- 
1.7.11.7

