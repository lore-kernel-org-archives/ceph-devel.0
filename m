From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 5/5] rbd: don't bother setting snapid in rbd_do_request()
Date: Thu, 03 Jan 2013 17:19:44 -0600
Message-ID: <50E61210.6050906@inktank.com>
References: <50E61175.7010103@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:45762 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852Ab3ACXTr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 18:19:47 -0500
Received: by mail-ie0-f175.google.com with SMTP id qd14so18607519ieb.20
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 15:19:46 -0800 (PST)
In-Reply-To: <50E61175.7010103@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

For some reason, the snapid field of the osd request header is
explicitly set to CEPH_NOSNAP in rbd_do_request().  Just a few lines
later--with no code that would access this field in between--a call
is made to ceph_calc_raw_layout() passing the snapid provided to
rbd_do_request(), which encodes the snapid value it is provided into
that field instead.

In other words, there is no need to fill in CEPH_NOSNAP, and doing
so suggests it might be necessary.  Don't do that any more.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 821d93c..cc12154 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1132,7 +1132,6 @@ static int rbd_do_request(struct request *rq,
 	u64 bno;
 	struct timespec mtime = CURRENT_TIME;
 	struct rbd_request *rbd_req;
-	struct ceph_osd_request_head *reqhead;
 	struct ceph_osd_client *osdc;

 	rbd_req = kzalloc(sizeof(*rbd_req), GFP_NOIO);
@@ -1165,9 +1164,6 @@ static int rbd_do_request(struct request *rq,

 	osd_req->r_priv = rbd_req;

-	reqhead = osd_req->r_request->front.iov_base;
-	reqhead->snapid = cpu_to_le64(CEPH_NOSNAP);
-
 	strncpy(osd_req->r_oid, object_name, sizeof(osd_req->r_oid));
 	osd_req->r_oid_len = strlen(osd_req->r_oid);

-- 
1.7.9.5

