From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 1/2] libceph: request a new osdmap if lingering request maps to no osd
Date: Wed, 13 May 2015 17:57:31 +0300
Message-ID: <1431529052-13932-2-git-send-email-idryomov@gmail.com>
References: <1431529052-13932-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:34086 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934303AbbEMO5z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 May 2015 10:57:55 -0400
Received: by wgic8 with SMTP id c8so46534814wgi.1
        for <ceph-devel@vger.kernel.org>; Wed, 13 May 2015 07:57:53 -0700 (PDT)
In-Reply-To: <1431529052-13932-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

This commit does two things.  First, if there are any homeless
lingering requests, we now request a new osdmap even if the osdmap that
is being processed brought no changes, i.e. if a given lingering
request turned homeless in one of the previous epochs and remained
homeless in the current epoch.  Not doing so leaves us with a stale
osdmap and as a result we may miss our window for reestablishing the
watch and lose notifies.

MON=1 OSD=1:

    # cat linger-needmap.sh
    #!/bin/bash
    rbd create --size 1 test
    DEV=$(rbd map test)
    ceph osd out 0
    rbd map dne/dne # obtain a new osdmap as a side effect (!)
    sleep 1
    ceph osd in 0
    rbd resize --size 2 test
    # rbd info test | grep size -> 2M
    # blockdev --getsize $DEV -> 1M

N.B.: Not obtaining a new osdmap in between "osd out" and "osd in"
above is enough to make it miss that resize notify, but that is a
bug^Wlimitation of ceph watch/notify v1.

Second, homeless lingering requests are now kicked just like those
lingering requests whose mapping has changed.  This is mainly to
recognize that a homeless lingering request makes no sense and to
preserve the invariant that a registered lingering request is not
sitting on any of r_req_lru_item lists.  This spares us a WARN_ON,
which commit ba9d114ec557 ("libceph: clear r_req_lru_item in
__unregister_linger_request()") tried to fix the _wrong_ way.

Cc: stable@vger.kernel.org # 3.10+
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/osd_client.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 41a4abc7e98e..31d4b1ebff01 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2017,20 +2017,29 @@ static void kick_requests(struct ceph_osd_client *osdc, bool force_resend,
 		err = __map_request(osdc, req,
 				    force_resend || force_resend_writes);
 		dout("__map_request returned %d\n", err);
-		if (err == 0)
-			continue;  /* no change and no osd was specified */
 		if (err < 0)
 			continue;  /* hrm! */
-		if (req->r_osd == NULL) {
-			dout("tid %llu maps to no valid osd\n", req->r_tid);
-			needmap++;  /* request a newer map */
-			continue;
-		}
+		if (req->r_osd == NULL || err > 0) {
+			if (req->r_osd == NULL) {
+				dout("lingering %p tid %llu maps to no osd\n",
+				     req, req->r_tid);
+				/*
+				 * A homeless lingering request makes
+				 * no sense, as it's job is to keep
+				 * a particular OSD connection open.
+				 * Request a newer map and kick the
+				 * request, knowing that it won't be
+				 * resent until we actually get a map
+				 * that can tell us where to send it.
+				 */
+				needmap++;
+			}
 
-		dout("kicking lingering %p tid %llu osd%d\n", req, req->r_tid,
-		     req->r_osd ? req->r_osd->o_osd : -1);
-		__register_request(osdc, req);
-		__unregister_linger_request(osdc, req);
+			dout("kicking lingering %p tid %llu osd%d\n", req,
+			     req->r_tid, req->r_osd ? req->r_osd->o_osd : -1);
+			__register_request(osdc, req);
+			__unregister_linger_request(osdc, req);
+		}
 	}
 	reset_changed_osds(osdc);
 	mutex_unlock(&osdc->request_mutex);
-- 
1.9.3

