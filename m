From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 07/25] mds: don't early reply rename
Date: Wed, 23 Jan 2013 11:08:43 +0800
Message-ID: <1358910541-15535-8-git-send-email-zheng.z.yan@intel.com>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12218 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752769Ab3AWDJL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jan 2013 22:09:11 -0500
In-Reply-To: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

_rename_finish() does not send dentry link/unlink message to replicas.
We should prevent dentries that are modified by the rename operation
from getting new replicas when the rename operation is committing. So
don't mark xlocks "done" and early reply for rename

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index eced76f..4492341 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -796,6 +796,14 @@ void Server::early_reply(MDRequest *mdr, CInode *tracei, CDentry *tracedn)
     return;
   }
 
+  // _rename_finish() does not send dentry link/unlink message to replicas.
+  // so do not mark xlocks "done", the xlocks prevent srcdn and destdn from
+  // getting new replica.
+  if (mdr->client_request->get_op() == CEPH_MDS_OP_RENAME) {
+    dout(10) << "early_reply - rename, not allowed" << dendl;
+    return;
+  }
+
   MClientRequest *req = mdr->client_request;
   entity_inst_t client_inst = req->get_source_inst();
   if (client_inst.name.is_mds())
-- 
1.7.11.7

