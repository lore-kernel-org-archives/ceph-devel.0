From: Alex Elder <elder@linaro.org>
Subject: [PATCH 4/7] osd_client: don't supply connection to handle_reply()
Date: Mon, 27 Apr 2015 12:13:12 -0500
Message-ID: <1430154795-17123-5-git-send-email-elder@linaro.org>
References: <1430154795-17123-1-git-send-email-elder@linaro.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33308 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964801AbbD0RNX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Apr 2015 13:13:23 -0400
Received: by pdbnk13 with SMTP id nk13so134862756pdb.0
        for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2015 10:13:22 -0700 (PDT)
Received: from shibby.corp.google.com ([104.135.1.105])
        by mx.google.com with ESMTPSA id ff10sm12124675pab.13.2015.04.27.10.13.21
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Apr 2015 10:13:22 -0700 (PDT)
In-Reply-To: <1430154795-17123-1-git-send-email-elder@linaro.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The connection parameter in handle_reply() is never used, so get rid
of it.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 net/ceph/osd_client.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index e3c2e8b..6539dfc 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1748,8 +1748,7 @@ static void complete_request(struct ceph_osd_request *req)
  * handle osd op reply.  either call the callback if it is specified,
  * or do the completion to wake up the waiting thread.
  */
-static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg,
-			 struct ceph_connection *con)
+static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 {
 	void *p, *end;
 	struct ceph_osd_request *req;
@@ -2796,7 +2795,7 @@ static void dispatch(struct ceph_connection *con, struct ceph_msg *msg)
 		ceph_osdc_handle_map(osdc, msg);
 		break;
 	case CEPH_MSG_OSD_OPREPLY:
-		handle_reply(osdc, msg, con);
+		handle_reply(osdc, msg);
 		break;
 	case CEPH_MSG_WATCH_NOTIFY:
 		handle_watch_notify(osdc, msg);
-- 
2.1.0

