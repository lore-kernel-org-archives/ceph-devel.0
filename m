From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: drop mutex on error in handle_reply()
Date: Tue, 02 Apr 2013 08:35:04 -0500
Message-ID: <515ADE88.8080501@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181]:64716 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761146Ab3DBNfH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Apr 2013 09:35:07 -0400
Received: by mail-vc0-f181.google.com with SMTP id hv10so401229vcb.40
        for <ceph-devel@vger.kernel.org>; Tue, 02 Apr 2013 06:35:06 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The osd client mutex is acquired just before getting a reference to
a request in handle_reply().  However the error paths after that
don't drop the mutex before returning as they should.

Drop the mutex after dropping the request reference.  Also add a
bad_mutex label at that point and use it so the failed request
lookup case can be handled with the rest.

This resolves:
    http://tracker.ceph.com/issues/4615

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 9b69f47..abbcde3 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1332,8 +1332,7 @@ static void handle_reply(struct ceph_osd_client
*osdc, struct ceph_msg *msg,
 	req = __lookup_request(osdc, tid);
 	if (req == NULL) {
 		dout("handle_reply tid %llu dne\n", tid);
-		mutex_unlock(&osdc->request_mutex);
-		return;
+		goto bad_mutex;
 	}
 	ceph_osdc_get_request(req);

@@ -1422,6 +1421,8 @@ done:

 bad_put:
 	ceph_osdc_put_request(req);
+bad_mutex:
+	mutex_unlock(&osdc->request_mutex);
 bad:
 	pr_err("corrupt osd_op_reply got %d %d\n",
 	       (int)msg->front.iov_len, le32_to_cpu(msg->hdr.front_len));
-- 
1.7.9.5

