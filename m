From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 4/6] mds: allow handling slave request in the clientreplay stage
Date: Mon, 28 Jan 2013 10:28:24 +0800
Message-ID: <1359340106-24257-5-git-send-email-zheng.z.yan@intel.com>
References: <1359340106-24257-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52188 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752122Ab3A1C2d (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 27 Jan 2013 21:28:33 -0500
In-Reply-To: <1359340106-24257-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

replaying a client request may need to create slave request and the slave
MDS can be also in the clientreplay stage.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 083c287..520d389 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -101,6 +101,10 @@ void Server::dispatch(Message *m)
 		(m->get_type() == CEPH_MSG_CLIENT_REQUEST &&
 		 ((MClientRequest*)m)->is_replay()))) {
       // replaying!
+    } else if (mds->is_clientreplay() && m->get_type() == MSG_MDS_SLAVE_REQUEST &&
+	       (((MMDSSlaveRequest*)m)->is_reply() ||
+		!mds->mdsmap->is_active(m->get_source().num()))) {
+      // slave reply or the master is also in the clientreplay stage
     } else {
       dout(3) << "not active yet, waiting" << dendl;
       mds->wait_for_active(new C_MDS_RetryMessage(mds, m));
-- 
1.7.11.7

