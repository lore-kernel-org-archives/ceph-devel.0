From: Sage Weil <sage@newdream.net>
Subject: [PATCH 07/23] libceph: don't time out osd requests that haven't been received
Date: Fri, 22 Jul 2011 17:02:46 -0700
Message-ID: <1311379382-9218-8-git-send-email-sage@newdream.net>
References: <1311379382-9218-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44315 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946Ab1GWAFy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jul 2011 20:05:54 -0400
In-Reply-To: <1311379382-9218-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

Keep track of when an outgoing message is ACKed (i.e., the server fully
received it and, presumably, queued it for processing).  Time out OSD
requests only if it's been too long since they've been received.

This prevents timeouts and connection thrashing when the OSDs are simply
busy and are throttling the requests they read off the network.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 include/linux/ceph/messenger.h |    1 +
 net/ceph/messenger.c           |   12 +++++-------
 net/ceph/osd_client.c          |    6 ++++++
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 31d91a6..d7adf15 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -94,6 +94,7 @@ struct ceph_msg {
 	bool more_to_follow;
 	bool needs_out_seq;
 	int front_max;
+	unsigned long ack_stamp;        /* tx: when we were acked */
 
 	struct ceph_msgpool *pool;
 };
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 78b55f4..c340e2e 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -486,13 +486,10 @@ static void prepare_write_message(struct ceph_connection *con)
 	m = list_first_entry(&con->out_queue,
 		       struct ceph_msg, list_head);
 	con->out_msg = m;
-	if (test_bit(LOSSYTX, &con->state)) {
-		list_del_init(&m->list_head);
-	} else {
-		/* put message on sent list */
-		ceph_msg_get(m);
-		list_move_tail(&m->list_head, &con->out_sent);
-	}
+
+	/* put message on sent list */
+	ceph_msg_get(m);
+	list_move_tail(&m->list_head, &con->out_sent);
 
 	/*
 	 * only assign outgoing seq # if we haven't sent this message
@@ -1399,6 +1396,7 @@ static void process_ack(struct ceph_connection *con)
 			break;
 		dout("got ack for seq %llu type %d at %p\n", seq,
 		     le16_to_cpu(m->hdr.type), m);
+		m->ack_stamp = jiffies;
 		ceph_msg_remove(m);
 	}
 	prepare_read_tag(con);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 7330c27..ce310ee 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1085,9 +1085,15 @@ static void handle_timeout(struct work_struct *work)
 		req = list_entry(osdc->req_lru.next, struct ceph_osd_request,
 				 r_req_lru_item);
 
+		/* hasn't been long enough since we sent it? */
 		if (time_before(jiffies, req->r_stamp + timeout))
 			break;
 
+		/* hasn't been long enough since it was acked? */
+		if (req->r_request->ack_stamp == 0 ||
+		    time_before(jiffies, req->r_request->ack_stamp + timeout))
+			break;
+
 		BUG_ON(req == last_req && req->r_stamp == last_stamp);
 		last_req = req;
 		last_stamp = req->r_stamp;
-- 
1.7.0

