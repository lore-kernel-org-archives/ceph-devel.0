From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: don't bother setting snapid in rbd_do_request()
Date: Fri, 09 Nov 2012 21:54:33 -0600
Message-ID: <509DCFF9.7040801@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:58787 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab2KJDyb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Nov 2012 22:54:31 -0500
Received: by mail-ia0-f174.google.com with SMTP id y32so3216943iag.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Nov 2012 19:54:31 -0800 (PST)
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
index b3d25c3..cd51216 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1134,7 +1134,6 @@ static int rbd_do_request(struct request *rq,
 	u64 bno;
 	struct timespec mtime = CURRENT_TIME;
 	struct rbd_request *rbd_req;
-	struct ceph_osd_request_head *reqhead;
 	struct ceph_osd_client *osdc;

 	rbd_req = kzalloc(sizeof(*rbd_req), GFP_NOIO);
@@ -1167,9 +1166,6 @@ static int rbd_do_request(struct request *rq,

 	osd_req->r_priv = rbd_req;

-	reqhead = osd_req->r_request->front.iov_base;
-	reqhead->snapid = cpu_to_le64(CEPH_NOSNAP);
-
 	strncpy(osd_req->r_oid, object_name, sizeof(osd_req->r_oid));
 	osd_req->r_oid_len = strlen(osd_req->r_oid);

-- 
1.7.9.5

