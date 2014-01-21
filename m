From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 02/11] mds: use ceph_seq_cmp() to compare migrate_seq
Date: Tue, 21 Jan 2014 12:15:36 +0800
Message-ID: <1390277745-20142-2-git-send-email-zheng.z.yan@intel.com>
References: <1390277745-20142-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:65179 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752789AbaAUEPw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 20 Jan 2014 23:15:52 -0500
In-Reply-To: <1390277745-20142-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 1012099..2c39d9f 100644
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
1.8.4.2

