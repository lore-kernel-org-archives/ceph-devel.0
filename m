From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 07/14] libceph: unregister only registered linger requests
Date: Wed, 25 Jun 2014 21:16:40 +0400
Message-ID: <1403716607-13535-8-git-send-email-ilya.dryomov@inktank.com>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:48849 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757578AbaFYRRJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jun 2014 13:17:09 -0400
Received: by mail-la0-f43.google.com with SMTP id e16so1007535lan.30
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jun 2014 10:17:08 -0700 (PDT)
Received: from localhost ([109.110.67.53])
        by mx.google.com with ESMTPSA id sq7sm4224790lbb.10.2014.06.25.10.17.06
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 25 Jun 2014 10:17:07 -0700 (PDT)
In-Reply-To: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Linger requests that have not yet been registered should not be
unregistered by __unregister_linger_request().  This messes up ref
count and leads to use-after-free.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osd_client.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index a9b7ea7bfdc6..12ec553a7e76 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1248,7 +1248,9 @@ static void __cancel_request(struct ceph_osd_request *req)
 static void __register_linger_request(struct ceph_osd_client *osdc,
 				    struct ceph_osd_request *req)
 {
-	dout("__register_linger_request %p\n", req);
+	dout("%s %p tid %llu\n", __func__, req, req->r_tid);
+	WARN_ON(!req->r_linger);
+
 	ceph_osdc_get_request(req);
 	list_add_tail(&req->r_linger_item, &osdc->req_linger);
 	if (req->r_osd)
@@ -1259,8 +1261,17 @@ static void __register_linger_request(struct ceph_osd_client *osdc,
 static void __unregister_linger_request(struct ceph_osd_client *osdc,
 					struct ceph_osd_request *req)
 {
-	dout("__unregister_linger_request %p\n", req);
+	WARN_ON(!req->r_linger);
+
+	if (list_empty(&req->r_linger_item)) {
+		dout("%s %p tid %llu not registered\n", __func__, req,
+		     req->r_tid);
+		return;
+	}
+
+	dout("%s %p tid %llu\n", __func__, req, req->r_tid);
 	list_del_init(&req->r_linger_item);
+
 	if (req->r_osd) {
 		list_del_init(&req->r_linger_osd_item);
 		maybe_move_osd_to_lru(osdc, req->r_osd);
-- 
1.7.10.4

