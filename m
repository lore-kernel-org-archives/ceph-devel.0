From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 2/3] libceph: rename front to front_len in get_reply()
Date: Mon, 13 Jan 2014 12:58:40 +0200
Message-ID: <1389610721-5280-3-git-send-email-ilya.dryomov@inktank.com>
References: <1389610721-5280-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:58759 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbaAMK7l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jan 2014 05:59:41 -0500
Received: by mail-ee0-f43.google.com with SMTP id c41so483181eek.30
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jan 2014 02:59:40 -0800 (PST)
In-Reply-To: <1389610721-5280-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

Rename front local variable to front_len in get_reply() to make its
purpose more clear.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osd_client.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 7ae5ebd43b4d..bf1b418cc06d 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2513,7 +2513,7 @@ static struct ceph_msg *get_reply(struct ceph_connection *con,
 	struct ceph_osd_client *osdc = osd->o_osdc;
 	struct ceph_msg *m;
 	struct ceph_osd_request *req;
-	int front = le32_to_cpu(hdr->front_len);
+	int front_len = le32_to_cpu(hdr->front_len);
 	int data_len = le32_to_cpu(hdr->data_len);
 	u64 tid;
 
@@ -2532,12 +2532,13 @@ static struct ceph_msg *get_reply(struct ceph_connection *con,
 		goto out;
 	}
 
-	if (front > req->r_reply->front.iov_len) {
+	if (front_len > req->r_reply->front.iov_len) {
 		pr_warning("get_reply front %d > preallocated %d (%u#%llu)\n",
-			   front, (int)req->r_reply->front.iov_len,
+			   front_len, (int)req->r_reply->front.iov_len,
 			   (unsigned int)con->peer_name.type,
 			   le64_to_cpu(con->peer_name.num));
-		m = ceph_msg_new(CEPH_MSG_OSD_OPREPLY, front, GFP_NOFS, false);
+		m = ceph_msg_new(CEPH_MSG_OSD_OPREPLY, front_len, GFP_NOFS,
+				 false);
 		if (!m)
 			goto out;
 		ceph_msg_put(req->r_reply);
-- 
1.7.10.4

