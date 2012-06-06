From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/4] libceph: have messages take a connection reference
Date: Tue, 05 Jun 2012 22:31:43 -0500
Message-ID: <4FCECF1F.3050106@inktank.com>
References: <4FCECD7F.9030002@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40363 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502Ab2FFDbi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jun 2012 23:31:38 -0400
Received: by mail-yx0-f174.google.com with SMTP id m10so4637648yen.19
        for <ceph-devel@vger.kernel.org>; Tue, 05 Jun 2012 20:31:38 -0700 (PDT)
In-Reply-To: <4FCECD7F.9030002@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There are essentially two types of ceph messages: incoming and
outgoing.  Outgoing messages are always allocated via ceph_msg_new(),
and at the time of their allocation they are not associated with any
particular connection.  Incoming messages are always allocated via
ceph_con_in_msg_alloc(), and they are initially associated with the
connection from which incoming data will be placed into the message.

When an outgoing message gets sent, it becomes associated with a
connection and remains that way until the message is successfully
sent.  The association of an incoming message goes away at the point
it is sent to an upper layer via a con->ops->dispatch method.

This patch implements reference counting for all ceph messages, such
that every message holds a reference (and a pointer) to a connection
if and only if it is associated with that connection (as described
above).


For background, here is an explanation of the ceph message
lifecycle, emphasizing when an association exists between a message
and a connection.

Outgoing Messages
An outgoing message is "owned" by its allocator, from the time it is
allocated in ceph_msg_new() up to the point it gets queued for
sending in ceph_con_send().  Prior to that point the message's
msg->con pointer is null; at the point it is queued for sending its
message pointer is assigned to refer to the connection.  At that
time the message is inserted into a connection's out_queue list.

When a message on the out_queue list has been sent to the socket
layer to be put on the wire, it is transferred out of that list and
into the connection's out_sent list.  At that point it is still owned
by the connection, and will remain so until an acknowledgement is
received from the recipient that indicates the message was
successfully transferred.  When such an acknowledgement is received
(in process_ack()), the message is removed from its list (in
ceph_msg_remove()), at which point it is no longer associated with
the connection.

So basically, any time a message is on one of a connection's lists,
it is associated with that connection.  Reference counting outgoing
messages can thus be done at the points a message is added to the
out_queue (in ceph_con_send()) and the point it is removed from
either its two lists (in ceph_msg_remove())--at which point its
connection pointer becomes null.

Incoming Messages
When an incoming message on a connection is getting read (in
read_partial_message()) and there is no message in con->in_msg,
a new one is allocated using ceph_con_in_msg_alloc().  At that
point the message is associated with the connection.  Once that
message has been completely and successfully read, it is passed to
upper layer code using the connection's con->ops->dispatch method.
At that point the association between the message and the connection
no longer exists.

Reference counting of connections for incoming messages can be done
by taking a reference to the connection when the message gets
allocated, and releasing that reference when it gets handed off
using the dispatch method.

We should never fail to get a connection reference for a
message--the since the caller should already hold one.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 59fa5fb..336707b 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -415,6 +415,7 @@ static void ceph_msg_remove(struct ceph_msg *msg)
 {
 	list_del_init(&msg->list_head);
 	BUG_ON(msg->con == NULL);
+	ceph_con_put(msg->con);
 	msg->con = NULL;

 	ceph_msg_put(msg);
@@ -440,6 +441,7 @@ static void reset_connection(struct ceph_connection
*con)
 		con->in_msg->con = NULL;
 		ceph_msg_put(con->in_msg);
 		con->in_msg = NULL;
+		ceph_con_put(con->in_msg->con);
 	}

 	con->connect_seq = 0;
@@ -1914,6 +1916,7 @@ static void process_message(struct ceph_connection
*con)
 	con->in_msg->con = NULL;
 	msg = con->in_msg;
 	con->in_msg = NULL;
+	ceph_con_put(con);

 	/* if first message, set peer_name */
 	if (con->peer_name.type == 0)
@@ -2275,6 +2278,7 @@ static void ceph_fault(struct ceph_connection *con)
 		con->in_msg->con = NULL;
 		ceph_msg_put(con->in_msg);
 		con->in_msg = NULL;
+		ceph_con_put(con);
 	}

 	/* Requeue anything that hasn't been acked */
@@ -2391,8 +2395,11 @@ void ceph_con_send(struct ceph_connection *con,
struct ceph_msg *msg)

 	/* queue */
 	mutex_lock(&con->mutex);
+
 	BUG_ON(msg->con != NULL);
-	msg->con = con;
+	msg->con = ceph_con_get(con);
+	BUG_ON(msg->con == NULL);
+
 	BUG_ON(!list_empty(&msg->list_head));
 	list_add_tail(&msg->list_head, &con->out_queue);
 	dout("----- %p to %s%lld %d=%s len %d+%d+%d -----\n", msg,
@@ -2421,10 +2428,11 @@ void ceph_con_revoke(struct ceph_connection
*con, struct ceph_msg *msg)
 		dout("%s %p msg %p - was on queue\n", __func__, con, msg);
 		list_del_init(&msg->list_head);
 		BUG_ON(msg->con == NULL);
+		ceph_con_put(msg->con);
 		msg->con = NULL;
+		msg->hdr.seq = 0;

 		ceph_msg_put(msg);
-		msg->hdr.seq = 0;
 	}
 	if (con->out_msg == msg) {
 		dout("%s %p msg %p - was sending\n", __func__, con, msg);
@@ -2433,8 +2441,9 @@ void ceph_con_revoke(struct ceph_connection *con,
struct ceph_msg *msg)
 			con->out_skip = con->out_kvec_bytes;
 			con->out_kvec_is_msg = false;
 		}
-		ceph_msg_put(msg);
 		msg->hdr.seq = 0;
+
+		ceph_msg_put(msg);
 	}
 	mutex_unlock(&con->mutex);
 }
@@ -2615,8 +2624,10 @@ static bool ceph_con_in_msg_alloc(struct
ceph_connection *con,
 		mutex_unlock(&con->mutex);
 		con->in_msg = con->ops->alloc_msg(con, hdr, &skip);
 		mutex_lock(&con->mutex);
-		if (con->in_msg)
-			con->in_msg->con = con;
+		if (con->in_msg) {
+			con->in_msg->con = ceph_con_get(con);
+			BUG_ON(con->in_msg->con == NULL);
+		}
 		if (skip)
 			con->in_msg = NULL;

@@ -2630,7 +2641,8 @@ static bool ceph_con_in_msg_alloc(struct
ceph_connection *con,
 			       type, front_len);
 			return false;
 		}
-		con->in_msg->con = con;
+		con->in_msg->con = ceph_con_get(con);
+		BUG_ON(con->in_msg->con == NULL);
 		con->in_msg->page_alignment = le16_to_cpu(hdr->data_off);
 	}
 	memcpy(&con->in_msg->hdr, &con->in_hdr, sizeof(con->in_hdr));
-- 
1.7.5.4

