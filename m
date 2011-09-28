From: Sage Weil <sage@newdream.net>
Subject: [PATCH 3/5] libceph: fix linger request requeuing
Date: Wed, 28 Sep 2011 10:26:29 -0700
Message-ID: <1317230791-6642-4-git-send-email-sage@newdream.net>
References: <1317230791-6642-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46493 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532Ab1I1R0i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Sep 2011 13:26:38 -0400
In-Reply-To: <1317230791-6642-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

The r_req_lru_item list node moves between several lists, and that cycle
is not directly related (and does not begin) with __register_request().
Initialize it in the request constructor, not __register_request(). This
fixes later badness (below) when OSDs restart underneath an rbd mount.

Crashes we've seen due to this include:

[  213.974288] kernel BUG at net/ceph/messenger.c:2193!

and

[  144.035274] BUG: unable to handle kernel NULL pointer dereference at 0000000000000048
[  144.035278] IP: [<ffffffffa036c053>] con_work+0x1463/0x2ce0 [libceph]

Signed-off-by: Sage Weil <sage@newdream.net>
---
 net/ceph/osd_client.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 16836a7..88ad8a2 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -217,6 +217,7 @@ struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 	INIT_LIST_HEAD(&req->r_unsafe_item);
 	INIT_LIST_HEAD(&req->r_linger_item);
 	INIT_LIST_HEAD(&req->r_linger_osd);
+	INIT_LIST_HEAD(&req->r_req_lru_item);
 	req->r_flags = flags;
 
 	WARN_ON((flags & (CEPH_OSD_FLAG_READ|CEPH_OSD_FLAG_WRITE)) == 0);
@@ -816,13 +817,10 @@ static void __register_request(struct ceph_osd_client *osdc,
 {
 	req->r_tid = ++osdc->last_tid;
 	req->r_request->hdr.tid = cpu_to_le64(req->r_tid);
-	INIT_LIST_HEAD(&req->r_req_lru_item);
-
 	dout("__register_request %p tid %lld\n", req, req->r_tid);
 	__insert_request(osdc, req);
 	ceph_osdc_get_request(req);
 	osdc->num_requests++;
-
 	if (osdc->num_requests == 1) {
 		dout(" first request, scheduling timeout\n");
 		__schedule_osd_timeout(osdc);
-- 
1.7.0

