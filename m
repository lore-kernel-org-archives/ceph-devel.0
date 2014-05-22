From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH v3 3/4] libceph: add ceph_monc_wait_osdmap()
Date: Thu, 22 May 2014 20:50:07 +0400
Message-ID: <1400777408-7016-4-git-send-email-ilya.dryomov@inktank.com>
References: <1400777408-7016-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:46849 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbaEVQuT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 May 2014 12:50:19 -0400
Received: by mail-wi0-f170.google.com with SMTP id bs8so10172842wib.1
        for <ceph-devel@vger.kernel.org>; Thu, 22 May 2014 09:50:18 -0700 (PDT)
Received: from localhost ([109.110.67.203])
        by mx.google.com with ESMTPSA id d6sm1251191wiz.4.2014.05.22.09.50.16
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 09:50:17 -0700 (PDT)
In-Reply-To: <1400777408-7016-1-git-send-email-ilya.dryomov@inktank.com>
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
index 585ef9450e9d..deb47e45ac7c 100644
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
index 6b46f1205ceb..ecfd65c05f49 100644
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

