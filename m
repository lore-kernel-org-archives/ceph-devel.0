From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/5] mds: fix handle_client_openc() hang
Date: Fri, 30 Nov 2012 10:36:51 +0800
Message-ID: <1354243014-21072-3-git-send-email-zheng.z.yan@intel.com>
References: <1354243014-21072-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8401 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754991Ab2K3ChB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 Nov 2012 21:37:01 -0500
In-Reply-To: <1354243014-21072-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

handle_client_openc() calls handle_client_open() if the linkage isn't
null. handle_client_open() calls rdlock_path_pin_ref() which returns
mdr->in[0] directly because mdr->done_locking is true. the problem here
is that mdr->in[0] can be NULL if the linkage is remote.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 4c66f4a..59d7d3c 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -2637,6 +2637,12 @@ void Server::handle_client_openc(MDRequest *mdr)
       reply_request(mdr, -EEXIST, dnl->get_inode(), dn);
       return;
     } 
+
+    mdcache->request_drop_non_rdlocks(mdr);
+
+    // remote link, avoid rdlock_path_pin_ref() returning null
+    if (!mdr->in[0])
+      mdr->done_locking = false;
     
     handle_client_open(mdr);
     return;
-- 
1.7.11.7

