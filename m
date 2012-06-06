From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: osd_client: don't drop reply reference too early
Date: Tue, 05 Jun 2012 22:30:38 -0500
Message-ID: <4FCECEDE.4030902@inktank.com>
References: <4FCECD7F.9030002@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55386 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab2FFDae (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jun 2012 23:30:34 -0400
Received: by yhmm54 with SMTP id m54so4512272yhm.19
        for <ceph-devel@vger.kernel.org>; Tue, 05 Jun 2012 20:30:33 -0700 (PDT)
In-Reply-To: <4FCECD7F.9030002@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In ceph_osdc_release_request(), a reference to the r_reply message
is dropped.  But just after that, that same message is revoked if it
was in use to receive an incoming reply.  Reorder these so we are
sure we hold a reference until we're actually done with the message.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index e30efbc..d8b6d31 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -139,8 +139,6 @@ void ceph_osdc_release_request(struct kref *kref)

 	if (req->r_request)
 		ceph_msg_put(req->r_request);
-	if (req->r_reply)
-		ceph_msg_put(req->r_reply);
 	if (req->r_con_filling_msg) {
 		dout("release_request revoking pages %p from con %p\n",
 		     req->r_pages, req->r_con_filling_msg);
@@ -148,6 +146,8 @@ void ceph_osdc_release_request(struct kref *kref)
 				      req->r_reply);
 		ceph_con_put(req->r_con_filling_msg);
 	}
+	if (req->r_reply)
+		ceph_msg_put(req->r_reply);
 	if (req->r_own_pages)
 		ceph_release_page_vector(req->r_pages,
 					 req->r_num_pages);
-- 
1.7.5.4

