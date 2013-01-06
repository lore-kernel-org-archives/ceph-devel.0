From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 5/6] ceph: check mds_wanted for imported cap
Date: Sun, 06 Jan 2013 16:54:52 +0800
Message-ID: <50E93BDC.6050104@intel.com>
References: <1357299261-20591-1-git-send-email-zheng.z.yan@intel.com> <1357299261-20591-6-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1301052216330.15430@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23925 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600Ab3AFIyz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 6 Jan 2013 03:54:55 -0500
In-Reply-To: <alpine.DEB.2.00.1301052216330.15430@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

how about below patch, also updated git://github.com/ukernel/ceph-client.git wip-ceph

Reagrds
Yan, Zheng
---
From 6fdcf8d71239dac7b26f50623ee5986f39552b4a Mon Sep 17 00:00:00 2001
From: "Yan, Zheng" <zheng.z.yan@intel.com>
Date: Fri, 4 Jan 2013 15:30:10 +0800
Subject: [PATCH 5/5] ceph: check mds_wanted for imported cap

The MDS may have incorrect wanted caps after importing caps. So the
client should check the value mds has and send cap update if necessary.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 40b5bbe..1e1e020 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2429,7 +2429,9 @@ static void handle_cap_grant(struct inode *inode, struct ceph_mds_caps *grant,
 		dout("mds wanted %s -> %s\n",
 		     ceph_cap_string(le32_to_cpu(grant->wanted)),
 		     ceph_cap_string(wanted));
-		grant->wanted = cpu_to_le32(wanted);
+		/* imported cap may not have correct mds_wanted */
+		if (le32_to_cpu(grant->op) == CEPH_CAP_OP_IMPORT)
+			check_caps = 1;
 	}
 
 	cap->seq = seq;
-- 
1.7.11.7

