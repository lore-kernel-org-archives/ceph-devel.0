From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 3/3] libceph: handle dead tcp connections during connection negotiation
Date: Fri, 17 Jan 2014 15:28:24 +0200
Message-ID: <1389965304-5667-4-git-send-email-ilya.dryomov@inktank.com>
References: <1389965304-5667-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:40231 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbaAQN30 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jan 2014 08:29:26 -0500
Received: by mail-ee0-f53.google.com with SMTP id t10so2128118eei.40
        for <ceph-devel@vger.kernel.org>; Fri, 17 Jan 2014 05:29:24 -0800 (PST)
In-Reply-To: <1389965304-5667-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

Keepalive mechanism that we are currently using doesn't handle dead
(e.g. half-open in RFC 793 sense) TCP connections: a) it's based on
pending ceph_osd_requests which are not necessarily present, and b)
keepalive byte is only sent if connection is in CON_STATE_OPEN state
because of protocol restrictions.  This does not cover connection
handshake and negotiation stages and can lead to kernel client hanging
forever.  Fix it by forcibly resetting the connection if after two
mount_timeouts we still haven't transitioned to CON_STATE_OPEN.

Fixes: http://tracker.ceph.com/issues/7139

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/messenger.h |    5 +++++
 net/ceph/ceph_common.c         |    1 +
 net/ceph/messenger.c           |   31 +++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 20ee8b63a968..25d3ec8bcdde 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -62,6 +62,8 @@ struct ceph_messenger {
 
 	u64 supported_features;
 	u64 required_features;
+
+	unsigned long connect_timeout;	/* jiffies */
 };
 
 enum ceph_msg_data_type {
@@ -240,6 +242,8 @@ struct ceph_connection {
 
 	struct delayed_work work;	    /* send|recv work */
 	unsigned long       delay;          /* current delay interval */
+
+	struct delayed_work connect_timeout_work;
 };
 
 
@@ -257,6 +261,7 @@ extern void ceph_messenger_init(struct ceph_messenger *msgr,
 			struct ceph_entity_addr *myaddr,
 			u64 supported_features,
 			u64 required_features,
+			unsigned long connect_timeout,
 			bool nocrc);
 
 extern void ceph_con_init(struct ceph_connection *con, void *private,
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 67d7721d237e..bc41e5a392a4 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -511,6 +511,7 @@ struct ceph_client *ceph_create_client(struct ceph_options *opt, void *private,
 	ceph_messenger_init(&client->msgr, myaddr,
 		client->supported_features,
 		client->required_features,
+		2 * client->options->mount_timeout * HZ,
 		ceph_test_opt(client, NOCRC));
 
 	/* subsystems */
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 8ed76faf7032..e0878d4e9dcd 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -386,6 +386,16 @@ static void con_fault_raise(struct ceph_connection *con)
 	queue_con(con);
 }
 
+static void handle_connect_timeout(struct work_struct *work)
+{
+	struct ceph_connection *con = container_of(work,
+						   struct ceph_connection,
+						   connect_timeout_work.work);
+
+	dout("%s connect timeout\n", __func__);
+	con_fault_raise(con);
+}
+
 
 /*
  * socket callback functions
@@ -447,6 +457,18 @@ static void ceph_sock_state_change(struct sock *sk)
 	case TCP_ESTABLISHED:
 		dout("%s TCP_ESTABLISHED\n", __func__);
 		con_sock_state_connected(con);
+		/*
+		 * If not told otherwise, arm connect_timeout hammer to
+		 * be able to deal with half-open (in RFC 793 sense)
+		 * sockets in the interim before we transition to
+		 * CON_STATE_OPEN and regular request keepalive
+		 * mechanism (ceph_con_keepalive()) kicks in.
+		 */
+		if (con->msgr->connect_timeout) {
+			dout("arming connect_timeout hammer\n");
+			schedule_delayed_work(&con->connect_timeout_work,
+					      con->msgr->connect_timeout);
+		}
 		queue_con(con);
 		break;
 	default:	/* Everything else is uninteresting */
@@ -725,6 +747,7 @@ void ceph_con_init(struct ceph_connection *con, void *private,
 	INIT_LIST_HEAD(&con->out_queue);
 	INIT_LIST_HEAD(&con->out_sent);
 	INIT_DELAYED_WORK(&con->work, con_work);
+	INIT_DELAYED_WORK(&con->connect_timeout_work, handle_connect_timeout);
 
 	con->state = CON_STATE_CLOSED;
 }
@@ -2076,6 +2099,7 @@ static int process_connect(struct ceph_connection *con)
 
 		WARN_ON(con->state != CON_STATE_NEGOTIATING);
 		con->state = CON_STATE_OPEN;
+
 		con->auth_retry = 0;    /* we authenticated; clear flag */
 		con->peer_global_seq = le32_to_cpu(con->in_reply.global_seq);
 		con->connect_seq++;
@@ -2092,6 +2116,11 @@ static int process_connect(struct ceph_connection *con)
 
 		con->delay = 0;      /* reset backoff memory */
 
+		if (con->msgr->connect_timeout) {
+			dout("disarming connect_timeout hammer\n");
+			cancel_delayed_work(&con->connect_timeout_work);
+		}
+
 		if (con->in_reply.tag == CEPH_MSGR_TAG_SEQ) {
 			prepare_write_seq(con);
 			prepare_read_seq(con);
@@ -2866,10 +2895,12 @@ void ceph_messenger_init(struct ceph_messenger *msgr,
 			struct ceph_entity_addr *myaddr,
 			u64 supported_features,
 			u64 required_features,
+			unsigned long connect_timeout,
 			bool nocrc)
 {
 	msgr->supported_features = supported_features;
 	msgr->required_features = required_features;
+	msgr->connect_timeout = connect_timeout;
 
 	spin_lock_init(&msgr->global_seq_lock);
 
-- 
1.7.10.4

