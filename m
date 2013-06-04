From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 7/9] ceph: check migrate seq before changing auth cap
Date: Tue,  4 Jun 2013 11:19:56 +0800
Message-ID: <1370315998-10418-8-git-send-email-zheng.z.yan@intel.com>
References: <1370315998-10418-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11730 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758145Ab3FDDVM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 3 Jun 2013 23:21:12 -0400
In-Reply-To: <1370315998-10418-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, elder@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

We may receive old request reply from the exporter MDS after receiving
the importer MDS' cap import message.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 54c290b..790f88b 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -612,9 +612,11 @@ retry:
 		__cap_delay_requeue(mdsc, ci);
 	}
 
-	if (flags & CEPH_CAP_FLAG_AUTH)
-		ci->i_auth_cap = cap;
-	else if (ci->i_auth_cap == cap) {
+	if (flags & CEPH_CAP_FLAG_AUTH) {
+		if (ci->i_auth_cap == NULL ||
+		    ceph_seq_cmp(ci->i_auth_cap->mseq, mseq) < 0)
+			ci->i_auth_cap = cap;
+	} else if (ci->i_auth_cap == cap) {
 		ci->i_auth_cap = NULL;
 		spin_lock(&mdsc->cap_dirty_lock);
 		if (!list_empty(&ci->i_dirty_item)) {
-- 
1.8.1.4

