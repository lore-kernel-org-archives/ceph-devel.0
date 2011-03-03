From: Sage Weil <sage@newdream.net>
Subject: [PATCH 6/8] libceph: fix msgr backoff
Date: Thu,  3 Mar 2011 12:40:08 -0800
Message-ID: <1299184810-19125-7-git-send-email-sage@newdream.net>
References: <1299184810-19125-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52167 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758714Ab1CCUj7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Mar 2011 15:39:59 -0500
In-Reply-To: <1299184810-19125-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

With commit f363e45f we replaced a bunch of hacky workqueue mutual
exclusion logic with the WQ_NON_REENTRANT flag.  One pieces of fallout is
that the exponential backoff breaks in certain cases:

 * con_work attempts to connect.
 * we get an immediate failure, and the socket state change handler queues
   immediate work.
 * con_work calls con_fault, we decide to back off, but can't queue delayed
   work.

In this case, we add a BACKOFF bit to make con_work reschedule delayed work
next time it runs (which should be immediately).

Signed-off-by: Sage Weil <sage@newdream.net>
---
 include/linux/ceph/messenger.h |    1 +
 net/ceph/messenger.c           |   30 ++++++++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index c3011be..eb31e10 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -123,6 +123,7 @@ struct ceph_msg_pos {
 #define SOCK_CLOSED	11 /* socket state changed to closed */
 #define OPENING         13 /* open connection w/ (possibly new) peer */
 #define DEAD            14 /* dead, about to kfree */
+#define BACKOFF         15
 
 /*
  * A single connection with another host.
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 6bd5025..af1ea93 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1948,6 +1948,19 @@ static void con_work(struct work_struct *work)
 	struct ceph_connection *con = container_of(work, struct ceph_connection,
 						   work.work);
 
+	if (test_and_clear_bit(BACKOFF, &con->state)) {
+		dout("con_work %p backing off\n", con);
+		if (queue_delayed_work(ceph_msgr_wq, &con->work,
+				       round_jiffies_relative(con->delay))) {
+			dout("con_work %p backoff %lu\n", con, con->delay);
+			return;
+		} else {
+			con->ops->put(con);
+			dout("con_work %p fAILED to back off %lu\n", con,
+			     con->delay);
+		}
+	}
+
 	mutex_lock(&con->mutex);
 
 	if (test_bit(CLOSED, &con->state)) { /* e.g. if we are replaced */
@@ -2017,11 +2030,24 @@ static void ceph_fault(struct ceph_connection *con)
 			con->delay = BASE_DELAY_INTERVAL;
 		else if (con->delay < MAX_DELAY_INTERVAL)
 			con->delay *= 2;
-		dout("fault queueing %p delay %lu\n", con, con->delay);
 		con->ops->get(con);
 		if (queue_delayed_work(ceph_msgr_wq, &con->work,
-				       round_jiffies_relative(con->delay)) == 0)
+				       round_jiffies_relative(con->delay))) {
+			dout("fault queued %p delay %lu\n", con, con->delay);
+		} else {
 			con->ops->put(con);
+			dout("fault failed to queue %p delay %lu, backoff\n",
+			     con, con->delay);
+			/*
+			 * In many cases we see a socket state change
+			 * while con_work is running and end up
+			 * queuing (non-delayed) work, such that we
+			 * can't backoff with a delay.  Set a flag so
+			 * that when con_work restarts we schedule the
+			 * delay then.
+			 */
+			set_bit(BACKOFF, &con->state);
+		}
 	}
 
 out_unlock:
-- 
1.7.0

