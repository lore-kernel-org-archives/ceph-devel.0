From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 05/14] libceph: harden ceph_osdc_request_release() a bit
Date: Wed, 25 Jun 2014 21:16:38 +0400
Message-ID: <1403716607-13535-6-git-send-email-ilya.dryomov@inktank.com>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:42496 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757535AbaFYRRE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jun 2014 13:17:04 -0400
Received: by mail-lb0-f176.google.com with SMTP id w7so2089907lbi.35
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jun 2014 10:17:02 -0700 (PDT)
Received: from localhost ([109.110.67.53])
        by mx.google.com with ESMTPSA id kx8sm1807202lac.38.2014.06.25.10.17.01
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 25 Jun 2014 10:17:02 -0700 (PDT)
In-Reply-To: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Add some WARN_ONs to alert us when we try to destroy requests that are
still registered.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osd_client.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 7406046212dc..052eb8bfcc74 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -305,6 +305,12 @@ static void ceph_osdc_release_request(struct kref *kref)
 
 	dout("%s %p (r_request %p r_reply %p)\n", __func__, req,
 	     req->r_request, req->r_reply);
+	WARN_ON(!RB_EMPTY_NODE(&req->r_node));
+	WARN_ON(!list_empty(&req->r_req_lru_item));
+	WARN_ON(!list_empty(&req->r_osd_item));
+	WARN_ON(!list_empty(&req->r_linger_item));
+	WARN_ON(!list_empty(&req->r_linger_osd_item));
+	WARN_ON(req->r_osd);
 
 	if (req->r_request)
 		ceph_msg_put(req->r_request);
@@ -1204,6 +1210,7 @@ static void __unregister_request(struct ceph_osd_client *osdc,
 
 	dout("__unregister_request %p tid %lld\n", req, req->r_tid);
 	rb_erase(&req->r_node, &osdc->requests);
+	RB_CLEAR_NODE(&req->r_node);
 	osdc->num_requests--;
 
 	if (req->r_osd) {
-- 
1.7.10.4

