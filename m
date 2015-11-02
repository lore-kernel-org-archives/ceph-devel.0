From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 3/4] libceph: stop duplicating client fields in messenger
Date: Mon,  2 Nov 2015 23:44:09 +0100
Message-ID: <1446504250-25647-4-git-send-email-idryomov@gmail.com>
References: <1446504250-25647-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34058 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbbKBVEd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Nov 2015 16:04:33 -0500
Received: by wmff134 with SMTP id f134so69371414wmf.1
        for <ceph-devel@vger.kernel.org>; Mon, 02 Nov 2015 13:04:31 -0800 (PST)
In-Reply-To: <1446504250-25647-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Zheng Yan <zyan@redhat.com>

supported_features and required_features serve no purpose at all, while
nocrc and tcp_nodelay belong to ceph_options::flags.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 include/linux/ceph/libceph.h   |  1 +
 include/linux/ceph/messenger.h | 11 +----------
 net/ceph/ceph_common.c         |  6 +-----
 net/ceph/messenger.c           | 26 +++++++++-----------------
 4 files changed, 12 insertions(+), 32 deletions(-)

diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 397c5cd09794..a7caafe03d3c 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -137,6 +137,7 @@ struct ceph_client {
 #endif
 };
 
+#define from_msgr(ms)	container_of(ms, struct ceph_client, msgr)
 
 
 /*
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 3687ff0f0133..71b1d6cdcb5d 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -57,8 +57,6 @@ struct ceph_messenger {
 
 	atomic_t stopping;
 	possible_net_t net;
-	bool nocrc;
-	bool tcp_nodelay;
 
 	/*
 	 * the global_seq counts connections i (attempt to) initiate
@@ -66,9 +64,6 @@ struct ceph_messenger {
 	 */
 	u32 global_seq;
 	spinlock_t global_seq_lock;
-
-	u64 supported_features;
-	u64 required_features;
 };
 
 enum ceph_msg_data_type {
@@ -267,11 +262,7 @@ extern void ceph_msgr_exit(void);
 extern void ceph_msgr_flush(void);
 
 extern void ceph_messenger_init(struct ceph_messenger *msgr,
-			struct ceph_entity_addr *myaddr,
-			u64 supported_features,
-			u64 required_features,
-			bool nocrc,
-			bool tcp_nodelay);
+				struct ceph_entity_addr *myaddr);
 extern void ceph_messenger_fini(struct ceph_messenger *msgr);
 
 extern void ceph_con_init(struct ceph_connection *con, void *private,
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 54a00d66509e..d1494d1a8592 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -596,11 +596,7 @@ struct ceph_client *ceph_create_client(struct ceph_options *opt, void *private,
 	if (ceph_test_opt(client, MYIP))
 		myaddr = &client->options->my_addr;
 
-	ceph_messenger_init(&client->msgr, myaddr,
-		client->supported_features,
-		client->required_features,
-		ceph_test_opt(client, NOCRC),
-		ceph_test_opt(client, TCP_NODELAY));
+	ceph_messenger_init(&client->msgr, myaddr);
 
 	/* subsystems */
 	err = ceph_monc_init(&client->monc, client);
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 805f6f82139f..11108076bac3 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -509,7 +509,7 @@ static int ceph_tcp_connect(struct ceph_connection *con)
 		return ret;
 	}
 
-	if (con->msgr->tcp_nodelay) {
+	if (ceph_test_opt(from_msgr(con->msgr), TCP_NODELAY)) {
 		int optval = 1;
 
 		ret = kernel_setsockopt(sock, SOL_TCP, TCP_NODELAY,
@@ -1432,7 +1432,8 @@ static int prepare_write_connect(struct ceph_connection *con)
 	dout("prepare_write_connect %p cseq=%d gseq=%d proto=%d\n", con,
 	     con->connect_seq, global_seq, proto);
 
-	con->out_connect.features = cpu_to_le64(con->msgr->supported_features);
+	con->out_connect.features =
+	    cpu_to_le64(from_msgr(con->msgr)->supported_features);
 	con->out_connect.host_type = cpu_to_le32(CEPH_ENTITY_TYPE_CLIENT);
 	con->out_connect.connect_seq = cpu_to_le32(con->connect_seq);
 	con->out_connect.global_seq = cpu_to_le32(global_seq);
@@ -1527,7 +1528,7 @@ static int write_partial_message_data(struct ceph_connection *con)
 {
 	struct ceph_msg *msg = con->out_msg;
 	struct ceph_msg_data_cursor *cursor = &msg->cursor;
-	bool do_datacrc = !con->msgr->nocrc;
+	bool do_datacrc = !ceph_test_opt(from_msgr(con->msgr), NOCRC);
 	u32 crc;
 
 	dout("%s %p msg %p\n", __func__, con, msg);
@@ -2005,8 +2006,8 @@ static int process_banner(struct ceph_connection *con)
 
 static int process_connect(struct ceph_connection *con)
 {
-	u64 sup_feat = con->msgr->supported_features;
-	u64 req_feat = con->msgr->required_features;
+	u64 sup_feat = from_msgr(con->msgr)->supported_features;
+	u64 req_feat = from_msgr(con->msgr)->required_features;
 	u64 server_feat = ceph_sanitize_features(
 				le64_to_cpu(con->in_reply.features));
 	int ret;
@@ -2232,7 +2233,7 @@ static int read_partial_msg_data(struct ceph_connection *con)
 {
 	struct ceph_msg *msg = con->in_msg;
 	struct ceph_msg_data_cursor *cursor = &msg->cursor;
-	const bool do_datacrc = !con->msgr->nocrc;
+	bool do_datacrc = !ceph_test_opt(from_msgr(con->msgr), NOCRC);
 	struct page *page;
 	size_t page_offset;
 	size_t length;
@@ -2277,7 +2278,7 @@ static int read_partial_message(struct ceph_connection *con)
 	int end;
 	int ret;
 	unsigned int front_len, middle_len, data_len;
-	bool do_datacrc = !con->msgr->nocrc;
+	bool do_datacrc = !ceph_test_opt(from_msgr(con->msgr), NOCRC);
 	bool need_sign = (con->peer_features & CEPH_FEATURE_MSG_AUTH);
 	u64 seq;
 	u32 crc;
@@ -2951,15 +2952,8 @@ static void con_fault(struct ceph_connection *con)
  * initialize a new messenger instance
  */
 void ceph_messenger_init(struct ceph_messenger *msgr,
-			struct ceph_entity_addr *myaddr,
-			u64 supported_features,
-			u64 required_features,
-			bool nocrc,
-			bool tcp_nodelay)
+			 struct ceph_entity_addr *myaddr)
 {
-	msgr->supported_features = supported_features;
-	msgr->required_features = required_features;
-
 	spin_lock_init(&msgr->global_seq_lock);
 
 	if (myaddr)
@@ -2969,8 +2963,6 @@ void ceph_messenger_init(struct ceph_messenger *msgr,
 	msgr->inst.addr.type = 0;
 	get_random_bytes(&msgr->inst.addr.nonce, sizeof(msgr->inst.addr.nonce));
 	encode_my_addr(msgr);
-	msgr->nocrc = nocrc;
-	msgr->tcp_nodelay = tcp_nodelay;
 
 	atomic_set(&msgr->stopping, 0);
 	write_pnet(&msgr->net, get_net(current->nsproxy->net_ns));
-- 
2.4.3

