From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 01/14] libceph: rename ceph_osd_request::r_linger_osd to r_linger_osd_item
Date: Wed, 25 Jun 2014 21:16:34 +0400
Message-ID: <1403716607-13535-2-git-send-email-ilya.dryomov@inktank.com>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:62619 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757311AbaFYRQy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jun 2014 13:16:54 -0400
Received: by mail-lb0-f170.google.com with SMTP id 10so2087914lbg.15
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jun 2014 10:16:52 -0700 (PDT)
Received: from localhost ([109.110.67.53])
        by mx.google.com with ESMTPSA id ba10sm4208723lbc.47.2014.06.25.10.16.51
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 25 Jun 2014 10:16:51 -0700 (PDT)
In-Reply-To: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

So that:

req->r_osd_item --> osd->o_requests list
req->r_linger_osd_item --> osd->o_linger_requests list

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/osd_client.h |    2 +-
 net/ceph/osd_client.c           |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 94ec69672164..7490a03ac163 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -117,7 +117,7 @@ struct ceph_osd_request {
 	struct list_head r_req_lru_item;
 	struct list_head r_osd_item;
 	struct list_head r_linger_item;
-	struct list_head r_linger_osd;
+	struct list_head r_linger_osd_item;
 	struct ceph_osd *r_osd;
 	struct ceph_pg   r_pgid;
 	int              r_pg_osds[CEPH_PG_MAX_SIZE];
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 05be0c181695..d5d2be3bd113 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -364,7 +364,7 @@ struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 	RB_CLEAR_NODE(&req->r_node);
 	INIT_LIST_HEAD(&req->r_unsafe_item);
 	INIT_LIST_HEAD(&req->r_linger_item);
-	INIT_LIST_HEAD(&req->r_linger_osd);
+	INIT_LIST_HEAD(&req->r_linger_osd_item);
 	INIT_LIST_HEAD(&req->r_req_lru_item);
 	INIT_LIST_HEAD(&req->r_osd_item);
 
@@ -916,7 +916,7 @@ static void __kick_osd_requests(struct ceph_osd_client *osdc,
 	 * list at the end to keep things in tid order.
 	 */
 	list_for_each_entry_safe(req, nreq, &osd->o_linger_requests,
-				 r_linger_osd) {
+				 r_linger_osd_item) {
 		/*
 		 * reregister request prior to unregistering linger so
 		 * that r_osd is preserved.
@@ -1218,7 +1218,7 @@ static void __register_linger_request(struct ceph_osd_client *osdc,
 	ceph_osdc_get_request(req);
 	list_add_tail(&req->r_linger_item, &osdc->req_linger);
 	if (req->r_osd)
-		list_add_tail(&req->r_linger_osd,
+		list_add_tail(&req->r_linger_osd_item,
 			      &req->r_osd->o_linger_requests);
 }
 
@@ -1228,7 +1228,7 @@ static void __unregister_linger_request(struct ceph_osd_client *osdc,
 	dout("__unregister_linger_request %p\n", req);
 	list_del_init(&req->r_linger_item);
 	if (req->r_osd) {
-		list_del_init(&req->r_linger_osd);
+		list_del_init(&req->r_linger_osd_item);
 
 		if (list_empty(&req->r_osd->o_requests) &&
 		    list_empty(&req->r_osd->o_linger_requests)) {
-- 
1.7.10.4

