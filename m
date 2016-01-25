From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 2/9] libceph: decouple hunting and subs management
Date: Mon, 25 Jan 2016 12:29:34 +0100
Message-ID: <1453721381-20612-3-git-send-email-idryomov@gmail.com>
References: <1453721381-20612-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34008 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756742AbcAYLaL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jan 2016 06:30:11 -0500
Received: by mail-wm0-f66.google.com with SMTP id b14so10684287wmb.1
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jan 2016 03:30:10 -0800 (PST)
Received: from localhost.localdomain.com (ip-78-102-114-179.net.upcbroadband.cz. [78.102.114.179])
        by smtp.gmail.com with ESMTPSA id 75sm15796950wmo.22.2016.01.25.03.30.09
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2016 03:30:09 -0800 (PST)
In-Reply-To: <1453721381-20612-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Coupling hunting state with subscribe state is not a good idea.  Clear
hunting when we complete the authentication handshake.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/mon_client.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 5ab737ce4f6d..d6af6ca26e8d 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -255,12 +255,6 @@ static void handle_subscribe_ack(struct ceph_mon_client *monc,
 	seconds = le32_to_cpu(h->duration);
 
 	mutex_lock(&monc->mutex);
-	if (monc->hunting) {
-		pr_info("mon%d %s session established\n",
-			monc->cur_mon,
-			ceph_pr_addr(&monc->con.peer_addr.in_addr));
-		monc->hunting = false;
-	}
 	dout("handle_subscribe_ack after %d seconds\n", seconds);
 	monc->sub_renew_after = monc->sub_sent + (seconds >> 1)*HZ - 1;
 	monc->sub_sent = 0;
@@ -877,6 +871,14 @@ void ceph_monc_stop(struct ceph_mon_client *monc)
 }
 EXPORT_SYMBOL(ceph_monc_stop);
 
+static void finish_hunting(struct ceph_mon_client *monc)
+{
+	if (monc->hunting) {
+		dout("%s found mon%d\n", __func__, monc->cur_mon);
+		monc->hunting = false;
+	}
+}
+
 static void handle_auth_reply(struct ceph_mon_client *monc,
 			      struct ceph_msg *msg)
 {
@@ -890,11 +892,15 @@ static void handle_auth_reply(struct ceph_mon_client *monc,
 				     msg->front.iov_len,
 				     monc->m_auth->front.iov_base,
 				     monc->m_auth->front_alloc_len);
+	if (ret > 0) {
+		__send_prepared_auth_request(monc, ret);
+		goto out;
+	}
+
+	finish_hunting(monc);
+
 	if (ret < 0) {
 		monc->client->auth_err = ret;
-		wake_up_all(&monc->client->auth_wq);
-	} else if (ret > 0) {
-		__send_prepared_auth_request(monc, ret);
 	} else if (!was_auth && ceph_auth_is_authenticated(monc->auth)) {
 		dout("authenticated, starting session\n");
 
@@ -904,8 +910,15 @@ static void handle_auth_reply(struct ceph_mon_client *monc,
 
 		__send_subscribe(monc);
 		__resend_generic_request(monc);
+
+		pr_info("mon%d %s session established\n", monc->cur_mon,
+			ceph_pr_addr(&monc->con.peer_addr.in_addr));
 	}
+
+out:
 	mutex_unlock(&monc->mutex);
+	if (monc->client->auth_err < 0)
+		wake_up_all(&monc->client->auth_wq);
 }
 
 static int __validate_auth(struct ceph_mon_client *monc)
-- 
2.4.3

