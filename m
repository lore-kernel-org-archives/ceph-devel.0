From: Sage Weil <sage@inktank.com>
Subject: [PATCH 3/4] ceph: wake up 'safe' waiters when unregistering request
Date: Mon, 30 Dec 2013 16:13:50 -0800
Message-ID: <1388448831-10324-4-git-send-email-sage@inktank.com>
References: <1388448831-10324-1-git-send-email-sage@inktank.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1388448831-10324-1-git-send-email-sage@inktank.com>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: ceph-devel@vger.kernel.org, "Yan, Zheng" <zheng.z.yan@intel.com>, Sage Weil <sage@inktank.com>
List-Id: ceph-devel.vger.kernel.org

From: "Yan, Zheng" <zheng.z.yan@intel.com>

We also need to wake up 'safe' waiters if error occurs or request
aborted. Otherwise sync(2)/fsync(2) may hang forever.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
Signed-off-by: Sage Weil <sage@inktank.com>
(cherry picked from commit fc55d2c9448b34218ca58733a6f51fbede09575b)
---
 fs/ceph/mds_client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 91214b2..7889015 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -642,6 +642,8 @@ static void __unregister_request(struct ceph_mds_client *mdsc,
 		req->r_unsafe_dir = NULL;
 	}
 
+	complete_all(&req->r_safe_completion);
+
 	ceph_mdsc_put_request(req);
 }
 
@@ -2189,7 +2191,6 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	if (head->safe) {
 		req->r_got_safe = true;
 		__unregister_request(mdsc, req);
-		complete_all(&req->r_safe_completion);
 
 		if (req->r_got_unsafe) {
 			/*
-- 
1.8.5.1
