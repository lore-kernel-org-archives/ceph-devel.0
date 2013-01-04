From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 24/29] mds: rdlock prepended dest trace when handling rename
Date: Fri,  4 Jan 2013 17:02:15 +0800
Message-ID: <1357290140-17044-25-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38624 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752091Ab3ADJCw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:52 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

rdlock prepended dest trace to prevent them from being xlocked by
someone else.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 8d05a37..119af98 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -5228,6 +5228,7 @@ void Server::handle_client_rename(MDRequest *mdr)
       while (destbase != srcbase) {
 	desttrace.insert(desttrace.begin(),
 			 destbase->get_projected_parent_dn());
+	rdlocks.insert(&desttrace[0]->lock);
 	dout(10) << "rename prepending desttrace with " << *desttrace[0] << dendl;
 	destbase = destbase->get_projected_parent_dn()->get_dir()->get_inode();
       }
-- 
1.7.11.7

