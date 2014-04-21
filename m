From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 1/2] libceph: add ceph_monc_wait_next_osdmap()
Date: Mon, 21 Apr 2014 17:26:15 +0400
Message-ID: <1398086776-7228-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f44.google.com ([74.125.83.44]:40318 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbaDUN0U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Apr 2014 09:26:20 -0400
Received: by mail-ee0-f44.google.com with SMTP id e49so3698163eek.3
        for <ceph-devel@vger.kernel.org>; Mon, 21 Apr 2014 06:26:19 -0700 (PDT)
Received: from localhost ([109.110.67.18])
        by mx.google.com with ESMTPSA id w12sm103630548eez.36.2014.04.21.06.26.17
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 21 Apr 2014 06:26:18 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Add ceph_monc_wait_next_osdmap(), which will block until the next
requested with ceph_monc_request_next_osdmap() osdmap is received or
timeout occurs.

Export both of these as they are going to be needed by rbd.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/mon_client.h |    2 ++
 net/ceph/mon_client.c           |   27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/ceph/mon_client.h b/include/linux/ceph/mon_client.h
index a486f390dfbe..5444897e8ebd 100644
--- a/include/linux/ceph/mon_client.h
+++ b/include/linux/ceph/mon_client.h
@@ -104,6 +104,8 @@ extern int ceph_monc_got_mdsmap(struct ceph_mon_client *monc, u32 have);
 extern int ceph_monc_got_osdmap(struct ceph_mon_client *monc, u32 have);
 
 extern void ceph_monc_request_next_osdmap(struct ceph_mon_client *monc);
+extern int ceph_monc_wait_next_osdmap(struct ceph_mon_client *monc,
+				      unsigned long timeout);
 
 extern int ceph_monc_do_statfs(struct ceph_mon_client *monc,
 			       struct ceph_statfs *buf);
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 2ac9ef35110b..39953ba83b4c 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -296,6 +296,33 @@ void ceph_monc_request_next_osdmap(struct ceph_mon_client *monc)
 		__send_subscribe(monc);
 	mutex_unlock(&monc->mutex);
 }
+EXPORT_SYMBOL(ceph_monc_request_next_osdmap);
+
+int ceph_monc_wait_next_osdmap(struct ceph_mon_client *monc,
+			       unsigned long timeout)
+{
+	unsigned long started = jiffies;
+	int ret;
+
+	mutex_lock(&monc->mutex);
+	while (monc->want_next_osdmap != 0) {
+		mutex_unlock(&monc->mutex);
+
+		if (timeout != 0 && time_after_eq(jiffies, started + timeout))
+			return -ETIMEDOUT;
+
+		ret = wait_event_interruptible_timeout(monc->client->auth_wq,
+					monc->want_next_osdmap == 0, timeout);
+		if (ret < 0)
+			return ret;
+
+		mutex_lock(&monc->mutex);
+	}
+
+	mutex_unlock(&monc->mutex);
+	return 0;
+}
+EXPORT_SYMBOL(ceph_monc_wait_next_osdmap);
 
 /*
  *
-- 
1.7.10.4

