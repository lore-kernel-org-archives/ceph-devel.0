From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/6] ceph: avoid releasing caps that are being used
Date: Fri, 18 Apr 2014 22:48:37 +0800
Message-ID: <1397832522-9557-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:42749 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbaDROtM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 18 Apr 2014 10:49:12 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

To avoid releasing caps that are being used, encode_inode_release()
should send implemented caps to MDS.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 9946ce3..de39a03 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3267,7 +3267,7 @@ int ceph_encode_inode_release(void **p, struct inode *inode,
 			rel->seq = cpu_to_le32(cap->seq);
 			rel->issue_seq = cpu_to_le32(cap->issue_seq),
 			rel->mseq = cpu_to_le32(cap->mseq);
-			rel->caps = cpu_to_le32(cap->issued);
+			rel->caps = cpu_to_le32(cap->implemented);
 			rel->wanted = cpu_to_le32(cap->mds_wanted);
 			rel->dname_len = 0;
 			rel->dname_seq = 0;
-- 
1.9.0

