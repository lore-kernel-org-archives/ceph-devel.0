From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4/9] libceph: pick a different monitor when reconnecting
Date: Mon, 25 Jan 2016 12:29:36 +0100
Message-ID: <1453721381-20612-5-git-send-email-idryomov@gmail.com>
References: <1453721381-20612-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35272 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756764AbcAYLaN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jan 2016 06:30:13 -0500
Received: by mail-wm0-f68.google.com with SMTP id 123so10693379wmz.2
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jan 2016 03:30:13 -0800 (PST)
Received: from localhost.localdomain.com (ip-78-102-114-179.net.upcbroadband.cz. [78.102.114.179])
        by smtp.gmail.com with ESMTPSA id 75sm15796950wmo.22.2016.01.25.03.30.11
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2016 03:30:11 -0800 (PST)
In-Reply-To: <1453721381-20612-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Don't try to reconnect to the same monitor when we fail to establish
a session within a timeout or it's lost.

For that, pick_new_mon() needs to see the old value of cur_mon, so
don't clear it in __close_session() - all calls to __close_session()
but one are followed by __open_session() anyway.  __open_session() is
only called when a new session needs to be established, so the "already
open?" branch, which is now in the way, is simply dropped.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/mon_client.c | 85 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 28 deletions(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 89029916315c..accfded53bae 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -122,45 +122,74 @@ static void __close_session(struct ceph_mon_client *monc)
 	ceph_msg_revoke(monc->m_subscribe);
 	ceph_msg_revoke_incoming(monc->m_subscribe_ack);
 	ceph_con_close(&monc->con);
-	monc->cur_mon = -1;
+
 	monc->pending_auth = 0;
 	ceph_auth_reset(monc->auth);
 }
 
 /*
- * Open a session with a (new) monitor.
+ * Pick a new monitor at random and set cur_mon.  If we are repicking
+ * (i.e. cur_mon is already set), be sure to pick a different one.
  */
-static int __open_session(struct ceph_mon_client *monc)
+static void pick_new_mon(struct ceph_mon_client *monc)
 {
-	char r;
-	int ret;
+	int old_mon = monc->cur_mon;
 
-	if (monc->cur_mon < 0) {
-		get_random_bytes(&r, 1);
-		monc->cur_mon = r % monc->monmap->num_mon;
-		dout("open_session num=%d r=%d -> mon%d\n",
-		     monc->monmap->num_mon, r, monc->cur_mon);
-		monc->sub_renew_after = jiffies;  /* i.e., expired */
-		monc->sub_renew_sent = 0;
+	BUG_ON(monc->monmap->num_mon < 1);
 
-		dout("open_session mon%d opening\n", monc->cur_mon);
-		ceph_con_open(&monc->con,
-			      CEPH_ENTITY_TYPE_MON, monc->cur_mon,
-			      &monc->monmap->mon_inst[monc->cur_mon].addr);
+	if (monc->monmap->num_mon == 1) {
+		monc->cur_mon = 0;
+	} else {
+		int max = monc->monmap->num_mon;
+		int o = -1;
+		int n;
+
+		if (monc->cur_mon >= 0) {
+			if (monc->cur_mon < monc->monmap->num_mon)
+				o = monc->cur_mon;
+			if (o >= 0)
+				max--;
+		}
 
-		/* send an initial keepalive to ensure our timestamp is
-		 * valid by the time we are in an OPENED state */
-		ceph_con_keepalive(&monc->con);
+		n = prandom_u32() % max;
+		if (o >= 0 && n >= o)
+			n++;
 
-		/* initiatiate authentication handshake */
-		ret = ceph_auth_build_hello(monc->auth,
-					    monc->m_auth->front.iov_base,
-					    monc->m_auth->front_alloc_len);
-		__send_prepared_auth_request(monc, ret);
-	} else {
-		dout("open_session mon%d already open\n", monc->cur_mon);
+		monc->cur_mon = n;
 	}
-	return 0;
+
+	dout("%s mon%d -> mon%d out of %d mons\n", __func__, old_mon,
+	     monc->cur_mon, monc->monmap->num_mon);
+}
+
+/*
+ * Open a session with a new monitor.
+ */
+static void __open_session(struct ceph_mon_client *monc)
+{
+	int ret;
+
+	pick_new_mon(monc);
+
+	monc->sub_renew_after = jiffies; /* i.e., expired */
+	monc->sub_renew_sent = 0;
+
+	dout("%s opening mon%d\n", __func__, monc->cur_mon);
+	ceph_con_open(&monc->con, CEPH_ENTITY_TYPE_MON, monc->cur_mon,
+		      &monc->monmap->mon_inst[monc->cur_mon].addr);
+
+	/*
+	 * send an initial keepalive to ensure our timestamp is valid
+	 * by the time we are in an OPENED state
+	 */
+	ceph_con_keepalive(&monc->con);
+
+	/* initiate authentication handshake */
+	ret = ceph_auth_build_hello(monc->auth,
+				    monc->m_auth->front.iov_base,
+				    monc->m_auth->front_alloc_len);
+	BUG_ON(ret <= 0);
+	__send_prepared_auth_request(monc, ret);
 }
 
 static bool __sub_expired(struct ceph_mon_client *monc)
@@ -907,7 +936,7 @@ void ceph_monc_stop(struct ceph_mon_client *monc)
 
 	mutex_lock(&monc->mutex);
 	__close_session(monc);
-
+	monc->cur_mon = -1;
 	mutex_unlock(&monc->mutex);
 
 	/*
-- 
2.4.3

