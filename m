From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 2/3] libceph: add ceph_monc_wait_osdmap()
Date: Thu, 24 Apr 2014 20:23:26 +0400
Message-ID: <1398356607-10666-3-git-send-email-ilya.dryomov@inktank.com>
References: <1398356607-10666-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:49381 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363AbaDXQXf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Apr 2014 12:23:35 -0400
Received: by mail-ee0-f54.google.com with SMTP id d49so2074461eek.27
        for <ceph-devel@vger.kernel.org>; Thu, 24 Apr 2014 09:23:34 -0700 (PDT)
Received: from localhost ([109.110.67.18])
        by mx.google.com with ESMTPSA id 4sm17089557eeq.33.2014.04.24.09.23.32
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 24 Apr 2014 09:23:33 -0700 (PDT)
In-Reply-To: <1398356607-10666-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Add ceph_monc_wait_osdmap(), which will block until the osdmap with the
specified epoch is received or timeout occurs.

Export both of these as they are going to be needed by rbd.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/mon_client.h |    2 ++
 net/ceph/mon_client.c           |   27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/ceph/mon_client.h b/include/linux/ceph/mon_client.h
index d8060dd87f16..99ea0d60042f 100644
--- a/include/linux/ceph/mon_client.h
+++ b/include/linux/ceph/mon_client.h
@@ -104,6 +104,8 @@ extern int ceph_monc_got_mdsmap(struct ceph_mon_client *monc, u32 have);
 extern int ceph_monc_got_osdmap(struct ceph_mon_client *monc, u32 have);
 
 extern void ceph_monc_request_next_osdmap(struct ceph_mon_client *monc);
+extern int ceph_monc_wait_osdmap(struct ceph_mon_client *monc, u32 epoch,
+				 unsigned long timeout);
 
 extern int ceph_monc_do_statfs(struct ceph_mon_client *monc,
 			       struct ceph_statfs *buf);
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index d64023965d1c..7aa1ab1dbbf6 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -296,6 +296,33 @@ void ceph_monc_request_next_osdmap(struct ceph_mon_client *monc)
 		__send_subscribe(monc);
 	mutex_unlock(&monc->mutex);
 }
+EXPORT_SYMBOL(ceph_monc_request_next_osdmap);
+
+int ceph_monc_wait_osdmap(struct ceph_mon_client *monc, u32 epoch,
+			  unsigned long timeout)
+{
+	unsigned long started = jiffies;
+	int ret;
+
+	mutex_lock(&monc->mutex);
+	while (monc->have_osdmap < epoch) {
+		mutex_unlock(&monc->mutex);
+
+		if (timeout != 0 && time_after_eq(jiffies, started + timeout))
+			return -ETIMEDOUT;
+
+		ret = wait_event_interruptible_timeout(monc->client->auth_wq,
+					 monc->have_osdmap >= epoch, timeout);
+		if (ret < 0)
+			return ret;
+
+		mutex_lock(&monc->mutex);
+	}
+
+	mutex_unlock(&monc->mutex);
+	return 0;
+}
+EXPORT_SYMBOL(ceph_monc_wait_osdmap);
 
 /*
  *
-- 
1.7.10.4

