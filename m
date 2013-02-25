From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: fix a osd request memory leak
Date: Mon, 25 Feb 2013 16:36:27 -0600
Message-ID: <512BE76B.5040104@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:54681 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932231Ab3BYWga (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Feb 2013 17:36:30 -0500
Received: by mail-ie0-f181.google.com with SMTP id 17so3668112iea.40
        for <ceph-devel@vger.kernel.org>; Mon, 25 Feb 2013 14:36:30 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

If an invalid layout is provided to ceph_osdc_new_request(), its
call to calc_layout() might return an error.  At that point in the
function we've already allocated an osd request structure, so we
need to free it (drop a reference) in the event such an error
occurs.

The only other value calc_layout() will return is 0, so make that
explicit in the successful case.

This resolves:
    http://tracker.ceph.com/issues/4240

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 39629b6..5daced2 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -109,7 +109,7 @@ static int calc_layout(struct ceph_vino vino,
 	snprintf(req->r_oid, sizeof(req->r_oid), "%llx.%08llx", vino.ino, bno);
 	req->r_oid_len = strlen(req->r_oid);

-	return r;
+	return 0;
 }

 /*
@@ -437,8 +437,10 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,

 	/* calculate max write size */
 	r = calc_layout(vino, layout, off, plen, req, ops);
-	if (r < 0)
+	if (r < 0) {
+		ceph_osdc_put_request(req);
 		return ERR_PTR(r);
+	}
 	req->r_file_layout = *layout;  /* keep a copy */

 	/* in case it differs from natural (file) alignment that
-- 
1.7.9.5

