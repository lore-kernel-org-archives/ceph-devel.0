From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 3/7] ceph: set mds_want according to cap import message
Date: Fri,  1 Mar 2013 14:46:20 +0800
Message-ID: <1362120384-5188-4-git-send-email-zheng.z.yan@intel.com>
References: <1362120384-5188-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58983 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750870Ab3CAGqb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 1 Mar 2013 01:46:31 -0500
In-Reply-To: <1362120384-5188-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

MDS ignores cap update message if migrate_seq mismatch, so when
receiving a cap import message with higher migrate_seq, set mds_want
according to the cap import message.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 5d5c32b..61f3833 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -553,6 +553,7 @@ retry:
 		cap->implemented = 0;
 		cap->mds = mds;
 		cap->mds_wanted = 0;
+		cap->mseq = 0;
 
 		cap->ci = ci;
 		__insert_cap_node(ci, cap);
@@ -628,7 +629,10 @@ retry:
 	cap->cap_id = cap_id;
 	cap->issued = issued;
 	cap->implemented |= issued;
-	cap->mds_wanted |= wanted;
+	if (mseq > cap->mseq)
+		cap->mds_wanted = wanted;
+	else
+		cap->mds_wanted |= wanted;
 	cap->seq = seq;
 	cap->issue_seq = seq;
 	cap->mseq = mseq;
-- 
1.7.11.7

