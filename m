From: Sage Weil <sage@inktank.com>
Subject: [PATCH 2/4] ceph: cleanup aborted requests when re-sending requests.
Date: Mon, 30 Dec 2013 16:13:49 -0800
Message-ID: <1388448831-10324-3-git-send-email-sage@inktank.com>
References: <1388448831-10324-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34240 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932403Ab3LaAOA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Dec 2013 19:14:00 -0500
In-Reply-To: <1388448831-10324-1-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: stable@vger.kernel.org
Cc: ceph-devel@vger.kernel.org, "Yan, Zheng" <zheng.z.yan@intel.com>, Sage Weil <sage@inktank.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Aborted requests usually get cleared when the reply is received.
If MDS crashes, no reply will be received. So we need to cleanup
aborted requests when re-sending requests.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
Reviewed-by: Greg Farnum <greg@inktank.com>
Signed-off-by: Sage Weil <sage@inktank.com>
(cherry picked from commit eb1b8af33c2e42a9a57fc0a7588f4a7b255d2e79)
---
 fs/ceph/mds_client.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index b7bda5d..91214b2 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1875,8 +1875,11 @@ static int __do_request(struct ceph_mds_client *mdsc,
 	int mds = -1;
 	int err = -EAGAIN;
 
-	if (req->r_err || req->r_got_result)
+	if (req->r_err || req->r_got_result) {
+		if (req->r_aborted)
+			__unregister_request(mdsc, req);
 		goto out;
+	}
 
 	if (req->r_timeout &&
 	    time_after_eq(jiffies, req->r_started + req->r_timeout)) {
-- 
1.8.5.1

