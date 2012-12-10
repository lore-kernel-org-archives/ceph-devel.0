From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/4] libceph: register request before unregister linger
Date: Sun, 09 Dec 2012 18:35:54 -0600
Message-ID: <50C52E6A.4070309@inktank.com>
References: <50C52DE5.9070602@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f172.google.com ([209.85.210.172]:58099 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443Ab2LJAlE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 9 Dec 2012 19:41:04 -0500
Received: by mail-ia0-f172.google.com with SMTP id z13so3355285iaz.3
        for <ceph-devel@vger.kernel.org>; Sun, 09 Dec 2012 16:41:03 -0800 (PST)
In-Reply-To: <50C52DE5.9070602@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

In kick_requests(), we need to register the request before we
unregister the linger request.  Otherwise the unregister will
reset the request's osd pointer to NULL.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 79a071b..1a42701 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1253,8 +1253,8 @@ static void kick_requests(struct ceph_osd_client
*osdc, int force_resend)

 		dout("kicking lingering %p tid %llu osd%d\n", req, req->r_tid,
 		     req->r_osd ? req->r_osd->o_osd : -1);
-		__unregister_linger_request(osdc, req);
 		__register_request(osdc, req);
+		__unregister_linger_request(osdc, req);
 	}
 	mutex_unlock(&osdc->request_mutex);

-- 
1.7.9.5

