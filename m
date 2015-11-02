From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] libceph: clear msg->con in ceph_msg_release() only
Date: Mon,  2 Nov 2015 23:47:07 +0100
Message-ID: <1446504427-25824-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38899 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664AbbKBVHT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Nov 2015 16:07:19 -0500
Received: by wicll6 with SMTP id ll6so58122692wic.1
        for <ceph-devel@vger.kernel.org>; Mon, 02 Nov 2015 13:07:18 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

The following bit in ceph_msg_revoke_incoming() is unsafe:

    struct ceph_connection *con = msg->con;
    if (!con)
            return;
    mutex_lock(&con->mutex);
    <more msg->con use>

There is nothing preventing con from getting destroyed right after
msg->con test.  One easy way to reproduce this is to disable message
signing only on the server side and try to map an image.  The system
will go into a

    libceph: read_partial_message ffff880073f0ab68 signature check failed
    libceph: osd0 192.168.255.155:6801 bad crc/signature
    libceph: read_partial_message ffff880073f0ab68 signature check failed
    libceph: osd0 192.168.255.155:6801 bad crc/signature

loop which has to be interrupted with Ctrl-C.  Hit Ctrl-C and you are
likely to end up with a random GP fault if the reset handler executes
"within" ceph_msg_revoke_incoming():

                     <yet another reply w/o a signature>
                                   ...
          <Ctrl-C>
    rbd_obj_request_end
      ceph_osdc_cancel_request
        __unregister_request
          ceph_osdc_put_request
            ceph_msg_revoke_incoming
                                   ...
                                osd_reset
                                  __kick_osd_requests
                                    __reset_osd
                                      remove_osd
                                        ceph_con_close
                                          reset_connection
                                            <clear con->in_msg->con>
                                            <put con ref>
                                              put_osd
                                                <free osd/con>
              <msg->con use> <-- !!!

If ceph_msg_revoke_incoming() executes "before" the reset handler,
osd/con will be leaked because ceph_msg_revoke_incoming() clears
con->in_msg but doesn't put con ref, while reset_connection() only puts
con ref if con->in_msg != NULL.

The current msg->con scheme was introduced by commits 38941f8031bf
("libceph: have messages point to their connection") and 92ce034b5a74
("libceph: have messages take a connection reference"), which defined
when messages get associated with a connection and when that
association goes away.  Part of the problem is that this association is
supposed to go away in much too many places; closing this race entirely
requires either a rework of the existing or an addition of a new layer
of synchronization.

In lieu of that, we can make it *much* less likely to hit by
disassociating messages only on their destruction and resend through
a different connection.  This makes the code simpler and is probably
a good thing to do regardless - this patch adds a msg_con_set() helper
which is is called from only three places: ceph_con_send() and
ceph_con_in_msg_alloc() to set msg->con and ceph_msg_release() to clear
it.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/messenger.c  | 45 ++++++++++++++++++++-------------------------
 net/ceph/osd_client.c |  3 ---
 2 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 0cc5608b2c8f..9981039ef4ff 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -637,9 +637,6 @@ static int con_close_socket(struct ceph_connection *con)
 static void ceph_msg_remove(struct ceph_msg *msg)
 {
 	list_del_init(&msg->list_head);
-	BUG_ON(msg->con == NULL);
-	msg->con->ops->put(msg->con);
-	msg->con = NULL;
 
 	ceph_msg_put(msg);
 }
@@ -662,15 +659,14 @@ static void reset_connection(struct ceph_connection *con)
 
 	if (con->in_msg) {
 		BUG_ON(con->in_msg->con != con);
-		con->in_msg->con = NULL;
 		ceph_msg_put(con->in_msg);
 		con->in_msg = NULL;
-		con->ops->put(con);
 	}
 
 	con->connect_seq = 0;
 	con->out_seq = 0;
 	if (con->out_msg) {
+		BUG_ON(con->out_msg->con != con);
 		ceph_msg_put(con->out_msg);
 		con->out_msg = NULL;
 	}
@@ -2438,13 +2434,10 @@ static int read_partial_message(struct ceph_connection *con)
  */
 static void process_message(struct ceph_connection *con)
 {
-	struct ceph_msg *msg;
+	struct ceph_msg *msg = con->in_msg;
 
 	BUG_ON(con->in_msg->con != con);
-	con->in_msg->con = NULL;
-	msg = con->in_msg;
 	con->in_msg = NULL;
-	con->ops->put(con);
 
 	/* if first message, set peer_name */
 	if (con->peer_name.type == 0)
@@ -2918,10 +2911,8 @@ static void con_fault(struct ceph_connection *con)
 
 	if (con->in_msg) {
 		BUG_ON(con->in_msg->con != con);
-		con->in_msg->con = NULL;
 		ceph_msg_put(con->in_msg);
 		con->in_msg = NULL;
-		con->ops->put(con);
 	}
 
 	/* Requeue anything that hasn't been acked */
@@ -2977,6 +2968,15 @@ void ceph_messenger_fini(struct ceph_messenger *msgr)
 }
 EXPORT_SYMBOL(ceph_messenger_fini);
 
+static void msg_con_set(struct ceph_msg *msg, struct ceph_connection *con)
+{
+	if (msg->con)
+		msg->con->ops->put(msg->con);
+
+	msg->con = con ? con->ops->get(con) : NULL;
+	BUG_ON(msg->con != con);
+}
+
 static void clear_standby(struct ceph_connection *con)
 {
 	/* come back from STANDBY? */
@@ -3008,9 +3008,7 @@ void ceph_con_send(struct ceph_connection *con, struct ceph_msg *msg)
 		return;
 	}
 
-	BUG_ON(msg->con != NULL);
-	msg->con = con->ops->get(con);
-	BUG_ON(msg->con == NULL);
+	msg_con_set(msg, con);
 
 	BUG_ON(!list_empty(&msg->list_head));
 	list_add_tail(&msg->list_head, &con->out_queue);
@@ -3038,16 +3036,15 @@ void ceph_msg_revoke(struct ceph_msg *msg)
 {
 	struct ceph_connection *con = msg->con;
 
-	if (!con)
+	if (!con) {
+		dout("%s msg %p null con\n", __func__, msg);
 		return;		/* Message not in our possession */
+	}
 
 	mutex_lock(&con->mutex);
 	if (!list_empty(&msg->list_head)) {
 		dout("%s %p msg %p - was on queue\n", __func__, con, msg);
 		list_del_init(&msg->list_head);
-		BUG_ON(msg->con == NULL);
-		msg->con->ops->put(msg->con);
-		msg->con = NULL;
 		msg->hdr.seq = 0;
 
 		ceph_msg_put(msg);
@@ -3071,16 +3068,13 @@ void ceph_msg_revoke(struct ceph_msg *msg)
  */
 void ceph_msg_revoke_incoming(struct ceph_msg *msg)
 {
-	struct ceph_connection *con;
+	struct ceph_connection *con = msg->con;
 
-	BUG_ON(msg == NULL);
-	if (!msg->con) {
+	if (!con) {
 		dout("%s msg %p null con\n", __func__, msg);
-
 		return;		/* Message not in our possession */
 	}
 
-	con = msg->con;
 	mutex_lock(&con->mutex);
 	if (con->in_msg == msg) {
 		unsigned int front_len = le32_to_cpu(con->in_hdr.front_len);
@@ -3326,9 +3320,8 @@ static int ceph_con_in_msg_alloc(struct ceph_connection *con, int *skip)
 	}
 	if (msg) {
 		BUG_ON(*skip);
+		msg_con_set(msg, con);
 		con->in_msg = msg;
-		con->in_msg->con = con->ops->get(con);
-		BUG_ON(con->in_msg->con == NULL);
 	} else {
 		/*
 		 * Null message pointer means either we should skip
@@ -3375,6 +3368,8 @@ static void ceph_msg_release(struct kref *kref)
 	dout("%s %p\n", __func__, m);
 	WARN_ON(!list_empty(&m->list_head));
 
+	msg_con_set(m, NULL);
+
 	/* drop middle, data, if any */
 	if (m->middle) {
 		ceph_buffer_put(m->middle);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 118e4ce37ecc..f8f235930d88 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2850,9 +2850,6 @@ static struct ceph_msg *get_reply(struct ceph_connection *con,
 		goto out;
 	}
 
-	if (req->r_reply->con)
-		dout("%s revoking msg %p from old con %p\n", __func__,
-		     req->r_reply, req->r_reply->con);
 	ceph_msg_revoke_incoming(req->r_reply);
 
 	if (front_len > req->r_reply->front_alloc_len) {
-- 
2.4.3

