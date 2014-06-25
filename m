From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 14/14] libceph: drop osd ref when canceling con work
Date: Wed, 25 Jun 2014 21:16:47 +0400
Message-ID: <1403716607-13535-15-git-send-email-ilya.dryomov@inktank.com>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:60457 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757741AbaFYRR1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jun 2014 13:17:27 -0400
Received: by mail-lb0-f175.google.com with SMTP id n15so2096582lbi.34
        for <ceph-devel@vger.kernel.org>; Wed, 25 Jun 2014 10:17:26 -0700 (PDT)
Received: from localhost ([109.110.67.53])
        by mx.google.com with ESMTPSA id tv3sm4209093lbb.49.2014.06.25.10.17.24
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 25 Jun 2014 10:17:25 -0700 (PDT)
In-Reply-To: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

queue_con() bumps osd ref count.  We should do the reverse when
canceling con work.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/messenger.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 8bffa5b90fef..e51cad0db580 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -174,6 +174,7 @@ static struct lock_class_key socket_class;
 #define SKIP_BUF_SIZE	1024
 
 static void queue_con(struct ceph_connection *con);
+static void cancel_con(struct ceph_connection *con);
 static void con_work(struct work_struct *);
 static void con_fault(struct ceph_connection *con);
 
@@ -680,7 +681,7 @@ void ceph_con_close(struct ceph_connection *con)
 
 	reset_connection(con);
 	con->peer_global_seq = 0;
-	cancel_delayed_work(&con->work);
+	cancel_con(con);
 	con_close_socket(con);
 	mutex_unlock(&con->mutex);
 }
@@ -2667,19 +2668,16 @@ static int queue_con_delay(struct ceph_connection *con, unsigned long delay)
 {
 	if (!con->ops->get(con)) {
 		dout("%s %p ref count 0\n", __func__, con);
-
 		return -ENOENT;
 	}
 
 	if (!queue_delayed_work(ceph_msgr_wq, &con->work, delay)) {
 		dout("%s %p - already queued\n", __func__, con);
 		con->ops->put(con);
-
 		return -EBUSY;
 	}
 
 	dout("%s %p %lu\n", __func__, con, delay);
-
 	return 0;
 }
 
@@ -2688,6 +2686,14 @@ static void queue_con(struct ceph_connection *con)
 	(void) queue_con_delay(con, 0);
 }
 
+static void cancel_con(struct ceph_connection *con)
+{
+	if (cancel_delayed_work(&con->work)) {
+		dout("%s %p\n", __func__, con);
+		con->ops->put(con);
+	}
+}
+
 static bool con_sock_closed(struct ceph_connection *con)
 {
 	if (!con_flag_test_and_clear(con, CON_FLAG_SOCK_CLOSED))
-- 
1.7.10.4

