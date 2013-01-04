From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 5/6] ceph: check mds_wanted for imported cap
Date: Fri,  4 Jan 2013 19:34:20 +0800
Message-ID: <1357299261-20591-6-git-send-email-zheng.z.yan@intel.com>
References: <1357299261-20591-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48663 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754479Ab3ADLef (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 06:34:35 -0500
In-Reply-To: <1357299261-20591-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The MDS may have incorrect wanted caps after importing caps. So the
client should check the value mds has and send cap update if necessary.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 7e90299..16c10f8 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2425,10 +2425,12 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 	     ceph_cap_string(used),
 	     ceph_cap_string(dirty));
 	if (wanted != le32_to_cpu(grant->wanted)) {
-		dout("mds wanted %s -> %s\n",
-		     ceph_cap_string(le32_to_cpu(grant->wanted)),
-		     ceph_cap_string(wanted));
-		grant->wanted = cpu_to_le32(wanted);
+		dout("mds wanted = %s\n",
+		     ceph_cap_string(le32_to_cpu(grant->wanted)));
+		/* imported cap may not have correct mds_wanted */
+		if (cap == ci->i_auth_cap &&
+		    (wanted & ~(cap->mds_wanted | cap->issued)))
+			check_caps = 1;
 	}
 
 	cap->seq = seq;
-- 
1.7.11.7

