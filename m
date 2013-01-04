From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 26/29] mds: drop locks when opening remote dentry
Date: Fri,  4 Jan 2013 17:02:17 +0800
Message-ID: <1357290140-17044-27-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53494 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754084Ab3ADJCy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:54 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Opening remote dentry while holding locks may cause dead lock. For example,
'discover' is blocked by a xlocked dentry, the request holding the xlock
is blocked by the locks hold by the readdir request.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 119af98..2531005 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -2901,6 +2901,8 @@ void Server::handle_client_readdir(MDRequest *mdr)
 	  break;
 	}
 
+	mds->locker->drop_locks(mdr);
+	mdr->drop_local_auth_pins();
 	mdcache->open_remote_dentry(dn, dnp, new C_MDS_RetryRequest(mdcache, mdr));
 	return;
       }
-- 
1.7.11.7

