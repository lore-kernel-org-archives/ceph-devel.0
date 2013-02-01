From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: don't require r_num_pages for bio requests
Date: Thu, 31 Jan 2013 23:30:37 -0600
Message-ID: <510B52FD.3010907@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f177.google.com ([209.85.210.177]:37243 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444Ab3BAFad (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Feb 2013 00:30:33 -0500
Received: by mail-ia0-f177.google.com with SMTP id h8so4929453iaa.36
        for <ceph-devel@vger.kernel.org>; Thu, 31 Jan 2013 21:30:33 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

There is a check in the completion path for osd requests that
ensures the number of pages allocated is enough to hold the amount
of incoming data expected.

For bio requests coming from rbd the "number of pages" is not really
meaningful (although total length would be).  So stop requiring that
nr_pages be supplied for bio requests.  This is done by checking
whether the pages pointer is null before checking the value of
nr_pages.

Note that this value is passed on to the messenger, but there it's
only used for debugging--it's never used for validation.

While here, change another spot that used r_pages in a debug message
inappropriately, and also invalidate the r_con_filling_msg pointer
after dropping a reference to it.

This resolves:
    http://tracker.ceph.com/issues/3875

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c   |    2 --
 net/ceph/osd_client.c |    7 ++++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 3ba4836..14a6967 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1342,8 +1342,6 @@ static struct ceph_osd_request *rbd_osd_req_create(
 	case OBJ_REQUEST_BIO:
 		rbd_assert(obj_request->bio_list != NULL);
 		osd_req->r_bio = obj_request->bio_list;
-		/* osd client requires "num pages" even for bio */
-		osd_req->r_num_pages = calc_pages_for(offset, length);
 		break;
 	case OBJ_REQUEST_PAGES:
 		osd_req->r_pages = obj_request->pages;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index ba03648..d9d58bb 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -137,10 +137,11 @@ void ceph_osdc_release_request(struct kref *kref)
 	if (req->r_request)
 		ceph_msg_put(req->r_request);
 	if (req->r_con_filling_msg) {
-		dout("%s revoking pages %p from con %p\n", __func__,
-		     req->r_pages, req->r_con_filling_msg);
+		dout("%s revoking msg %p from con %p\n", __func__,
+		     req->r_reply, req->r_con_filling_msg);
 		ceph_msg_revoke_incoming(req->r_reply);
 		req->r_con_filling_msg->ops->put(req->r_con_filling_msg);
+		req->r_con_filling_msg = NULL;
 	}
 	if (req->r_reply)
 		ceph_msg_put(req->r_reply);
@@ -1981,7 +1982,7 @@ static struct ceph_msg *get_reply(struct
ceph_connection *con,
 	if (data_len > 0) {
 		int want = calc_pages_for(req->r_page_alignment, data_len);

-		if (unlikely(req->r_num_pages < want)) {
+		if (req->r_pages && unlikely(req->r_num_pages < want)) {
 			pr_warning("tid %lld reply has %d bytes %d pages, we"
 				   " had only %d pages ready\n", tid, data_len,
 				   want, req->r_num_pages);
-- 
1.7.9.5

