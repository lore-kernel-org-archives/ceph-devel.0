From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 6/9] libceph: monc hunt rate is 3s with backoff up to 30s
Date: Mon, 25 Jan 2016 12:29:38 +0100
Message-ID: <1453721381-20612-7-git-send-email-idryomov@gmail.com>
References: <1453721381-20612-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36167 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756021AbcAYLaQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jan 2016 06:30:16 -0500
Received: by mail-wm0-f68.google.com with SMTP id l65so10673888wmf.3
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jan 2016 03:30:15 -0800 (PST)
Received: from localhost.localdomain.com (ip-78-102-114-179.net.upcbroadband.cz. [78.102.114.179])
        by smtp.gmail.com with ESMTPSA id 75sm15796950wmo.22.2016.01.25.03.30.13
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2016 03:30:14 -0800 (PST)
In-Reply-To: <1453721381-20612-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Unless we are in the process of setting up a client (i.e. connecting to
the monitor cluster for the first time), apply a backoff: every time we
want to reopen a session, increase our timeout by a multiple (currently
2); when we complete the connection, reduce that multipler by 50%.

Mirrors ceph.git commit 794c86fd289bd62a35ed14368fa096c46736e9a2.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 include/linux/ceph/libceph.h    |  3 +++
 include/linux/ceph/mon_client.h |  3 +++
 net/ceph/mon_client.c           | 25 ++++++++++++++++---------
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index f5466273b9a3..e7975e4681e1 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -68,8 +68,11 @@ struct ceph_options {
 #define CEPH_OSD_KEEPALIVE_DEFAULT	msecs_to_jiffies(5 * 1000)
 #define CEPH_OSD_IDLE_TTL_DEFAULT	msecs_to_jiffies(60 * 1000)
 
+#define CEPH_MONC_HUNT_INTERVAL		msecs_to_jiffies(3 * 1000)
 #define CEPH_MONC_PING_INTERVAL		msecs_to_jiffies(10 * 1000)
 #define CEPH_MONC_PING_TIMEOUT		msecs_to_jiffies(30 * 1000)
+#define CEPH_MONC_HUNT_BACKOFF		2
+#define CEPH_MONC_HUNT_MAX_MULT		10
 
 #define CEPH_MSG_MAX_FRONT_LEN	(16*1024*1024)
 #define CEPH_MSG_MAX_MIDDLE_LEN	(16*1024*1024)
diff --git a/include/linux/ceph/mon_client.h b/include/linux/ceph/mon_client.h
index 8b2d2f0b659e..e230e7ed60d3 100644
--- a/include/linux/ceph/mon_client.h
+++ b/include/linux/ceph/mon_client.h
@@ -72,6 +72,9 @@ struct ceph_mon_client {
 	unsigned long sub_renew_sent;
 	struct ceph_connection con;
 
+	bool had_a_connection;
+	int hunt_mult; /* [1..CEPH_MONC_HUNT_MAX_MULT] */
+
 	/* pending generic requests */
 	struct rb_root generic_request_tree;
 	int num_generic_requests;
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 23a270c49baf..fd1cf408fd89 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -171,6 +171,12 @@ static void __open_session(struct ceph_mon_client *monc)
 
 	pick_new_mon(monc);
 
+	if (monc->had_a_connection) {
+		monc->hunt_mult *= CEPH_MONC_HUNT_BACKOFF;
+		if (monc->hunt_mult > CEPH_MONC_HUNT_MAX_MULT)
+			monc->hunt_mult = CEPH_MONC_HUNT_MAX_MULT;
+	}
+
 	monc->sub_renew_after = jiffies; /* i.e., expired */
 	monc->sub_renew_sent = 0;
 
@@ -192,11 +198,6 @@ static void __open_session(struct ceph_mon_client *monc)
 	__send_prepared_auth_request(monc, ret);
 }
 
-static bool __sub_expired(struct ceph_mon_client *monc)
-{
-	return time_after_eq(jiffies, monc->sub_renew_after);
-}
-
 /*
  * Reschedule delayed work timer.
  */
@@ -204,11 +205,11 @@ static void __schedule_delayed(struct ceph_mon_client *monc)
 {
 	unsigned long delay;
 
-	if (monc->cur_mon < 0 || __sub_expired(monc)) {
-		delay = 10 * HZ;
-	} else {
+	if (monc->hunting)
+		delay = CEPH_MONC_HUNT_INTERVAL * monc->hunt_mult;
+	else
 		delay = CEPH_MONC_PING_INTERVAL;
-	}
+
 	dout("__schedule_delayed after %lu\n", delay);
 	schedule_delayed_work(&monc->delayed_work,
 			      round_jiffies_relative(delay));
@@ -902,6 +903,8 @@ int ceph_monc_init(struct ceph_mon_client *monc, struct ceph_client *cl)
 	monc->hunting = true;
 	monc->sub_renew_after = jiffies;
 	monc->sub_renew_sent = 0;
+	monc->had_a_connection = false;
+	monc->hunt_mult = 1;
 
 	INIT_DELAYED_WORK(&monc->delayed_work, delayed_work);
 	monc->generic_request_tree = RB_ROOT;
@@ -959,6 +962,10 @@ static void finish_hunting(struct ceph_mon_client *monc)
 	if (monc->hunting) {
 		dout("%s found mon%d\n", __func__, monc->cur_mon);
 		monc->hunting = false;
+		monc->had_a_connection = true;
+		monc->hunt_mult /= 2; /* reduce by 50% */
+		if (monc->hunt_mult < 1)
+			monc->hunt_mult = 1;
 	}
 }
 
-- 
2.4.3

