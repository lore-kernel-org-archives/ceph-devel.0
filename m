Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C1B32FA18
	for <ceph-devel@vger.kernel.org>; Thu,  9 Jul 2026 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783594290; cv=none; b=Wn58cj9bJOocz37Um2dABV8kFxD5iloApI5SU1R8gNJen13ReCBvSfmwSIcy5G1qrYEuYl0oo1Hu6yYKK/LjctcFLlTZuyNPng4N4Uuek1BzWnGvByIHvRMi3V82T1wxUbT/zSvKUSfOV6j5oDY/ttH2D/qMA9ZyfJobmh7c1Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783594290; c=relaxed/simple;
	bh=f9kDw77gEsbqv1HNcl7J0/i3CspWSPRwh3E5D9zt1gw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WkUTYJ+s1yVyGdQ7aCnP2EKeki5whe1x41M/ohhMzLva/nmVOPSBe/N3BamiQ1d7NEU3L5yJYFASKV22O841XTF2J1V3iTngUUrHiLBcRwlQuXg8XG4HIUpTzGHSrOEzj3I46QXdXYuDxyaEYNeBWYVWpOyF5JZMkhLypFhP6u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=TQRuO9hf; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="TQRuO9hf"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47db714766aso410954f8f.0
        for <ceph-devel@vger.kernel.org>; Thu, 09 Jul 2026 03:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783594280; x=1784199080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z24JHlCqiele8XucaYrzikSVEzk4wXX5NPdUKl5ZXQ0=;
        b=TQRuO9hfj9GC1YZ7mKuxpIhQDE3g1knyCTvd9UO1NvG4MZr9OdB4ksUWxb4qlqK72f
         bwFV+CcrxfrsQTzeAx6nv1KbcmM7c34kPn7+/8N3B/Fq5tIoXEnhcTN5CF0qVzlVrule
         aleoWmLXN1TTQq3f+FI/D3ciirHZ9ZCm6QaU4RZ24i4iJiwCwumcQ5j+MZhSGNCV6rpy
         dySpU06E+jc6X5AwJwIIMrmHf+KPcyXRP9WPBpweZIQVNdqNOY67JySKCbICm9JWet84
         8rXcjt1nKSxXke6K9y/zUme+nQlPvTvYY97CtJCGkemcoQJAM5wyaJWhFzoAAzjJoV2R
         NIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783594280; x=1784199080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z24JHlCqiele8XucaYrzikSVEzk4wXX5NPdUKl5ZXQ0=;
        b=Ze6hsEHkF9Z02CbK16eBxUp1Tpzd+P6v2lhYG6zOa/M6c8RAozjReUrRWao1sCkFNW
         UiEUAc9B2rsUjEOnOMOJrN7EV0EO+kmR8bGcqEDtTaV7oeJYwD0I8ts3g5CHRY5KtzWo
         /Vi2xMOk1uX69j3F0S+4/e9y4iA+OEIIUACRK1C5xs3zksZGJGLWUplbZhgz0c5F6/4j
         wEe/kGmea37qi9ET4V8/X4DMdw9/abPpiyx8b2U3fWSA70shy06lY5ocCvIjm7rbkqZZ
         XWTF97Av9mCzdejDMh8HXT2isNRm/MEWRjAhjLpH/R54l5HJcuUwRmJpmL8khKqK8ps/
         vrUA==
X-Forwarded-Encrypted: i=1; AHgh+RrknxKSnmhnQZba2zg0ctOUt6+sqCvQ7v7CE0w4/n31G0tI85TLfcnciQBcep6WRElIC87FvTE6jmva@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq4/MRYDrXwTRrUmSletPkwtNTJzzUTm5DmzrEK7Rec6Mds3p9
	bdf62/TpU09VN1XzOl02NhGPpH8KOwXM+4I9vojP7x+BrBvilK+TtD3LHmhOjXKVbbw=
X-Gm-Gg: AfdE7cm0+56LRlBu2qY9zlyj/uHE++Ftpno1eQdYlaT9Naa9b5ETHapfAJxIfAJnZrA
	1Nd9Vp+T1vJTbH/2+eJDeaoem+1r744d+7wyDd8lvW3FOHiF4QAfuVt6JAllmUtzDzdMFpnLNaZ
	DARkv3JeXRghbkFzQEeVMv4dIpvO2+FOHd9onUuy3VAAFEb22RZaPKXXOL6wmSMYp4b5ZN2KCt/
	c9IjYa9dQySfDEBFh9IvyF6/gMDu92B9LID7154C9FwtFeRQ9K6JUZwNo57+/yZzN0rFTXIvg/o
	GBVAULe2p3LX/3ENtGIQNzljAQsiJTjaLm72uk9pag3ITeOXA1hORFdqGDtiuBq99BDqZs9whkb
	hKK0l9zI7OO0OT/eAYcTt4UynqXNT01R4zbHZ3yfx7M9NLJfkUTDEgOyJkAO/ciQ3sjwPmlWnY4
	eLFTHaV+YB+F5qzV0sBZm2IoQjY4ubCzOYiyG4iw76zreB5atnq0fPOHWkJedyUPk2m9TtGa+AB
	VUl5H41kCJ4O1tx
X-Received: by 2002:a05:6000:2508:b0:46d:d6b2:395c with SMTP id ffacd0b85a97d-47df755c391mr2516453f8f.23.1783594279439;
        Thu, 09 Jul 2026 03:51:19 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f34b400023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f34:b400:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f2186bsm49063782f8f.36.2026.07.09.03.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 03:51:19 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] net/ceph/messenger: add lockdep assertions
Date: Thu,  9 Jul 2026 12:51:14 +0200
Message-ID: <20260709105114.901748-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To verify locking correctness at runtime and to document that these
locks are necessary.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 net/ceph/messenger.c    |  14 ++++
 net/ceph/messenger_v1.c |  71 +++++++++++++++++
 net/ceph/messenger_v2.c | 168 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 253 insertions(+)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 34b3097b4c7b..710abbc75d85 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -441,6 +441,7 @@ int ceph_tcp_connect(struct ceph_connection *con)
 
 	dout("%s con %p peer_addr %s\n", __func__, con,
 	     ceph_pr_addr(&con->peer_addr));
+	lockdep_assert_held(&con->mutex);
 	BUG_ON(con->sock);
 
 	/* sock_create_kern() allocates with GFP_KERNEL */
@@ -488,6 +489,8 @@ int ceph_con_close_socket(struct ceph_connection *con)
 	int rc = 0;
 
 	dout("%s con %p sock %p\n", __func__, con, con->sock);
+	lockdep_assert_held(&con->mutex);
+
 	if (con->sock) {
 		rc = con->sock->ops->shutdown(con->sock, SHUT_RDWR);
 		sock_release(con->sock);
@@ -509,6 +512,7 @@ int ceph_con_close_socket(struct ceph_connection *con)
 static void ceph_con_reset_protocol(struct ceph_connection *con)
 {
 	dout("%s con %p\n", __func__, con);
+	lockdep_assert_held(&con->mutex);
 
 	ceph_con_close_socket(con);
 	if (con->in_msg) {
@@ -556,6 +560,7 @@ void ceph_con_reset_session(struct ceph_connection *con)
 {
 	dout("%s con %p\n", __func__, con);
 
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(con->in_msg);
 	WARN_ON(con->out_msg);
 	ceph_msg_remove_list(&con->out_queue);
@@ -675,6 +680,8 @@ void ceph_con_discard_sent(struct ceph_connection *con, u64 ack_seq)
 	u64 seq;
 
 	dout("%s con %p ack_seq %llu\n", __func__, con, ack_seq);
+	lockdep_assert_held(&con->mutex);
+
 	while (!list_empty(&con->out_sent)) {
 		msg = list_first_entry(&con->out_sent, struct ceph_msg,
 				       list_head);
@@ -700,6 +707,8 @@ void ceph_con_discard_requeued(struct ceph_connection *con, u64 reconnect_seq)
 	u64 seq;
 
 	dout("%s con %p reconnect_seq %llu\n", __func__, con, reconnect_seq);
+	lockdep_assert_held(&con->mutex);
+
 	while (!list_empty(&con->out_queue)) {
 		msg = list_first_entry(&con->out_queue, struct ceph_msg,
 				       list_head);
@@ -1403,6 +1412,7 @@ void ceph_con_process_message(struct ceph_connection *con)
 {
 	struct ceph_msg *msg = con->in_msg;
 
+	lockdep_assert_held(&con->mutex);
 	BUG_ON(con->in_msg->con != con);
 	con->in_msg = NULL;
 
@@ -1713,6 +1723,8 @@ static void msg_con_set(struct ceph_msg *msg, struct ceph_connection *con)
 
 static void clear_standby(struct ceph_connection *con)
 {
+	lockdep_assert_held(&con->mutex);
+
 	/* come back from STANDBY? */
 	if (con->state == CEPH_CON_S_STANDBY) {
 		dout("clear_standby %p\n", con);
@@ -2114,6 +2126,8 @@ struct ceph_msg *ceph_con_get_out_msg(struct ceph_connection *con)
 {
 	struct ceph_msg *msg;
 
+	lockdep_assert_held(&con->mutex);
+
 	if (list_empty(&con->out_queue))
 		return NULL;
 
diff --git a/net/ceph/messenger_v1.c b/net/ceph/messenger_v1.c
index c9e002d96319..c449b7aac8eb 100644
--- a/net/ceph/messenger_v1.c
+++ b/net/ceph/messenger_v1.c
@@ -109,6 +109,7 @@ static int ceph_tcp_sendpage(struct socket *sock, struct page *page,
 
 static void con_out_kvec_reset(struct ceph_connection *con)
 {
+	lockdep_assert_held(&con->mutex);
 	BUG_ON(con->v1.out_skip);
 
 	con->v1.out_kvec_left = 0;
@@ -121,6 +122,7 @@ static void con_out_kvec_add(struct ceph_connection *con,
 {
 	int index = con->v1.out_kvec_left;
 
+	lockdep_assert_held(&con->mutex);
 	BUG_ON(con->v1.out_skip);
 	BUG_ON(index >= ARRAY_SIZE(con->v1.out_kvec));
 
@@ -139,6 +141,8 @@ static int con_out_kvec_skip(struct ceph_connection *con)
 {
 	int skip = 0;
 
+	lockdep_assert_held(&con->mutex);
+
 	if (con->v1.out_kvec_bytes > 0) {
 		skip = con->v1.out_kvec_cur[con->v1.out_kvec_left - 1].iov_len;
 		BUG_ON(con->v1.out_kvec_bytes < skip);
@@ -172,6 +176,8 @@ static void prepare_message_data(struct ceph_msg *msg, u32 data_len)
 static void prepare_write_message_footer(struct ceph_connection *con,
 					 struct ceph_msg *m)
 {
+	lockdep_assert_held(&con->mutex);
+
 	m->footer.flags |= CEPH_MSG_FOOTER_COMPLETE;
 
 	dout("prepare_write_message_footer %p\n", con);
@@ -196,6 +202,8 @@ static void prepare_write_message(struct ceph_connection *con,
 {
 	u32 crc;
 
+	lockdep_assert_held(&con->mutex);
+
 	con_out_kvec_reset(con);
 	con->v1.out_msg_done = false;
 
@@ -264,6 +272,8 @@ static void prepare_write_ack(struct ceph_connection *con)
 {
 	dout("prepare_write_ack %p %llu -> %llu\n", con,
 	     con->in_seq_acked, con->in_seq);
+	lockdep_assert_held(&con->mutex);
+
 	con->in_seq_acked = con->in_seq;
 
 	con_out_kvec_reset(con);
@@ -285,6 +295,8 @@ static void prepare_write_seq(struct ceph_connection *con)
 {
 	dout("prepare_write_seq %p %llu -> %llu\n", con,
 	     con->in_seq_acked, con->in_seq);
+	lockdep_assert_held(&con->mutex);
+
 	con->in_seq_acked = con->in_seq;
 
 	con_out_kvec_reset(con);
@@ -302,6 +314,8 @@ static void prepare_write_seq(struct ceph_connection *con)
 static void prepare_write_keepalive(struct ceph_connection *con)
 {
 	dout("prepare_write_keepalive %p\n", con);
+	lockdep_assert_held(&con->mutex);
+
 	con_out_kvec_reset(con);
 	if (con->peer_features & CEPH_FEATURE_MSGR_KEEPALIVE2) {
 		struct timespec64 now;
@@ -326,6 +340,8 @@ static int get_connect_authorizer(struct ceph_connection *con)
 	struct ceph_auth_handshake *auth;
 	int auth_proto;
 
+	lockdep_assert_held(&con->mutex);
+
 	if (!con->ops->get_authorizer) {
 		con->v1.auth = NULL;
 		con->v1.out_connect.authorizer_protocol = CEPH_AUTH_UNKNOWN;
@@ -349,6 +365,8 @@ static int get_connect_authorizer(struct ceph_connection *con)
  */
 static void prepare_write_banner(struct ceph_connection *con)
 {
+	lockdep_assert_held(&con->mutex);
+
 	con_out_kvec_add(con, strlen(CEPH_BANNER), CEPH_BANNER);
 	con_out_kvec_add(con, sizeof (con->msgr->my_enc_addr),
 					&con->msgr->my_enc_addr);
@@ -359,6 +377,8 @@ static void prepare_write_banner(struct ceph_connection *con)
 
 static void __prepare_write_connect(struct ceph_connection *con)
 {
+	lockdep_assert_held(&con->mutex);
+
 	con_out_kvec_add(con, sizeof(con->v1.out_connect),
 			 &con->v1.out_connect);
 	if (con->v1.auth)
@@ -375,6 +395,8 @@ static int prepare_write_connect(struct ceph_connection *con)
 	int proto;
 	int ret;
 
+	lockdep_assert_held(&con->mutex);
+
 	switch (con->peer_name.type) {
 	case CEPH_ENTITY_TYPE_MON:
 		proto = CEPH_MONC_PROTOCOL;
@@ -419,6 +441,8 @@ static int write_partial_kvec(struct ceph_connection *con)
 	int ret;
 
 	dout("write_partial_kvec %p %d left\n", con, con->v1.out_kvec_bytes);
+	lockdep_assert_held(&con->mutex);
+
 	while (con->v1.out_kvec_bytes > 0) {
 		ret = ceph_tcp_sendmsg(con->sock, con->v1.out_kvec_cur,
 				       con->v1.out_kvec_left,
@@ -466,6 +490,7 @@ static int write_partial_message_data(struct ceph_connection *con,
 	u32 crc;
 
 	dout("%s %p msg %p\n", __func__, con, msg);
+	lockdep_assert_held(&con->mutex);
 
 	if (!msg->num_data_items)
 		return -EINVAL;
@@ -525,6 +550,8 @@ static int write_partial_skip(struct ceph_connection *con)
 	int ret;
 
 	dout("%s %p %d left\n", __func__, con, con->v1.out_skip);
+	lockdep_assert_held(&con->mutex);
+
 	while (con->v1.out_skip > 0) {
 		size_t size = min(con->v1.out_skip, (int)PAGE_SIZE);
 
@@ -545,24 +572,32 @@ static int write_partial_skip(struct ceph_connection *con)
 static void prepare_read_banner(struct ceph_connection *con)
 {
 	dout("prepare_read_banner %p\n", con);
+	lockdep_assert_held(&con->mutex);
+
 	con->v1.in_base_pos = 0;
 }
 
 static void prepare_read_connect(struct ceph_connection *con)
 {
 	dout("prepare_read_connect %p\n", con);
+	lockdep_assert_held(&con->mutex);
+
 	con->v1.in_base_pos = 0;
 }
 
 static void prepare_read_ack(struct ceph_connection *con)
 {
 	dout("prepare_read_ack %p\n", con);
+	lockdep_assert_held(&con->mutex);
+
 	con->v1.in_base_pos = 0;
 }
 
 static void prepare_read_seq(struct ceph_connection *con)
 {
 	dout("prepare_read_seq %p\n", con);
+	lockdep_assert_held(&con->mutex);
+
 	con->v1.in_base_pos = 0;
 	con->v1.in_tag = CEPH_MSGR_TAG_SEQ;
 }
@@ -570,6 +605,8 @@ static void prepare_read_seq(struct ceph_connection *con)
 static void prepare_read_tag(struct ceph_connection *con)
 {
 	dout("prepare_read_tag %p\n", con);
+	lockdep_assert_held(&con->mutex);
+
 	con->v1.in_base_pos = 0;
 	con->v1.in_tag = CEPH_MSGR_TAG_READY;
 }
@@ -577,6 +614,8 @@ static void prepare_read_tag(struct ceph_connection *con)
 static void prepare_read_keepalive_ack(struct ceph_connection *con)
 {
 	dout("prepare_read_keepalive_ack %p\n", con);
+	lockdep_assert_held(&con->mutex);
+
 	con->v1.in_base_pos = 0;
 }
 
@@ -586,6 +625,7 @@ static void prepare_read_keepalive_ack(struct ceph_connection *con)
 static int prepare_read_message(struct ceph_connection *con)
 {
 	dout("prepare_read_message %p\n", con);
+	lockdep_assert_held(&con->mutex);
 	BUG_ON(con->in_msg != NULL);
 	con->v1.in_base_pos = 0;
 	con->in_front_crc = con->in_middle_crc = con->in_data_crc = 0;
@@ -595,6 +635,8 @@ static int prepare_read_message(struct ceph_connection *con)
 static int read_partial(struct ceph_connection *con,
 			int end, int size, void *object)
 {
+	lockdep_assert_held(&con->mutex);
+
 	while (con->v1.in_base_pos < end) {
 		int left = end - con->v1.in_base_pos;
 		int have = size - left;
@@ -616,6 +658,7 @@ static int read_partial_banner(struct ceph_connection *con)
 	int ret;
 
 	dout("read_partial_banner %p at %d\n", con, con->v1.in_base_pos);
+	lockdep_assert_held(&con->mutex);
 
 	/* peer's banner */
 	size = strlen(CEPH_BANNER);
@@ -649,6 +692,7 @@ static int read_partial_connect(struct ceph_connection *con)
 	int ret;
 
 	dout("read_partial_connect %p at %d\n", con, con->v1.in_base_pos);
+	lockdep_assert_held(&con->mutex);
 
 	size = sizeof(con->v1.in_reply);
 	end = size;
@@ -685,6 +729,8 @@ static int read_partial_connect(struct ceph_connection *con)
  */
 static int verify_hello(struct ceph_connection *con)
 {
+	lockdep_assert_held(&con->mutex);
+
 	if (memcmp(con->v1.in_banner, CEPH_BANNER, strlen(CEPH_BANNER))) {
 		pr_err("connect to %s got bad banner\n",
 		       ceph_pr_addr(&con->peer_addr));
@@ -699,6 +745,7 @@ static int process_banner(struct ceph_connection *con)
 	struct ceph_entity_addr *my_addr = &con->msgr->inst.addr;
 
 	dout("process_banner on %p\n", con);
+	lockdep_assert_held(&con->mutex);
 
 	if (verify_hello(con) < 0)
 		return -1;
@@ -745,6 +792,7 @@ static int process_connect(struct ceph_connection *con)
 	int ret;
 
 	dout("process_connect on %p tag %d\n", con, con->v1.in_tag);
+	lockdep_assert_held(&con->mutex);
 
 	if (con->v1.auth) {
 		int len = le32_to_cpu(con->v1.in_reply.authorizer_len);
@@ -949,6 +997,8 @@ static void process_ack(struct ceph_connection *con)
 {
 	u64 ack = le64_to_cpu(con->v1.in_temp_ack);
 
+	lockdep_assert_held(&con->mutex);
+
 	if (con->v1.in_tag == CEPH_MSGR_TAG_ACK)
 		ceph_con_discard_sent(con, ack);
 	else
@@ -963,6 +1013,7 @@ static int read_partial_message_chunk(struct ceph_connection *con,
 {
 	int ret, left;
 
+	lockdep_assert_held(&con->mutex);
 	BUG_ON(!section);
 
 	while (section->iov_len < sec_len) {
@@ -993,6 +1044,8 @@ static int read_partial_sparse_msg_extent(struct ceph_connection *con, u32 *crc)
 	struct ceph_msg_data_cursor *cursor = &con->in_msg->cursor;
 	bool do_bounce = ceph_test_opt(from_msgr(con->msgr), RXBOUNCE);
 
+	lockdep_assert_held(&con->mutex);
+
 	if (do_bounce && unlikely(!con->bounce_page)) {
 		con->bounce_page = alloc_page(GFP_NOIO);
 		if (!con->bounce_page) {
@@ -1030,6 +1083,8 @@ static int read_partial_sparse_msg_data(struct ceph_connection *con)
 	u32 crc = 0;
 	int ret = 1;
 
+	lockdep_assert_held(&con->mutex);
+
 	if (do_datacrc)
 		crc = con->in_data_crc;
 
@@ -1070,6 +1125,8 @@ static int read_partial_msg_data(struct ceph_connection *con)
 	u32 crc = 0;
 	int ret;
 
+	lockdep_assert_held(&con->mutex);
+
 	if (do_datacrc)
 		crc = con->in_data_crc;
 	while (cursor->total_resid) {
@@ -1105,6 +1162,8 @@ static int read_partial_msg_data_bounce(struct ceph_connection *con)
 	u32 crc;
 	int ret;
 
+	lockdep_assert_held(&con->mutex);
+
 	if (unlikely(!con->bounce_page)) {
 		con->bounce_page = alloc_page(GFP_NOIO);
 		if (!con->bounce_page) {
@@ -1153,6 +1212,7 @@ static int read_partial_message(struct ceph_connection *con)
 	u32 crc;
 
 	dout("read_partial_message con %p msg %p\n", con, m);
+	lockdep_assert_held(&con->mutex);
 
 	/* header */
 	size = sizeof(con->v1.in_hdr);
@@ -1323,6 +1383,8 @@ int ceph_con_v1_try_read(struct ceph_connection *con)
 {
 	int ret = -1;
 
+	lockdep_assert_held(&con->mutex);
+
 more:
 	dout("try_read start %p state %d\n", con, con->state);
 	if (con->state != CEPH_CON_S_V1_BANNER &&
@@ -1471,6 +1533,8 @@ int ceph_con_v1_try_write(struct ceph_connection *con)
 	struct ceph_msg *msg;
 	int ret = 1;
 
+	lockdep_assert_held(&con->mutex);
+
 	dout("try_write start %p state %d\n", con, con->state);
 	if (con->state != CEPH_CON_S_PREOPEN &&
 	    con->state != CEPH_CON_S_V1_BANNER &&
@@ -1564,6 +1628,7 @@ int ceph_con_v1_try_write(struct ceph_connection *con)
 
 void ceph_con_v1_revoke(struct ceph_connection *con, struct ceph_msg *msg)
 {
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(con->v1.out_skip);
 	/* footer */
 	if (con->v1.out_msg_done) {
@@ -1589,6 +1654,8 @@ void ceph_con_v1_revoke_incoming(struct ceph_connection *con)
 	unsigned int middle_len = le32_to_cpu(con->v1.in_hdr.middle_len);
 	unsigned int data_len = le32_to_cpu(con->v1.in_hdr.data_len);
 
+	lockdep_assert_held(&con->mutex);
+
 	/* skip rest of message */
 	con->v1.in_base_pos = con->v1.in_base_pos -
 			sizeof(struct ceph_msg_header) -
@@ -1610,11 +1677,15 @@ bool ceph_con_v1_opened(struct ceph_connection *con)
 
 void ceph_con_v1_reset_session(struct ceph_connection *con)
 {
+	lockdep_assert_held(&con->mutex);
+
 	con->v1.connect_seq = 0;
 	con->v1.peer_global_seq = 0;
 }
 
 void ceph_con_v1_reset_protocol(struct ceph_connection *con)
 {
+	lockdep_assert_held(&con->mutex);
+
 	con->v1.out_skip = 0;
 }
diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index 05f6eea299fc..bfb7c0950ee6 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -109,6 +109,8 @@ static int ceph_tcp_recv(struct ceph_connection *con)
 {
 	int ret;
 
+	lockdep_assert_held(&con->mutex);
+
 	dout("%s con %p %s %zu\n", __func__, con,
 	     iov_iter_is_discard(&con->v2.in_iter) ? "discard" : "need",
 	     iov_iter_count(&con->v2.in_iter));
@@ -198,6 +200,8 @@ static int ceph_tcp_send(struct ceph_connection *con)
 
 	dout("%s con %p have %zu try_sendpage %d\n", __func__, con,
 	     iov_iter_count(&con->v2.out_iter), con->v2.out_iter_sendpage);
+	lockdep_assert_held(&con->mutex);
+
 	if (con->v2.out_iter_sendpage)
 		ret = do_try_sendpage(con->sock, &con->v2.out_iter);
 	else
@@ -209,6 +213,7 @@ static int ceph_tcp_send(struct ceph_connection *con)
 
 static void add_in_kvec(struct ceph_connection *con, void *buf, int len)
 {
+	lockdep_assert_held(&con->mutex);
 	BUG_ON(con->v2.in_kvec_cnt >= ARRAY_SIZE(con->v2.in_kvecs));
 	WARN_ON(!iov_iter_is_kvec(&con->v2.in_iter));
 
@@ -222,6 +227,7 @@ static void add_in_kvec(struct ceph_connection *con, void *buf, int len)
 
 static void reset_in_kvecs(struct ceph_connection *con)
 {
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(iov_iter_count(&con->v2.in_iter));
 
 	con->v2.in_kvec_cnt = 0;
@@ -230,6 +236,7 @@ static void reset_in_kvecs(struct ceph_connection *con)
 
 static void set_in_bvec(struct ceph_connection *con, const struct bio_vec *bv)
 {
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(iov_iter_count(&con->v2.in_iter));
 
 	con->v2.in_bvec = *bv;
@@ -238,6 +245,7 @@ static void set_in_bvec(struct ceph_connection *con, const struct bio_vec *bv)
 
 static void set_in_skip(struct ceph_connection *con, int len)
 {
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(iov_iter_count(&con->v2.in_iter));
 
 	dout("%s con %p len %d\n", __func__, con, len);
@@ -246,6 +254,7 @@ static void set_in_skip(struct ceph_connection *con, int len)
 
 static void add_out_kvec(struct ceph_connection *con, void *buf, int len)
 {
+	lockdep_assert_held(&con->mutex);
 	BUG_ON(con->v2.out_kvec_cnt >= ARRAY_SIZE(con->v2.out_kvecs));
 	WARN_ON(!iov_iter_is_kvec(&con->v2.out_iter));
 	WARN_ON(con->v2.out_zero);
@@ -260,6 +269,7 @@ static void add_out_kvec(struct ceph_connection *con, void *buf, int len)
 
 static void reset_out_kvecs(struct ceph_connection *con)
 {
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(iov_iter_count(&con->v2.out_iter));
 	WARN_ON(con->v2.out_zero);
 
@@ -272,6 +282,7 @@ static void reset_out_kvecs(struct ceph_connection *con)
 static void set_out_bvec(struct ceph_connection *con, const struct bio_vec *bv,
 			 bool zerocopy)
 {
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(iov_iter_count(&con->v2.out_iter));
 	WARN_ON(con->v2.out_zero);
 
@@ -283,6 +294,7 @@ static void set_out_bvec(struct ceph_connection *con, const struct bio_vec *bv,
 
 static void set_out_bvec_zero(struct ceph_connection *con)
 {
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(iov_iter_count(&con->v2.out_iter));
 	WARN_ON(!con->v2.out_zero);
 
@@ -296,6 +308,8 @@ static void set_out_bvec_zero(struct ceph_connection *con)
 static void out_zero_add(struct ceph_connection *con, int len)
 {
 	dout("%s con %p len %d\n", __func__, con, len);
+	lockdep_assert_held(&con->mutex);
+
 	con->v2.out_zero += len;
 }
 
@@ -304,6 +318,7 @@ static void *alloc_conn_buf(struct ceph_connection *con, int len)
 	void *buf;
 
 	dout("%s con %p len %d\n", __func__, con, len);
+	lockdep_assert_held(&con->mutex);
 
 	if (WARN_ON(con->v2.conn_buf_cnt >= ARRAY_SIZE(con->v2.conn_bufs)))
 		return NULL;
@@ -318,12 +333,15 @@ static void *alloc_conn_buf(struct ceph_connection *con, int len)
 
 static void free_conn_bufs(struct ceph_connection *con)
 {
+	lockdep_assert_held(&con->mutex);
+
 	while (con->v2.conn_buf_cnt)
 		kvfree(con->v2.conn_bufs[--con->v2.conn_buf_cnt]);
 }
 
 static void add_in_sign_kvec(struct ceph_connection *con, void *buf, int len)
 {
+	lockdep_assert_held(&con->mutex);
 	BUG_ON(con->v2.in_sign_kvec_cnt >= ARRAY_SIZE(con->v2.in_sign_kvecs));
 
 	con->v2.in_sign_kvecs[con->v2.in_sign_kvec_cnt].iov_base = buf;
@@ -333,11 +351,14 @@ static void add_in_sign_kvec(struct ceph_connection *con, void *buf, int len)
 
 static void clear_in_sign_kvecs(struct ceph_connection *con)
 {
+	lockdep_assert_held(&con->mutex);
+
 	con->v2.in_sign_kvec_cnt = 0;
 }
 
 static void add_out_sign_kvec(struct ceph_connection *con, void *buf, int len)
 {
+	lockdep_assert_held(&con->mutex);
 	BUG_ON(con->v2.out_sign_kvec_cnt >= ARRAY_SIZE(con->v2.out_sign_kvecs));
 
 	con->v2.out_sign_kvecs[con->v2.out_sign_kvec_cnt].iov_base = buf;
@@ -347,6 +368,8 @@ static void add_out_sign_kvec(struct ceph_connection *con, void *buf, int len)
 
 static void clear_out_sign_kvecs(struct ceph_connection *con)
 {
+	lockdep_assert_held(&con->mutex);
+
 	con->v2.out_sign_kvec_cnt = 0;
 }
 
@@ -562,6 +585,8 @@ static int decode_preamble(void *p, struct ceph_frame_desc *desc)
 
 static void encode_epilogue_plain(struct ceph_connection *con, bool aborted)
 {
+	lockdep_assert_held(&con->mutex);
+
 	con->v2.out_epil.late_status = aborted ? FRAME_LATE_STATUS_ABORTED :
 						 FRAME_LATE_STATUS_COMPLETE;
 	cpu_to_le32s(&con->v2.out_epil.front_crc);
@@ -571,6 +596,8 @@ static void encode_epilogue_plain(struct ceph_connection *con, bool aborted)
 
 static void encode_epilogue_secure(struct ceph_connection *con, bool aborted)
 {
+	lockdep_assert_held(&con->mutex);
+
 	memset(&con->v2.out_epil, 0, sizeof(con->v2.out_epil));
 	con->v2.out_epil.late_status = aborted ? FRAME_LATE_STATUS_ABORTED :
 						 FRAME_LATE_STATUS_COMPLETE;
@@ -639,6 +666,7 @@ static int verify_control_crc(struct ceph_connection *con)
 	int ctrl_len = con->v2.in_desc.fd_lens[0];
 	u32 crc, expected_crc;
 
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(con->v2.in_kvecs[0].iov_len != ctrl_len);
 	WARN_ON(con->v2.in_kvecs[1].iov_len != CEPH_CRC_LEN);
 
@@ -656,6 +684,8 @@ static int verify_control_crc(struct ceph_connection *con)
 static int verify_epilogue_crcs(struct ceph_connection *con, u32 front_crc,
 				u32 middle_crc, u32 data_crc)
 {
+	lockdep_assert_held(&con->mutex);
+
 	if (front_len(con->in_msg)) {
 		con->in_front_crc = crc32c(-1, con->in_msg->front.iov_base,
 					   front_len(con->in_msg));
@@ -707,6 +737,7 @@ static int setup_crypto(struct ceph_connection *con,
 
 	dout("%s con %p con_mode %d session_key_len %d con_secret_len %d\n",
 	     __func__, con, con->v2.con_mode, session_key_len, con_secret_len);
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(con->v2.hmac_key_set || con->v2.gcm_tfm || con->v2.gcm_req);
 
 	if (con->v2.con_mode != CEPH_CON_MODE_CRC &&
@@ -786,6 +817,7 @@ static void con_hmac_sha256(struct ceph_connection *con,
 
 	dout("%s con %p hmac_key_set %d kvec_cnt %d\n", __func__, con,
 	     con->v2.hmac_key_set, kvec_cnt);
+	lockdep_assert_held(&con->mutex);
 
 	if (!con->v2.hmac_key_set) {
 		memset(hmac, 0, SHA256_DIGEST_SIZE);
@@ -814,6 +846,8 @@ static int gcm_crypt(struct ceph_connection *con, bool encrypt,
 	struct ceph_gcm_nonce *nonce;
 	int ret;
 
+	lockdep_assert_held(&con->mutex);
+
 	nonce = encrypt ? &con->v2.out_gcm_nonce : &con->v2.in_gcm_nonce;
 
 	aead_request_set_ad(con->v2.gcm_req, 0);  /* no AAD */
@@ -1033,6 +1067,8 @@ static int decrypt_preamble(struct ceph_connection *con)
 {
 	struct scatterlist sg;
 
+	lockdep_assert_held(&con->mutex);
+
 	sg_init_one(&sg, con->v2.in_buf, CEPH_PREAMBLE_SECURE_LEN);
 	return gcm_crypt(con, false, &sg, &sg, CEPH_PREAMBLE_SECURE_LEN);
 }
@@ -1044,6 +1080,8 @@ static int decrypt_control_remainder(struct ceph_connection *con)
 	int pt_len = padding_len(rem_len) + CEPH_GCM_TAG_LEN;
 	struct scatterlist sgs[2];
 
+	lockdep_assert_held(&con->mutex);
+
 	WARN_ON(con->v2.in_kvecs[0].iov_len != rem_len);
 	WARN_ON(con->v2.in_kvecs[1].iov_len != pt_len);
 
@@ -1062,6 +1100,8 @@ static int process_v2_sparse_read(struct ceph_connection *con,
 	struct ceph_msg_data_cursor cursor;
 	int ret;
 
+	lockdep_assert_held(&con->mutex);
+
 	ceph_msg_data_cursor_init(&cursor, con->in_msg,
 				  con->in_msg->sparse_read_total);
 
@@ -1108,6 +1148,8 @@ static int decrypt_tail(struct ceph_connection *con)
 	int tail_len;
 	int ret;
 
+	lockdep_assert_held(&con->mutex);
+
 	tail_len = tail_onwire_len(con->in_msg, true);
 	ret = sg_alloc_table_from_pages(&enc_sgt, con->v2.in_enc_pages,
 					con->v2.in_enc_page_cnt, 0, tail_len,
@@ -1155,6 +1197,8 @@ static int prepare_banner(struct ceph_connection *con)
 	int buf_len = CEPH_BANNER_V2_LEN + 2 + 8 + 8;
 	void *buf, *p;
 
+	lockdep_assert_held(&con->mutex);
+
 	buf = alloc_conn_buf(con, buf_len);
 	if (!buf)
 		return -ENOMEM;
@@ -1197,6 +1241,8 @@ static void prepare_head_plain(struct ceph_connection *con, void *base,
 	void *crcp = base + base_len - CEPH_CRC_LEN;
 	u32 crc;
 
+	lockdep_assert_held(&con->mutex);
+
 	crc = crc32c(-1, CTRL_BODY(base), ctrl_len);
 	if (extdata_len)
 		crc = crc32c(crc, extdata, extdata_len);
@@ -1225,6 +1271,8 @@ static int prepare_head_secure_small(struct ceph_connection *con,
 	struct scatterlist sg;
 	int ret;
 
+	lockdep_assert_held(&con->mutex);
+
 	/* inline buffer padding? */
 	if (ctrl_len < CEPH_PREAMBLE_INLINE_LEN)
 		memset(CTRL_BODY(base) + ctrl_len, 0,
@@ -1270,6 +1318,8 @@ static int prepare_head_secure_big(struct ceph_connection *con,
 	struct scatterlist sgs[2];
 	int ret;
 
+	lockdep_assert_held(&con->mutex);
+
 	sg_init_table(sgs, 2);
 	sg_set_buf(&sgs[0], base, rem - base);
 	sg_set_buf(&sgs[1], pmbl_tag, CEPH_GCM_TAG_LEN);
@@ -1302,6 +1352,7 @@ static int __prepare_control(struct ceph_connection *con, int tag,
 
 	dout("%s con %p tag %d len %d (%d+%d)\n", __func__, con, tag,
 	     total_len, ctrl_len, extdata_len);
+	lockdep_assert_held(&con->mutex);
 
 	/* extdata may be vmalloc'ed but not base */
 	if (WARN_ON(is_vmalloc_addr(base) || !ctrl_len))
@@ -1342,6 +1393,8 @@ static int prepare_hello(struct ceph_connection *con)
 	void *buf, *p;
 	int ctrl_len;
 
+	lockdep_assert_held(&con->mutex);
+
 	ctrl_len = 1 + ceph_entity_addr_encoding_len(&con->peer_addr);
 	buf = alloc_conn_buf(con, head_onwire_len(ctrl_len, false));
 	if (!buf)
@@ -1366,6 +1419,8 @@ static int prepare_auth_request(struct ceph_connection *con)
 	void *buf;
 	int ret;
 
+	lockdep_assert_held(&con->mutex);
+
 	ctrl_len = AUTH_BUF_LEN;
 	buf = alloc_conn_buf(con, head_onwire_len(ctrl_len, false));
 	if (!buf)
@@ -1403,6 +1458,8 @@ static int prepare_auth_request_more(struct ceph_connection *con,
 	void *buf;
 	int ret;
 
+	lockdep_assert_held(&con->mutex);
+
 	ctrl_len = AUTH_BUF_LEN;
 	buf = alloc_conn_buf(con, head_onwire_len(ctrl_len, false));
 	if (!buf)
@@ -1431,6 +1488,8 @@ static int prepare_auth_signature(struct ceph_connection *con)
 {
 	void *buf;
 
+	lockdep_assert_held(&con->mutex);
+
 	buf = alloc_conn_buf(con, head_onwire_len(SHA256_DIGEST_SIZE,
 						  con_secure(con)));
 	if (!buf)
@@ -1451,6 +1510,7 @@ static int prepare_client_ident(struct ceph_connection *con)
 	void *buf, *p;
 	int ctrl_len;
 
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(con->v2.server_cookie);
 	WARN_ON(con->v2.connect_seq);
 	WARN_ON(con->v2.peer_global_seq);
@@ -1501,6 +1561,7 @@ static int prepare_session_reconnect(struct ceph_connection *con)
 	void *buf, *p;
 	int ctrl_len;
 
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(!con->v2.client_cookie);
 	WARN_ON(!con->v2.server_cookie);
 	WARN_ON(!con->v2.connect_seq);
@@ -1537,6 +1598,7 @@ static int prepare_keepalive2(struct ceph_connection *con)
 
 	ktime_get_real_ts64(&now);
 	dout("%s con %p timestamp %ptSp\n", __func__, con, &now);
+	lockdep_assert_held(&con->mutex);
 
 	ceph_encode_timespec64(ts, &now);
 
@@ -1551,6 +1613,8 @@ static int prepare_ack(struct ceph_connection *con)
 
 	dout("%s con %p in_seq_acked %llu -> %llu\n", __func__, con,
 	     con->in_seq_acked, con->in_seq);
+	lockdep_assert_held(&con->mutex);
+
 	con->in_seq_acked = con->in_seq;
 
 	p = CTRL_BODY(con->v2.out_buf);
@@ -1566,6 +1630,7 @@ static void prepare_epilogue_plain(struct ceph_connection *con,
 	dout("%s con %p msg %p aborted %d crcs %u %u %u\n", __func__, con,
 	     msg, aborted, con->v2.out_epil.front_crc,
 	     con->v2.out_epil.middle_crc, con->v2.out_epil.data_crc);
+	lockdep_assert_held(&con->mutex);
 
 	encode_epilogue_plain(con, aborted);
 	add_out_kvec(con, &con->v2.out_epil, CEPH_EPILOGUE_PLAIN_LEN);
@@ -1578,6 +1643,8 @@ static void prepare_epilogue_plain(struct ceph_connection *con,
 static void prepare_message_plain(struct ceph_connection *con,
 				  struct ceph_msg *msg)
 {
+	lockdep_assert_held(&con->mutex);
+
 	prepare_head_plain(con, con->v2.out_buf,
 			   sizeof(struct ceph_msg_header2), NULL, 0, false);
 
@@ -1641,6 +1708,8 @@ static int prepare_message_secure(struct ceph_connection *con,
 	int tail_len;
 	int ret;
 
+	lockdep_assert_held(&con->mutex);
+
 	ret = prepare_head_secure_small(con, con->v2.out_buf,
 					sizeof(struct ceph_msg_header2));
 	if (ret)
@@ -1708,6 +1777,7 @@ static int prepare_message(struct ceph_connection *con, struct ceph_msg *msg)
 
 	dout("%s con %p msg %p logical %d+%d+%d+%d\n", __func__, con,
 	     msg, lens[0], lens[1], lens[2], lens[3]);
+	lockdep_assert_held(&con->mutex);
 
 	if (con->in_seq > con->in_seq_acked) {
 		dout("%s con %p in_seq_acked %llu -> %llu\n", __func__, con,
@@ -1737,6 +1807,8 @@ static int prepare_read_banner_prefix(struct ceph_connection *con)
 {
 	void *buf;
 
+	lockdep_assert_held(&con->mutex);
+
 	buf = alloc_conn_buf(con, CEPH_BANNER_V2_PREFIX_LEN);
 	if (!buf)
 		return -ENOMEM;
@@ -1753,6 +1825,8 @@ static int prepare_read_banner_payload(struct ceph_connection *con,
 {
 	void *buf;
 
+	lockdep_assert_held(&con->mutex);
+
 	buf = alloc_conn_buf(con, payload_len);
 	if (!buf)
 		return -ENOMEM;
@@ -1766,6 +1840,8 @@ static int prepare_read_banner_payload(struct ceph_connection *con,
 
 static void prepare_read_preamble(struct ceph_connection *con)
 {
+	lockdep_assert_held(&con->mutex);
+
 	reset_in_kvecs(con);
 	add_in_kvec(con, con->v2.in_buf,
 		    con_secure(con) ? CEPH_PREAMBLE_SECURE_LEN :
@@ -1779,6 +1855,8 @@ static int prepare_read_control(struct ceph_connection *con)
 	int head_len;
 	void *buf;
 
+	lockdep_assert_held(&con->mutex);
+
 	reset_in_kvecs(con);
 	if (con->state == CEPH_CON_S_V2_HELLO ||
 	    con->state == CEPH_CON_S_V2_AUTH) {
@@ -1815,6 +1893,8 @@ static int prepare_read_control_remainder(struct ceph_connection *con)
 	int rem_len = ctrl_len - CEPH_PREAMBLE_INLINE_LEN;
 	void *buf;
 
+	lockdep_assert_held(&con->mutex);
+
 	buf = alloc_conn_buf(con, ctrl_len);
 	if (!buf)
 		return -ENOMEM;
@@ -1833,6 +1913,8 @@ static int prepare_read_data(struct ceph_connection *con)
 {
 	struct bio_vec bv;
 
+	lockdep_assert_held(&con->mutex);
+
 	con->in_data_crc = -1;
 	ceph_msg_data_cursor_init(&con->v2.in_cursor, con->in_msg,
 				  data_len(con->in_msg));
@@ -1859,6 +1941,8 @@ static void prepare_read_data_cont(struct ceph_connection *con)
 {
 	struct bio_vec bv;
 
+	lockdep_assert_held(&con->mutex);
+
 	if (ceph_test_opt(from_msgr(con->msgr), RXBOUNCE)) {
 		con->in_data_crc = crc32c(con->in_data_crc,
 					  page_address(con->bounce_page),
@@ -1902,6 +1986,7 @@ static int prepare_sparse_read_cont(struct ceph_connection *con)
 	char *buf = NULL;
 	struct ceph_msg_data_cursor *cursor = &con->v2.in_cursor;
 
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(con->v2.in_state != IN_S_PREPARE_SPARSE_DATA_CONT);
 
 	if (iov_iter_is_bvec(&con->v2.in_iter)) {
@@ -1999,6 +2084,7 @@ static int prepare_sparse_read_data(struct ceph_connection *con)
 	struct ceph_msg *msg = con->in_msg;
 
 	dout("%s: starting sparse read\n", __func__);
+	lockdep_assert_held(&con->mutex);
 
 	if (WARN_ON_ONCE(!con->ops->sparse_read))
 		return -EOPNOTSUPP;
@@ -2019,6 +2105,8 @@ static int prepare_read_tail_plain(struct ceph_connection *con)
 {
 	struct ceph_msg *msg = con->in_msg;
 
+	lockdep_assert_held(&con->mutex);
+
 	if (!front_len(msg) && !middle_len(msg)) {
 		WARN_ON(!data_len(msg));
 		return prepare_read_data(con);
@@ -2052,6 +2140,7 @@ static void prepare_read_enc_page(struct ceph_connection *con)
 
 	dout("%s con %p i %d resid %d\n", __func__, con, con->v2.in_enc_i,
 	     con->v2.in_enc_resid);
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(!con->v2.in_enc_resid);
 
 	bvec_set_page(&bv, con->v2.in_enc_pages[con->v2.in_enc_i],
@@ -2080,6 +2169,8 @@ static int prepare_read_tail_secure(struct ceph_connection *con)
 	int enc_page_cnt;
 	int tail_len;
 
+	lockdep_assert_held(&con->mutex);
+
 	tail_len = tail_onwire_len(con->in_msg, true);
 	WARN_ON(!tail_len);
 
@@ -2100,6 +2191,8 @@ static int prepare_read_tail_secure(struct ceph_connection *con)
 
 static void __finish_skip(struct ceph_connection *con)
 {
+	lockdep_assert_held(&con->mutex);
+
 	con->in_seq++;
 	prepare_read_preamble(con);
 }
@@ -2111,6 +2204,7 @@ static void prepare_skip_message(struct ceph_connection *con)
 
 	dout("%s con %p %d+%d+%d\n", __func__, con, desc->fd_lens[1],
 	     desc->fd_lens[2], desc->fd_lens[3]);
+	lockdep_assert_held(&con->mutex);
 
 	tail_len = __tail_onwire_len(desc->fd_lens[1], desc->fd_lens[2],
 				     desc->fd_lens[3], con_secure(con));
@@ -2127,6 +2221,7 @@ static int process_banner_prefix(struct ceph_connection *con)
 	int payload_len;
 	void *p;
 
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(con->v2.in_kvecs[0].iov_len != CEPH_BANNER_V2_PREFIX_LEN);
 
 	p = con->v2.in_kvecs[0].iov_base;
@@ -2154,6 +2249,8 @@ static int process_banner_payload(struct ceph_connection *con)
 	void *p;
 	int ret;
 
+	lockdep_assert_held(&con->mutex);
+
 	p = con->v2.in_kvecs[0].iov_base;
 	ceph_decode_64_safe(&p, end, server_feat, bad);
 	ceph_decode_64_safe(&p, end, server_req_feat, bad);
@@ -2197,6 +2294,8 @@ static int process_hello(struct ceph_connection *con, void *p, void *end)
 	u8 entity_type;
 	int ret;
 
+	lockdep_assert_held(&con->mutex);
+
 	if (con->state != CEPH_CON_S_V2_HELLO) {
 		con->error_msg = "protocol error, unexpected hello";
 		return -EINVAL;
@@ -2266,6 +2365,8 @@ static int process_auth_bad_method(struct ceph_connection *con,
 	int ret;
 	int i;
 
+	lockdep_assert_held(&con->mutex);
+
 	if (con->state != CEPH_CON_S_V2_AUTH) {
 		con->error_msg = "protocol error, unexpected auth_bad_method";
 		return -EINVAL;
@@ -2325,6 +2426,8 @@ static int process_auth_reply_more(struct ceph_connection *con,
 	int payload_len;
 	int ret;
 
+	lockdep_assert_held(&con->mutex);
+
 	if (con->state != CEPH_CON_S_V2_AUTH) {
 		con->error_msg = "protocol error, unexpected auth_reply_more";
 		return -EINVAL;
@@ -2365,6 +2468,8 @@ static int process_auth_done(struct ceph_connection *con, void *p, void *end)
 	u64 global_id;
 	int ret;
 
+	lockdep_assert_held(&con->mutex);
+
 	if (con->state != CEPH_CON_S_V2_AUTH) {
 		con->error_msg = "protocol error, unexpected auth_done";
 		return -EINVAL;
@@ -2427,6 +2532,8 @@ static int process_auth_signature(struct ceph_connection *con,
 	u8 hmac[SHA256_DIGEST_SIZE];
 	int ret;
 
+	lockdep_assert_held(&con->mutex);
+
 	if (con->state != CEPH_CON_S_V2_AUTH_SIGNATURE) {
 		con->error_msg = "protocol error, unexpected auth_signature";
 		return -EINVAL;
@@ -2481,6 +2588,8 @@ static int process_server_ident(struct ceph_connection *con,
 	u64 flags;
 	int ret;
 
+	lockdep_assert_held(&con->mutex);
+
 	if (con->state != CEPH_CON_S_V2_SESSION_CONNECT) {
 		con->error_msg = "protocol error, unexpected server_ident";
 		return -EINVAL;
@@ -2559,6 +2668,8 @@ static int process_ident_missing_features(struct ceph_connection *con,
 	struct ceph_client *client = from_msgr(con->msgr);
 	u64 missing_features;
 
+	lockdep_assert_held(&con->mutex);
+
 	if (con->state != CEPH_CON_S_V2_SESSION_CONNECT) {
 		con->error_msg = "protocol error, unexpected ident_missing_features";
 		return -EINVAL;
@@ -2580,6 +2691,8 @@ static int process_session_reconnect_ok(struct ceph_connection *con,
 {
 	u64 seq;
 
+	lockdep_assert_held(&con->mutex);
+
 	if (con->state != CEPH_CON_S_V2_SESSION_RECONNECT) {
 		con->error_msg = "protocol error, unexpected session_reconnect_ok";
 		return -EINVAL;
@@ -2610,6 +2723,8 @@ static int process_session_retry(struct ceph_connection *con,
 	u64 connect_seq;
 	int ret;
 
+	lockdep_assert_held(&con->mutex);
+
 	if (con->state != CEPH_CON_S_V2_SESSION_RECONNECT) {
 		con->error_msg = "protocol error, unexpected session_retry";
 		return -EINVAL;
@@ -2643,6 +2758,8 @@ static int process_session_retry_global(struct ceph_connection *con,
 	u64 global_seq;
 	int ret;
 
+	lockdep_assert_held(&con->mutex);
+
 	if (con->state != CEPH_CON_S_V2_SESSION_RECONNECT) {
 		con->error_msg = "protocol error, unexpected session_retry_global";
 		return -EINVAL;
@@ -2676,6 +2793,8 @@ static int process_session_reset(struct ceph_connection *con,
 	bool full;
 	int ret;
 
+	lockdep_assert_held(&con->mutex);
+
 	if (con->state != CEPH_CON_S_V2_SESSION_RECONNECT) {
 		con->error_msg = "protocol error, unexpected session_reset";
 		return -EINVAL;
@@ -2721,6 +2840,8 @@ static int process_session_reset(struct ceph_connection *con,
 static int process_keepalive2_ack(struct ceph_connection *con,
 				  void *p, void *end)
 {
+	lockdep_assert_held(&con->mutex);
+
 	if (con->state != CEPH_CON_S_OPEN) {
 		con->error_msg = "protocol error, unexpected keepalive2_ack";
 		return -EINVAL;
@@ -2742,6 +2863,8 @@ static int process_ack(struct ceph_connection *con, void *p, void *end)
 {
 	u64 seq;
 
+	lockdep_assert_held(&con->mutex);
+
 	if (con->state != CEPH_CON_S_OPEN) {
 		con->error_msg = "protocol error, unexpected ack";
 		return -EINVAL;
@@ -2764,6 +2887,7 @@ static int process_control(struct ceph_connection *con, void *p, void *end)
 	int ret;
 
 	dout("%s con %p tag %d len %d\n", __func__, con, tag, (int)(end - p));
+	lockdep_assert_held(&con->mutex);
 
 	switch (tag) {
 	case FRAME_TAG_HELLO:
@@ -2835,6 +2959,8 @@ static int process_message_header(struct ceph_connection *con,
 	int ret;
 	u64 seq;
 
+	lockdep_assert_held(&con->mutex);
+
 	ceph_decode_need(&p, end, sizeof(*hdr2), bad);
 	hdr2 = p;
 
@@ -2876,6 +3002,8 @@ static int process_message_header(struct ceph_connection *con,
 
 static int process_message(struct ceph_connection *con)
 {
+	lockdep_assert_held(&con->mutex);
+
 	ceph_con_process_message(con);
 
 	/*
@@ -2898,6 +3026,8 @@ static int __handle_control(struct ceph_connection *con, void *p)
 	struct ceph_msg *msg;
 	int ret;
 
+	lockdep_assert_held(&con->mutex);
+
 	if (con->v2.in_desc.fd_tag != FRAME_TAG_MESSAGE)
 		return process_control(con, p, end);
 
@@ -2942,6 +3072,8 @@ static int handle_preamble(struct ceph_connection *con)
 	struct ceph_frame_desc *desc = &con->v2.in_desc;
 	int ret;
 
+	lockdep_assert_held(&con->mutex);
+
 	if (con_secure(con)) {
 		ret = decrypt_preamble(con);
 		if (ret) {
@@ -2979,6 +3111,7 @@ static int handle_control(struct ceph_connection *con)
 	void *buf;
 	int ret;
 
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(con_secure(con));
 
 	ret = verify_control_crc(con);
@@ -3003,6 +3136,7 @@ static int handle_control_remainder(struct ceph_connection *con)
 {
 	int ret;
 
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(!con_secure(con));
 
 	ret = decrypt_control_remainder(con);
@@ -3021,6 +3155,8 @@ static int handle_epilogue(struct ceph_connection *con)
 	u32 front_crc, middle_crc, data_crc;
 	int ret;
 
+	lockdep_assert_held(&con->mutex);
+
 	if (con_secure(con)) {
 		ret = decrypt_tail(con);
 		if (ret) {
@@ -3057,6 +3193,7 @@ static int handle_epilogue(struct ceph_connection *con)
 static void finish_skip(struct ceph_connection *con)
 {
 	dout("%s con %p\n", __func__, con);
+	lockdep_assert_held(&con->mutex);
 
 	if (con_secure(con))
 		gcm_inc_nonce(&con->v2.in_gcm_nonce);
@@ -3070,6 +3207,7 @@ static int populate_in_iter(struct ceph_connection *con)
 
 	dout("%s con %p state %d in_state %d\n", __func__, con, con->state,
 	     con->v2.in_state);
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(iov_iter_count(&con->v2.in_iter));
 
 	if (con->state == CEPH_CON_S_V2_BANNER_PREFIX) {
@@ -3139,6 +3277,7 @@ int ceph_con_v2_try_read(struct ceph_connection *con)
 
 	dout("%s con %p state %d need %zu\n", __func__, con, con->state,
 	     iov_iter_count(&con->v2.in_iter));
+	lockdep_assert_held(&con->mutex);
 
 	if (con->state == CEPH_CON_S_PREOPEN)
 		return 0;
@@ -3169,6 +3308,8 @@ static void queue_data(struct ceph_connection *con, struct ceph_msg *msg)
 {
 	struct bio_vec bv;
 
+	lockdep_assert_held(&con->mutex);
+
 	con->v2.out_epil.data_crc = -1;
 	ceph_msg_data_cursor_init(&con->v2.out_cursor, msg,
 				  data_len(msg));
@@ -3182,6 +3323,8 @@ static void queue_data_cont(struct ceph_connection *con, struct ceph_msg *msg)
 {
 	struct bio_vec bv;
 
+	lockdep_assert_held(&con->mutex);
+
 	con->v2.out_epil.data_crc = ceph_crc32c_page(
 		con->v2.out_epil.data_crc, con->v2.out_bvec.bv_page,
 		con->v2.out_bvec.bv_offset, con->v2.out_bvec.bv_len);
@@ -3209,6 +3352,7 @@ static void queue_enc_page(struct ceph_connection *con)
 
 	dout("%s con %p i %d resid %d\n", __func__, con, con->v2.out_enc_i,
 	     con->v2.out_enc_resid);
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(!con->v2.out_enc_resid);
 
 	bvec_set_page(&bv, con->v2.out_enc_pages[con->v2.out_enc_i],
@@ -3234,6 +3378,7 @@ static void queue_enc_page(struct ceph_connection *con)
 static void queue_zeros(struct ceph_connection *con, struct ceph_msg *msg)
 {
 	dout("%s con %p out_zero %d\n", __func__, con, con->v2.out_zero);
+	lockdep_assert_held(&con->mutex);
 
 	if (con->v2.out_zero) {
 		set_out_bvec_zero(con);
@@ -3255,6 +3400,7 @@ static void queue_zeros(struct ceph_connection *con, struct ceph_msg *msg)
 static void finish_message(struct ceph_connection *con)
 {
 	dout("%s con %p msg %p\n", __func__, con, con->out_msg);
+	lockdep_assert_held(&con->mutex);
 
 	/* we end up here both plain and secure modes */
 	if (con->v2.out_enc_pages) {
@@ -3280,6 +3426,7 @@ static int populate_out_iter(struct ceph_connection *con)
 
 	dout("%s con %p state %d out_state %d\n", __func__, con, con->state,
 	     con->v2.out_state);
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(iov_iter_count(&con->v2.out_iter));
 
 	if (con->state != CEPH_CON_S_OPEN) {
@@ -3357,6 +3504,7 @@ int ceph_con_v2_try_write(struct ceph_connection *con)
 
 	dout("%s con %p state %d have %zu\n", __func__, con, con->state,
 	     iov_iter_count(&con->v2.out_iter));
+	lockdep_assert_held(&con->mutex);
 
 	/* open the socket first? */
 	if (con->state == CEPH_CON_S_PREOPEN) {
@@ -3439,6 +3587,7 @@ static void prepare_zero_front(struct ceph_connection *con,
 {
 	int sent;
 
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(!resid || resid > front_len(msg));
 	sent = front_len(msg) - resid;
 	dout("%s con %p sent %d resid %d\n", __func__, con, sent, resid);
@@ -3461,6 +3610,7 @@ static void prepare_zero_middle(struct ceph_connection *con,
 {
 	int sent;
 
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(!resid || resid > middle_len(msg));
 	sent = middle_len(msg) - resid;
 	dout("%s con %p sent %d resid %d\n", __func__, con, sent, resid);
@@ -3482,6 +3632,8 @@ static void prepare_zero_data(struct ceph_connection *con,
 			      struct ceph_msg *msg)
 {
 	dout("%s con %p\n", __func__, con);
+	lockdep_assert_held(&con->mutex);
+
 	con->v2.out_epil.data_crc = crc32c_zeros(-1, data_len(msg));
 	out_zero_add(con, data_len(msg));
 }
@@ -3492,6 +3644,7 @@ static void revoke_at_queue_data(struct ceph_connection *con,
 	int boundary;
 	int resid;
 
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(!data_len(msg));
 	WARN_ON(!iov_iter_is_kvec(&con->v2.out_iter));
 	resid = iov_iter_count(&con->v2.out_iter);
@@ -3535,6 +3688,7 @@ static void revoke_at_queue_data_cont(struct ceph_connection *con,
 {
 	int sent, resid;  /* current piece of data */
 
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(!data_len(msg));
 	WARN_ON(!iov_iter_is_bvec(&con->v2.out_iter));
 	resid = iov_iter_count(&con->v2.out_iter);
@@ -3563,6 +3717,7 @@ static void revoke_at_finish_message(struct ceph_connection *con,
 	int boundary;
 	int resid;
 
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(!iov_iter_is_kvec(&con->v2.out_iter));
 	resid = iov_iter_count(&con->v2.out_iter);
 
@@ -3618,6 +3773,7 @@ static void revoke_at_finish_message(struct ceph_connection *con,
 
 void ceph_con_v2_revoke(struct ceph_connection *con, struct ceph_msg *msg)
 {
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(con->v2.out_zero);
 
 	if (con_secure(con)) {
@@ -3648,6 +3804,7 @@ static void revoke_at_prepare_read_data(struct ceph_connection *con)
 	int remaining;
 	int resid;
 
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(con_secure(con));
 	WARN_ON(!data_len(con->in_msg));
 	WARN_ON(!iov_iter_is_kvec(&con->v2.in_iter));
@@ -3667,6 +3824,7 @@ static void revoke_at_prepare_read_data_cont(struct ceph_connection *con)
 	int recved, resid;  /* current piece of data */
 	int remaining;
 
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(con_secure(con));
 	WARN_ON(!data_len(con->in_msg));
 	WARN_ON(!iov_iter_is_bvec(&con->v2.in_iter));
@@ -3691,6 +3849,7 @@ static void revoke_at_prepare_read_enc_page(struct ceph_connection *con)
 {
 	int resid;  /* current enc page (not necessarily data) */
 
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(!con_secure(con));
 	WARN_ON(!iov_iter_is_bvec(&con->v2.in_iter));
 	resid = iov_iter_count(&con->v2.in_iter);
@@ -3708,6 +3867,7 @@ static void revoke_at_prepare_sparse_data(struct ceph_connection *con)
 	int resid;  /* current piece of data */
 	int remaining;
 
+	lockdep_assert_held(&con->mutex);
 	WARN_ON(con_secure(con));
 	WARN_ON(!data_len(con->in_msg));
 	WARN_ON(!iov_iter_is_bvec(&con->v2.in_iter));
@@ -3724,6 +3884,8 @@ static void revoke_at_handle_epilogue(struct ceph_connection *con)
 {
 	int resid;
 
+	lockdep_assert_held(&con->mutex);
+
 	resid = iov_iter_count(&con->v2.in_iter);
 	WARN_ON(!resid);
 
@@ -3735,6 +3897,8 @@ static void revoke_at_handle_epilogue(struct ceph_connection *con)
 
 void ceph_con_v2_revoke_incoming(struct ceph_connection *con)
 {
+	lockdep_assert_held(&con->mutex);
+
 	switch (con->v2.in_state) {
 	case IN_S_PREPARE_SPARSE_DATA:
 	case IN_S_PREPARE_READ_DATA:
@@ -3765,6 +3929,8 @@ bool ceph_con_v2_opened(struct ceph_connection *con)
 
 void ceph_con_v2_reset_session(struct ceph_connection *con)
 {
+	lockdep_assert_held(&con->mutex);
+
 	con->v2.client_cookie = 0;
 	con->v2.server_cookie = 0;
 	con->v2.global_seq = 0;
@@ -3774,6 +3940,8 @@ void ceph_con_v2_reset_session(struct ceph_connection *con)
 
 void ceph_con_v2_reset_protocol(struct ceph_connection *con)
 {
+	lockdep_assert_held(&con->mutex);
+
 	iov_iter_truncate(&con->v2.in_iter, 0);
 	iov_iter_truncate(&con->v2.out_iter, 0);
 	con->v2.out_zero = 0;
-- 
2.47.3

