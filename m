From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 2/2] ceph: make sure request isn't in any waiting list when kicking request.
Date: Thu, 11 Sep 2014 15:22:36 +0800
Message-ID: <1410420156-3289-2-git-send-email-zyan@redhat.com>
References: <1410420156-3289-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63364 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752671AbaIKHW5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 11 Sep 2014 03:22:57 -0400
In-Reply-To: <1410420156-3289-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <ukernel@gmail.com>, "Yan, Zheng" <zyan@redhat.com>

From: "Yan, Zheng" <ukernel@gmail.com>

we may corrupt waiting list if a request in the waiting list is kicked.

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 fs/ceph/mds_client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 267ba44..a17fc49 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2078,6 +2078,7 @@ static void kick_requests(struct ceph_mds_client *mdsc, int mds)
 		if (req->r_session &&
 		    req->r_session->s_mds == mds) {
 			dout(" kicking tid %llu\n", req->r_tid);
+			list_del_init(&req->r_wait);
 			__do_request(mdsc, req);
 		}
 	}
-- 
1.9.3

