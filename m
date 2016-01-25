From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 7/9] libceph: introduce and switch to reopen_session()
Date: Mon, 25 Jan 2016 12:29:39 +0100
Message-ID: <1453721381-20612-8-git-send-email-idryomov@gmail.com>
References: <1453721381-20612-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35305 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756860AbcAYLaR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jan 2016 06:30:17 -0500
Received: by mail-wm0-f66.google.com with SMTP id 123so10693780wmz.2
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jan 2016 03:30:17 -0800 (PST)
Received: from localhost.localdomain.com (ip-78-102-114-179.net.upcbroadband.cz. [78.102.114.179])
        by smtp.gmail.com with ESMTPSA id 75sm15796950wmo.22.2016.01.25.03.30.15
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2016 03:30:15 -0800 (PST)
In-Reply-To: <1453721381-20612-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hunting is now set in __open_session() and cleared in finish_hunting(),
instead of all around.  The "session lost" message is printed not only
on connection resets, but also on keepalive timeouts.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/mon_client.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index fd1cf408fd89..816fb813a336 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -171,6 +171,7 @@ static void __open_session(struct ceph_mon_client *monc)
 
 	pick_new_mon(monc);
 
+	monc->hunting = true;
 	if (monc->had_a_connection) {
 		monc->hunt_mult *= CEPH_MONC_HUNT_BACKOFF;
 		if (monc->hunt_mult > CEPH_MONC_HUNT_MAX_MULT)
@@ -198,6 +199,16 @@ static void __open_session(struct ceph_mon_client *monc)
 	__send_prepared_auth_request(monc, ret);
 }
 
+static void reopen_session(struct ceph_mon_client *monc)
+{
+	if (!monc->hunting)
+		pr_info("mon%d %s session lost, hunting for new mon\n",
+		    monc->cur_mon, ceph_pr_addr(&monc->con.peer_addr.in_addr));
+
+	__close_session(monc);
+	__open_session(monc);
+}
+
 /*
  * Reschedule delayed work timer.
  */
@@ -788,17 +799,15 @@ static void delayed_work(struct work_struct *work)
 	dout("monc delayed_work\n");
 	mutex_lock(&monc->mutex);
 	if (monc->hunting) {
-		__close_session(monc);
-		__open_session(monc);  /* continue hunting */
+		dout("%s continuing hunt\n", __func__);
+		reopen_session(monc);
 	} else {
 		int is_auth = ceph_auth_is_authenticated(monc->auth);
 		if (ceph_con_keepalive_expired(&monc->con,
 					       CEPH_MONC_PING_TIMEOUT)) {
 			dout("monc keepalive timeout\n");
 			is_auth = 0;
-			__close_session(monc);
-			monc->hunting = true;
-			__open_session(monc);
+			reopen_session(monc);
 		}
 
 		if (!monc->hunting) {
@@ -900,9 +909,6 @@ int ceph_monc_init(struct ceph_mon_client *monc, struct ceph_client *cl)
 		      &monc->client->msgr);
 
 	monc->cur_mon = -1;
-	monc->hunting = true;
-	monc->sub_renew_after = jiffies;
-	monc->sub_renew_sent = 0;
 	monc->had_a_connection = false;
 	monc->hunt_mult = 1;
 
@@ -1157,16 +1163,9 @@ static void mon_fault(struct ceph_connection *con)
 	if (!con->private)
 		goto out;
 
-	if (!monc->hunting)
-		pr_info("mon%d %s session lost, "
-			"hunting for new mon\n", monc->cur_mon,
-			ceph_pr_addr(&monc->con.peer_addr.in_addr));
-
-	__close_session(monc);
 	if (!monc->hunting) {
-		/* start hunting */
-		monc->hunting = true;
-		__open_session(monc);
+		dout("%s hunting for new mon\n", __func__);
+		reopen_session(monc);
 	} else {
 		/* already hunting, let's wait a bit */
 		__schedule_delayed(monc);
-- 
2.4.3

