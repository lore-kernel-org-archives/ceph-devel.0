From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 10/14] mds: don't retry readdir request after issuing caps
Date: Tue, 11 Dec 2012 16:30:56 +0800
Message-ID: <1355214660-26354-11-git-send-email-zheng.z.yan@intel.com>
References: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16602 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752519Ab2LKIbO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Dec 2012 03:31:14 -0500
In-Reply-To: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

If remote linkage without inode is encountered after some caps are
issued, Server::handle_client_readdir() should send the reply to
client immediately instead of retrying the request after opening
the remote dentry. This is because the MDS may want to revoke these
caps before the MDS succeeds in opening the remote dentry.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index c8c52e1..c95344e 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -2830,14 +2830,22 @@ void Server::handle_client_readdir(MDRequest *mdr)
 	dout(10) << "skipping bad remote ino on " << *dn << dendl;
 	continue;
       } else {
-	mdcache->open_remote_dentry(dn, dnp, new C_MDS_RetryRequest(mdcache, mdr));
-
 	// touch everything i _do_ have
 	for (it = dir->begin(); 
 	     it != dir->end(); 
 	     it++) 
 	  if (!it->second->get_linkage()->is_null())
 	    mdcache->lru.lru_touch(it->second);
+
+	// already issued caps and leases, reply immediately.
+	if (dnbl.length() > 0) {
+	  mdcache->open_remote_dentry(dn, dnp, new C_NoopContext);
+	  dout(10) << " open remote dentry after caps were issued, stopping at "
+		   << dnbl.length() << " < " << bytes_left << dendl;
+	  break;
+	}
+
+	mdcache->open_remote_dentry(dn, dnp, new C_MDS_RetryRequest(mdcache, mdr));
 	return;
       }
     }
-- 
1.7.11.7

