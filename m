From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 5/9] ceph: reset iov_len when discarding cap release messages
Date: Tue,  4 Jun 2013 11:19:54 +0800
Message-ID: <1370315998-10418-6-git-send-email-zheng.z.yan@intel.com>
References: <1370315998-10418-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11730 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758024Ab3FDDVL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 3 Jun 2013 23:21:11 -0400
In-Reply-To: <1370315998-10418-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, elder@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/mds_client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 4f22671..e2d7e56 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1391,6 +1391,7 @@ static void discard_cap_releases(struct ceph_mds_client *mdsc,
 	num = le32_to_cpu(head->num);
 	dout("discard_cap_releases mds%d %p %u\n", session->s_mds, msg, num);
 	head->num = cpu_to_le32(0);
+	msg->front.iov_len = sizeof(*head);
 	session->s_num_cap_releases += num;
 
 	/* requeue completed messages */
-- 
1.8.1.4

