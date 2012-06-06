From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/4] libceph: have messages point to their connection
Date: Tue, 05 Jun 2012 22:31:36 -0500
Message-ID: <4FCECF18.8060905@inktank.com>
References: <4FCECD7F.9030002@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48047 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab2FFDbc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jun 2012 23:31:32 -0400
Received: by yhmm54 with SMTP id m54so4512604yhm.19
        for <ceph-devel@vger.kernel.org>; Tue, 05 Jun 2012 20:31:32 -0700 (PDT)
In-Reply-To: <4FCECD7F.9030002@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When a ceph message is queued for sending it is placed on a list of
pending messages (ceph_connection->out_queue).  When they are
actually sent over the wire, they are moved from that list to
another (ceph_connection->out_sent).  When acknowledgement for the
message is received, it is removed from the sent messages list.

During that entire time the message is "in the possession" of a
single ceph connection.  Keep track of that connection in the
message.  This will be used in the next patch (and is a helpful
bit of information for debugging anyway).

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/messenger.h |    3 +++
 net/ceph/messenger.c           |   27 +++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index dd27837..6df837f 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -77,7 +77,10 @@ struct ceph_msg {
 	unsigned nr_pages;              /* size of page array */
 	unsigned page_alignment;        /* io offset in first page */
 	struct ceph_pagelist *pagelist; /* instead of pages */
+
+	struct ceph_connection *con;
 	struct list_head list_head;
+
 	struct kref kref;
 	struct bio  *bio;		/* instead of pages/pagelist */
 	struct bio  *bio_iter;		/* bio iterator */
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index f7c9061..59fa5fb 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -414,6 +414,9 @@ static int con_close_socket(struct ceph_connection *con)
 static void ceph_msg_remove(struct ceph_msg *msg)
 {
 	list_del_init(&msg->list_head);
+	BUG_ON(msg->con == NULL);
+	msg->con = NULL;
+
 	ceph_msg_put(msg);
 }
 static void ceph_msg_remove_list(struct list_head *head)
@@ -433,6 +436,8 @@ static void reset_connection(struct ceph_connection
*con)
 	ceph_msg_remove_list(&con->out_sent);

 	if (con->in_msg) {
+		BUG_ON(con->in_msg->con != con);
+		con->in_msg->con = NULL;
 		ceph_msg_put(con->in_msg);
 		con->in_msg = NULL;
 	}
@@ -625,8 +630,10 @@ static void prepare_write_message(struct
ceph_connection *con)
 			&con->out_temp_ack);
 	}

+	BUG_ON(list_empty(&con->out_queue));
 	m = list_first_entry(&con->out_queue, struct ceph_msg, list_head);
 	con->out_msg = m;
+	BUG_ON(m->con != con);

 	/* put message on sent list */
 	ceph_msg_get(m);
@@ -1806,6 +1813,8 @@ static int read_partial_message(struct
ceph_connection *con)
 				"error allocating memory for incoming message";
 			return -ENOMEM;
 		}
+
+		BUG_ON(con->in_msg->con != con);
 		m = con->in_msg;
 		m->front.iov_len = 0;    /* haven't read it yet */
 		if (m->middle)
@@ -1901,6 +1910,8 @@ static void process_message(struct ceph_connection
*con)
 {
 	struct ceph_msg *msg;

+	BUG_ON(con->in_msg->con != con);
+	con->in_msg->con = NULL;
 	msg = con->in_msg;
 	con->in_msg = NULL;

@@ -2260,6 +2271,8 @@ static void ceph_fault(struct ceph_connection *con)
 	con_close_socket(con);

 	if (con->in_msg) {
+		BUG_ON(con->in_msg->con != con);
+		con->in_msg->con = NULL;
 		ceph_msg_put(con->in_msg);
 		con->in_msg = NULL;
 	}
@@ -2378,6 +2391,8 @@ void ceph_con_send(struct ceph_connection *con,
struct ceph_msg *msg)

 	/* queue */
 	mutex_lock(&con->mutex);
+	BUG_ON(msg->con != NULL);
+	msg->con = con;
 	BUG_ON(!list_empty(&msg->list_head));
 	list_add_tail(&msg->list_head, &con->out_queue);
 	dout("----- %p to %s%lld %d=%s len %d+%d+%d -----\n", msg,
@@ -2403,13 +2418,16 @@ void ceph_con_revoke(struct ceph_connection
*con, struct ceph_msg *msg)
 {
 	mutex_lock(&con->mutex);
 	if (!list_empty(&msg->list_head)) {
-		dout("con_revoke %p msg %p - was on queue\n", con, msg);
+		dout("%s %p msg %p - was on queue\n", __func__, con, msg);
 		list_del_init(&msg->list_head);
+		BUG_ON(msg->con == NULL);
+		msg->con = NULL;
+
 		ceph_msg_put(msg);
 		msg->hdr.seq = 0;
 	}
 	if (con->out_msg == msg) {
-		dout("con_revoke %p msg %p - was sending\n", con, msg);
+		dout("%s %p msg %p - was sending\n", __func__, con, msg);
 		con->out_msg = NULL;
 		if (con->out_kvec_is_msg) {
 			con->out_skip = con->out_kvec_bytes;
@@ -2478,6 +2496,8 @@ struct ceph_msg *ceph_msg_new(int type, int
front_len, gfp_t flags,
 	if (m == NULL)
 		goto out;
 	kref_init(&m->kref);
+
+	m->con = NULL;
 	INIT_LIST_HEAD(&m->list_head);

 	m->hdr.tid = 0;
@@ -2595,6 +2615,8 @@ static bool ceph_con_in_msg_alloc(struct
ceph_connection *con,
 		mutex_unlock(&con->mutex);
 		con->in_msg = con->ops->alloc_msg(con, hdr, &skip);
 		mutex_lock(&con->mutex);
+		if (con->in_msg)
+			con->in_msg->con = con;
 		if (skip)
 			con->in_msg = NULL;

@@ -2608,6 +2630,7 @@ static bool ceph_con_in_msg_alloc(struct
ceph_connection *con,
 			       type, front_len);
 			return false;
 		}
+		con->in_msg->con = con;
 		con->in_msg->page_alignment = le16_to_cpu(hdr->data_off);
 	}
 	memcpy(&con->in_msg->hdr, &con->in_hdr, sizeof(con->in_hdr));
-- 
1.7.5.4

