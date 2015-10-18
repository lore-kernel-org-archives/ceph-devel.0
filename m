From: Shraddha Barke <shraddha.6596@gmail.com>
Subject: [PATCH] Net: ceph: osd_client: Remove con argument in handle_reply
Date: Sun, 18 Oct 2015 13:55:38 +0530
Message-ID: <1445156738-3797-1-git-send-email-shraddha.6596@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36239 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbbJRIZs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Oct 2015 04:25:48 -0400
Received: by pacfv9 with SMTP id fv9so63194795pac.3
        for <ceph-devel@vger.kernel.org>; Sun, 18 Oct 2015 01:25:47 -0700 (PDT)
Received: from shraddha-370R4E-370R4V-370R5E-3570RE-370R5V.bits-goa.ac.in ([122.15.200.115])
        by smtp.gmail.com with ESMTPSA id u10sm30002143pbs.63.2015.10.18.01.25.45
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Oct 2015 01:25:46 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Since the function handle_reply does not use it's con argument,
remove it.

Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
---
 net/ceph/osd_client.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 80b94e3..e281f60 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1745,8 +1745,7 @@ static void complete_request(struct ceph_osd_request *req)
  * handle osd op reply.  either call the callback if it is specified,
  * or do the completion to wake up the waiting thread.
  */
-static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg,
-			 struct ceph_connection *con)
+static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 {
 	void *p, *end;
 	struct ceph_osd_request *req;
@@ -2802,7 +2801,7 @@ static void dispatch(struct ceph_connection *con, struct ceph_msg *msg)
 		ceph_osdc_handle_map(osdc, msg);
 		break;
 	case CEPH_MSG_OSD_OPREPLY:
-		handle_reply(osdc, msg, con);
+		handle_reply(osdc, msg);
 		break;
 	case CEPH_MSG_WATCH_NOTIFY:
 		handle_watch_notify(osdc, msg);
-- 
2.1.4

