From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 8/9] ceph: clear migrate seq when MDS restarts
Date: Tue,  4 Jun 2013 11:19:57 +0800
Message-ID: <1370315998-10418-9-git-send-email-zheng.z.yan@intel.com>
References: <1370315998-10418-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58772 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758064Ab3FDDVL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
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
index e2d7e56..ce7a789 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2455,6 +2455,7 @@ static int encode_caps_cb(struct inode *inode, struct ceph_cap *cap,
 	spin_lock(&ci->i_ceph_lock);
 	cap->seq = 0;        /* reset cap seq */
 	cap->issue_seq = 0;  /* and issue_seq */
+	cap->mseq = 0;       /* and migrate_seq */
 
 	if (recon_state->flock) {
 		rec.v2.cap_id = cpu_to_le64(cap->cap_id);
-- 
1.8.1.4

