From: Alex Elder <elder@inktank.com>
Subject: [PATCH 17/20] libceph: set message data when building osd request
Date: Fri, 05 Apr 2013 09:05:33 -0500
Message-ID: <515EDA2D.10306@inktank.com>
References: <515ED849.9060901@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f181.google.com ([209.85.210.181]:50040 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161548Ab3DEOFg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Apr 2013 10:05:36 -0400
Received: by mail-ia0-f181.google.com with SMTP id o25so3231371iad.12
        for <ceph-devel@vger.kernel.org>; Fri, 05 Apr 2013 07:05:36 -0700 (PDT)
In-Reply-To: <515ED849.9060901@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

All calls of ceph_osdc_start_request() are preceded (in the case of
rbd, almost) immediately by a call to ceph_osdc_build_request().

Move the build calls at the top of ceph_osdc_start_request() out of
there and into the ceph_osdc_build_request().  Nothing prevents
moving these calls to the top of ceph_osdc_build_request(), either
(and we're going to want them there in the next patch) so put them
at the top.

This and the next patch are related to:
    http://tracker.ceph.com/issues/4657

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index f80984e..40466ab 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1884,6 +1884,11 @@ void ceph_osdc_build_request(struct
ceph_osd_request *req, u64 off,
 	u64 data_len;
 	unsigned int i;

+	/* Set up response incoming data and request outgoing data fields */
+
+	ceph_osdc_msg_data_set(req->r_reply, &req->r_data_in);
+	ceph_osdc_msg_data_set(req->r_request, &req->r_data_out);
+
 	req->r_snapid = snap_id;
 	req->r_snapc = ceph_get_snap_context(snapc);

@@ -1976,11 +1981,6 @@ int ceph_osdc_start_request(struct
ceph_osd_client *osdc,
 {
 	int rc = 0;

-	/* Set up response incoming data and request outgoing data fields */
-
-	ceph_osdc_msg_data_set(req->r_reply, &req->r_data_in);
-	ceph_osdc_msg_data_set(req->r_request, &req->r_data_out);
-
 	down_read(&osdc->map_sem);
 	mutex_lock(&osdc->request_mutex);
 	__register_request(osdc, req);
-- 
1.7.9.5

