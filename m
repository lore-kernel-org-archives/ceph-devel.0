From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5/9] libceph: monc ping rate is 10s
Date: Mon, 25 Jan 2016 12:29:37 +0100
Message-ID: <1453721381-20612-6-git-send-email-idryomov@gmail.com>
References: <1453721381-20612-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34040 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756788AbcAYLaO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jan 2016 06:30:14 -0500
Received: by mail-wm0-f68.google.com with SMTP id b14so10684616wmb.1
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jan 2016 03:30:14 -0800 (PST)
Received: from localhost.localdomain.com (ip-78-102-114-179.net.upcbroadband.cz. [78.102.114.179])
        by smtp.gmail.com with ESMTPSA id 75sm15796950wmo.22.2016.01.25.03.30.12
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2016 03:30:12 -0800 (PST)
In-Reply-To: <1453721381-20612-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Split ping interval and ping timeout: ping interval is 10s; keepalive
timeout is 30s.

Make monc_ping_timeout a constant while at it - it's not actually
exported as a mount option (and the rest of tick-related settings won't
be either), so it's got no place in ceph_options.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 include/linux/ceph/libceph.h | 5 +++--
 net/ceph/ceph_common.c       | 1 -
 net/ceph/mon_client.c        | 8 ++------
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 3e3799cdc6e6..f5466273b9a3 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -47,7 +47,6 @@ struct ceph_options {
 	unsigned long mount_timeout;		/* jiffies */
 	unsigned long osd_idle_ttl;		/* jiffies */
 	unsigned long osd_keepalive_timeout;	/* jiffies */
-	unsigned long monc_ping_timeout;	/* jiffies */
 
 	/*
 	 * any type that can't be simply compared or doesn't need need
@@ -68,7 +67,9 @@ struct ceph_options {
 #define CEPH_MOUNT_TIMEOUT_DEFAULT	msecs_to_jiffies(60 * 1000)
 #define CEPH_OSD_KEEPALIVE_DEFAULT	msecs_to_jiffies(5 * 1000)
 #define CEPH_OSD_IDLE_TTL_DEFAULT	msecs_to_jiffies(60 * 1000)
-#define CEPH_MONC_PING_TIMEOUT_DEFAULT	msecs_to_jiffies(30 * 1000)
+
+#define CEPH_MONC_PING_INTERVAL		msecs_to_jiffies(10 * 1000)
+#define CEPH_MONC_PING_TIMEOUT		msecs_to_jiffies(30 * 1000)
 
 #define CEPH_MSG_MAX_FRONT_LEN	(16*1024*1024)
 #define CEPH_MSG_MAX_MIDDLE_LEN	(16*1024*1024)
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 389dbabba17b..dcc18c6f7cf9 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -361,7 +361,6 @@ ceph_parse_options(char *options, const char *dev_name,
 	opt->osd_keepalive_timeout = CEPH_OSD_KEEPALIVE_DEFAULT;
 	opt->mount_timeout = CEPH_MOUNT_TIMEOUT_DEFAULT;
 	opt->osd_idle_ttl = CEPH_OSD_IDLE_TTL_DEFAULT;
-	opt->monc_ping_timeout = CEPH_MONC_PING_TIMEOUT_DEFAULT;
 
 	/* get mon ip(s) */
 	/* ip1[:port1][,ip2[:port2]...] */
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index accfded53bae..23a270c49baf 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -202,15 +202,12 @@ static bool __sub_expired(struct ceph_mon_client *monc)
  */
 static void __schedule_delayed(struct ceph_mon_client *monc)
 {
-	struct ceph_options *opt = monc->client->options;
 	unsigned long delay;
 
 	if (monc->cur_mon < 0 || __sub_expired(monc)) {
 		delay = 10 * HZ;
 	} else {
-		delay = 20 * HZ;
-		if (opt->monc_ping_timeout > 0)
-			delay = min(delay, opt->monc_ping_timeout / 3);
+		delay = CEPH_MONC_PING_INTERVAL;
 	}
 	dout("__schedule_delayed after %lu\n", delay);
 	schedule_delayed_work(&monc->delayed_work,
@@ -793,10 +790,9 @@ static void delayed_work(struct work_struct *work)
 		__close_session(monc);
 		__open_session(monc);  /* continue hunting */
 	} else {
-		struct ceph_options *opt = monc->client->options;
 		int is_auth = ceph_auth_is_authenticated(monc->auth);
 		if (ceph_con_keepalive_expired(&monc->con,
-					       opt->monc_ping_timeout)) {
+					       CEPH_MONC_PING_TIMEOUT)) {
 			dout("monc keepalive timeout\n");
 			is_auth = 0;
 			__close_session(monc);
-- 
2.4.3

