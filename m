From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 6/6] ceph: call handle_cap_grant() for cap import message
Date: Mon, 19 Nov 2012 10:49:09 +0800
Message-ID: <1353293349-15494-7-git-send-email-zheng.z.yan@intel.com>
References: <1353293349-15494-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10829 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825Ab2KSCtT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 18 Nov 2012 21:49:19 -0500
In-Reply-To: <1353293349-15494-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

If client sends cap message that requests new max size during
exporting caps, the exporting MDS will drop the message quietly.
So the client may wait for the reply that updates the max size
forever. call handle_cap_grant() for cap import message can
avoid this issue.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 5efa3f5..a1d9bb3 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2751,6 +2751,7 @@ static void handle_cap_import(struct ceph_mds_client *mdsc,
 
 	/* make sure we re-request max_size, if necessary */
 	spin_lock(&ci->i_ceph_lock);
+	ci->i_wanted_max_size = 0;  /* reset */
 	ci->i_requested_max_size = 0;
 	spin_unlock(&ci->i_ceph_lock);
 }
@@ -2846,8 +2847,6 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	case CEPH_CAP_OP_IMPORT:
 		handle_cap_import(mdsc, inode, h, session,
 				  snaptrace, snaptrace_len);
-		ceph_check_caps(ceph_inode(inode), 0, session);
-		goto done_unlocked;
 	}
 
 	/* the rest require a cap */
@@ -2864,6 +2863,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	switch (op) {
 	case CEPH_CAP_OP_REVOKE:
 	case CEPH_CAP_OP_GRANT:
+	case CEPH_CAP_OP_IMPORT:
 		handle_cap_grant(inode, h, session, cap, msg->middle);
 		goto done_unlocked;
 
-- 
1.7.11.7

