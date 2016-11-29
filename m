From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH] libceph: wake up sync waiter when unregistering request
Date: Tue, 29 Nov 2016 19:49:21 +0800
Message-ID: <20161129114921.62964-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52060 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757344AbcK2Ltb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 29 Nov 2016 06:49:31 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: idryomov@gmail.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>

Current code does not wake up sync waiter if osd replies error
or the request does not want ondisk ack.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 net/ceph/osd_client.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index e6ae15b..54ffe8b 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2934,8 +2934,7 @@ static void handle_reply(struct ceph_osd *osd, struct ceph_msg *msg)
 			dout("req %p tid %llu cb\n", req, req->r_tid);
 			__complete_request(req);
 		}
-		if (m.flags & CEPH_OSD_FLAG_ONDISK)
-			complete_all(&req->r_safe_completion);
+		complete_all(&req->r_safe_completion);
 		ceph_osdc_put_request(req);
 	} else {
 		if (req->r_unsafe_callback) {
-- 
2.7.4

