From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 03/12] mds: use ceph_seq_cmp() to compare migrate_seq
Date: Fri,  6 Dec 2013 16:46:34 +0800
Message-ID: <1386319603-2610-4-git-send-email-zheng.z.yan@intel.com>
References: <1386319603-2610-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23345 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757174Ab3LFIqu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 Dec 2013 03:46:50 -0500
In-Reply-To: <1386319603-2610-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index b1b7304..a3033fa 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -628,7 +628,7 @@ retry:
 	cap->cap_id = cap_id;
 	cap->issued = issued;
 	cap->implemented |= issued;
-	if (mseq > cap->mseq)
+	if (ceph_seq_cmp(mseq, cap->mseq) > 0)
 		cap->mds_wanted = wanted;
 	else
 		cap->mds_wanted |= wanted;
-- 
1.8.1.4

