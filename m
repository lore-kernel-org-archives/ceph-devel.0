From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 2/2] Revert "libceph: clear r_req_lru_item in __unregister_linger_request()"
Date: Wed, 13 May 2015 17:57:32 +0300
Message-ID: <1431529052-13932-3-git-send-email-idryomov@gmail.com>
References: <1431529052-13932-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37568 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934541AbbEMO54 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 May 2015 10:57:56 -0400
Received: by widdi4 with SMTP id di4so59372192wid.0
        for <ceph-devel@vger.kernel.org>; Wed, 13 May 2015 07:57:55 -0700 (PDT)
In-Reply-To: <1431529052-13932-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

This reverts commit ba9d114ec5578e6e99a4dfa37ff8ae688040fd64.

.. which introduced a regression that prevented all lingering requests
requeued in kick_requests() from ever being sent to the OSDs, resulting
in a lot of missed notifies.  In retrospect it's pretty obvious that
r_req_lru_item item in the case of lingering requests can be used not
only for notarget, but also for unsent linkage due to how tightly
actual map and enqueue operations are coupled in __map_request().

The assertion that was being silenced is taken care of in the previous
("libceph: request a new osdmap if lingering request maps to no osd")
commit: by always kicking homeless lingering requests we ensure that
none of them ends up on the notarget list outside of the critical
section guarded by request_mutex.

Cc: stable@vger.kernel.org # 3.18+, needs 3d8c73c93605 "libceph: request a new osdmap if lingering request maps to no osd"
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/osd_client.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 31d4b1ebff01..c4ec9239249a 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1306,8 +1306,6 @@ static void __unregister_linger_request(struct ceph_osd_client *osdc,
 		if (list_empty(&req->r_osd_item))
 			req->r_osd = NULL;
 	}
-
-	list_del_init(&req->r_req_lru_item); /* can be on notarget */
 	ceph_osdc_put_request(req);
 }
 
-- 
1.9.3

