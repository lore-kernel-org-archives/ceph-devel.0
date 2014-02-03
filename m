From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 4/4] libceph: take map_sem for read in handle_reply()
Date: Mon,  3 Feb 2014 15:47:08 +0200
Message-ID: <1391435228-27874-5-git-send-email-ilya.dryomov@inktank.com>
References: <1391435228-27874-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:55931 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbaBCNrV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Feb 2014 08:47:21 -0500
Received: by mail-wg0-f49.google.com with SMTP id a1so11640152wgh.28
        for <ceph-devel@vger.kernel.org>; Mon, 03 Feb 2014 05:47:20 -0800 (PST)
Received: from localhost ([109.110.66.110])
        by mx.google.com with ESMTPSA id hy8sm44007706wjb.2.2014.02.03.05.47.19
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Feb 2014 05:47:20 -0800 (PST)
In-Reply-To: <1391435228-27874-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Handling redirect replies requires both map_sem and request_mutex.
Taking map_sem unconditionally near the top of handle_reply() avoids
possible race conditions that arise from releasing request_mutex to be
able to acquire map_sem in redirect reply case.  (Lock ordering is:
map_sem, request_mutex, crush_mutex.)

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osd_client.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 2aa82b6bb305..0676f2b199d6 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1687,6 +1687,7 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg,
 	osdmap_epoch = ceph_decode_32(&p);
 
 	/* lookup */
+	down_read(&osdc->map_sem);
 	mutex_lock(&osdc->request_mutex);
 	req = __lookup_request(osdc, tid);
 	if (req == NULL) {
@@ -1743,7 +1744,6 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg,
 		dout("redirect pool %lld\n", redir.oloc.pool);
 
 		__unregister_request(osdc, req);
-		mutex_unlock(&osdc->request_mutex);
 
 		req->r_target_oloc = redir.oloc; /* struct */
 
@@ -1755,10 +1755,10 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg,
 		 * successfully.  In the future we might want to follow
 		 * original request's nofail setting here.
 		 */
-		err = ceph_osdc_start_request(osdc, req, true);
+		err = __ceph_osdc_start_request(osdc, req, true);
 		BUG_ON(err);
 
-		goto done;
+		goto out_unlock;
 	}
 
 	already_completed = req->r_got_reply;
@@ -1776,8 +1776,7 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg,
 		req->r_got_reply = 1;
 	} else if ((flags & CEPH_OSD_FLAG_ONDISK) == 0) {
 		dout("handle_reply tid %llu dup ack\n", tid);
-		mutex_unlock(&osdc->request_mutex);
-		goto done;
+		goto out_unlock;
 	}
 
 	dout("handle_reply tid %llu flags %d\n", tid, flags);
@@ -1792,6 +1791,7 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg,
 		__unregister_request(osdc, req);
 
 	mutex_unlock(&osdc->request_mutex);
+	up_read(&osdc->map_sem);
 
 	if (!already_completed) {
 		if (req->r_unsafe_callback &&
@@ -1809,10 +1809,14 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg,
 		complete_request(req);
 	}
 
-done:
+out:
 	dout("req=%p req->r_linger=%d\n", req, req->r_linger);
 	ceph_osdc_put_request(req);
 	return;
+out_unlock:
+	mutex_unlock(&osdc->request_mutex);
+	up_read(&osdc->map_sem);
+	goto out;
 
 bad_put:
 	req->r_result = -EIO;
@@ -1825,6 +1829,7 @@ bad_put:
 	ceph_osdc_put_request(req);
 bad_mutex:
 	mutex_unlock(&osdc->request_mutex);
+	up_read(&osdc->map_sem);
 bad:
 	pr_err("corrupt osd_op_reply got %d %d\n",
 	       (int)msg->front.iov_len, le32_to_cpu(msg->hdr.front_len));
-- 
1.7.10.4

